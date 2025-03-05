/* eslint-disable @typescript-eslint/no-explicit-any */
"use client";

import { Select } from "@mantine/core";
import { useEffect, useState } from "react";
import { DatePickerInput } from "@mantine/dates";
import { curMonth, curMonthNo, curYear, months, years } from "@/lib/ynm";
// import { format } from "date-fns";

const DataLoader = ({
	link,
	setQueryData,
	post,
	updated,
	defaultLoad = "yearnmonth",
}: {
	link: string;
	setQueryData: any;
	post: any;
	updated?: boolean;
	defaultLoad?: string;
}) => {
	const [criteria, setCriteria] = useState(defaultLoad);
	const [cYear, setCYear] = useState<string | null>(curYear);
	const [cYnmY, setCYnmY] = useState<string | null>(curYear);
	const [cYnmM, setCYnmM] = useState<string | null>(curMonth);
	const [cDate, setCDate] = useState<Date>(new Date());
	const [from, setFrom] = useState<Date | null>(
		new Date(Number(curYear), curMonthNo, 2)
	);
	const [to, setTo] = useState<Date | null>(new Date());
	const loadValue = (criteria: string) => {
		if (criteria == "yearnmonth") {
			return (
				<div className='flex items-end gap-6'>
					<Select
						label='Load Year'
						placeholder='Select a year'
						data={years}
						value={cYnmY}
						allowDeselect={false}
						onChange={(yearvalue) => {
							setCYnmY(yearvalue);
						}}
					/>
					<Select
						label='Load Month'
						placeholder='Select a month'
						data={months}
						allowDeselect={false}
						value={cYnmM}
						onChange={(monthvalue: any) => {
							setCYnmM(monthvalue);
						}}
					/>
				</div>
			);
		} else if (criteria == "date") {
			return (
				<DatePickerInput
					label='Pick date'
					placeholder='Pick date'
					value={cDate}
					onChange={(datevalue: any) => {
						setCDate(datevalue);
					}}
				/>
			);
		} else if (criteria == "range") {
			return (
				<div className='flex items-start gap-4'>
					<DatePickerInput
						label='From date'
						placeholder='Pick a date'
						className='w-[10rem]'
						value={from}
						onChange={(datevalue) => {
							setFrom(datevalue);
						}}
					/>
					<DatePickerInput
						label='To date'
						placeholder='Pick a date'
						className='w-[10rem]'
						value={to}
						onChange={(datevalue) => {
							setTo(datevalue);
						}}
					/>
				</div>
			);
		} else {
			return (
				<Select
					label='Load Year'
					placeholder='Select a year'
					data={years}
					value={cYear}
					allowDeselect={false}
					onChange={(yearvalue) => {
						setCYear(yearvalue);
					}}
				/>
			);
		}
	};
	const getData = async () => {
		if (criteria == "year") {
			const { data } = await post(`${link}/${criteria}`, {
				value: Number(cYear),
			});
			setQueryData(data);
		} else if (criteria == "yearnmonth") {
			const { data } = await post(`${link}/${criteria}`, {
				value: { year: Number(cYnmY), month: cYnmM },
			});
			setQueryData(data);
		} else if (criteria == "date") {
			const { data } = await post(`${link}/${criteria}`, {
				value: cDate,
			});
			setQueryData(data);
		} else if (criteria == "range") {
			const { data } = await post(`${link}/${criteria}`, {
				value: { from, to },
			});
			setQueryData(data);
		}
	};
	useEffect(() => {
		getData();
	}, [criteria, cYear, cYnmY, cYnmM, cDate, to, updated]);
	return (
		<form
			className='flex items-end gap-6 '
			onSubmit={async (e) => {
				e.preventDefault();
				getData();
			}}
		>
			<Select
				label='Load data by criteria'
				placeholder='Select a criteria'
				value={criteria}
				data={[
					{ label: "Year", value: "year" },
					{ label: "Year and Month", value: "yearnmonth" },
					{ label: "Date", value: "date" },
					{ label: "Date range", value: "range" },
				]}
				allowDeselect={false}
				onChange={(value: any) => {
					setCriteria(value);
				}}
			/>
			{loadValue(criteria)}
			{/* <Button type='submit'>Load Data</Button> */}
		</form>
	);
};

export default DataLoader;
