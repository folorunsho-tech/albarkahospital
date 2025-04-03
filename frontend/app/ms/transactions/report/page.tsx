"use client";
import Debtors from "@/components/reports/tnx/Debtors";
import Payments from "@/components/reports/tnx/Payments";
import { Tabs } from "@mantine/core";
const page = () => {
	return (
		<Tabs defaultValue='payments' keepMounted={false} color='teal'>
			<Tabs.List grow justify='space-between'>
				<Tabs.Tab value='payments'>Payments</Tabs.Tab>
				<Tabs.Tab value='debtors'>Debtors</Tabs.Tab>
			</Tabs.List>
			<Tabs.Panel value='payments' className='py-4'>
				<Payments />
			</Tabs.Panel>
			<Tabs.Panel value='debtors' className='py-4'>
				<Debtors />
			</Tabs.Panel>
		</Tabs>
	);
};

export default page;
