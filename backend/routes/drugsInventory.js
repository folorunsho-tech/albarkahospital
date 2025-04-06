import { Router } from "express";
import prisma from "../config/prisma.js";

const router = Router();
const months = [
	"January",
	"February",
	"March",
	"April",
	"May",
	"June",
	"July",
	"August",
	"September",
	"October",
	"November",
	"December",
];
router.get("/", async (req, res) => {
	try {
		const found = await prisma.drugsInventory.findMany({
			orderBy: {
				drug: "asc",
			},
		});
		res.status(200).json(found);
	} catch (error) {
		res.status(500).json(error);
	}
});
router.get("/report", async (req, res) => {
	try {
		const found = await prisma.drugsInventory.findMany({
			orderBy: {
				drug: "asc",
			},
			select: {
				drug: true,
			},
		});
		res.status(200).json(found);
	} catch (error) {
		res.status(500).json(error);
	}
});

router.get("/:id", async (req, res) => {
	try {
		const found = await prisma.drugsInventory.findFirst({
			where: {
				id: req.params.id,
			},
			include: {
				givenHistory: true,
				drugHistory: true,
				updatedBy: true,
				_count: {
					select: {
						givenHistory: true,
						drugHistory: true,
					},
				},
			},
		});
		res.status(200).json(found);
	} catch (error) {
		res.status(500).json(error);
	}
});

router.post("/", async (req, res) => {
	const {
		drug_id,
		stock_qty,
		added,
		rate,
		prevStock,
		createdById,
		updatedById,
		drug,
	} = req.body;
	try {
		const created = await prisma.drugsInventory.create({
			data: {
				drug_id,
				stock_qty,
				added,
				rate,
				createdById,
				updatedById,
				drug,
			},
		});
		const drugHist = await prisma.stocksHistory.create({
			data: {
				drug_id: created.id,
				updatedById: created.createdById,
				stock_qty: prevStock,
				added: created.added,
				month: months[new Date().getMonth()],
				year: new Date().getFullYear(),
				updatedAt: new Date(new Date().setUTCHours(0, 0, 0, 0, 0)),
				name: created.drug,
			},
		});
		res.status(200).json({ created, drugHist });
	} catch (error) {
		res.status(500).json(error);
	}
});
router.post("/many", async (req, res) => {
	try {
		const created = await prisma.drugsInventory.createMany({
			data: [...req.body],
		});

		res.status(200).json(created);
	} catch (error) {
		res.status(500).json(error);
	}
});

router.post("/edit/:id", async (req, res) => {
	const { drug_id, stock_qty, added, rate, prevStock, updatedById } = req.body;
	try {
		const updated = await prisma.drugsInventory.update({
			where: {
				id: req.params.id,
			},
			data: {
				drug_id,
				stock_qty,
				added,
				rate,
				updatedById,
			},
		});
		const drugHist = await prisma.stocksHistory.create({
			data: {
				drug_id: updated.id,
				updatedById: updated.updatedById,
				stock_qty: prevStock,
				added: updated.added,
				month: months[new Date().getMonth()],
				year: new Date().getFullYear(),
				updatedAt: new Date(new Date().setUTCHours(0, 0, 0, 0, 0)),
				name: updated.drug,
				type: "gain",
			},
		});
		res.status(200).json({ updated, drugHist });
	} catch (error) {
		res.status(500).json(error);
	}
});
router.post("/loss/:id", async (req, res) => {
	const { drug_id, stock_qty, added, rate, prevStock, updatedById } = req.body;
	try {
		const updated = await prisma.drugsInventory.update({
			where: {
				id: req.params.id,
			},
			data: {
				drug_id,
				stock_qty,
				added,
				rate,
				updatedById,
			},
		});
		const drugHist = await prisma.stocksHistory.create({
			data: {
				drug_id: updated.id,
				updatedById: updated.updatedById,
				stock_qty: prevStock,
				added: updated.added,
				month: months[new Date().getMonth()],
				year: new Date().getFullYear(),
				updatedAt: new Date(new Date().setUTCHours(0, 0, 0, 0, 0)),
				name: updated.drug,
				type: "loss",
			},
		});
		res.status(200).json({ updated, drugHist });
	} catch (error) {
		res.status(500).json(error);
	}
});

