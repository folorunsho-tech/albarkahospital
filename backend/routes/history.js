import prisma from "../config/prisma.js";
import { Router } from "express";
const router = Router();
// import { PrismaClient } from "@prisma/client";
// const prisma = new PrismaClient();
router.get("/", async (req, res) => {
	try {
		const history = await prisma.authHistory.findMany({
			include: {
				account: true,
			},
		});
		res.status(200).json(history);
	} catch (error) {
		res.status(500).json({
			message: {
				success: "",
				error: "Server Error",
			},
		});
		console.error(error);
	}
});

export default router;
