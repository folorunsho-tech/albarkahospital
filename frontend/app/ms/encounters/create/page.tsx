/* eslint-disable @typescript-eslint/no-explicit-any */
"use client";

import { useEffect, useState } from "react";
import { useFetch, usePostT } from "@/queries";
import { ArrowLeft } from "lucide-react";
import {
	Button,
	Group,
	LoadingOverlay,
	ScrollArea,
	Select,
	Text,
} from "@mantine/core";
import { DatePickerInput } from "@mantine/dates";
import { months } from "@/lib/ynm";
import PatientSearch from "@/components/PatientSearch";
import Diagnosis from "@/components/encounter/create/Diagnosis";
import DrugsGiven from "@/components/encounter/create/DrugsGiven";
import Labtest from "@/components/encounter/create/Labtest";
import Operations from "@/components/encounter/create/Operations";
import Delivery from "@/components/encounter/create/Delivery";
import { useRouter } from "next/navigation";
import Link from "next/link";
import ANC from "@/components/encounter/create/ANC";
import Immunization from "@/components/encounter/create/Immunization";
import Admission from "@/components/encounter/create/Admission";

const Create = () => {
	const { fetch } = useFetch();
	const { post, loading } = usePostT();
	const [drugsGiven, setDrugsGiven] = useState<any[]>([]);
	const [delivery, setDelivery] = useState(null);
	const [anc, setANC] = useState(null);
	const [immunization, setImmunization] = useState(null);
	const [admission, setAdmission] = useState(null);
	const [operation, setOperation] = useState(null);
	const [labTest, setLabTest] = useState([]);
	const [diagnosis, setDiagnosis] = useState([]);
	const [patientData, setPatientData] = useState<any>(null);
	const [cares, setCares] = useState([]);
	const [selectedP, setSelectedP] = useState("");
	const [care, setCare] = useState("");
	const [outcome, setOutcome] = useState<any>("");
	const [follow_up_to, setFollowUPTo] = useState<string | null>("");
	const [follow_ups, setFollowUps] = useState<any[]>([]);
	const [posted, setPosted] = useState(false);
	const [enc_date, setEncDate] = useState<any>(new Date());
	const router = useRouter();
	const getFollows = async () => {
		const { data } = await fetch(`/encounters/${patientData?.id}/followup`);
		const sorted = data.map((enc: any) => {
			return {
				value: enc?.id,
				label: `${enc?.care?.name} -- ${new Date(
					enc?.enc_date
				).toLocaleDateString()} at ${enc?.time}`,
			};
		});
		setFollowUps(sorted);
	};
	useEffect(() => {
		const getAll = async () => {
			const { data } = await fetch("/settings/care");
			const sorted = data.map((care: { id: string; name: string }) => {
				return {
					value: care.id,
					label: care.name,
				};
			});

			setCares(sorted);
		};
		getAll();
	}, []);
	const handleSubmit = async () => {
		await post("/encounters", {
			care,
			patient_id: patientData?.id,
			month: months[new Date().getMonth()],
			year: new Date().getFullYear(),
			diagnosis,
			delivery,
			drugsGiven,
			labTest,
			enc_date,
			outcome,
			follow_up_to,
			anc,
			immunization,
			admission,
			operation,
			admitted: outcome == "Admitted" ? true : false,
			stock_updates: drugsGiven.map((drug) => {
				return {
					id: drug?.id,
					stock_qty: drug?.curr_stock,
				};
			}),
		});
		setPosted(true);
		setDrugsGiven([]);
		setDelivery(null);
		setLabTest([]);
		setDiagnosis([]);
		setFollowUPTo("");
		setOutcome("");
		setPosted(false);
		// console.log({
		// 	care,
		// 	patient_id: patientData?.id,
		// 	month: months[new Date().getMonth()],
		// 	year: new Date().getFullYear(),
		// 	diagnosis,
		// 	delivery,
		// 	drugsGiven,
		// 	labTest,
		// 	enc_date,
		// 	outcome,
		// 	follow_up_to,
		// 	anc,
		// 	immunization,
		// 	admission,
		// 	operation,
		// 	admitted: outcome == "Admitted" ? true : false,
		// 	stock_updates: drugsGiven.map((drug) => {
		// 		return {
		// 			id: drug?.id,
		// 			stock_qty: drug?.curr_stock,
		// 		};
		// 	}),
		// });
	};
	return (
		<section className='space-y-6'>
			<section>
				<div className='flex justify-between items-center'>
					<Link
						className='bg-blue-500 hover:bg-blue-600 p-1 px-2 rounded-lg text-white flex gap-3'
						href='/ms/encounters'
					>
						<ArrowLeft />
						Go back
					</Link>
					<Text size='xl'>Register new encounter</Text>
				</div>
			</section>
			<section className='flex gap-4'>
				<PatientSearch setSelected={setSelectedP} setPatient={setPatientData} />
				<Select
					label='Care type'
					placeholder='Select a care'
					data={cares}
					allowDeselect={false}
					value={care}
					onChange={(value: any) => {
						setCare(value);
					}}
					required
				/>
				<DatePickerInput
					label='Regristration date'
					placeholder='Reg. date...'
					className='w-44'
					value={enc_date}
					onChange={setEncDate}
					required
					allowDeselect
					clearable
					closeOnChange={false}
				/>
				<Select
					placeholder='follow_up_to'
					label='Follow Up To'
					className='w-[20rem]'
					data={follow_ups}
					onFocus={() => {
						getFollows();
					}}
					allowDeselect
					clearable
					onChange={setFollowUPTo}
					nothingFoundMessage='No previous encounters'
				/>
			</section>
			<section className='flex gap-4 flex-wrap items-center'>
				<div className='flex gap-3 items-center'>
					<h3 className='font-semibold'>Hospital No: </h3>
					<Text>{patientData?.hosp_no}</Text>
				</div>
				<div className='flex gap-3 items-center'>
					<h3 className='font-semibold'>Patient Name: </h3>
					<Text>{patientData?.name}</Text>
				</div>
				<div className='flex gap-3 items-center'>
					<h3 className='font-semibold'>Sex: </h3>
					<Text>{patientData?.sex}</Text>
				</div>
				<div className='flex gap-3 items-center'>
					<h3 className='font-semibold'>Age: </h3>
					<Text>{patientData?.age}</Text>
				</div>
				<div className='flex gap-3 items-center'>
					<h3 className='font-semibold'>Address: </h3>
					<Text>{patientData?.town?.name}</Text>
				</div>
				<div className='flex gap-3 items-center'>
					<h3 className='font-semibold'>Group: </h3>
					<Text>{patientData?.groups?.name}</Text>
				</div>
			</section>
			{selectedP && care ? (
				<form
					onSubmit={(e) => {
						e.preventDefault();
						handleSubmit();
					}}
				>
					<ScrollArea h={500}>
						<section className='space-y-4'>
							<Diagnosis setDiagnosis={setDiagnosis} />

							<div className='flex flex-col gap-2'>
								<label className='font-bold underline'>ANC</label>
								<ANC setANC={setANC} />
							</div>
							<div className='flex flex-col gap-2'>
								<label className='font-bold underline'>Immunization</label>
								<Immunization setImmunization={setImmunization} />
							</div>
							<div className='flex flex-col gap-2'>
								<label className='font-bold underline'>Delivery</label>
								<Delivery setDelivery={setDelivery} />
							</div>
							<div className='flex flex-col gap-2'>
								<label className='font-bold underline'>Operation</label>
								<Operations setOperation={setOperation} />
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
				</form>
			) : (
				<h2 className='text-xl text-center font-bold'>
					Select patient and care type to continue
				</h2>
			)}
			<LoadingOverlay visible={loading} />
		</section>
	);
};

export default Create;
