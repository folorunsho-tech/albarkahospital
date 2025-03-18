import { Router } from "express";
// import { PrismaClient } from "@prisma/client";
// const prisma = new PrismaClient();
import prisma from "../config/prisma.js";

const router = Router();

// DIAGNOSIS LIST
router.get("/diagnosis", async (req, res) => {
	try {
		const found = await prisma.diagnosis.findMany({
			orderBy: {
				name: "asc",
			},
		});
		res.status(200).json(found);
	} catch (error) {
		res.status(500).json(error);
	}
});
router.get("/diagnosis/:id", async (req, res) => {
	try {
		const found = await prisma.diagnosis.findUnique({
			where: {
				id: req.params.id,
			},
		});
		if (!found) {
			res.status(404).json("Not found");
		}
		res.status(200).json(found);
	} catch (error) {
		res.status(500).json(error);
	}
});
router.post("/diagnosis", async (req, res) => {
	try {
		const created = await prisma.diagnosis.create({
			data: req.body,
		});
		res.status(200).json(created);
	} catch (error) {
		res.status(500).json(error);
	}
});
router.post("/diagnosis/many", async (req, res) => {
	try {
		const created = await prisma.diagnosis.createMany({
			data: [...req.body],
		});
		res.status(200).json(created);
	} catch (error) {
		res.status(500).json(error);
	}
});
router.post("/diagnosis/edit/:id", async (req, res) => {
	try {
		const updated = await prisma.diagnosis.update({
			where: {
				id: req.params.id,
			},
			data: req.body,
		});
		res.status(200).json(updated);
	} catch (error) {
		res.status(500).json(error);
	}
});
// DIAGNOSIS LIST

// PROCEDURES LIST
router.get("/procedures", async (req, res) => {
	try {
		const found = await prisma.procedures.findMany({
			orderBy: {
				name: "asc",
			},
		});
		res.status(200).json(found);
	} catch (error) {
		res.status(500).json(error);
	}
});
router.get("/procedures/:id", async (req, res) => {
	try {
		const found = await prisma.procedures.findUnique({
			where: {
				id: req.params.id,
			},
		});
		if (!found) {
			res.status(404).json("Not found");
		}
		res.status(200).json(found);
	} catch (error) {
		res.status(500).json(error);
	}
});
router.post("/procedures", async (req, res) => {
	try {
		const created = await prisma.procedures.create({
			data: req.body,
		});
		res.status(200).json(created);
	} catch (error) {
		res.status(500).json(error);
	}
});
router.post("/procedures/many", async (req, res) => {
	try {
		const created = await prisma.procedures.createMany({
			data: [...req.body],
		});
		res.status(200).json(created);
	} catch (error) {
		res.status(500).json(error);
	}
});
router.post("/procedures/edit/:id", async (req, res) => {
	try {
		const updated = await prisma.procedures.update({
			where: {
				id: req.params.id,
			},
			data: req.body,
		});
		res.status(200).json(updated);
	} catch (error) {
		res.status(500).json(error);
	}
});
// PROCEDURES LIST

// TESTS LIST
router.get("/tests", async (req, res) => {
	try {
		const found = await prisma.tests.findMany({
			orderBy: {
				name: "asc",
			},
		});
		res.status(200).json(found);
	} catch (error) {
		res.status(500).json(error);
	}
});
router.get("/tests/:id", async (req, res) => {
	try {
		const found = await prisma.tests.findUnique({
			where: {
				id: req.params.id,
			},
		});
		if (!found) {
			res.status(404).json("Not found");
		}
		res.status(200).json(found);
	} catch (error) {
		res.status(500).json(error);
	}
});
router.post("/tests", async (req, res) => {
	try {
		const created = await prisma.tests.create({
			data: req.body,
		});
		res.status(200).json(created);
	} catch (error) {
		res.status(500).json(error);
	}
});
router.post("/tests/many", async (req, res) => {
	try {
		const created = await prisma.tests.createMany({
			data: [...req.body],
		});
		res.status(200).json(created);
	} catch (error) {
		res.status(500).json(error);
	}
});
router.post("/tests/edit/:id", async (req, res) => {
	try {
		const updated = await prisma.tests.update({
			where: {
				id: req.params.id,
			},
			data: { ...req.body },
		});
		res.status(200).json(updated);
	} catch (error) {
		res.status(500).json(error);
	}
});
// TESTS LIST

