/* eslint-disable @typescript-eslint/no-explicit-any */
"use client";
import { useEffect, useState } from "react";
import { useFetch, useHospNo, usePost } from "@/queries";
import { ArrowLeft } from "lucide-react";
import {
	Button,
	Group,
	LoadingOverlay,
	Select,
	Text,
	TextInput,
} from "@mantine/core";
import { useForm } from "@mantine/form";
import { DatePickerInput } from "@mantine/dates";
import { months } from "@/lib/ynm";
import { useRouter } from "next/navigation";
import Link from "next/link";
const Create = () => {
	const { fetch } = useFetch();
	const { fetch: hospF } = useHospNo();
	const { post, loading } = usePost();
	const [groupsList, setGroupsList] = useState([]);
	const [townsList, setTownsList] = useState([]);
	const [group_id, setGroupId] = useState("cm5fk55fk0009uqyoyc55c44n");
	const [sex, setSex] = useState("");
	const [hosp_no, setHospNo] = useState("");
	const [religion, setReligion] = useState("");
	const [townId, setTownId] = useState<any>("");
	const [reg_date, setRegDate] = useState<any>(new Date());
	const form = useForm({
		mode: "uncontrolled",
		initialValues: {
			name: "",
			age: "",
			phone_no: "",
			occupation: "",
			month: months[new Date().getMonth()],
			year: new Date().getFullYear(),
		},
	});
	const router = useRouter();

	const getHospNo = async () => {
		const { data: hosp } = await hospF("/patients/no");
		setHospNo(hosp);
	};
	useEffect(() => {
		const getAll = async () => {
			const { data } = await fetch("/patients/groups");
			getHospNo();
			const sortedG = data.map((group: { id: string; name: string }) => {
				return {
					value: group.id,
					label: group.name,
				};
			});
			const { data: towns } = await fetch("/settings/town");
			const sortedT = towns.map((town: { id: string; name: string }) => {
				return {
					value: town.id,
					label: town.name,
				};
			});
			setTownsList(sortedT);
			setGroupsList(sortedG);
		};
		getAll();
	}, []);
	const handleSubmit = async (values: typeof form.values) => {
		await post("/patients", {
			...values,
			hosp_no,
			sex,
			group_id,
			reg_date,
			religion,
			townId,
		});
		form.reset();
		getHospNo();
	};

	return (
		<main className='space-y-6'>
			<div className='flex justify-between items-center'>
				<Link
					className='bg-blue-500 hover:bg-blue-600 p-1 px-2 rounded-lg text-white flex gap-3'
					href='/ms/patients'
				>
					<ArrowLeft />
					Go back
				</Link>
				<Text size='xl'>Register new patients</Text>
			</div>
			<form
				className='flex gap-4 flex-wrap'
				onSubmit={form.onSubmit(handleSubmit)}
			>
				<DatePickerInput
					label='Regristration date'
					placeholder='Reg. date...'
					className='w-44'
					value={reg_date}
					onChange={setRegDate}
					required
				/>
				<TextInput
					label='Patient Name'
					placeholder='name...'
					className='w-60'
					required
					key={form.key("name")}
					{...form.getInputProps("name")}
				/>
				<Select
					label='Sex'
					placeholder='Select patient sex'
					data={["Male", "Female"]}
					allowDeselect={false}
					value={sex}
					onChange={(value: any) => {
						setSex(value);
					}}
				/>
				<TextInput
					label='Card No'
					placeholder='hospital card no...'
					required
					value={hosp_no}
					onChange={(e) => {
						setHospNo(e.currentTarget.value);
					}}
				/>
				<Select
					label='Address'
					placeholder='Select patient addres'
					data={townsList}
					allowDeselect={false}
					value={townId}
					onChange={(value: any) => {
						setTownId(value);
					}}
					required
					searchable
					nothingFoundMessage='Nothing found...'
				/>
				<TextInput
					label='Phone No'
					placeholder='phone no...'
					key={form.key("phone_no")}
					{...form.getInputProps("phone_no")}
				/>
				<TextInput
					label='Age'
					placeholder='age...'
					key={form.key("age")}
					{...form.getInputProps("age")}
				/>
				<TextInput
					label='Occupation'
					placeholder='occupation...'
					key={form.key("occupation")}
					{...form.getInputProps("occupation")}
				/>

				<Select
					label='Religion'
					placeholder='Select patient religion'
					data={["Islam", "Christianity", "Others"]}
					value={religion}
					onChange={(value: any) => {
						setReligion(value);
					}}
				/>
				<Select
					label='Group'
					placeholder='Select patient group'
					data={groupsList}
					allowDeselect={false}
					value={group_id}
					onChange={(value: any) => {
						setGroupId(value);
					}}
					// required
					searchable
					nothingFoundMessage='Nothing found...'
				/>
				<Group mt={20} justify='end'>
					<Button
						onClick={() => {
							router.push("/ms/patients");
						}}
						color='black'
					>
						Cancel
					</Button>
					<Button color='teal' type='submit'>
						Add patient
					</Button>
				</Group>
				<LoadingOverlay visible={loading} />
			</form>
		</main>
	);
};

export default Create;
