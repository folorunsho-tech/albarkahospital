const { createHash } = await import("node:crypto");
import { Router } from "express";
// import { PrismaClient } from "@prisma/client";
// const prisma = new PrismaClient();
import prisma from "../config/prisma.js";

const router = Router();
import mysqldump from "mysqldump";
const hashpass = (password) => {
	return createHash("sha256").update(password).digest("hex");
};
router.post("/login", async (req, res) => {
	const { username, password } = req.body;
	try {
		const user = await prisma.accounts.findFirst({
			where: {
				username,
				passHash: hashpass(password),
			},
		});
		if (!user) {
			res.status(404).json("Invalid Credentials");
		} else {
			const authHist = await prisma.authHistory.create({
				data: {
					accountId: user.id,
					loggedInAt: new Date(),
				},
			});
			await mysqldump({
				connection: {
					host: process.env.DB_HOST,
					password: process.env.DB_PASS,
					user: process.env.DB_USER,
					port: process.env.DB_PORT,
					database: process.env.DB_NAME,
					charset: "utf8",
				},
				dumpToFile: "../db/backup/hospital-backup.sql",
				dump: {
					schema: {
						table: {
							dropIfExist: true,
						},
					},
				},
			});
			res.status(200).json({ user, authId: authHist?.id });
		}
	} catch (error) {
		res.status(500).status(error);
	}
});
router.post("/logout", async (req, res) => {
	const { id } = req.body;
	try {
		await prisma.authHistory.update({
			where: {
				id,
			},
			data: {
				loggedOutAt: new Date(),
			},
		});
		await mysqldump({
			connection: {
				host: process.env.DB_HOST,
				password: process.env.DB_PASS,
				user: process.env.DB_USER,
				port: process.env.DB_PORT,
				database: process.env.DB_NAME,
				charset: "utf8",
			},
			dumpToFile: "../db/backup/hospital-backup.sql",
			dump: {
				schema: {
					table: {
						dropIfExist: true,
					},
				},
			},
		});
		res.status(200).json("User logged out");
	} catch (error) {
		res.status(500).json(error);
	}
});
export default router;
