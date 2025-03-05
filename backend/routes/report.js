import express from "express";
// import { PrismaClient } from "@prisma/client";
// const prisma = new PrismaClient();
import prisma from "../config/prisma.js";
const router = express.Router();

router.post("/:criteria", async (req, res) => {
	const { value } = req.body;
	const criteria = req.params.criteria;
	try {
		if (criteria == "year") {
			const drugsgiven = await prisma.drugsGiven.groupBy({
				by: ["name"],
				_sum: {
					quantity: true,
					price: true,
				},
				having: {
					quantity: {
						_sum: {
							gt: 0,
						},
					},
				},
				orderBy: {
					name: "asc",
				},
				where: {
					year: value,
				},
			});
			// const stocks = await prisma.stocksHistory.groupBy({
			// 	by: ["name"],
			// 	_sum: {
			// 		stock_qty: true,
			// 	},
			// 	orderBy: {
			// 		name: "asc",
			// 	},
			// 	where: {
			// 		year: value,
			// 	},
			// });

			res.status(200).json(drugsgiven);
		} else if (criteria == "yearnmonth") {
			const drugsgiven = await prisma.drugsGiven.groupBy({
				by: ["name"],
				_sum: {
					quantity: true,
					price: true,
				},
				having: {
					quantity: {
						_sum: {
							gt: 0,
						},
					},
				},
				orderBy: {
					name: "asc",
				},
				where: {
					year: value?.year,
					month: value?.month,
				},
			});
			// const stocks = await prisma.stocksHistory.groupBy({
			// 	by: ["name"],
			// 	_sum: {
			// 		stock_qty: true,
			// 	},
			// 	orderBy: {
			// 		name: "asc",
			// 	},
			// 	where: {
			// 		year: value?.year,
			// 		month: value?.month,
			// 	},
			// });

			res.status(200).json(drugsgiven);
		} else if (criteria == "date") {
			const drugsgiven = await prisma.drugsGiven.groupBy({
				by: ["name"],
				_sum: {
					quantity: true,
					price: true,
				},
				having: {
					quantity: {
						_sum: {
							gt: 0,
						},
					},
				},
				orderBy: {
					name: "asc",
				},
				where: {
					date: new Date(new Date(value).setUTCHours(0, 0, 0, 0, 0)),
				},
			});
			// const stocks = await prisma.stocksHistory.groupBy({
			// 	by: ["name"],
			// 	_sum: {
			// 		stock_qty: true,
			// 	},
			// 	orderBy: {
			// 		name: "asc",
			// 	},
			// 	where: {
			// 		createdAt: new Date(new Date(value).setUTCHours(0, 0, 0, 0, 0)),
			// 	},
			// });

			res.status(200).json(drugsgiven);
		} else if (criteria == "range") {
			const drugsgiven = await prisma.drugsGiven.groupBy({
				by: ["name"],
				_sum: {
					quantity: true,
					price: true,
				},
				having: {
					quantity: {
						_sum: {
							gt: 0,
						},
					},
				},
				orderBy: {
					name: "asc",
				},
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
			});
			// const stocks = await prisma.stocksHistory.groupBy({
			// 	by: ["name"],
			// 	_sum: {
			// 		stock_qty: true,
			// 	},
			// 	orderBy: {
			// 		name: "asc",
			// 	},
			// 	where: {
			// 		AND: [
			// 			{
			// 				createdAt: {
			// 					gte: new Date(new Date(value?.from).setUTCHours(0, 0, 0, 0, 0)),
			// 				},
			// 			},
			// 			{
			// 				createdAt: {
			// 					lte: new Date(new Date(value?.to).setUTCHours(0, 0, 0, 0, 0)),
			// 				},
			// 			},
			// 		],
			// 	},
			// });

			res.status(200).json(drugsgiven);
		}
	} catch (error) {
		res.status(500).json(error);
	}
});
export default router;
