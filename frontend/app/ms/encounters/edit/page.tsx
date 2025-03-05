/* eslint-disable @typescript-eslint/no-explicit-any */
"use client";

import { useEffect, useState } from "react";
import { useFetch } from "@/queries";
import {
	ArrowLeft,
	BriefcaseMedical,
	Cross,
	Hospital,
	Scissors,
	TestTubes,
} from "lucide-react";
import { Select, Text, Tabs, rem } from "@mantine/core";
import { DatePickerInput } from "@mantine/dates";
import Diagnosis from "@/components/encounter/edit/Diagnosis";
import DrugsGiven from "@/components/encounter/edit/DrugsGiven";
import Labtest from "@/components/encounter/edit/Labtest";
import Procedures from "@/components/encounter/edit/Procedures";
import Delivery from "@/components/encounter/edit/Delivery";
import { useSearchParams } from "next/navigation";
import Link from "next/link";

const Edit = () => {
	const { fetch } = useFetch();
	const [queryData, setQueryData] = useState<any>(null);
	const [patientData, setPatientData] = useState<any>(null);
	const [cares, setCares] = useState([]);
	const [care, setCare] = useState("");
	const [adm_date, setDate] = useState<any>(new Date());
	const searchParams = useSearchParams();
	const id = searchParams.get("id");
	const getAll = async () => {
		const { data } = await fetch("/settings/care");
		const { data: found } = await fetch(`/encounters/${id}`);
		const sorted = data.map((care: { id: string; name: string }) => {
			return {
				value: care.id,
				label: care.name,
			};
		});
		setQueryData(found);
		setPatientData(found?.patient);
		setDate(new Date(found?.adm_date));
		setCares(sorted);
		setCare(found?.care?.id);
	};
	useEffect(() => {
		getAll();
	}, []);

	const iconStyle = { width: rem(22), height: rem(22) };

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
					<Text size='xl'>Editing encounter id: {id}</Text>
				</div>
			</section>
			<section className='flex justify-between gap-3'>
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
				<Select
					label='Care type'
					placeholder='Select a care'
					data={cares}
					allowDeselect={false}
					value={care}
					disabled
					onChange={(value: any) => {
						setCare(value);
					}}
					nothingFoundMessage='Nothing found...'
				/>
				<DatePickerInput
					label='Regristration date'
					placeholder='Reg. date...'
					className='w-44'
					disabled
					value={adm_date}
					onChange={setDate}
				/>
			</section>

			<main>
				<Tabs defaultValue='diagnosis' keepMounted={false}>
					<Tabs.List>
						<Tabs.Tab
							value='diagnosis'
							leftSection={<BriefcaseMedical style={iconStyle} />}
						>
							Diagnosis
						</Tabs.Tab>
						<Tabs.Tab
							value='drugs'
							leftSection={<Hospital style={iconStyle} />}
						>
							Drugs given
						</Tabs.Tab>
						<Tabs.Tab
							value='tests'
							leftSection={<TestTubes style={iconStyle} />}
						>
							Lab test
						</Tabs.Tab>
						<Tabs.Tab
							value='procedures'
							leftSection={<Scissors style={iconStyle} />}
						>
							Procedures
						</Tabs.Tab>
						<Tabs.Tab
							value='delivery'
							leftSection={<Cross style={iconStyle} />}
						>
							Delivery
						</Tabs.Tab>
					</Tabs.List>

					<Tabs.Panel value='diagnosis'>
						<Diagnosis data={queryData?.diagnosis} id={id} getEnc={getAll} />
					</Tabs.Panel>

					<Tabs.Panel value='drugs'>
						<DrugsGiven data={queryData?.drugsGiven} id={id} getEnc={getAll} />
					</Tabs.Panel>

					<Tabs.Panel value='tests'>
						<Labtest data={queryData?.labTest} id={id} getEnc={getAll} />
					</Tabs.Panel>
					<Tabs.Panel value='procedures'>
						<Procedures
							data={{
								procedure: queryData?.procedure?.id,
								proc_date: queryData?.proc_date,
							}}
							id={id}
							getEnc={getAll}
						/>
					</Tabs.Panel>
					<Tabs.Panel value='delivery'>
						<Delivery data={queryData?.delivery} id={id} getEnc={getAll} />
					</Tabs.Panel>
				</Tabs>
			</main>
		</section>
	);
};

export default Edit;
