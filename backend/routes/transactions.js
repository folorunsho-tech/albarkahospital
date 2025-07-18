import { Router } from "express";
import prisma from "../config/prisma.js";
import { nanoid } from "nanoid";
import { curMonth, curYear } from "../config/ynm.js";
import { generator, Rgenerator } from "../config/tnxIdGen.js";
const router = Router();

router.get("/id", async (req, res) => {
	try {
		const id = await Rgenerator("2504001");
		res.status(200).json(id);
	} catch (error) {
		res.status(500).json(error);
	}
});

router.get("/", async (req, res) => {
	try {
		const found = await prisma.transaction.findMany({
			include: {
				include: {
					items: true,
					reciepts: true,
					patient: true,
				},
			},
		});
		res.status(200).json(found);
	} catch (error) {
		res.status(500).json(error);
	}
});
router.get("/payments/:id", async (req, res) => {
	const id = req.params.id;
	try {
		const found = await prisma.payment.findMany({
			where: {
				tnxId: id,
			},
			include: {
				createdBy: {
					select: {
						username: true,
					},
				},
			},
			orderBy: {
				updatedAt: "desc",
			},
		});
		res.status(200).json(found);
	} catch (error) {
		res.status(500).json(error);
		console.log(error);
	}
});
router.get("/reciepts/:id", async (req, res) => {
	const id = req.params.id;
	try {
		const found = await prisma.reciept.findMany({
			where: {
				tnxId: id,
			},
			include: {
				createdBy: {
					select: {
						username: true,
					},
				},
				transaction: {
					select: {
						patient: {
							include: {
								town: true,
							},
						},
					},
				},
			},
			orderBy: {
				updatedAt: "desc",
			},
		});
		res.status(200).json(found);
	} catch (error) {
		res.status(500).json(error);
		console.log(error);
	}
});
router.get("/info/:id", async (req, res) => {
	const id = req.params.id;
	try {
		const found = await prisma.transaction.findUnique({
			where: {
				id,
			},
			include: {
				items: {
					include: {
						fee: true,
					},
				},

				patient: true,
				updatedBy: {
					select: {
						username: true,
					},
				},
			},
		});
		res.status(200).json(found);
	} catch (error) {
		res.status(500).json(error);
		console.log(error);
	}
});
router.get("/:id", async (req, res) => {
	const id = req.params.id.substring(0, 7);
	try {
		const found = await prisma.transaction.findUnique({
			where: {
				id,
			},
			include: {
				items: {
					include: {
						fee: true,
					},
				},
				reciepts: true,
				patient: true,
				updatedBy: {
					select: {
						username: true,
					},
				},
			},
		});
		res.status(200).json(found);
	} catch (error) {
		res.status(500).json(error);
		console.log(error);
	}
});
router.post("/byPatient", async (req, res) => {
	const { value } = req.body;
	try {
		const found = await prisma.transaction.findMany({
			where: {
				patient: {
					OR: [
						{
							name: value,
						},
						{
							hosp_no: value,
						},
					],
				},
				balance: {
					gt: 0,
				},
			},
			include: {
				items: {
					include: {
						fee: true,
					},
				},
				reciepts: true,
				patient: true,
				updatedBy: {
					select: {
						username: true,
					},
				},
			},
		});
		res.status(200).json(found);
	} catch (error) {
		res.status(500).json(error);
		console.log(error);
	}
});
router.post("/balance/:id", async (req, res) => {
	const { balance, items, status, updatedById } = req.body;
	const id = req.params.id.substring(0, 7);
	const Items = items.map((item) => {
		return {
			id: nanoid(8),
			paid: item?.paid,
			price: item?.price,
			balance: item?.balance,
			name: item?.name,
			method: item?.method,
		};
	});
	const tnxItems = items.map((item) => {
		return {
			id: item?.id,
			paid: item?.mpaid,
			balance: item?.balance,
		};
	});
	const payments = items.map((item) => {
		return {
			id: nanoid(8),
			itemId: item?.id,
			paid: item?.paid,
			year: curYear,
			month: curMonth,
			name: item?.name,
			method: item?.method,
			type: "balance",
			createdById: updatedById,
		};
	});
	const recieptId = await Rgenerator(id);
	try {
		tnxItems.forEach(async (i) => {
			await prisma.tnxItem.update({
				where: {
					id: i?.id,
				},
				data: {
					paid: i?.paid,
					balance: i?.balance,
				},
			});
		});

		const updated = await prisma.transaction.update({
			where: {
				id,
			},
			data: {
				status,
				balance,
				payments: {
					createMany: {
						data: payments,
					},
				},
				reciepts: {
					create: {
						id: recieptId,
						items: JSON.stringify(Items),
						year: curYear,
						month: curMonth,
						status,
						createdById: updatedById,
					},
				},
				updatedById,
				updatedAt: new Date(),
			},
			select: {
				reciepts: {
					include: {
						createdBy: {
							select: {
								username: true,
							},
						},
						transaction: {
							select: {
								patient: {
									select: {
										name: true,
										hosp_no: true,
										phone_no: true,
										town: {
											select: {
												name: true,
											},
										},
									},
								},
							},
						},
					},
					orderBy: {
						createdAt: "desc",
					},
				},
				_count: {
					select: {
						items: true,
					},
				},
			},
		});
		res.status(200).json(updated);
	} catch (error) {
		res.status(500).json(error);
		console.log(error);
	}
});
router.post("/reversal/:id", async (req, res) => {
	const { status, toReverse, updatedById } = req.body;
	const id = req.params.id.substring(0, 7);
	const payments = toReverse.map((item) => {
		return {
			id: nanoid(8),
			itemId: item?.id,
			paid: item?.paid,
			year: curYear,
			month: curMonth,
			name: item?.name,
			method: "",
			type: "reversal",
			createdById: updatedById,
		};
	});
	// const recieptId = await Rgenerator(id);
	try {
		toReverse.forEach(async (i) => {
			await prisma.tnxItem.update({
				where: {
					id: i?.id,
				},
				data: {
					active: i?.active,
				},
			});
		});

		const updated = await prisma.transaction.update({
			where: {
				id,
			},
			data: {
				status,

				payments: {
					createMany: {
						data: payments,
					},
				},
				updatedById,
				updatedAt: new Date(),
				// reciepts: {
				// 	create: {
				// 		id: recieptId,
				// 		items: JSON.stringify(Items),
				// 		year: curYear,
				// 		month: curMonth,
				// 		status,
				// 		createdById: updatedById,
				// 	},
				// },
			},
			// select: {
			// 	reciepts: {
			// 		include: {
			// 			createdBy: {
			// 				select: {
			// 					username: true,
			// 				},
			// 			},
			// 			transaction: {
			// 				select: {
			// 					patient: {
			// 						select: {
			// 							name: true,
			// 							hosp_no: true,
			// 							phone_no: true,
			// 							town: {
			// 								select: {
			// 									name: true,
			// 								},
			// 							},
			// 						},
			// 					},
			// 				},
			// 			},
			// 		},
			// 		orderBy: {
			// 			createdAt: "desc",
			// 		},
			// 	},
			// 	_count: {
			// 		select: {
			// 			items: true,
			// 		},
			// 	},
			// },
		});
		res.status(200).json(updated);
	} catch (error) {
		res.status(500).json(error);
		console.log(error);
	}
});
router.post("/create", async (req, res) => {
	const { total, balance, items, status, patientId, createdById } = req.body;
	const Items = items.map((item) => {
		return {
			id: nanoid(8),
			feeId: item?.feeId,
			price: item?.price,
			paid: item?.paid,
			balance: item?.balance,
			year: curYear,
			month: curMonth,
			name: item?.name,
			method: item?.method,
		};
	});
	const tnxItems = Items.map((item) => {
		return {
			id: item?.id,
			feeId: item?.feeId,
			price: item?.price,
			paid: item?.paid,
			balance: item?.balance,
			year: curYear,
			month: curMonth,
		};
	});
	const payments = Items.map((item) => {
		return {
			id: nanoid(8),
			itemId: item?.id,
			paid: item?.paid,
			year: curYear,
			month: curMonth,
			name: item?.name,
			method: item?.method,
			createdById,
		};
	});
	const id = await generator(curYear, curMonth);
	try {
		const created = await prisma.transaction.create({
			data: {
				id,
				total,
				status,
				balance,
				patientId,
				items: {
					createMany: {
						data: tnxItems,
					},
				},
				payments: {
					createMany: {
						data: payments,
					},
				},
				year: curYear,
				month: curMonth,
				reciepts: {
					create: {
						id: `${id}${1}`,
						items: JSON.stringify(Items),
						year: curYear,
						month: curMonth,
						status,
						createdById,
					},
				},
				createdById,
			},
			select: {
				reciepts: {
					include: {
						createdBy: {
							select: {
								username: true,
							},
						},
						transaction: {
							select: {
								patient: {
									select: {
										name: true,
										hosp_no: true,
										phone_no: true,
										town: {
											select: {
												name: true,
											},
										},
									},
								},
							},
						},
					},
					orderBy: {
						createdAt: "desc",
					},
				},
				_count: {
					select: {
						items: true,
					},
				},
			},
		});
		res.status(200).json(created);
	} catch (error) {
		res.status(500).json(error);
		console.log(error);
	}
});
router.post("/:criteria", async (req, res) => {
	const { value } = req.body;
	const criteria = req.params.criteria;
	try {
		if (criteria == "year") {
			const found = await prisma.transaction.findMany({
				where: {
					year: value,
				},
				include: {
					_count: {
						select: {
							items: true,
						},
					},
					patient: {
						include: {
							town: true,
						},
					},
				},
				orderBy: {
					updatedAt: "desc",
				},
			});

			res.status(200).json(found);
		} else if (criteria == "yearnmonth") {
			const found = await prisma.transaction.findMany({
				where: {
					year: value?.year,
					month: value?.month,
				},
				include: {
					_count: {
						select: {
							items: true,
						},
					},
					patient: {
						include: {
							town: true,
						},
					},
				},
				orderBy: {
					updatedAt: "desc",
				},
			});

			res.status(200).json(found);
		} else if (criteria == "date") {
			const found = await prisma.transaction.findMany({
				where: {
					AND: [
						{
							updatedAt: {
								gte: new Date(new Date(value).setUTCHours(0, 0, 0, 0, 0)),
							},
						},
						{
							updatedAt: {
								lte: new Date(new Date(value).setUTCHours(23, 0, 0, 0, 0)),
							},
						},
					],
				},
				include: {
					_count: {
						select: {
							items: true,
						},
					},
					patient: {
						include: {
							town: true,
						},
					},
				},
				orderBy: {
					updatedAt: "desc",
				},
			});
			res.status(200).json(found);
		} else if (criteria == "range") {
			const found = await prisma.transaction.findMany({
				where: {
					AND: [
						{
							updatedAt: {
								gte: new Date(new Date(value?.from).setUTCHours(0, 0, 0, 0, 0)),
							},
						},
						{
							updatedAt: {
								lte: new Date(new Date(value?.to).setUTCHours(23, 0, 0, 0, 0)),
							},
						},
					],
				},
				include: {
					_count: {
						select: {
							items: true,
						},
					},
					patient: {
						include: {
							town: true,
						},
					},
				},
				orderBy: {
					updatedAt: "desc",
				},
			});

			res.status(200).json(found);
		}
	} catch (error) {
		res.status(500).json(error);
	}
});
export default router;