// DRUGS PURCHASES

router.get("/purchases", async (req, res) => {
	try {
		const found = await prisma.drugPurchases.findMany({
			include: {
				drug: true,
			},
		});

		res.status(200).json(found);
	} catch (error) {
		res.status(500).json(error);
	}
});

router.post("/purchases", async (req, res) => {
	try {
		const created = await prisma.drugPurchases.create({
			data: {
				...req.body,
				date: new Date(new Date(req.body.date).setUTCHours(0, 0, 0, 0, 0)),
			},
			include: { drug: true },
		});

		res.status(200).json(created);
	} catch (error) {
		res.status(500).json(error);
	}
});

router.post("/purchases/edit/:id", async (req, res) => {
	try {
		const updated = await prisma.drugPurchases.update({
			where: {
				id: req.params.id,
			},
			data: req.body,
		});

		res.status(200).json(updated);
	} catch (error) {
		res.status(500).json(error);
	}
});

router.post("/purchases/:criteria", async (req, res) => {
	const { value } = req.body;
	const criteria = req.params.criteria;

	try {
		if (criteria == "year") {
			const found = await prisma.drugPurchases.findMany({
				where: {
					year: value,
				},
				include: {
					drug: true,
				},
				orderBy: {
					createdAt: "desc",
				},
			});

			res.status(200).json(found);
		} else if (criteria == "yearnmonth") {
			const found = await prisma.drugPurchases.findMany({
				where: {
					year: value?.year,
					month: value?.month,
				},
				include: {
					drug: true,
				},
				orderBy: {
					createdAt: "desc",
				},
			});

			res.status(200).json(found);
		} else if (criteria == "date") {
			const found = await prisma.drugPurchases.findMany({
				where: {
					date: new Date(new Date(value).setUTCHours(0, 0, 0, 0, 0)),
				},
				include: {
					drug: true,
				},
				orderBy: {
					createdAt: "desc",
				},
			});
			res.status(200).json(found);
		} else if (criteria == "range") {
			const found = await prisma.drugPurchases.findMany({
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
					drug: true,
				},
				orderBy: {
					createdAt: "desc",
				},
			});

			res.status(200).json(found);
		}
	} catch (error) {
		res.status(500).json(error);
	}
});

// DRUGS PURCHSAES

// DRUGS STOCK HISTORY

router.post("/stocks/:criteria", async (req, res) => {
	const { value } = req.body;
	const criteria = req.params.criteria;

	try {
		if (criteria == "year") {
			const found = await prisma.stocksHistory.findMany({
				where: {
					year: value,
				},
				include: {
					drug: true,
				},
				orderBy: {
					createdAt: "desc",
				},
			});

			res.status(200).json(found);
		} else if (criteria == "yearnmonth") {
			const found = await prisma.stocksHistory.findMany({
				where: {
					year: value?.year,
					month: value?.month,
				},
				include: {
					drug: true,
				},
				orderBy: {
					createdAt: "desc",
				},
			});

			res.status(200).json(found);
		} else if (criteria == "date") {
			const found = await prisma.stocksHistory.findMany({
				where: {
					updatedAt: new Date(new Date(value).setUTCHours(0, 0, 0, 0, 0)),
				},
				include: {
					drug: true,
				},
				orderBy: {
					createdAt: "desc",
				},
			});
			res.status(200).json(found);
		} else if (criteria == "range") {
			const found = await prisma.stocksHistory.findMany({
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
					drug: true,
				},
				orderBy: {
					createdAt: "desc",
				},
			});

			res.status(200).json(found);
		}
	} catch (error) {
		res.status(500).json(error);
	}
});

// DRUGS STOCK HISTORY

export default router;
