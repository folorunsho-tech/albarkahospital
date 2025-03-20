import { Router } from "express";
// import { PrismaClient } from "@prisma/client";
// const prisma = new PrismaClient();
import prisma from "../config/prisma.js";

const router = Router();
// import { nanoid } from "nanoid";
router.get("/", async (req, res) => {
	try {
		const found = await prisma.encounters.findMany({});
		res.status(200).json(found);
	} catch (error) {
		res.status(500).json(error);
	}
});
router.post("/many", async (req, res) => {
	try {
		const created = await prisma.encounters.createMany({
			data: [...req.body],
		});
		res.status(200).json(created);
	} catch (error) {
		res.status(500).json(error);
	}
});
router.post("/:criteria", async (req, res) => {
	const { value } = req.body;
	const criteria = req.params.criteria;
	try {
		if (criteria == "year") {
			const found = await prisma.encounters.findMany({
				where: {
					year: value,
				},
				include: {
					care: true,
					patient: true,
					_count: {
						select: {
							diagnosis: true,
							drugsGiven: true,
							labTest: true,
						},
					},
				},
				orderBy: {
					updatedAt: "desc",
				},
			});

			res.status(200).json(found);
		} else if (criteria == "yearnmonth") {
			const found = await prisma.encounters.findMany({
				where: {
					year: value?.year,
					month: value?.month,
				},
				include: {
					patient: true,
					care: true,
					_count: {
						select: {
							diagnosis: true,
							drugsGiven: true,
							labTest: true,
						},
					},
				},
				orderBy: {
					updatedAt: "desc",
				},
			});

			res.status(200).json(found);
		} else if (criteria == "date") {
			const found = await prisma.encounters.findMany({
				where: {
					AND: [
						{
							enc_date: {
								gte: new Date(new Date(value).setUTCHours(0, 0, 0, 0, 0)),
							},
						},
						{
							enc_date: {
								lte: new Date(new Date(value).setUTCHours(23, 0, 0, 0, 0)),
							},
						},
					],
				},
				include: {
					patient: true,
					care: true,
					_count: {
						select: {
							diagnosis: true,
							drugsGiven: true,
							labTest: true,
						},
					},
				},
				orderBy: {
					updatedAt: "desc",
				},
			});
			res.status(200).json(found);
		} else if (criteria == "range") {
			const found = await prisma.encounters.findMany({
				where: {
					AND: [
						{
							enc_date: {
								gte: new Date(new Date(value?.from).setUTCHours(0, 0, 0, 0, 0)),
							},
						},
						{
							enc_date: {
								lte: new Date(new Date(value?.to).setUTCHours(23, 0, 0, 0, 0)),
							},
						},
					],
				},
				include: {
					patient: true,
					care: true,
					_count: {
						select: {
							diagnosis: true,
							drugsGiven: true,
							labTest: true,
						},
					},
				},
				orderBy: {
					updatedAt: "desc",
				},
			});

			res.status(200).json(found);
		}
	} catch (error) {
		res.status(500).json(error);
	}
});

router.get("/:id", async (req, res) => {
	try {
		const found = await prisma.encounters.findUnique({
			where: {
				id: req.params.id,
			},

			include: {
				drugsGiven: {
					include: {
						drug: true,
					},
				},
				diagnosis: true,
				care: true,
				updatedBy: true,
				labTest: {
					include: {
						testType: true,
					},
				},
				patient: {
					include: {
						town: true,
					},
				},
				operations: {
					include: {
						procedure: true,
					},
				},
				delivery: true,
				follow_ups: true,
				admission: true,
				immunization: true,
				anc: true,
			},
		});

		res.status(200).json(found);
	} catch (error) {
		res.status(500).json(error);
	}
});
router.get("/:id/followup", async (req, res) => {
	try {
		const found = await prisma.encounters.findMany({
			where: {
				patient_id: req.params.id,
			},
			include: {
				care: true,
			},
		});

		res.status(200).json(found);
	} catch (error) {
		res.status(500).json(error);
	}
});

