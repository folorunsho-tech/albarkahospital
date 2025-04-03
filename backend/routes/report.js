import express from "express";
// import { PrismaClient } from "@prisma/client";
// const prisma = new PrismaClient();
import prisma from "../config/prisma.js";
const router = express.Router();
// DRUGS
router.post("/drugs/summary/:criteria", async (req, res) => {
	const { value } = req.body;
	const criteria = req.params.criteria;
	try {
		if (criteria == "year") {
			const drugsgiven = await prisma.drugsGiven.groupBy({
				by: ["name"],
				_sum: {
					quantity: true,
					price: true,
				},
				having: {
					quantity: {
						_sum: {
							gt: 0,
						},
					},
				},
				orderBy: {
					name: "asc",
				},
				where: {
					year: value,
				},
			});

			res.status(200).json(drugsgiven);
		} else if (criteria == "yearnmonth") {
			const drugsgiven = await prisma.drugsGiven.groupBy({
				by: ["name"],
				_sum: {
					quantity: true,
					price: true,
				},
				having: {
					quantity: {
						_sum: {
							gt: 0,
						},
					},
				},
				orderBy: {
					name: "asc",
				},
				where: {
					year: value?.year,
					month: value?.month,
				},
			});

			res.status(200).json(drugsgiven);
		} else if (criteria == "date") {
			const drugsgiven = await prisma.drugsGiven.groupBy({
				by: ["name"],
				_sum: {
					quantity: true,
					price: true,
				},
				having: {
					quantity: {
						_sum: {
							gt: 0,
						},
					},
				},
				orderBy: {
					name: "asc",
				},
				where: {
					AND: [
						{
							date: {
								gte: new Date(new Date(value).setUTCHours(0, 0, 0, 0, 0)),
							},
						},
						{
							date: {
								lte: new Date(new Date(value).setUTCHours(23, 0, 0, 0, 0)),
							},
						},
					],
				},
			});

			res.status(200).json(drugsgiven);
		} else if (criteria == "range") {
			const drugsgiven = await prisma.drugsGiven.groupBy({
				by: ["name"],
				_sum: {
					quantity: true,
					price: true,
				},
				having: {
					quantity: {
						_sum: {
							gt: 0,
						},
					},
				},
				orderBy: {
					name: "asc",
				},
				where: {
					AND: [
						{
							date: {
								gte: new Date(new Date(value?.from).setUTCHours(0, 0, 0, 0, 0)),
							},
						},
						{
							date: {
								lte: new Date(new Date(value?.to).setUTCHours(23, 0, 0, 0, 0)),
							},
						},
					],
				},
			});

			res.status(200).json(drugsgiven);
		}
	} catch (error) {
		res.status(500).json(error);
	}
});
router.post("/drugs/detailed/:criteria", async (req, res) => {
	const { value } = req.body;
	const criteria = req.params.criteria;
	try {
		if (criteria == "year") {
			const found = await prisma.drugsGiven.findMany({
				where: {
					year: value,
				},
				include: {
					encounter: {
						include: {
							patient: true,
						},
					},
				},
				orderBy: {
					updatedAt: "desc",
				},
			});

			res.status(200).json(found);
		} else if (criteria == "yearnmonth") {
			const found = await prisma.drugsGiven.findMany({
				where: {
					year: value?.year,
					month: value?.month,
				},
				include: {
					encounter: {
						include: {
							patient: true,
						},
					},
				},
				orderBy: {
					updatedAt: "desc",
				},
			});

			res.status(200).json(found);
		} else if (criteria == "date") {
			const found = await prisma.drugsGiven.findMany({
				where: {
					AND: [
						{
							date: {
								gte: new Date(new Date(value).setUTCHours(0, 0, 0, 0, 0)),
							},
						},
						{
							date: {
								lte: new Date(new Date(value).setUTCHours(23, 0, 0, 0, 0)),
							},
						},
					],
				},
				include: {
					encounter: {
						include: {
							patient: true,
						},
					},
				},
				orderBy: {
					updatedAt: "desc",
				},
			});
			res.status(200).json(found);
		} else if (criteria == "range") {
			const found = await prisma.drugsGiven.findMany({
				where: {
					AND: [
						{
							date: {
								gte: new Date(new Date(value?.from).setUTCHours(0, 0, 0, 0, 0)),
							},
						},
						{
							date: {
								lte: new Date(new Date(value?.to).setUTCHours(23, 0, 0, 0, 0)),
							},
						},
					],
				},
				include: {
					encounter: {
						include: {
							patient: true,
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
// DRUGS END

// PATIENTS
router.post("/patients/:criteria", async (req, res) => {
	const { value } = req.body;
	const criteria = req.params.criteria;
	try {
		if (criteria == "year") {
			const found = await prisma.patients.findMany({
				where: {
					year: value,
				},
				include: {
					encounters: true,
					town: true,
					groups: true,
					_count: {
						select: {
							encounters: true,
							transactions: true,
						},
					},
				},

				orderBy: {
					updatedAt: "desc",
				},
			});

			res.status(200).json(found);
		} else if (criteria == "yearnmonth") {
			const found = await prisma.patients.findMany({
				where: {
					year: value?.year,
					month: value?.month,
				},
				include: {
					encounters: true,
					town: true,
					groups: true,
					_count: {
						select: {
							encounters: true,
							transactions: true,
						},
					},
				},
				orderBy: {
					updatedAt: "desc",
				},
			});

			res.status(200).json(found);
		} else if (criteria == "date") {
			const found = await prisma.patients.findMany({
				where: {
					AND: [
						{
							reg_date: {
								gte: new Date(new Date(value).setUTCHours(0, 0, 0, 0, 0)),
							},
						},
						{
							reg_date: {
								lte: new Date(new Date(value).setUTCHours(23, 0, 0, 0, 0)),
							},
						},
					],
				},
				include: {
					encounters: true,
					town: true,
					groups: true,
					_count: {
						select: {
							encounters: true,
							transactions: true,
						},
					},
				},
				orderBy: {
					updatedAt: "desc",
				},
			});
			res.status(200).json(found);
		} else if (criteria == "range") {
			const found = await prisma.patients.findMany({
				where: {
					AND: [
						{
							reg_date: {
								gte: new Date(new Date(value?.from).setUTCHours(0, 0, 0, 0, 0)),
							},
						},
						{
							reg_date: {
								lte: new Date(new Date(value?.to).setUTCHours(23, 0, 0, 0, 0)),
							},
						},
					],
				},
				include: {
					encounters: true,
					town: true,
					groups: true,
					_count: {
						select: {
							encounters: true,
							transactions: true,
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
// PATIENTS END

// ENCOUNTERS
router.post("/encounters/:criteria", async (req, res) => {
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
					follow_ups: {
						include: {
							encounter: {
								select: {
									diagnosis: { select: { name: true } },
									care: true,
								},
							},
						},
					},
					diagnosis: true,
					_count: {
						select: {
							drugsGiven: true,
							labTest: true,
							anc: true,
							immunization: true,
							follow_ups: true,
						},
					},
					patient: true,
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
					care: true,
					follow_ups: {
						include: {
							encounter: {
								select: {
									care: true,
									diagnosis: { select: { name: true } },
								},
							},
						},
					},
					diagnosis: true,
					_count: {
						select: {
							drugsGiven: true,
							labTest: true,
							anc: true,
							follow_ups: true,
							immunization: true,
						},
					},
					patient: true,
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
					care: true,
					follow_ups: {
						include: {
							encounter: {
								select: {
									diagnosis: { select: { name: true } },
									care: true,
								},
							},
						},
					},
					diagnosis: true,
					_count: {
						select: {
							drugsGiven: true,
							labTest: true,
							anc: true,
							follow_ups: true,
							immunization: true,
						},
					},
					patient: true,
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
					care: true,
					follow_ups: {
						include: {
							encounter: {
								select: {
									diagnosis: { select: { name: true } },
									care: true,
								},
							},
						},
					},
					diagnosis: true,
					_count: {
						select: {
							drugsGiven: true,
							labTest: true,
							anc: true,
							follow_ups: true,
							immunization: true,
						},
					},
					patient: true,
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
// ENCOUNTERS END

// DELIVERIES
router.post("/deliveries/:criteria", async (req, res) => {
	const { value } = req.body;
	const criteria = req.params.criteria;
	try {
		if (criteria == "year") {
			const found = await prisma.delivery.findMany({
				where: {
					encounter: {
						year: value,
					},
				},
				include: {
					encounter: {
						include: {
							patient: true,
						},
					},
				},
				orderBy: {
					updatedAt: "desc",
				},
			});

			res.status(200).json(found);
		} else if (criteria == "yearnmonth") {
			const found = await prisma.delivery.findMany({
				where: {
					encounter: {
						year: value?.year,
						month: value?.month,
					},
				},
				include: {
					encounter: {
						include: {
							patient: true,
						},
					},
				},
				orderBy: {
					updatedAt: "desc",
				},
			});

			res.status(200).json(found);
		} else if (criteria == "date") {
			const found = await prisma.delivery.findMany({
				where: {
					AND: [
						{
							delivery_date: {
								gte: new Date(new Date(value).setUTCHours(0, 0, 0, 0, 0)),
							},
						},
						{
							delivery_date: {
								lte: new Date(new Date(value).setUTCHours(23, 0, 0, 0, 0)),
							},
						},
					],
				},
				include: {
					encounter: {
						include: {
							patient: true,
						},
					},
				},
				orderBy: {
					updatedAt: "desc",
				},
			});
			res.status(200).json(found);
		} else if (criteria == "range") {
			const found = await prisma.delivery.findMany({
				where: {
					AND: [
						{
							delivery_date: {
								gte: new Date(new Date(value?.from).setUTCHours(0, 0, 0, 0, 0)),
							},
						},
						{
							delivery_date: {
								lte: new Date(new Date(value?.to).setUTCHours(23, 0, 0, 0, 0)),
							},
						},
					],
				},
				include: {
					encounter: {
						include: {
							patient: true,
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
// DELIVERIES END

// LABS
router.post("/labs/:criteria", async (req, res) => {
	const { value } = req.body;
	const criteria = req.params.criteria;
	try {
		if (criteria == "year") {
			const found = await prisma.labTest.findMany({
				where: {
					encounter: {
						year: value,
					},
				},
				include: {
					encounter: {
						include: {
							patient: true,
						},
					},
					testType: true,
				},
				orderBy: {
					updatedAt: "desc",
				},
			});

			res.status(200).json(found);
		} else if (criteria == "yearnmonth") {
			const found = await prisma.labTest.findMany({
				where: {
					encounter: {
						year: value?.year,
						month: value?.month,
					},
				},
				include: {
					encounter: {
						include: {
							patient: true,
						},
					},
					testType: true,
				},
				orderBy: {
					updatedAt: "desc",
				},
			});

			res.status(200).json(found);
		} else if (criteria == "date") {
			const found = await prisma.labTest.findMany({
				where: {
					AND: [
						{
							date: {
								gte: new Date(new Date(value).setUTCHours(0, 0, 0, 0, 0)),
							},
						},
						{
							date: {
								lte: new Date(new Date(value).setUTCHours(23, 0, 0, 0, 0)),
							},
						},
					],
				},
				include: {
					encounter: {
						include: {
							patient: true,
						},
					},
					testType: true,
				},
				orderBy: {
					updatedAt: "desc",
				},
			});
			res.status(200).json(found);
		} else if (criteria == "range") {
			const found = await prisma.labTest.findMany({
				where: {
					AND: [
						{
							date: {
								gte: new Date(new Date(value?.from).setUTCHours(0, 0, 0, 0, 0)),
							},
						},
						{
							date: {
								lte: new Date(new Date(value?.to).setUTCHours(23, 0, 0, 0, 0)),
							},
						},
					],
				},
				include: {
					encounter: {
						include: {
							patient: true,
						},
					},
					testType: true,
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
// LABS END

// OPERATIONS
router.post("/operations/:criteria", async (req, res) => {
	const { value } = req.body;
	const criteria = req.params.criteria;
	try {
		if (criteria == "year") {
			const found = await prisma.operations.findMany({
				where: {
					encounter: {
						year: value,
					},
				},
				include: {
					procedure: true,
					encounter: {
						include: {
							patient: true,
						},
					},
				},
				orderBy: {
					updatedAt: "desc",
				},
			});

			res.status(200).json(found);
		} else if (criteria == "yearnmonth") {
			const found = await prisma.operations.findMany({
				where: {
					encounter: {
						year: value?.year,
						month: value?.month,
					},
				},
				include: {
					procedure: true,
					encounter: {
						include: {
							patient: true,
						},
					},
				},
				orderBy: {
					updatedAt: "desc",
				},
			});

			res.status(200).json(found);
		} else if (criteria == "date") {
			const found = await prisma.operations.findMany({
				where: {
					AND: [
						{
							proc_date: {
								gte: new Date(new Date(value).setUTCHours(0, 0, 0, 0, 0)),
							},
						},
						{
							proc_date: {
								lte: new Date(new Date(value).setUTCHours(23, 0, 0, 0, 0)),
							},
						},
					],
				},
				include: {
					procedure: true,
					encounter: {
						include: {
							patient: true,
						},
					},
				},
				orderBy: {
					updatedAt: "desc",
				},
			});
			res.status(200).json(found);
		} else if (criteria == "range") {
			const found = await prisma.operations.findMany({
				where: {
					AND: [
						{
							proc_date: {
								gte: new Date(new Date(value?.from).setUTCHours(0, 0, 0, 0, 0)),
							},
						},
						{
							proc_date: {
								lte: new Date(new Date(value?.to).setUTCHours(23, 0, 0, 0, 0)),
							},
						},
					],
				},
				include: {
					procedure: true,
					encounter: {
						include: {
							patient: true,
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
// OPERATIONS END

// ADMISSIONS
router.post("/admissions/:criteria", async (req, res) => {
	const { value } = req.body;
	const criteria = req.params.criteria;
	try {
		if (criteria == "year") {
			const found = await prisma.admission.findMany({
				where: {
					encounter: {
						year: value,
					},
				},
				include: {
					encounter: {
						include: {
							patient: true,
						},
					},
				},
				orderBy: {
					updatedAt: "desc",
				},
			});

			res.status(200).json(found);
		} else if (criteria == "yearnmonth") {
			const found = await prisma.admission.findMany({
				where: {
					encounter: {
						year: value?.year,
						month: value?.month,
					},
				},
				include: {
					encounter: {
						include: {
							patient: true,
						},
					},
				},
				orderBy: {
					updatedAt: "desc",
				},
			});

			res.status(200).json(found);
		} else if (criteria == "date") {
			const found = await prisma.admission.findMany({
				where: {
					AND: [
						{
							adm_date: {
								gte: new Date(new Date(value).setUTCHours(0, 0, 0, 0, 0)),
							},
						},
						{
							adm_date: {
								lte: new Date(new Date(value).setUTCHours(23, 0, 0, 0, 0)),
							},
						},
					],
				},
				include: {
					encounter: {
						include: {
							patient: true,
						},
					},
				},
				orderBy: {
					updatedAt: "desc",
				},
			});

			res.status(200).json(found);
		} else if (criteria == "range") {
			const found = await prisma.admission.findMany({
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
					encounter: {
						include: {
							patient: true,
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

// ADMISSIONS END

// IMMUNIZATION
router.post("/immunization/:criteria", async (req, res) => {
	const { value } = req.body;
	const criteria = req.params.criteria;
	try {
		if (criteria == "year") {
			const found = await prisma.immunization.findMany({
				where: {
					encounter: {
						year: value,
					},
				},
				include: {
					encounter: {
						include: {
							patient: true,
						},
					},
				},
				orderBy: {
					updatedAt: "desc",
				},
			});

			res.status(200).json(found);
		} else if (criteria == "yearnmonth") {
			const found = await prisma.immunization.findMany({
				where: {
					encounter: {
						year: value?.year,
						month: value?.month,
					},
				},
				include: {
					encounter: {
						include: {
							patient: true,
						},
					},
				},
				orderBy: {
					updatedAt: "desc",
				},
			});

			res.status(200).json(found);
		} else if (criteria == "date") {
			const found = await prisma.immunization.findMany({
				where: {
					AND: [
						{
							date: {
								gte: new Date(new Date(value).setUTCHours(0, 0, 0, 0, 0)),
							},
						},
						{
							date: {
								lte: new Date(new Date(value).setUTCHours(23, 0, 0, 0, 0)),
							},
						},
					],
				},
				include: {
					encounter: {
						include: {
							patient: true,
						},
					},
				},
				orderBy: {
					updatedAt: "desc",
				},
			});
			res.status(200).json(found);
		} else if (criteria == "range") {
			const found = await prisma.immunization.findMany({
				where: {
					AND: [
						{
							date: {
								gte: new Date(new Date(value?.from).setUTCHours(0, 0, 0, 0, 0)),
							},
						},
						{
							date: {
								lte: new Date(new Date(value?.to).setUTCHours(23, 0, 0, 0, 0)),
							},
						},
					],
				},
				include: {
					encounter: {
						include: {
							patient: true,
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
// IMMUNIZATION END

// ANC
router.post("/anc/:criteria", async (req, res) => {
	const { value } = req.body;
	const criteria = req.params.criteria;
	try {
		if (criteria == "year") {
			const found = await prisma.anc.findMany({
				where: {
					encounter: {
						year: value,
					},
				},
				include: {
					encounter: {
						include: {
							patient: true,
						},
					},
				},
				orderBy: {
					updatedAt: "desc",
				},
			});

			res.status(200).json(found);
		} else if (criteria == "yearnmonth") {
			const found = await prisma.anc.findMany({
				where: {
					encounter: {
						year: value?.year,
						month: value?.month,
					},
				},
				include: {
					encounter: {
						include: {
							patient: true,
						},
					},
				},
				orderBy: {
					updatedAt: "desc",
				},
			});

			res.status(200).json(found);
		} else if (criteria == "date") {
			const found = await prisma.anc.findMany({
				where: {
					AND: [
						{
							date: {
								gte: new Date(new Date(value).setUTCHours(0, 0, 0, 0, 0)),
							},
						},
						{
							date: {
								lte: new Date(new Date(value).setUTCHours(23, 0, 0, 0, 0)),
							},
						},
					],
				},
				include: {
					encounter: {
						include: {
							patient: true,
						},
					},
				},
				orderBy: {
					updatedAt: "desc",
				},
			});
			res.status(200).json(found);
		} else if (criteria == "range") {
			const found = await prisma.anc.findMany({
				where: {
					AND: [
						{
							date: {
								gte: new Date(new Date(value?.from).setUTCHours(0, 0, 0, 0, 0)),
							},
						},
						{
							date: {
								lte: new Date(new Date(value?.to).setUTCHours(23, 0, 0, 0, 0)),
							},
						},
					],
				},
				include: {
					encounter: {
						include: {
							patient: true,
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
// ANC END

// DIAGNOSIS
router.post("/diagnosis/:id", async (req, res) => {
	const { value, criteria } = req.body;
	try {
		if (criteria == "year") {
			const found = await prisma.encounters.findMany({
				where: {
					AND: [
						{
							year: value,
						},
						{
							diagnosis: {
								some: {
									id: req.params.id,
								},
							},
						},
					],
				},
				include: {
					care: true,
					follow_ups: {
						include: {
							encounter: {
								select: {
									diagnosis: { select: { name: true } },
									care: true,
								},
							},
						},
					},
					diagnosis: true,
					_count: {
						select: {
							drugsGiven: true,
							labTest: true,
							anc: true,
							immunization: true,
							follow_ups: true,
						},
					},
					patient: true,
				},
				orderBy: {
					updatedAt: "desc",
				},
			});

			res.status(200).json(found);
		} else if (criteria == "yearnmonth") {
			const found = await prisma.encounters.findMany({
				where: {
					AND: [
						{
							year: value?.year,
							month: value?.month,
						},
						{
							diagnosis: {
								some: {
									id: req.params.id,
								},
							},
						},
					],
				},

				include: {
					care: true,
					follow_ups: {
						include: {
							encounter: {
								select: {
									care: true,
									diagnosis: { select: { name: true } },
								},
							},
						},
					},
					diagnosis: true,
					_count: {
						select: {
							drugsGiven: true,
							labTest: true,
							anc: true,
							follow_ups: true,
							immunization: true,
						},
					},
					patient: true,
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
						{
							diagnosis: {
								some: {
									id: req.params.id,
								},
							},
						},
					],
				},
				include: {
					care: true,
					follow_ups: {
						include: {
							encounter: {
								select: {
									diagnosis: { select: { name: true } },
									care: true,
								},
							},
						},
					},
					diagnosis: true,
					_count: {
						select: {
							drugsGiven: true,
							labTest: true,
							anc: true,
							follow_ups: true,
							immunization: true,
						},
					},
					patient: true,
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
						{
							diagnosis: {
								some: {
									id: req.params.id,
								},
							},
						},
					],
				},
				include: {
					care: true,
					follow_ups: {
						include: {
							encounter: {
								select: {
									diagnosis: { select: { name: true } },
									care: true,
								},
							},
						},
					},
					diagnosis: true,
					_count: {
						select: {
							drugsGiven: true,
							labTest: true,
							anc: true,
							follow_ups: true,
							immunization: true,
						},
					},
					patient: true,
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
// DIAGNOSIS END

// TRANSACTIONS
router.post("/debtors/:criteria", async (req, res) => {
	const { value } = req.body;
	const criteria = req.params.criteria;
	try {
		if (criteria == "year") {
			const found = await prisma.tnxItem.findMany({
				where: {
					year: value,
					active: true,
					balance: {
						gt: 0,
					},
				},
				include: {
					transaction: {
						select: {
							patient: true,
						},
					},
					fee: true,
				},
				orderBy: {
					updatedAt: "desc",
				},
			});
			res.status(200).json(found);
		} else if (criteria == "yearnmonth") {
			const found = await prisma.tnxItem.findMany({
				where: {
					year: value?.year,
					month: value?.month,
					active: true,
					balance: {
						gt: 0,
					},
				},
				include: {
					transaction: {
						select: {
							patient: true,
						},
					},
					fee: true,
				},
				orderBy: {
					updatedAt: "desc",
				},
			});
			res.status(200).json(found);
		} else if (criteria == "date") {
			const found = await prisma.tnxItem.findMany({
				where: {
					AND: [
						{
							updatedAt: {
								gte: new Date(new Date(value).setUTCHours(0, 0, 0, 0, 0)),
							},
						},
						{
							updatedAt: {
								lte: new Date(new Date(value).setUTCHours(23, 0, 0, 0, 0)),
							},
						},
						{ active: true },
						{
							balance: {
								gt: 0,
							},
						},
					],
				},
				include: {
					transaction: {
						select: {
							patient: true,
						},
					},
					fee: true,
				},
				orderBy: {
					updatedAt: "desc",
				},
			});
			res.status(200).json(found);
		} else if (criteria == "range") {
			const found = await prisma.tnxItem.findMany({
				where: {
					AND: [
						{
							updatedAt: {
								gte: new Date(new Date(value?.from).setUTCHours(0, 0, 0, 0, 0)),
							},
						},
						{
							updatedAt: {
								lte: new Date(new Date(value?.to).setUTCHours(23, 0, 0, 0, 0)),
							},
						},
						{ active: true },
						{
							balance: {
								gt: 0,
							},
						},
					],
				},
				include: {
					transaction: {
						select: {
							patient: true,
						},
					},
					fee: true,
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
router.post("/payments/:criteria", async (req, res) => {
	const { value } = req.body;
	const criteria = req.params.criteria;
	try {
		if (criteria == "year") {
			const found = await prisma.payment.findMany({
				where: {
					year: value,
				},
				include: {
					transaction: {
						select: {
							patient: true,
						},
					},
					createdBy: {
						select: {
							username: true,
						},
					},
				},
				orderBy: {
					updatedAt: "desc",
				},
			});
			res.status(200).json(found);
		} else if (criteria == "yearnmonth") {
			const found = await prisma.payment.findMany({
				where: {
					year: value?.year,
					month: value?.month,
				},
				include: {
					transaction: {
						select: {
							patient: true,
						},
					},
					createdBy: {
						select: {
							username: true,
						},
					},
				},
				orderBy: {
					updatedAt: "desc",
				},
			});
			res.status(200).json(found);
		} else if (criteria == "date") {
			const found = await prisma.payment.findMany({
				where: {
					AND: [
						{
							updatedAt: {
								gte: new Date(new Date(value).setUTCHours(0, 0, 0, 0, 0)),
							},
						},
						{
							updatedAt: {
								lte: new Date(new Date(value).setUTCHours(23, 0, 0, 0, 0)),
							},
						},
					],
				},
				include: {
					transaction: {
						select: {
							patient: true,
						},
					},
					createdBy: {
						select: {
							username: true,
						},
					},
				},
				orderBy: {
					updatedAt: "desc",
				},
			});
			res.status(200).json(found);
		} else if (criteria == "range") {
			const found = await prisma.payment.findMany({
				where: {
					AND: [
						{
							updatedAt: {
								gte: new Date(new Date(value?.from).setUTCHours(0, 0, 0, 0, 0)),
							},
						},
						{
							updatedAt: {
								lte: new Date(new Date(value?.to).setUTCHours(23, 0, 0, 0, 0)),
							},
						},
					],
				},
				include: {
					transaction: {
						select: {
							patient: true,
						},
					},
					createdBy: {
						select: {
							username: true,
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
// TRANSACTIONS END
export default router;
