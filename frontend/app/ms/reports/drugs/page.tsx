"use client";

import Summary from "@/components/reports/drugs/Summary";
import { Tabs } from "@mantine/core";

const page = () => {
	return (
		<Tabs defaultValue='summary' keepMounted={false}>
			<Tabs.List>
				<Tabs.Tab value='summary'>Summary</Tabs.Tab>
			</Tabs.List>
			<Tabs.Panel value='summary' className='py-4'>
				<Summary />
			</Tabs.Panel>
		</Tabs>
	);
};

export default page;
