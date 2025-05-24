import express from "express";
import { config } from "dotenv";
import cors from "cors";
import accounts from "./routes/accounts.js";
import auth from "./routes/auth.js";
import backup from "./routes/backup.js";
import report from "./routes/report.js";
import snapshot from "./routes/snapshot.js";
import settings from "./routes/settings.js";
import patients from "./routes/patients.js";
import encounters from "./routes/encounters.js";
import drugsInventory from "./routes/drugsInventory.js";
import transactions from "./routes/transactions.js";
import { verifyToken } from "./middlewares/jwt.js";
import cron from "node-cron";
import mysqldump from "mysqldump";
import prisma from "./config/prisma.js";
import { curMonth, curYear } from "./config/ynm.js";

const app = express();
const port = 8000;
config();
app.use(express.json());
app.use(cors());
app.use("/auth", auth);
app.use("/backup", backup);
app.use("/accounts", verifyToken, accounts);
app.use("/reports", verifyToken, report);
app.use("/snapshot", verifyToken, snapshot);
app.use("/patients", verifyToken, patients);
app.use("/transactions", verifyToken, transactions);
app.use("/encounters", verifyToken, encounters);
app.use("/drugsinventory", verifyToken, drugsInventory);
app.use("/settings", verifyToken, settings);
app.get("/", (req, res) => {
	res.send("<h2>Welcome</h2>");
});

cron.schedule(
	"*/30 * * * *",
	async () => {
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
		console.log("Backed Up Successfully");
	},
	{
		scheduled: true,
	}
);
cron.schedule(
	"*/59 * * * *",
	async () => {
		try {
			const drugs = await prisma.drugsInventory.findMany({
				// where: {
				// 	OR: [
				// 		{
				// 			drugPurchases: {
				// 				some: {
				// 					month: curMonth,
				// 					year: curYear,
				// 				},
				// 			},
				// 		},
				// 		{
				// 			stockHistory: {
				// 				some: {
				// 					month: curMonth,
				// 					year: curYear,
				// 				},
				// 			},
				// 		},
				// 		{
				// 			givenHistory: {
				// 				some: {
				// 					month: curMonth,
				// 					year: curYear,
				// 				},
				// 			},
				// 		},
				// 	],
				// },
				select: {
					drug: true,
					stock_qty: true,
					stockHistory: {
						select: {
							added: true,
							type: true,
						},
					},

					drugPurchases: {
						select: {
							quantity: true,
							price: true,
						},
					},
					givenHistory: {
						select: {
							quantity: true,
						},
					},
				},

				orderBy: {
					drug: "asc",
				},
			});
			const final = drugs.map((drug) => {
				return {
					name: drug.drug,
					curr_stock: drug.stock_qty,
					totalSLoss: drug.stockHistory.reduce((acc, stock) => {
						if (stock.type === "loss") {
							return acc + stock.added;
						}
						return acc;
					}, 0),
					totalSGain: drug.stockHistory.reduce((acc, stock) => {
						if (stock.type === "gain") {
							return acc + stock.added;
						}
						return acc;
					}, 0),
					prescriptions: drug.givenHistory.reduce((acc, given) => {
						return acc + given.quantity;
					}, 0),
					// totalPurchasePrice: drug.drugPurchases.reduce((acc, purchase) => {
					// 	return acc + purchase.price;
					// }, 0),
					totalPurchaseQty: drug.drugPurchases.reduce((acc, purchase) => {
						return acc + purchase.quantity;
					}, 0),
				};
			});
			//Check if a snapshot for the current month and year already exists
			const existingSnapshot = await prisma.snapshot.findFirst({
				where: {
					month: curMonth,
					year: curYear,
					type: "drugs",
				},
			});
			if (existingSnapshot) {
				// Update the existing snapshot
				await prisma.snapshot.update({
					where: {
						id: existingSnapshot.id,
					},
					data: {
						data: final,
					},
				});
				console.log("done exiting");
			} else {
				// Create a new snapshot
				await prisma.snapshot.create({
					data: {
						month: curMonth,
						year: curYear,
						type: "drugs",
						data: final,
					},
				});
				console.log("done");
			}
		} catch (error) {
			console.log(error);
		}
	},
	{
		scheduled: true,
	}
);

app.listen(port, () => {
	console.log(`Albarka server listening on port ${port}`);
});
