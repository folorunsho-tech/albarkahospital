/* eslint-disable @typescript-eslint/no-explicit-any */
"use client";

import { useEffect, useState } from "react";
import { useFetch, usePostT } from "@/queries";
import { ArrowLeft } from "lucide-react";
import { Button, Group, LoadingOverlay, Select, Text } from "@mantine/core";
import { DatePickerInput } from "@mantine/dates";
import { months } from "@/lib/ynm";
import PatientSearch from "@/components/PatientSearch";
import Diagnosis from "@/components/encounter/create/Diagnosis";
import DrugsGiven from "@/components/encounter/create/DrugsGiven";
import Labtest from "@/components/encounter/create/Labtest";
import Procedures from "@/components/encounter/create/Procedures";
import Delivery from "@/components/encounter/create/Delivery";
import { useRouter } from "next/navigation";
import Link from "next/link";

const Create = () => {
	const { fetch } = useFetch();
	const { post, loading } = usePostT();
	const [drugsGiven, setDrugsGiven] = useState<any[]>([]);
	const [delivery, setDelivery] = useState(null);
	const [labTest, setLabTest] = useState([]);
	const [procedure, setProcedure] = useState("cm7ejrak40001uq4gffbajfe8");
	const [proc_date, setProcDate] = useState<Date>(new Date());
	const [diagnosis, setDiagnosis] = useState([]);
	const [patientData, setPatientData] = useState<any>(null);
	const [cares, setCares] = useState([]);
	const [selectedP, setSelectedP] = useState("");
	const [care, setCare] = useState("");
	const [posted, setPosted] = useState(false);
	const [adm_date, setDate] = useState<any>(new Date());
	const router = useRouter();
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
			selectedP,
			month: months[new Date().getMonth()],
			year: new Date().getFullYear(),
			diagnosis,
			delivery,
			drugsGiven,
			procedure,
			proc_date,
			labTest,
			adm_date,
			stock_updates: drugsGiven.map((drug) => {
				return {
					id: drug?.id,
					stock_qty: drug?.curr_stock,
				};
			}),
		});
		setPosted(true);
		setProcedure("cm7ejrak40001uq4gffbajfe8");
		setDrugsGiven([]);
		setDelivery(null);
		setLabTest([]);
		setDiagnosis([]);
		setPosted(false);
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
			<section className='flex justify-between'>
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
					value={adm_date}
					onChange={setDate}
					required
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
					<Text>{patientData?.address}</Text>
				</div>
			</section>
			{selectedP && care ? (
				<form
					onSubmit={(e) => {
						e.preventDefault();
						handleSubmit();
					}}
				>
					<section className='space-y-4'>
						<Diagnosis setDiagnosis={setDiagnosis} />
						<Procedures
							setProcedure={setProcedure}
							procedure={procedure}
							proc_date={proc_date}
							setProcDate={setProcDate}
						/>
						<div className='flex flex-col gap-2'>
							<label className='font-bold underline'>Delivery</label>
							<Delivery setDelivery={setDelivery} />
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
					</section>
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
