/* eslint-disable @typescript-eslint/no-explicit-any */
"use client";

import { Text, Table, Select, Button, TextInput, Pill } from "@mantine/core";
import { usePostNormal, useFetch } from "@/queries";
import { useEffect, useState } from "react";
import DataLoader from "@/components/DataLoader";

import ReportsTable from "@/components/ReportsTable";

const page = () => {
	const { post, loading } = usePostNormal();
	const { fetch } = useFetch();
	const [queryData, setQueryData] = useState<any[]>([]);
	const [cares, setCares] = useState<any[]>([]);
	const [diagnosis, setDiagnosis] = useState<any[]>([]);
	const [sortedData, setSortedData] = useState<any[]>(queryData);
	const [value, setValue] = useState<any>("");
	const [criteria, setCriteria] = useState<string | null>("");
	const [loaded, setLoaded] = useState<any>("");
	const rows = sortedData?.map((row, i) => (
		<Table.Tr key={row?.id}>
			<Table.Td>{new Date(row?.enc_date).toLocaleDateString()}</Table.Td>
			<Table.Td>{row?.time}</Table.Td>
			<Table.Td>{row?.patient?.hosp_no}</Table.Td>
			<Table.Td>{row?.patient?.name}</Table.Td>
			<Table.Td>{row?.admitted ? "True" : "False"}</Table.Td>
			<Table.Td>{row?.care?.name}</Table.Td>
			<Table.Td>
				{row?.diagnosis?.length > 0 ? (
					<Pill>
						{row?.diagnosis?.length > 1
							? `${row?.diagnosis[0]?.name} + ${row?.diagnosis?.length - 1}`
							: row?.diagnosis[0]?.name}
					</Pill>
				) : (
					""
				)}
			</Table.Td>
			<Table.Td>{row?._count?.drugsGiven}</Table.Td>
			<Table.Td>{row?._count?.labTest}</Table.Td>
			<Table.Td>{row?.outcome}</Table.Td>
			<Table.Td>{row?.follow_ups[0]?.encounter?.diagnosis[0]?.name}</Table.Td>
		</Table.Tr>
	));

	const printRows = sortedData?.map((row, i) => (
		<Table.Tr key={row?.id}>
			<Table.Td>{new Date(row?.enc_date).toLocaleDateString()}</Table.Td>
			<Table.Td>{row?.time}</Table.Td>
			<Table.Td>{row?.patient?.hosp_no}</Table.Td>
			<Table.Td>{row?.patient?.name}</Table.Td>
			<Table.Td>{row?.admitted ? "True" : "False"}</Table.Td>
			<Table.Td>{row?.care?.name}</Table.Td>
			<Table.Td>
				{row?.diagnosis?.length > 0 ? (
					<Pill>
						{row?.diagnosis?.length > 1
							? `${row?.diagnosis[0]?.name} + ${row?.diagnosis?.length - 1}`
							: row?.diagnosis[0]?.name}
					</Pill>
				) : (
					""
				)}
			</Table.Td>
			<Table.Td>{row?._count?.drugsGiven}</Table.Td>
			<Table.Td>{row?._count?.labTest}</Table.Td>
			<Table.Td>{row?.outcome}</Table.Td>
			<Table.Td>{row?.follow_ups[0]?.encounter?.diagnosis[0]?.name}</Table.Td>
		</Table.Tr>
	));

	const getValuesUI = () => {
		if (criteria == "Care") {
			return (
				<Select
					label='Care'
					placeholder='search for or select a value'
					data={cares}
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
		if (criteria == "Diagnosis") {
			return (
				<Select
					label='Value'
					placeholder='search for or select a value'
					data={diagnosis}
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
		if (criteria == "Outcome") {
			return (
				<Select
					label='Outcome'
					placeholder='search for or select a value'
					data={[
						"Admited",
						"DAMA",
						"Dead",
						"Discharged",
						"PoliceCase",
						"ReferGH",
						"ReferFMC",
						"ReferUITH",
						"Treated",
					]}
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
		if (criteria == "Care") {
			const found = queryData?.filter((d: any) => d?.care?.name == value);
			setSortedData(found);
		}
		if (criteria == "Outcome") {
			const found = queryData?.filter((d: any) => d?.outcome == value);
			setSortedData(found);
		}
		if (criteria == "Referals") {
			const found = queryData?.filter((d: any) =>
				String(d?.outcome).includes("Refer")
			);
			setSortedData(found);
		}
		if (criteria == "Diagnosis") {
			const found = queryData?.filter((d: any) => d?.diagnosis?.length > 0);
			let data: any[] = [];
			found.forEach((enc: any) => {
				const returned = enc?.diagnosis?.filter(
					(diag: { id: string; name: string }) => diag.name == value
				);
				data = [...returned];
			});
			// console.log(data, found);
			setSortedData(data);
		}
		if (criteria == "Under-5 Malaria") {
			const found = queryData?.filter((d: any) => d?.diagnosis?.length > 0);
			// const data =  found?.
			console.log(found);
			// setSortedData(found);
		}

		if (criteria == "Follow-up ANC") {
			const found = queryData?.filter((d: any) => d?._count?.follow_ups > 0);
			const data = found?.filter(
				(dat: any) => dat?.follow_ups[0]?.encounter?.care?.name == "ANC"
			);
			setSortedData(data);
		}
		if (criteria == "New ANC Pts") {
			const found = queryData?.filter(
				(d: any) => d?._count?.anc > 0 && d?.care?.name == "ANC"
			);
			setSortedData(found);
		}
		if (criteria == "Follow-up Out-Pts") {
			const found = queryData?.filter((d: any) => d?._count?.follow_ups > 0);
			setSortedData(found);
		}
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
						"Care",
						"Diagnosis",
						"Outcome",
						"Referals",
						"Under-5 Malaria",
						"New ANC Pts",
						"Follow-up ANC",
						"Follow-up Out-Pts",
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
						// setCondition("equals");
					}}
				>
					Clear Filter
				</Button>
			</div>
		</form>
	);
	const getReport = () => {
		if (criteria && value) {
			return `Encounters report for ${criteria} --> ${value}`;
		}
		return "Encounters report for";
	};
	useEffect(() => {
		const getD = async () => {
			const { data } = await fetch("/settings/care");
			const { data: diags } = await fetch("/settings/diagnosis");
			const sorted = data.map((d: { name: string; id: string }) => {
				return d.name;
			});
			const sortedD = diags.map((d: { name: string; id: string }) => {
				return d.name;
			});

			setDiagnosis(sortedD);
			setCares(sorted);
		};
		getD();
	}, []);
	useEffect(() => {
		setSortedData(queryData);
		setCriteria(null);
		setValue(null);
		// setCondition("equals");
	}, [loaded]);
	return (
		<main className='space-y-6'>
			<div className='flex justify-between items-end'>
				<DataLoader
					link='/reports/encounters'
					post={post}
					setQueryData={setQueryData}
					setLoaded={setLoaded}
				/>

				<Text size='md' fw={600}>
					Encounters report
				</Text>
			</div>

			<ReportsTable
				headers={[
					"ENC Date",
					"ENC time",
					"Hosp No",
					"Patient",
					"Admitted",
					"Care",
					"Diagnosis",
					"Drugs Count",
					"Tests Count",
					"Outcome",
					"Follow Up To",
				]}
				printHeaders={[
					"ENC Date",
					"ENC time",
					"Hosp No",
					"Patient",
					"Admitted",
					"Care",
					"Diagnosis",
					"Drugs Count",
					"Tests Count",
					"Outcome",
					"Follow Up To",
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
