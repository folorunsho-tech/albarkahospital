/* eslint-disable @typescript-eslint/no-explicit-any */
"use client";

import { useFetch } from "@/queries";
import { Select } from "@mantine/core";
import { DatePickerInput } from "@mantine/dates";
import { useEffect, useState } from "react";
const Procedures = ({
	setProcedure,
	procedure,
	proc_date,
	setProcDate,
}: {
	setProcedure: any;
	procedure: string;
	setProcDate: any;
	proc_date: Date;
}) => {
	const { fetch } = useFetch();
	const [proceduresList, setProceduresList] = useState([]);
	const getAll = async () => {
		const { data } = await fetch("/settings/procedures");
		const mapped = data?.map((proc: any) => {
			return {
				value: proc?.id,
				label: proc?.name,
			};
		});
		setProceduresList(mapped);
	};
	useEffect(() => {
		getAll();
	}, []);
	return (
		<main className='flex gap-6 items-end'>
			<Select
				label='Procedures'
				placeholder='Select aprocedures'
				data={proceduresList}
				value={procedure}
				clearable
				onFocus={getAll}
				onChange={(value: any) => {
					setProcedure(value);
				}}
				searchable
				nothingFoundMessage='Nothing found...'
			/>
			<DatePickerInput
				label='Procedure date'
				placeholder='proc. date...'
				className='w-44'
				value={proc_date}
				onChange={setProcDate}
			/>
		</main>
	);
};

export default Procedures;
