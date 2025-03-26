"use client";

import { useState } from "react";
import { usePostT } from "@/queries";
import {
	Button,
	Group,
	LoadingOverlay,
	ScrollArea,
	Select,
} from "@mantine/core";
import { months } from "@/lib/ynm";
import { useRouter } from "next/navigation";
import Admission from "../create/Admission";
import Diagnosis from "../create/Diagnosis";
import DrugsGiven from "../create/DrugsGiven";
import Labtest from "../create/Labtest";
import ANCC from "../create/ANC";
import { format } from "date-fns";

const ANC = ({
	careId,
	patient_id,
	follow_up_to,
	enc_date,
}: {
	careId: string;
	patient_id: string;
	follow_up_to: string | null;
	enc_date: Date | null;
}) => {
	const { post, loading } = usePostT();
	const [drugsGiven, setDrugsGiven] = useState<any[]>([]);
	const [admission, setAdmission] = useState(null);
	const [labTest, setLabTest] = useState([]);
	const [diagnosis, setDiagnosis] = useState([]);
	const [outcome, setOutcome] = useState<null | string>(null);
	const [posted, setPosted] = useState(false);
	const [anc, setANC] = useState(null);
	const router = useRouter();
	const handleSubmit = async () => {
		await post("/encounters/create/anc", {
			careId,
			patient_id,
			month: months[new Date().getMonth()],
			year: new Date().getFullYear(),
			time: format(new Date(), "p"),
			diagnosis,
			drugsGiven,
			labTest,
			enc_date,
			outcome,
			follow_up_to,
			admission,
			admitted: outcome == "Admitted" ? true : false,
			stock_updates: drugsGiven.map((drug) => {
				return {
					id: drug?.id,
					stock_qty: drug?.curr_stock,
				};
			}),
			anc,
		});
		setPosted(true);
		setDrugsGiven([]);
		setLabTest([]);
		setDiagnosis([]);
		setOutcome(null);
		setPosted(false);
	};
	return (
		<form
			onSubmit={(e) => {
				e.preventDefault();
				handleSubmit();
			}}
		>
			<ScrollArea h={500}>
				<section className='space-y-4'>
					<Diagnosis setDiagnosis={setDiagnosis} diagnosis={diagnosis} />
					<div className='flex flex-col gap-2'>
						<label className='font-bold underline'>ANC</label>
						<ANCC setANC={setANC} />
					</div>
					<div className='flex flex-col gap-2'>
						<label className='font-bold underline'>Pharmacy</label>
						<DrugsGiven
							setDrugsGiven={setDrugsGiven}
							drugsGiven={drugsGiven}
							posted={posted}
						/>
					</div>
					<div className='flex flex-col gap-2'>
						<label className='font-bold underline'>Lab</label>
						<Labtest setLabTest={setLabTest} labTest={labTest} />
					</div>

					<Select
						placeholder='outcome'
						label='Outcome'
						className='w-max'
						data={[
							"Admitted",
							"DAMA",
							"Dead",
							"Discharged",
							"Police Case",
							"ReferGH",
							"ReferFMC",
							"ReferUITH",
							"Treated",
						]}
						onChange={(value) => {
							setOutcome(value);
						}}
					/>
					{outcome == "Admitted" && (
						<div className='flex flex-col gap-2'>
							<label className='font-bold underline'>Admission</label>
							<Admission setAdmission={setAdmission} />
						</div>
					)}
				</section>
			</ScrollArea>
			<Group mt={20} justify='start'>
				<Button
					onClick={() => {
						router.push("/ms/encounters");
					}}
					color='black'
				>
					Cancel
				</Button>
				<Button type='submit'>Add encounter</Button>
			</Group>
			<LoadingOverlay visible={loading} />
		</form>
	);
};

export default ANC;
