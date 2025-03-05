import { Router } from "express";
// import { PrismaClient } from "@prisma/client";
// const prisma = new PrismaClient();
import prisma from "../config/prisma.js";

const router = Router();
// import { nanoid } from "nanoid";
router.get("/", async (req, res) => {
	try {
		const found = await prisma.encounters.findMany({
			include: {
				drugsGiven: true,
				diagnosis: true,
				procedure: true,
				care: true,
			},
		});
		res.status(200).json(found);
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
					adm_date: new Date(new Date(value).setUTCHours(0, 0, 0, 0, 0)),
				},
				include: {
					patient: true,
					care: true,
					_count: {
						select: {
							diagnosis: true,
							drugsGiven: true,
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
							adm_date: {
								gte: new Date(new Date(value?.from).setUTCHours(0, 0, 0, 0, 0)),
							},
						},
						{
							adm_date: {
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
				id: Number(req.params.id),
			},

			include: {
				drugsGiven: {
					include: {
						drug: true,
					},
				},
				diagnosis: true,
				procedure: true,
				care: true,
				updatedBy: true,
				labTest: {
					include: {
						testType: true,
					},
				},
				patient: true,
			},
		});

		res.status(200).json(found);
	} catch (error) {
		res.status(500).json(error);
		// console.log(error);
	}
});

router.post("/", async (req, res) => {
	const {
		care,
		selectedP,
		month,
		year,
		diagnosis,
		delivery,
		drugsGiven,
		procedure,
		proc_date,
		labTest,
		adm_date,
		createdById,
		time,
		stock_updates,
	} = req.body;
	try {
		const created = await prisma.encounters.create({
			data: {
				patient_id: selectedP,
				year,
				month,
				care_id: care,
				createdById,
				proc_date,
				diagnosis: {
					connect: diagnosis?.map((diag) => {
						return {
							id: diag,
						};
					}),
				},
				procedureId: procedure,
				delivery: JSON.stringify({
					foetal_diag: delivery?.fDiag,
					anc_ega: delivery?.anc,
					baby_outcome: delivery?.outcome,
					date: new Date(new Date().setUTCHours(0, 0, 0, 0, 0)),
					year,
					month,
					createdAt: new Date(),
				}),
				labTest: {
					createMany: {
						data: labTest?.map((test) => {
							return {
								id: test?.lab_id,
								date: new Date(new Date().setUTCHours(0, 0, 0, 0, 0)),
								year,
								month,
								info: test?.info,
								result: test?.result,
								test_id: test?.id,
							};
						}),
					},
				},
				drugsGiven: {
					createMany: {
						data: drugsGiven?.map((drug) => {
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
						}),
					},
				},
				prescriptions: JSON.stringify(drugsGiven),
				time,
				adm_date: new Date(new Date(adm_date).setUTCHours(0, 0, 0, 0, 0)),
			},
			include: {
				drugsGiven: true,
				patient: true,
			},
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
		res.status(200).json(created);
	} catch (error) {
		res.status(500).json(error);
		console.log(error);
	}
});
router.post("/edit/delivery/:id", async (req, res) => {
	try {
		const found = await prisma.encounters.update({
			where: {
				id: Number(req.params.id),
			},
			data: {
				delivery: JSON.stringify(req.body),
				updatedById: req.body.updatedById,
			},
			select: {
				delivery: true,
			},
		});
		res.status(200).json(found);
	} catch (error) {
		res.status(500).json(error);
	}
});
router.post("/edit/procedure/:id", async (req, res) => {
	try {
		const found = await prisma.encounters.update({
			where: {
				id: Number(req.params.id),
			},
			data: {
				procedureId: req.body.procedureId,
				proc_date: new Date(req.body?.proc_date),
				updatedById: req.body.updatedById,
			},
			select: {
				procedure: true,
				proc_date: true,
			},
		});
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
		};
	});
	try {
		const found = await prisma.encounters.update({
			where: {
				id: Number(req.params.id),
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
				id: Number(req.params.id),
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
					enc_id: Number(req.params.id),
				};
			}),
		});

		res.status(200).json(created);
	} catch (error) {
		res.status(500).json(error);
		console.log(error);
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
				id: Number(req.params.id),
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
