"use client";
import { useEffect, useState } from "react";
import { useFetch } from "@/queries";
import { ArrowLeft } from "lucide-react";
import Link from "next/link";
import {
	Button,
	Checkbox,
	LoadingOverlay,
	NumberFormatter,
	Table,
	Text,
	TextInput,
} from "@mantine/core";

import { useParams } from "next/navigation";
const page = () => {
	const { id } = useParams<{ id: string }>();
	const { fetch, loading } = useFetch();
	const [tnx, setTnx] = useState<any | null>(null);
	const [status, setStatus] = useState<{
		color: string;
		label: string;
	} | null>(null);
	const getStatus = (status: string | any) => {
		if (status == "Fully Paid") {
			setStatus({
				color: "teal",
				label: "Fully Paid",
			});
		} else if (status == "Partly Paid") {
			setStatus({
				color: "orange",
				label: "Partly Paid",
			});
		} else if (status == "Partly Reversed") {
			setStatus({
				color: "pink",
				label: "Partly Reversed",
			});
		} else if (status == "Fully Reversed") {
			setStatus({
				color: "red",
				label: "Fully Reversed",
			});
		}
	};
	useEffect(() => {
		if (tnx) {
			getStatus(tnx?.status);
		}
	}, [tnx]);
	useEffect(() => {
		if (id) {
			const getData = async () => {
				const { data } = await fetch(`/transactions/${id}`);
				setTnx(data);
			};
			getData();
		}
	}, []);

	return (
		<main>
			<header className='flex justify-between items-center'>
				<Link
					className='bg-blue-500 hover:bg-blue-600 p-1 px-2 rounded-lg text-white flex gap-3'
					href='/ms/transactions'
				>
					<ArrowLeft />
					Go back
				</Link>
				<Text size='xl'>Viewing Tnx {id}</Text>

				<div className='flex flex-col gap-1 w-max pointer-events-none'>
					<label htmlFor='status'>Transaction status</label>
					<Button id='status' color={status?.color}>
						{status?.label}
					</Button>
				</div>
			</header>
			<section></section>
			<LoadingOverlay visible={loading} />
		</main>
	);
};

export default page;
