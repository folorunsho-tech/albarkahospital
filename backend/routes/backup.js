import express from "express";
import mysqldump from "mysqldump";
const router = express.Router();

router.get("/download", (req, res) => {
	const filePath = "./backup/hospital-backup.sql";
	res.download(
		filePath,
		"hospital-backup.sql", // Remember to include file extension
		(err) => {
			if (err) {
				res.status(400).send({
					error: err,
					msg: "Problem downloading the file",
				});
			}
		}
	);
});

router.post("/generate", async (req, res) => {
	try {
		await mysqldump({
			connection: {
				host: process.env.DB_HOST,
				password: process.env.DB_PASS,
				user: process.env.DB_USER,
				port: process.env.DB_PORT,
				database: process.env.DB_NAME,
				charset: "utf8",
			},
			dumpToFile: "./backup/hospital-backup.sql",
			dump: {
				schema: {
					table: {
						dropIfExist: true,
					},
				},
			},
		});
		res.status(200).json("Database succesfully backed-up");
	} catch (error) {
		res.status(500).json(error);
	}
});

export default router;
