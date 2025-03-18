import express from "express";
// import { PrismaClient } from "@prisma/client";
// const prisma = new PrismaClient();
import prisma from "../config/prisma.js";
const router = express.Router();
const { createHash } = await import("node:crypto");
const hashpass = (password) => {
	return createHash("sha256").update(password).digest("hex");
};

router.get("/", async (req, res) => {
	try {
		const found = await prisma.accounts.findMany();
		res.status(200).json(found);
	} catch (error) {
		res.status(500).json(error);
	}
});
router.get("/history/:id", async (req, res) => {
	try {
		const found = await prisma.authHistory.findMany({
			where: {
				accountId: req.params.id,
			},
			include: {
				account: true,
			},
		});
		res.status(200).json(found);
	} catch (error) {
		res.status(500).json(error);
	}
});
router.post("/history/many", async (req, res) => {
	try {
		const created = await prisma.authHistory.createMany({
			data: [...req.body],
		});
		res.status(200).json(created);
	} catch (error) {
		res.status(500).json(error);
	}
});
router.get("/:account_id/basic", async (req, res) => {
	try {
		const found = await prisma.accounts.findUnique({
			where: {
				id: req.params.account_id,
			},
		});
		res.status(200).json(found);
	} catch (error) {
		res.status(500).json(error);
	}
});

router.get("/:account_id", async (req, res) => {
	try {
		const found = await prisma.accounts.findUnique({
			where: {
				id: req.params.account_id,
			},
			include: {
				authHistory: true,
				patients: true,
				encounters: true,
				drugsHistory: true,
				transactions: true,
			},
		});
		res.status(200).json(found);
	} catch (error) {
		res.status(500).json(error);
	}
});

router.post("/", async (req, res) => {
	const { username, password, menu, createdById, updatedById, role } = req.body;
	try {
		const created = await prisma.accounts.create({
			data: {
				passHash: hashpass(password),
				username,
				role,
				menu,
				createdById,
				updatedById,
			},
		});
		res.status(200).json(created);
	} catch (error) {
		res.status(500).json(error);
	}
});
router.post("/many", async (req, res) => {
	try {
		const created = await prisma.accounts.createMany({
			data: [...req.body],
		});
		res.status(200).json(created);
	} catch (error) {
		res.status(500).json(error);
	}
});
router.post("/edit/:id", async (req, res) => {
	const { password, menu, updatedById, role, status } = req.body;
	try {
		if (password) {
			const updated = await prisma.accounts.update({
				where: {
					id: req.params.id,
				},
				data: {
					passHash: hashpass(password),
					menu,
					updatedById,
					role,
					status,
				},
			});
			res.status(200).json(updated);
		} else {
			const updated = await prisma.accounts.update({
				where: {
					id: req.params.id,
				},
				data: {
					menu,
					updatedById,
					role,
					status,
				},
			});
			res.status(200).json(updated);
		}
	} catch (error) {
		res.status(500).json(error);
	}
});
export default router;
