/* eslint-disable @typescript-eslint/no-explicit-any */
"use client";

import { useEffect, useState } from "react";
import { useFetch, usePost } from "@/queries";
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
import { useRouter, useSearchParams } from "next/navigation";
import Link from "next/link";
const Edit = () => {
	const searchParams = useSearchParams();
	const id = searchParams.get("id");
	const { fetch } = useFetch();
	const { post, loading } = usePost();
	const [groupsList, setGroupsList] = useState([]);
	const [group_id, setGroupId] = useState("");
	const [sex, setSex] = useState("");
	const [reg_date, setRegDate] = useState<any>(new Date());
	const form = useForm({
		mode: "uncontrolled",
		initialValues: {
			name: "",
			hosp_no: "",
			age: "",
			phone_no: "",
			address: "",
		},
	});
	const router = useRouter();

	useEffect(() => {
		const getAll = async () => {
			const { data: found } = await fetch(`/patients/${id}`);
			const { data } = await fetch("/patients/groups");

			const sortedG = data.map((group: { id: string; name: string }) => {
				return {
					value: group.id,
					label: group.name,
				};
			});
			form.setValues({
				name: found?.name,
				hosp_no: found?.hosp_no,
				age: found?.age,
				phone_no: found?.phone_no,
				address: found?.address,
			});

			setSex(found?.sex);
			setRegDate(new Date(found?.reg_date));
			setGroupId(found?.group_id || null);
			setGroupsList(sortedG);
		};
		getAll();
	}, []);
	const handleSubmit = async (values: typeof form.values) => {
		await post(`/patients/edit/${id}`, {
			...values,
			sex,
			reg_date,
			group_id,
		});
		form.reset();
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
				<Text size='xl'>Update patient data</Text>
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
				/>
				<TextInput
					label='Patient Name'
					placeholder='name...'
					className='w-60'
					key={form.key("name")}
					{...form.getInputProps("name")}
				/>
				<Select
					label='Sex'
					placeholder='Select patient sex'
					data={["M", "F"]}
					allowDeselect={false}
					value={sex}
					onChange={(value: any) => {
						setSex(value);
					}}
					searchable
					nothingFoundMessage='Nothing found...'
				/>
				<TextInput
					label='Card No'
					placeholder='hospital card no...'
					disabled
					key={form.key("hosp_no")}
					{...form.getInputProps("hosp_no")}
				/>
				<TextInput
					className='w-60'
					label='Patient address'
					placeholder='address...'
					key={form.key("address")}
					{...form.getInputProps("address")}
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
				<Select
					label='Group'
					placeholder='Select patient group'
					data={groupsList}
					allowDeselect={false}
					value={group_id}
					onChange={(value: any) => {
						setGroupId(value);
					}}
					required
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
					<Button type='submit'>Update patient</Button>
				</Group>
				<LoadingOverlay visible={loading} />
			</form>
		</main>
	);
};

export default Edit;