// FEES LIST
router.get("/fees", async (req, res) => {
	try {
		const found = await prisma.fees.findMany({
			orderBy: {
				name: "asc",
			},
		});
		res.status(200).json(found);
	} catch (error) {
		res.status(500).json(error);
	}
});
router.get("/fees/:id", async (req, res) => {
	try {
		const found = await prisma.fees.findUnique({
			where: {
				id: req.params.id,
			},
		});
		if (!found) {
			res.status(404).json("Not found");
		}
		res.status(200).json(found);
	} catch (error) {
		res.status(500).json(error);
	}
});
router.post("/fees", async (req, res) => {
	try {
		const created = await prisma.fees.create({
			data: req.body,
		});
		res.status(200).json(created);
	} catch (error) {
		res.status(500).json(error);
	}
});
router.post("/fees/edit/:id", async (req, res) => {
	try {
		const updated = await prisma.fees.update({
			where: {
				id: req.params.id,
			},
			data: req.body,
		});
		res.status(200).json(updated);
	} catch (error) {
		res.status(500).json(error);
	}
});
// FEES LIST

// GROUPS LIST
router.get("/groups", async (req, res) => {
	try {
		const found = await prisma.groups.findMany({
			orderBy: {
				name: "asc",
			},
		});
		res.status(200).json(found);
	} catch (error) {
		res.status(500).json(error);
	}
});
router.get("/groups/:id", async (req, res) => {
	try {
		const found = await prisma.groups.findUnique({
			where: {
				id: req.params.id,
			},
		});
		if (!found) {
			res.status(404).json("Not found");
		}
		res.status(200).json(found);
	} catch (error) {
		res.status(500).json(error);
	}
});
router.post("/groups", async (req, res) => {
	try {
		const created = await prisma.groups.create({
			data: req.body,
		});
		res.status(200).json(created);
	} catch (error) {
		res.status(500).json(error);
	}
});
router.post("/groups/many", async (req, res) => {
	try {
		const created = await prisma.groups.createMany({
			data: [...req.body],
		});
		res.status(200).json(created);
	} catch (error) {
		res.status(500).json(error);
	}
});
router.post("/groups/edit/:id", async (req, res) => {
	try {
		const updated = await prisma.groups.update({
			where: {
				id: req.params.id,
			},
			data: req.body,
		});
		res.status(200).json(updated);
	} catch (error) {
		res.status(500).json(error);
	}
});
// GROUPS LIST

// CARE LIST
router.get("/care", async (req, res) => {
	try {
		const found = await prisma.care.findMany({
			orderBy: {
				name: "asc",
			},
		});
		res.status(200).json(found);
	} catch (error) {
		res.status(500).json(error);
	}
});
router.get("/care/:id", async (req, res) => {
	try {
		const found = await prisma.care.findUnique({
			where: {
				id: req.params.id,
			},
		});
		if (!found) {
			res.status(404).json("Not found");
		}
		res.status(200).json(found);
	} catch (error) {
		res.status(500).json(error);
	}
});
router.post("/care", async (req, res) => {
	try {
		const created = await prisma.care.create({
			data: req.body,
		});
		res.status(200).json(created);
	} catch (error) {
		res.status(500).json(error);
	}
});
router.post("/care/many", async (req, res) => {
	try {
		const created = await prisma.care.createMany({
			data: [...req.body],
		});
		res.status(200).json(created);
	} catch (error) {
		res.status(500).json(error);
	}
});
router.post("/care/edit/:id", async (req, res) => {
	try {
		const updated = await prisma.care.update({
			where: {
				id: req.params.id,
			},
			data: req.body,
		});
		res.status(200).json(updated);
	} catch (error) {
		res.status(500).json(error);
	}
});
// CARE LIST

// TOWN LIST
router.get("/town", async (req, res) => {
	try {
		const found = await prisma.town.findMany({
			orderBy: {
				name: "asc",
			},
		});
		res.status(200).json(found);
	} catch (error) {
		res.status(500).json(error);
	}
});
router.get("/town/:id", async (req, res) => {
	try {
		const found = await prisma.town.findUnique({
			where: {
				id: req.params.id,
			},
		});
		if (!found) {
			res.status(404).json("Not found");
		}
		res.status(200).json(found);
	} catch (error) {
		res.status(500).json(error);
	}
});
router.post("/town", async (req, res) => {
	try {
		const created = await prisma.town.create({
			data: req.body,
		});
		res.status(200).json(created);
	} catch (error) {
		res.status(500).json(error);
	}
});
router.post("/town/many", async (req, res) => {
	try {
		const created = await prisma.town.createMany({
			data: [...req.body],
		});
		res.status(200).json(created);
	} catch (error) {
		res.status(500).json(error);
	}
});
router.post("/town/edit/:id", async (req, res) => {
	try {
		const updated = await prisma.town.update({
			where: {
				id: req.params.id,
			},
			data: req.body,
		});
		res.status(200).json(updated);
	} catch (error) {
		res.status(500).json(error);
	}
});
// TOWN LIST

export default router;
