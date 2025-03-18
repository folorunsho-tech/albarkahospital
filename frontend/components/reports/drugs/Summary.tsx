/* eslint-disable @typescript-eslint/no-explicit-any */
"use client";

import { Button, Text, NumberFormatter, Table, Select } from "@mantine/core";

import { ArrowLeft, Printer } from "lucide-react";
import { usePostNormal } from "@/queries";
import { useState, useRef } from "react";
import { useReactToPrint } from "react-to-print";
import DataLoader from "@/components/DataLoader";
import { format } from "date-fns";
import Link from "next/link";
import ReportsTable from "@/components/ReportsTable";
const Summary = () => {
	const { post, loading } = usePostNormal();
	const [queryData, setQueryData] = useState<any[]>([]);
	const [sortedData, setSortedData] = useState<any[]>([]);
	const [filter, setFilter] = useState("");

	const rows = sortedData?.map((row, i) => (
		<Table.Tr key={row?.name + i}>
			<Table.Td>{i + 1}</Table.Td>
			<Table.Td>{row?.name}</Table.Td>
			<Table.Td>
				<NumberFormatter value={row?._sum?.quantity} thousandSeparator />
			</Table.Td>
			<Table.Td>
				<NumberFormatter
					prefix='N '
					value={row?._sum?.price}
					thousandSeparator
				/>
			</Table.Td>
		</Table.Tr>
	));
	const printRows = sortedData?.map((row, i) => (
		<Table.Tr key={row?.name + i}>
			<Table.Td>{i + 1}</Table.Td>
			<Table.Td>{row?.name}</Table.Td>
			<Table.Td>
				<NumberFormatter value={row?._sum?.quantity} thousandSeparator />
			</Table.Td>
			<Table.Td>
				<NumberFormatter
					prefix='N '
					value={row?._sum?.price}
					thousandSeparator
				/>
			</Table.Td>
		</Table.Tr>
	));
	const filters = (
		<div className='flex gap-3 items-end flex-wrap'>
			<Select
				label='Filters'
				placeholder='select filter'
				data={[]}
				value={filter}
				searchable
				clearable
				onChange={(value: any) => {
					setFilter(value);
				}}
			/>
		</div>
	);
	return (
		<main className='space-y-6'>
			<div className='flex justify-between items-end'>
				<Link
					className='bg-blue-500 hover:bg-blue-600 p-1 px-2 rounded-lg text-white flex gap-3'
					href='/ms/drugs'
				>
					<ArrowLeft />
					Go back
				</Link>
				{/* <DataLoader
					link='/report/drugs'
					post={post}
					setQueryData={setQueryData}
				/> */}

				<Text size='md'>Drugs report summary</Text>
			</div>

			<ReportsTable
				headers={["S/N", "Drug", "Total prescription", "Total price"]}
				printHeaders={["S/N", "Drug", "Total prescription", "Total price"]}
				sortedData={sortedData}
				setSortedData={setSortedData}
				data={queryData}
				tableLoading={loading}
				rows={rows}
				printRows={printRows}
				showSearch={false}
				filters={filters}
				filter={filter}
				tableReport='Drugs report summary'
			/>
		</main>
	);
};

export default Summary;
