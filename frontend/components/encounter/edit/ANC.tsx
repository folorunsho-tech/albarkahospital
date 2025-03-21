/* eslint-disable @typescript-eslint/no-explicit-any */
"use client";

import { useFetch, useEdit } from "@/queries";
import { Button, LoadingOverlay, Select } from "@mantine/core";
import { DatePickerInput } from "@mantine/dates";
import { useEffect, useState } from "react";

const ANC = ({ enc_id }: { enc_id: string | null }) => {
	const { fetch } = useFetch();
	const { edit, loading } = useEdit();
	const [ega, setEga] = useState<any>("");
	const [fe_diagnosis, setFDiag] = useState("");
	const [fe_no, setFeNo] = useState("");
	const [fe_liq_vol, setLiqVol] = useState("");
	const [fe_abnormality, setAbnormal] = useState("");
	const [fe_live, setLive] = useState("");
	const [placenta_pos, setPlacenta] = useState("");
	const [date, setDate] = useState<Date | null>(null);
	const [edd, setEDate] = useState<Date | null>(null);
	const [anc_id, setANCId] = useState<null | string>("");

	useEffect(() => {
		async function getData() {
			const { data } = await fetch(`/encounters/${enc_id}`);
			const anc = data?.anc[0];
			setANCId(anc?.id);
			setEga(anc?.ega);
			setFDiag(anc?.fe_diagnosis);
			setFeNo(anc?.fe_no);
			setLiqVol(anc?.fe_liq_vol);
			setAbnormal(anc?.fe_abnormality);
			setLive(anc?.fe_live);
			setPlacenta(anc?.placenta_pos);
			if (anc?.date) setDate(new Date(anc?.date));
			if (anc?.edd) setEDate(new Date(anc?.edd));
		}
		getData();
	}, []);
	return (
		<form
			className='flex flex-wrap gap-3 mt-4 items-end'
			onSubmit={async (e) => {
				e.preventDefault();
				await edit("/encounters/edit/anc/" + enc_id, {
					anc: {
						ega,
						fe_abnormality,
						fe_diagnosis,
						fe_no,
						fe_liq_vol,
						fe_live,
						placenta_pos,
						date,
						edd,
					},
					anc_id,
				});
			}}
		>
			<DatePickerInput
				label='ANC Date'
				value={date}
				placeholder='anc date'
				className='w-44'
				onChange={setDate}
				allowDeselect
				clearable
				closeOnChange={false}
			/>
			<DatePickerInput
				label='EDD Date'
				value={edd}
				placeholder='edd date'
				className='w-44'
				onChange={setEDate}
			/>
			<Select
				label='ANC EGA'
				placeholder='Select week(s)'
				data={[
					"1W",
					"2W",
					"3W",
					"4W",
					"5W",
					"6W",
					"7W",
					"8W",
					"9W",
					"10W",
					"11W",
					"12W",
					"13W",
					"14W",
					"15W",
					"16W",
					"17W",
					"18W",
					"19W",
					"20W",
					"21W",
					"22W",
					"23W",
					"24W",
					"25W",
					"26W",
					"27W",
					"28W",
					"29W",
					"30W",
					"31W",
					"32W",
					"33W",
					"34W",
					"35W",
					"36W",
					"37W",
					"38W",
					"39W",
					"40W",
					"Postdate",
				]}
				searchable
				clearable
				className='w-36'
				value={ega}
				onChange={setEga}
				nothingFoundMessage='Nothing found...'
			/>
			<Select
				label='Foetal Presentation'
				placeholder='Select a value'
				data={["Breech", "Cephalic", "Multiple", "Transverse"]}
				className='w-[12rem]'
				clearable
				value={fe_diagnosis}
				onChange={(value: any) => {
					setFDiag(value);
				}}
				nothingFoundMessage='Nothing found...'
			/>
			<Select
				label='Foetal No'
				placeholder='Select a no'
				data={["Singleton", "Twins", "Triplet"]}
				className='w-[12rem]'
				clearable
				value={fe_no}
				onChange={(value: any) => {
					setFeNo(value);
				}}
				nothingFoundMessage='Nothing found...'
			/>
			<Select
				label='Foetal Live'
				placeholder='Select a value'
				data={["Alive", "IUFD"]}
				className='w-[12rem]'
				clearable
				value={fe_live}
				onChange={(value: any) => {
					setLive(value);
				}}
				nothingFoundMessage='Nothing found...'
			/>
			<Select
				label='Foetal Abnormal'
				placeholder='Select a value'
				data={["Present", "Absent"]}
				className='w-[12rem]'
				clearable
				value={fe_abnormality}
				onChange={(value: any) => {
					setAbnormal(value);
				}}
				nothingFoundMessage='Nothing found...'
			/>
			<Select
				label='Foetal Liquid Vol.'
				placeholder='Select a value'
				data={["Adequate", "Reduced"]}
				className='w-[12rem]'
				clearable
				value={fe_liq_vol}
				onChange={(value: any) => {
					setLiqVol(value);
				}}
				nothingFoundMessage='Nothing found...'
			/>
			<Select
				label='Placenta Position'
				placeholder='Select a value'
				data={["Anterior", "Posterior", "Praevia"]}
				className='w-[12rem]'
				clearable
				value={placenta_pos}
				onChange={(value: any) => {
					setPlacenta(value);
				}}
				nothingFoundMessage='Nothing found...'
			/>
			<Button color='teal' w={200} type='submit'>
				Update ANC
			</Button>
			<LoadingOverlay visible={loading} />
		</form>
	);
};

export default ANC;
