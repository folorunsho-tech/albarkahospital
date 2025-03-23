import { Router } from "express";
import prisma from "../config/prisma.js";

const router = Router();

router.get("/", async (req, res) => {
	try {
		const found = await prisma.transactions.findMany({
			include: {
				items: true,
			},
		});
		res.status(200).json(found);
	} catch (error) {
		res.status(500).json(error);
	}
});
router.get("/:id", async (req, res) => {
	try {
		const found = await prisma.transactions.findMany({
			where: {
				id: req.params.id,
			},
			include: {
				items: true,
			},
		});
		res.status(200).json(found);
	} catch (error) {
		res.status(500).json(error);
	}
});

export default router;
