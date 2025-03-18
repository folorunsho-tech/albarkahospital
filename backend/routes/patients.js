import { Router } from "express";
// import { PrismaClient } from "@prisma/client";
// const prisma = new PrismaClient();
import prisma from "../config/prisma.js";

const router = Router();
export const curYear = String(new Date().getFullYear());
export const curMonthNo = new Date().getMonth();
router.get("/groups", async (req, res) => {
	try {
		const found = await prisma.groups.findMany();
		res.status(200).json(found);
	} catch (error) {
		res.status(500).json(error);
	}
});
router.post("/no", async (req, res) => {
	const { year } = req.body;
	try {
		const found = await prisma.patients.findMany({
			where: {
				year: Number(year),
			},
			select: {
				hosp_no: true,
			},
			orderBy: {
				hosp_no: "desc",
			},
		});
		const gotten = found[0];
		if (!gotten) {
			const card = `${curYear}/1`;
			res.status(200).json(card);
		} else {
			const splited = gotten.hosp_no?.split("/");
			const no = Number(splited[1]) + 1;
			const card = `${splited[0]}/${no}`;
			res.status(200).json(card);
		}
	} catch (error) {
		res.status(500).json(error);
	}
});
router.get("/", async (req, res) => {
	try {
		const found = await prisma.patients.findMany({
			include: {
				groups: true,
			},
		});
		res.status(200).json(found);
	} catch (error) {
		res.status(500).json(error);
	}
});
router.post("/many", async (req, res) => {
	try {
		const created = await prisma.patients.createMany({
			data: [...req.body],
		});
		res.status(200).json(created);
	} catch (error) {
		res.status(500).json(error);
	}
});
router.post("/transactions", async (req, res) => {
	const { id } = req.body;

	try {
		const found = await prisma.transactions.findMany({
			where: {
				patient_id: id,
			},
			include: {
				_count: {
					select: {
						items: true,
					},
				},
			},
		});
		res.status(200).json(found);
	} catch (error) {
		res.status(500).json(error);
	}
});
router.post("/encounters", async (req, res) => {
	const { id } = req.body;
	try {
		const found = await prisma.encounters.findMany({
			where: {
				patient_id: id,
			},

			include: {
				care: true,
				patient: true,
				_count: {
					select: {
						drugsGiven: true,
						labTest: true,
						diagnosis: true,
					},
				},
			},
		});
		res.status(200).json(found);
	} catch (error) {
		res.status(500).json(error);
	}
});
router.get("/:id", async (req, res) => {
	try {
		const found = await prisma.patients.findUnique({
			where: {
				id: req.params.id,
			},
			include: {
				groups: true,
				town: true,
				updatedBy: true,
			},
		});
		res.status(200).json(found);
	} catch (error) {
		res.status(500).json(error);
	}
});
router.post("/search", async (req, res) => {
	const { value } = req.body;

	try {
		if (value !== "") {
			const found = await prisma.patients.findMany({
				where: {
					OR: [
						{
							hosp_no: {
								contains: value,
							},
						},
						{
							name: {
								contains: value,
							},
						},
					],
				},
				take: 100,
				include: {
					encounters: {
						include: {
							care: true,
						},
					},
					groups: true,
					town: true,
				},
			});
			res.status(200).json(found);
		} else {
			res.status(200).json([]);
		}
	} catch (error) {
		res.status(500).json(error);
	}
});

router.post("/", async (req, res) => {
	try {
		const found = await prisma.patients.findFirst({
			where: {
				hosp_no: req.body.hosp_no,
			},
		});
		if (found) {
			res.status(400).json("already exist");
		} else {
			const created = await prisma.patients.create({
				data: {
					...req.body,
					reg_date: new Date(
						new Date(req.body.reg_date).setUTCHours(0, 0, 0, 0, 0)
					),
				},
				include: {
					groups: true,
				},
			});
			res.status(200).json(created);
		}
	} catch (error) {
		res.status(500).json(error);
	}
});
router.post("/edit/:id", async (req, res) => {
	try {
		const edited = await prisma.patients.update({
			where: {
				id: req.params.id,
			},
			data: {
				...req.body,
				reg_date: new Date(
					new Date(req.body.reg_date).setUTCHours(0, 0, 0, 0, 0)
				),
			},
			include: {
				updatedBy: true,
				groups: true,
			},
		});
		res.status(200).json(edited);
	} catch (error) {
		res.status(500).json(error);
	}
});

router.post("/:criteria", async (req, res) => {
	const { value } = req.body;
	const criteria = req.params.criteria;
	try {
		if (criteria == "year") {
			const found = await prisma.patients.findMany({
				where: {
					year: value,
				},
				include: {
					groups: true,
					town: true,
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
					groups: true,
					town: true,
				},
				orderBy: {
					updatedAt: "desc",
				},
			});

			res.status(200).json(found);
		} else if (criteria == "date") {
			const found = await prisma.patients.findMany({
				where: {
					reg_date: new Date(new Date(value).setUTCHours(0, 0, 0, 0, 0)),
				},
				include: {
					groups: true,
					town: true,
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
					groups: true,
					town: true,
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

export default router;
