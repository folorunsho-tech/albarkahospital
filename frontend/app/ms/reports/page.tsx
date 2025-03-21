/* eslint-disable @typescript-eslint/no-explicit-any */
"use client";

import { Text, Table, Select, Button, TextInput } from "@mantine/core";
import { usePostNormal, useFetch } from "@/queries";
import { useEffect, useState } from "react";
import DataLoader from "@/components/DataLoader";

import ReportsTable from "@/components/ReportsTable";

const page = () => {
	const { post, loading } = usePostNormal();
	const { fetch } = useFetch();
	const [queryData, setQueryData] = useState<any[]>([]);
	const [towns, setTowns] = useState<any[]>([]);
	const [groups, setGroups] = useState<any[]>([]);
	const [sortedData, setSortedData] = useState<any[]>(queryData);
	const [value, setValue] = useState<any>("");
	const [criteria, setCriteria] = useState<string | null>("");
	const [loaded, setLoaded] = useState<any>("");
	const rows = sortedData?.map((row, i) => (
		<Table.Tr key={row?.id}>
			<Table.Td>{new Date(row?.reg_date).toLocaleDateString()}</Table.Td>
			<Table.Td>{row?.hosp_no}</Table.Td>
			<Table.Td>{row?.name}</Table.Td>
			<Table.Td>{row?.sex}</Table.Td>
			<Table.Td>{row?.age}</Table.Td>
			<Table.Td>{row?.occupation}</Table.Td>
			<Table.Td>{row?.religion}</Table.Td>
			<Table.Td>{row?.phone_no}</Table.Td>
			<Table.Td>{row?.town?.name}</Table.Td>
			<Table.Td>{row?.groups?.name}</Table.Td>
			<Table.Td>{row?._count?.encounters}</Table.Td>
			<Table.Td>{row?._count?.transactions}</Table.Td>
		</Table.Tr>
	));
	const printRows = sortedData?.map((row, i) => (
		<Table.Tr key={row?.id}>
			<Table.Td>{new Date(row?.reg_date).toLocaleDateString()}</Table.Td>
			<Table.Td>{row?.hosp_no}</Table.Td>
			<Table.Td>{row?.name}</Table.Td>
			<Table.Td>{row?.sex}</Table.Td>
			<Table.Td>{row?.age}</Table.Td>
			<Table.Td>{row?.occupation}</Table.Td>
			<Table.Td>{row?.religion}</Table.Td>
			<Table.Td>{row?.phone_no}</Table.Td>
			<Table.Td>{row?.town?.name}</Table.Td>
			<Table.Td>{row?.groups?.name}</Table.Td>
			<Table.Td>{row?._count?.encounters}</Table.Td>
			<Table.Td>{row?._count?.transactions}</Table.Td>
		</Table.Tr>
	));
	const getValuesUI = () => {
		if (criteria == "Sex") {
			return (
				<Select
					label='Value'
					placeholder='search for or select a value'
					data={["Male", "Female"]}
					className='w-[16rem]'
					searchable
					clearable
					value={value}
					onChange={(value) => {
						setValue(value);
					}}
				/>
			);
		}
		if (criteria == "Age") {
			return (
				<Select
					label='Value'
					placeholder='search for or select a value'
					data={["Male", "Female"]}
					className='w-[16rem]'
					searchable
					clearable
					value={value}
					onChange={(value) => {
						setValue(value);
					}}
				/>
			);
		}
		if (criteria == "Occupation") {
			return (
				<TextInput
					label='Occupation'
					placeholder='occupation'
					value={value}
					onChange={(e) => {
						setValue(e.currentTarget.value);
					}}
				/>
			);
		}
		if (criteria == "Religion") {
			return (
				<Select
					label='Value'
					placeholder='search for or select a value'
					data={["Islam", "Christianity", "Others"]}
					className='w-[16rem]'
					searchable
					clearable
					value={value}
					onChange={(value) => {
						setValue(value);
					}}
				/>
			);
		}
		if (criteria == "Address") {
			return (
				<Select
					label='Value'
					placeholder='search for or select a value'
					data={towns}
					className='w-[16rem]'
					searchable
					clearable
					value={value}
					onChange={(value) => {
						setValue(value);
					}}
				/>
			);
		}
		if (criteria == "Group") {
			return (
				<Select
					label='Value'
					placeholder='search for or select a value'
					data={groups}
					className='w-[16rem]'
					searchable
					clearable
					value={value}
					onChange={(value) => {
						setValue(value);
					}}
				/>
			);
		}
	};

	const getFilter = () => {
		if (criteria == "Sex") {
			const found = queryData?.filter((d: any) => d?.sex == value);
			setSortedData(found);
		}
		if (criteria == "Age") {
			const found = queryData?.filter((d: any) => d?.age == value);
			setSortedData(found);
		}
		if (criteria == "Occupation") {
			const found = queryData?.filter((d: any) =>
				String(d?.occupation).toLowerCase().includes(value)
			);
			setSortedData(found);
		}
		if (criteria == "Religion") {
			const found = queryData?.filter((d: any) => d?.religion == value);
			setSortedData(found);
		}
		if (criteria == "Address") {
			const found = queryData?.filter((d: any) => d?.town?.name == value);
			setSortedData(found);
		}
		if (criteria == "Group") {
			const found = queryData?.filter((d: any) => d?.groups?.name == value);
			setSortedData(found);
		}
		if (criteria == "New Out Patients") {
			const found = queryData?.filter((d: any) => d?._count?.encounters == 0);
			setSortedData(found);
		}
		// if (criteria == "Under 5yrs Out Patients") {
		// 	const found = queryData?.filter((d: any) => d?.age < '5y');
		// 	setSortedData(found);
		// }
	};
	const filters = (
		<form
			onSubmit={(e) => {
				e.preventDefault();
				getFilter();
			}}
			className='w-full'
		>
			<label htmlFor='filters'>Filters</label>
			<div id='filters' className='flex gap-3 items-end flex-wrap'>
				<Select
					label='Criteria'
					placeholder='select a criteria'
					data={[
						"Sex",
						"Age",
						"Occupation",
						"Religion",
						"Address",
						"Group",
						"New Out Patients",
						"Under 5yrs Out Patients",
					]}
					value={criteria}
					className='w-[16rem]'
					searchable
					clearable
					onChange={(value) => {
						setCriteria(value);
						setValue(null);
					}}
				/>
				{getValuesUI()}
				<Button type='submit'>Filter</Button>
				<Button
					color='red'
					onClick={() => {
						setSortedData(queryData);
						setCriteria(null);
						setValue(null);
					}}
				>
					Clear Filter
				</Button>
			</div>
		</form>
	);
	const getReport = () => {
		if (criteria && value) {
			return `Patients report for ${criteria} --> ${value}`;
		}
		return "Patients report for";
	};
	useEffect(() => {
		const getD = async () => {
			const { data } = await fetch("/settings/town");
			const { data: groups } = await fetch("/settings/groups");
			const sorted = data.map((d: { name: string; id: string }) => {
				return d.name;
			});
			const sortedG = groups.map((d: { name: string; id: string }) => {
				return d.name;
			});
			setTowns(sorted);
			setGroups(sortedG);
		};
		getD();
	}, []);
	useEffect(() => {
		setSortedData(queryData);
		setCriteria(null);
		setValue(null);
	}, [loaded]);
	return (
		<main className='space-y-6'>
			<div className='flex justify-between items-end'>
				<DataLoader
					link='/reports/patients'
					post={post}
					setQueryData={setQueryData}
					setLoaded={setLoaded}
				/>

				<Text size='md' fw={600}>
					Patients report
				</Text>
			</div>

			<ReportsTable
				headers={[
					"Reg Date",
					"Hosp No",
					"Name",
					"Sex",
					"Age",
					"Occupation",
					"Religion",
					"Phone No",
					"Address",
					"Group",
					"ENC Count",
					"TNX Count",
				]}
				printHeaders={[
					"Reg Date",
					"Hosp No",
					"Name",
					"Sex",
					"Age",
					"Occupation",
					"Religion",
					"Phone No",
					"Address",
					"Group",
					"ENC Count",
					"TNX Count",
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
				tableReport={getReport()}
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
