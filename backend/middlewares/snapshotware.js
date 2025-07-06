import prisma from "../config/prisma.js";
import { curMonth, curYear } from "../config/ynm.js";

export const createShot = async (req, res, next) => {
	try {
		const drugs = await prisma.drugsInventory.findMany({
			where: {
				OR: [
					{
						drugPurchases: {
							some: {
								month: curMonth,
								year: curYear,
							},
						},
					},
					{
						stockHistory: {
							some: {
								month: curMonth,
								year: curYear,
							},
						},
					},
					{
						givenHistory: {
							some: {
								month: curMonth,
								year: curYear,
							},
						},
					},
				],
			},
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
			res.status(200);
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
			res.status(200);
		}
		next();
	} catch (error) {
		console.log(error);
		res.status(500).json({ error: "Internal Server Error" });
	}
};
