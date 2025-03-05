/* eslint-disable react-hooks/exhaustive-deps */
/* eslint-disable @typescript-eslint/no-explicit-any */
"use client";

import { useEdit } from "@/queries";

import { Button, LoadingOverlay, NumberInput, Select } from "@mantine/core";
import { useEffect, useState } from "react";

const Delivery = ({
	data,
	id,
	getEnc,
}: {
	data: any;
	id: string | null;
	getEnc: any;
}) => {
	const { edit, loading } = useEdit();

	const [anc, setAnc] = useState("");
	const [fDiag, setFDiag] = useState("");
	const [outcome, setOutcome] = useState("");
	useEffect(() => {
		if (data !== null || data !== undefined) {
			const q = JSON.parse(data);
			setAnc(q?.anc_ega);
			setFDiag(q?.foetal_diag);
			setOutcome(q?.baby_outcome);
		}
		getEnc();
	}, []);
	return (
		<form
			className='flex flex-col gap-4 mt-4'
			onSubmit={async (e) => {
				e.preventDefault();
				const { data } = await edit("/encounters/edit/delivery/" + id, {
					foetal_diag: fDiag,
					anc_ega: anc,
					baby_outcome: outcome,
				});
				const q = JSON.parse(data?.delivery);
				setAnc(q?.anc_ega);
				setFDiag(q?.foetal_diag);
				setOutcome(q?.baby_outcome);
			}}
		>
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
			<Button color='teal' w={200} type='submit'>
				Update delivery
			</Button>
			<LoadingOverlay visible={loading} />
		</form>
	);
};

export default Delivery;
