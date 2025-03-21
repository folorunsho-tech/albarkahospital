/* eslint-disable @typescript-eslint/no-explicit-any */
"use client";

import { Text, Table, Select, Button } from "@mantine/core";
import { usePostNormal } from "@/queries";
import { useEffect, useState } from "react";
import DataLoader from "@/components/DataLoader";

import ReportsTable from "@/components/ReportsTable";

const page = () => {
	const { post, loading } = usePostNormal();
	const [queryData, setQueryData] = useState<any[]>([]);
	const [sortedData, setSortedData] = useState<any[]>(queryData);
	const [value, setValue] = useState<string | undefined | null>("");
	const [loaded, setLoaded] = useState<any>("");
	const rows = sortedData?.map((row, i) => (
		<Table.Tr key={row?.id}>
			<Table.Td>
				{new Date(row?.encounter?.enc_date).toLocaleDateString()}
			</Table.Td>
			<Table.Td>{row?.encounter?.patient?.hosp_no}</Table.Td>
			<Table.Td>{row?.encounter?.patient?.name}</Table.Td>
			<Table.Td>{row?.type}</Table.Td>
			<Table.Td>{new Date(row?.date).toLocaleDateString()}</Table.Td>
			<Table.Td>{new Date(row?.next_date).toLocaleDateString()}</Table.Td>
		</Table.Tr>
	));
	const printRows = sortedData?.map((row, i) => (
		<Table.Tr key={row?.id}>
			<Table.Td>
				{new Date(row?.encounter?.enc_date).toLocaleDateString()}
			</Table.Td>
			<Table.Td>{row?.encounter?.patient?.hosp_no}</Table.Td>
			<Table.Td>{row?.encounter?.patient?.name}</Table.Td>
			<Table.Td>{row?.type}</Table.Td>
			<Table.Td>{new Date(row?.date).toLocaleDateString()}</Table.Td>
			<Table.Td>{new Date(row?.next_date).toLocaleDateString()}</Table.Td>
		</Table.Tr>
	));

	const filters = (
		<form
			onSubmit={(e) => {
				e.preventDefault();
				const found = queryData?.filter((d: any) => d?.type == value);
				setSortedData(found);
			}}
			className='w-full'
		>
			<label htmlFor='filters'>Filters</label>
			<div id='filters' className='flex gap-3 items-end flex-wrap'>
				<Select
					label='Immunization type'
					placeholder='select a type'
					data={["TT", "EPI"]}
					className='w-[16rem]'
					clearable
					value={value}
					onChange={(value) => {
						setValue(value);
					}}
				/>

				<Button disabled={!value} type='submit'>
					Filter
				</Button>
				<Button
					color='red'
					onClick={() => {
						setSortedData(queryData);

						setValue(null);
					}}
				>
					Clear Filter
				</Button>
			</div>
		</form>
	);
	useEffect(() => {
		setSortedData(queryData);

		setValue(null);
	}, [loaded]);
	return (
		<main className='space-y-6'>
			<div className='flex justify-between items-end'>
				<DataLoader
					link='/reports/immunization'
					post={post}
					setQueryData={setQueryData}
					setLoaded={setLoaded}
				/>

				<Text size='md' fw={600}>
					Immunizations report
				</Text>
			</div>

			<ReportsTable
				headers={[
					"ENC Date",
					"Hosp No",
					"Patient",
					"Type",
					"Imm Date",
					"Next Appt. Date",
				]}
				printHeaders={[
					"ENC Date",
					"Hosp No",
					"Patient",
					"Type",
					"Imm Date",
					"Next Appt. Date",
				]}
				sortedData={sortedData}
				setSortedData={setSortedData}
				data={queryData}
				tableLoading={loading}
				rows={rows}
				printRows={printRows}
				showSearch={false}
				filters={filters}
				loaded={loaded}
				tableReport={`Immunizations report for Type --> ${value || ""}`}
				metadata={
					<div className='text-lg font-semibold my-2'>
						<h2>Total Count: {sortedData.length}</h2>
					</div>
				}
			/>
		</main>
	);
};

export default page;
