import { Router } from "express";
// import { PrismaClient } from "@prisma/client";
// const prisma = new PrismaClient();
import prisma from "../config/prisma.js";

const router = Router();

router.post("/", async (req, res) => {
	const { hosp_no } = req.body;
	try {
		const found = await prisma.drugsGiven.findMany({
			where: {
				encounter: {
					hosp_no,
				},
			},
			include: {
				encounter: {
					select: {
						patient: {
							select: {
								name: true,
								hosp_no: true,
							},
						},
					},
				},
			},
		});
		res.status(200).json(found);
	} catch (error) {
		res.status(500).json(error);
	}
});

// router.post("/:id", async (req, res) => {
// 	try {
// 		const created = await prisma.drugsGiven.update({
// 			where: {
// 				id: req.params.id,
// 			},
// 			data: req.body,
// 		});
// 		res.status(200).json(created);
// 	} catch (error) {
// 		res.status(500).json(error);
// 	}
// });

export default router;
