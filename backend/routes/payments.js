import { Router } from "express";
// import { PrismaClient } from "@prisma/client";
// const prisma = new PrismaClient();
import prisma from "../config/prisma.js";

const router = Router();

router.get("/", async (req, res) => {
	try {
		const found = await prisma.payments.findMany();
		res.status(200).json(found);
	} catch (error) {
		res.status(500).json(error);
	}
});

router.get("/byYear/:year", async (req, res) => {
	try {
		const found = await prisma.payments.findMany({
			where: {
				year: req.params.year,
			},
		});
		res.status(200).json(found);
	} catch (error) {
		res.status(500).json(error);
	}
});
router.get("/byMonth/:year/:month", async (req, res) => {
	try {
		const found = await prisma.payments.findMany({
			where: {
				year: req.params.year,
				month: req.params.month,
			},
		});
		res.status(200).json(found);
	} catch (error) {
		res.status(500).json(error);
	}
});
router.get("/byDate/:date", async (req, res) => {
	try {
		const found = await prisma.payments.findMany({
			where: {
				date: req.params.date,
			},
		});
		res.status(200).json(found);
	} catch (error) {
		res.status(500).json(error);
	}
});
router.get("/:id", async (req, res) => {
	try {
		const found = await prisma.payments.findUnique({
			where: {
				id: req.params.id,
			},
		});
		res.status(200).json(found);
	} catch (error) {
		res.status(500).json(error);
	}
});
router.post("/", async (req, res) => {
	try {
		const created = await prisma.payments.create({
			data: req.body,
		});
		res.status(200).json(created);
	} catch (error) {
		res.status(500).json(error);
	}
});
router.post("/edit/:id", async (req, res) => {
	const { status, paid } = req.body;
	try {
		const updated = await prisma.payments.update({
			where: {
				id: req.params.id,
			},
			data: {
				status,
				paid,
			},
		});
		res.status(200).json(updated);
	} catch (error) {
		res.status(500).json(error);
	}
});
export default router;