router.post("/", async (req, res) => {
	const {
		care,
		month,
		year,
		diagnosis,
		delivery,
		drugsGiven,
		operation,
		labTest,
		createdById,
		time,
		stock_updates,
		anc,
		immunization,
		follow_up_to,
		admitted,
		admission,
		enc_date,
		outcome,
		patient_id,
	} = req.body;
	try {
		const diags = diagnosis?.map((diag) => {
			return {
				id: diag,
			};
		});
		const labs = labTest?.map((test) => {
			return {
				id: test?.lab_id,
				date: new Date(new Date().setUTCHours(0, 0, 0, 0, 0)),
				year,
				month,
				info: test?.info,
				result: test?.result,
				test_id: test?.id,
				rate: test?.rate,
			};
		});
		const drugsG = drugsGiven?.map((drug) => {
			return {
				drug_id: drug?.id,
				rate: drug?.rate,
				name: drug?.name,
				quantity: drug?.quantity,
				price: drug?.price,
				date: new Date(new Date().setUTCHours(0, 0, 0, 0, 0)),
				year,
				month,
			};
		});

		const created = await prisma.encounters.create({
			data: {
				patient_id,
				year,
				month,
				care_id: care,
				createdById,
				diagnosis: {
					connect: diags,
				},
				labTest: {
					createMany: {
						data: labs,
					},
				},
				drugsGiven: {
					createMany: {
						data: drugsG,
					},
				},
				time,
				enc_date: new Date(enc_date),
				admitted,
				outcome,
			},
			include: {
				patient: true,
				care: true,
				drugsGiven: true,
			},
		});
		stock_updates.forEach(async (update) => {
			await prisma.drugsInventory.update({
				where: {
					id: update?.id,
				},
				data: {
					stock_qty: update?.stock_qty,
				},
			});
		});
		await prisma.prescriptionHist.createMany({
			data: drugsGiven?.map((d) => {
				return {
					drug: d?.name,
					hosp_no: created.patient.hosp_no,
					quantity: d?.quantity,
					rate: d?.rate,
					price: d?.price,
					stock_remain: d?.curr_stock,
					month,
					date: new Date(new Date().setUTCHours(0, 0, 0, 0, 0)),
					time,
					year,
					given_id: created.drugsGiven.find((g) => g.drug_id == d?.id).id,
					enc_id: created.id,
				};
			}),
		});
		if (admitted) {
			await prisma.admission.create({
				data: {
					encounter_id: created.id,
					admitted_for: admission?.admitted_for,
					discharged_on: admission?.discharged_on,
					outcome: admission?.outcome,
					nok_phone: admission?.nok_phone,
					ward_matron: admission?.ward_matron,
					adm_date: new Date(admission?.adm_date),
				},
			});
		}
		if (follow_up_to !== "" || follow_up_to !== null) {
			await prisma.followups.create({
				data: {
					encounter_id: follow_up_to,
					year,
					month,
				},
			});
		}
		if (anc?.date) {
			await prisma.anc.create({
				data: {
					ega: anc?.ega,
					fe_no: anc?.fe_no,
					fe_liq_vol: anc?.fe_liq_vol,
					fe_abnormality: anc?.fe_abnormality,
					fe_diagnosis: anc?.fe_diagnosis,
					fe_live: anc?.fe_live,
					placenta_pos: anc?.placenta_pos,
					edd: anc?.edd,
					date: new Date(anc?.date),
					encounter_id: created.id,
				},
			});
		}
		if (delivery?.delivery_date) {
			await prisma.delivery.create({
				data: {
					parity: delivery?.parity,
					mother_diag: delivery?.mother_diag,
					labour_duration: delivery?.labour_duration,
					delivery_type: delivery?.delivery_type,
					placenta_delivery: delivery?.placenta_delivery,
					apgar_score: delivery?.apgar_score,
					baby_outcome: delivery?.baby_outcome,
					baby_maturity: delivery?.baby_maturity,
					baby_weight: delivery?.baby_weight,
					baby_sex: delivery?.baby_sex,
					midwife: delivery?.midwife,
					congenital_no: Number(delivery?.congenital_no),
					mother_outcome: delivery?.mother_outcome,
					delivery_date: new Date(delivery?.delivery_date),
					year,
					month,
					encounter_id: created.id,
				},
			});
		}
		if (operation?.procedureId !== "") {
			await prisma.operations.create({
				data: {
					procedureId: operation?.procedureId,
					proc_date: operation?.proc_date,
					surgeon: operation?.surgeon,
					assistant: operation?.assistant,
					outcome: operation?.outcome,
					anaesthesia: operation?.anaesthesia,
					year,
					month,
					encounter_id: created.id,
				},
			});
		}
		if (immunization?.date) {
			await prisma.immunization.create({
				data: {
					date: new Date(immunization?.date),
					next_date: new Date(immunization?.next_date),
					type: immunization?.type,
					encounter_id: created.id,
				},
			});
		}

		res.status(200).json(created);
	} catch (error) {
		res.status(500).json(error);
	}
});
router.post("/edit/operation/:id", async (req, res) => {
	try {
		const found = await prisma.operations.findUnique({
			where: {
				id: req.body.operation_id ? req.body.operation_id : "",
			},
		});
		if (found) {
			const updated = await prisma.operations.update({
				where: {
					id: req.body.operation_id,
				},
				data: {
					...req.body.operation,
				},
			});
			if (updated) {
				await prisma.encounters.update({
					where: {
						id: updated.encounter_id,
					},
					data: {
						updatedAt: new Date(),
					},
				});
			}
		} else {
			const updated = await prisma.operations.create({
				data: {
					...req.body.operation,
					encounter_id: req.params.id,
				},
			});
			if (updated) {
				await prisma.encounters.update({
					where: {
						id: updated.encounter_id,
					},
					data: {
						updatedAt: new Date(),
					},
				});
			}
		}
		res.status(200).json(found);
	} catch (error) {
		res.status(500).json(error);
		console.log(error);
	}
});
router.post("/edit/immunization/:id", async (req, res) => {
	try {
		const found = await prisma.immunization.findUnique({
			where: {
				id: req.body.immunization_id ? req.body.immunization_id : "",
			},
		});
		if (found) {
			const updated = await prisma.immunization.update({
				where: {
					id: req.body.immunization_id,
				},
				data: {
					...req.body.immunization,
				},
			});
			if (updated) {
				await prisma.encounters.update({
					where: {
						id: updated.encounter_id,
					},
					data: {
						updatedAt: new Date(),
					},
				});
			}
		} else {
			const updated = await prisma.immunization.create({
				data: {
					encounter_id: req.params.id,
					...req.body.immunization,
				},
			});
			if (updated) {
				await prisma.encounters.update({
					where: {
						id: updated.encounter_id,
					},
					data: {
						updatedAt: new Date(),
					},
				});
			}
		}
		res.status(200).json(found);
	} catch (error) {
		res.status(500).json(error);
	}
});
router.post("/edit/anc/:id", async (req, res) => {
	try {
		const found = await prisma.anc.findUnique({
			where: {
				id: req.body.anc_id ? req.body.anc_id : "",
			},
		});
		if (found) {
			const updated = await prisma.anc.update({
				where: {
					id: req.body.anc_id,
				},
				data: {
					...req.body.anc,
				},
			});
			if (updated) {
				await prisma.encounters.update({
					where: {
						id: updated.encounter_id,
					},
					data: {
						updatedAt: new Date(),
					},
				});
			}
		} else {
			const updated = await prisma.anc.create({
				data: {
					encounter_id: req.params.id,
					...req.body.anc,
				},
			});
			if (updated) {
				await prisma.encounters.update({
					where: {
						id: updated.encounter_id,
					},
					data: {
						updatedAt: new Date(),
					},
				});
			}
		}

		res.status(200).json(found);
	} catch (error) {
		res.status(500).json(error);
	}
});
router.post("/edit/delivery/:id", async (req, res) => {
	try {
		const found = await prisma.delivery.findUnique({
			where: {
				id: req.body.delivery_id ? req.body.delivery_id : "",
			},
		});
		if (found) {
			const updated = await prisma.delivery.update({
				where: {
					id: req.body.delivery_id,
				},
				data: {
					...req.body.delivery,
				},
			});
			if (updated) {
				await prisma.encounters.update({
					where: {
						id: updated.encounter_id,
					},
					data: {
						updatedAt: new Date(),
					},
				});
			}
		} else {
			const updated = await prisma.delivery.create({
				data: {
					encounter_id: req.params.id,
					...req.body.delivery,
				},
			});
			if (updated) {
				await prisma.encounters.update({
					where: {
						id: updated.encounter_id,
					},
					data: {
						updatedAt: new Date(),
					},
				});
			}
		}
		res.status(200).json(found);
	} catch (error) {
		res.status(500).json(error);
	}
});
router.post("/edit/labs/:id", async (req, res) => {
	const labs = req.body.labs.map((test) => {
		return {
			id: test?.lab_id,
			test_id: test?.id,
			result: test?.result,
			info: test?.info,
			rate: test?.rate,
		};
	});
	try {
		const found = await prisma.encounters.update({
			where: {
				id: req.params.id,
			},
			data: {
				labTest: {
					deleteMany: {},
					createMany: { data: labs },
				},
				updatedById: req.body.updatedById,
			},
			select: {
				labTest: true,
			},
		});
		res.status(200).json(found);
	} catch (error) {
		res.status(500).json(error);
	}
});
router.post("/edit/drugs/:id", async (req, res) => {
	const drugs = req.body.drugs;
	const updates = req.body.stock_updates;

	try {
		drugs.forEach(async (drug) => {
			await prisma.drugsGiven.update({
				where: {
					id: drug.id,
				},
				data: {
					rate: drug.rate,
					quantity: drug.quantity,
					price: drug.price,
					month: req.body.month,
					year: Number(req.body.year),
				},
			});
		});

		const created = await prisma.encounters.findUnique({
			where: {
				id: req.params.id,
			},
			include: { drugsGiven: true, patient: true },
		});
		updates.forEach(async (update) => {
			await prisma.drugsInventory.update({
				where: {
					id: update?.id,
				},
				data: {
					stock_qty: update?.stock_qty,
				},
			});
		});
		await prisma.prescriptionHist.createMany({
			data: drugs?.map((d) => {
				return {
					drug: d?.name,
					hosp_no: created.patient.hosp_no,
					quantity: d?.added,
					rate: d?.rate,
					price: d?.price,
					stock_remain: d?.curr_stock,
					month: req.body.month,
					date: new Date(new Date().setUTCHours(0, 0, 0, 0, 0)),
					time: req.body.time,
					year: Number(req.body.year),
					given_id: d?.id,
					enc_id: req.params.id,
				};
			}),
		});

		res.status(200).json(created);
	} catch (error) {
		res.status(500).json(error);
	}
});
router.post("/edit/diagnosis/:id", async (req, res) => {
	const diags = req.body.diagnosis.map((diag) => {
		return {
			id: diag,
		};
	});
	try {
		const found = await prisma.encounters.update({
			where: {
				id: req.params.id,
			},
			data: {
				diagnosis: {
					set: [],
					connect: diags,
				},
				updatedById: req.body.updatedById,
			},
			select: {
				diagnosis: true,
			},
		});
		res.status(200).json(found);
	} catch (error) {
		res.status(500).json(error);
	}
});
export default router;
