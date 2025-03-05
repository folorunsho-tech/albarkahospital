/* eslint-disable react-hooks/exhaustive-deps */
/* eslint-disable @typescript-eslint/no-explicit-any */
"use client";

import { NumberInput, Select } from "@mantine/core";
import { useEffect, useState } from "react";

const Delivery = ({ setDelivery }: { setDelivery: any }) => {
	const [anc, setAnc] = useState("");
	const [fDiag, setFDiag] = useState("");
	const [outcome, setOutcome] = useState("");
	useEffect(() => {
		setDelivery({
			anc: `${Number(anc)} Weeks`,
			fDiag,
			outcome,
		});
	}, [anc, fDiag, outcome]);
	return (
		<main className='flex gap-4 '>
			<NumberInput
				label='ANC ENG'
				placeholder='Input week(s)'
				suffix=' Weeks'
				className='w-max'
				min={1}
				max={44}
				value={anc}
				onChange={(value: any) => {
					setAnc(value);
				}}
			/>
			<Select
				label='Foetal Diagnosis'
				placeholder='Select a diagnosis'
				data={["Breech", "Cephalic", "IUFD", "Multiple", "Transverse"]}
				className='w-[20rem]'
				clearable
				value={fDiag}
				onChange={(value: any) => {
					setFDiag(value);
				}}
				nothingFoundMessage='Nothing found...'
			/>
			<Select
				label='Baby Outcome'
				placeholder='Select an outcome'
				data={[
					"Live Birth (F)",
					"Live Birth (M)",
					"Live Multiple (F & F)",
					"Live Multiple (M & F)",
					"Live Multiple (M & M)",
					"Still Birth",
				]}
				className='w-[20rem]'
				clearable
				value={outcome}
				onChange={(value: any) => {
					setOutcome(value);
				}}
				nothingFoundMessage='Nothing found...'
			/>
		</main>
	);
};

export default Delivery;
