/* eslint-disable @typescript-eslint/no-explicit-any */
"use client";
import { ArrowLeft, Pencil } from "lucide-react";
import { useState, useEffect } from "react";
import { useFetch } from "@/queries";
import { Button, Text } from "@mantine/core";
import { useSearchParams } from "next/navigation";
import { useRouter } from "next/navigation";
import Link from "next/link";

const View = () => {
	const searchParams = useSearchParams();
	const id = searchParams.get("id");
	const { fetch } = useFetch();
	const [queryData, setQueryData] = useState<any>(null);
	const [createdBy, setCreatedBy] = useState<any>(null);
	const router = useRouter();
	useEffect(() => {
		const getAll = async () => {
			const { data: found } = await fetch(`/encounters/${id}`);
			const { data: created } = await fetch(
				`/accounts/${found?.createdById}/basic`
			);
			setQueryData(found);
			setCreatedBy(created);
		};
		getAll();
	}, []);

	return (
		<main>
			<section>
				<div className='flex justify-between items-center'>
					<Link
						className='bg-blue-500 hover:bg-blue-600 p-1 px-2 rounded-lg text-white flex gap-3'
						href='/ms/encounters'
					>
						<ArrowLeft />
						Go back
					</Link>
					<Button
						justify='end'
						color='teal'
						onClick={() => {
							router.push(`edit/?id=${id}`);
						}}
						leftSection={<Pencil />}
					>
						Edit data
					</Button>
					<div className='flex items-center gap-2'>
						<h3 className='text-lg'>
							Viewing encounter: <i>{id}</i>
						</h3>
						<h3 className='text-lg'>
							Created by: <i className='underline'>{createdBy?.username}</i>
						</h3>
						{queryData?.updatedBy?.username && (
							<h3 className='text-lg'>
								Last updated by:{" "}
								<i className='underline'>{queryData?.updatedBy?.username}</i>
							</h3>
						)}
					</div>
				</div>
			</section>
			<section className='space-y-6'>
				<div className='space-y-3 pt-5'>
					<label htmlFor='info' className='font-bold underline'>
						Personal Info
					</label>
					<div id='info' className='flex gap-3 flex-wrap'>
						<Text className='flex gap-1 items-center'>
							Enc Date:{" "}
							<i className='text-sm'>
								{new Date(queryData?.adm_date).toLocaleDateString()}
							</i>
						</Text>
						<Text className='flex gap-1 items-center'>
							Enc time: <i className='text-sm'>{queryData?.time}</i>
						</Text>
						<Text className='flex gap-1 items-center'>
							Hosp No: <i className='text-sm'>{queryData?.hosp_no}</i>
						</Text>
						<Text className='flex gap-1 items-center'>
							Name:
							<i className='text-sm'>{queryData?.patient?.name}</i>
						</Text>
						<Text className='flex gap-1 items-center'>
							Age:
							<i className='text-sm'>{queryData?.patient?.age}</i>
						</Text>
						<Text className='flex gap-1 items-center'>
							Sex:
							<i className='text-sm'>{queryData?.patient?.sex}</i>
						</Text>
						<Text className='flex gap-1 items-center'>
							Phone Number:
							<i className='text-sm'>{queryData?.patient?.phone_no}</i>
						</Text>
						<Text className='flex gap-1 items-center'>
							Address:
							<i className='text-sm'>{queryData?.patient?.address}</i>
						</Text>
						<Text className='flex gap-1 items-center'>
							Care type:
							<i className='text-sm'>{queryData?.care?.name}</i>
						</Text>
					</div>
				</div>
				<div className='space-y-4'>
					<label htmlFor='data' className='font-bold underline'>
						Encounter Data
					</label>
					<div id='' className='flex gap-2 flex-wrap'>
						<div>
							<label htmlFor='diag' className='font-bold'>
								Diagnosis
							</label>
							<ul id='diag' className='pl-4 flex-wrap flex gap-6 list-decimal'>
								{queryData?.diagnosis?.map((diag: any) => (
									<li key={diag?.id}>{diag?.name}</li>
								))}
							</ul>
						</div>
					</div>
					<div id='' className='flex gap-2 flex-wrap'>
						<div>
							<label htmlFor='del' className='font-bold'>
								Delivery
							</label>
							<div id='del' className='pl-4 flex-wrap flex gap-6'>
								<Text>
									ANC EGA: <i>{queryData?.delivery?.anc_ega}</i>
								</Text>
								<Text>
									Foetal Diagnosis: <i>{queryData?.delivery?.foetal_diag}</i>
								</Text>
								<Text>
									Baby Outcome: <i>{queryData?.delivery?.baby_outcome}</i>
								</Text>
							</div>
						</div>
					</div>
					<div id='' className='flex gap-2 flex-wrap'>
						<div>
							<label htmlFor='diag' className='font-bold'>
								Drugs Given
							</label>
							<ul id='diag' className='pl-4 flex-wrap flex gap-6 list-decimal'>
								{queryData?.drugsGiven?.map((given: any) => (
									<li key={given?.id}>
										{given?.drug?.drug} - <span>{given?.quantity}</span>
										<i> at </i>
										<span>NGN {given?.rate}</span>
									</li>
								))}
							</ul>
						</div>
					</div>
					<div id='' className='flex gap-2 flex-wrap'>
						<div>
							<label htmlFor='diag' className='font-bold'>
								Labs
							</label>
							<ul id='diag' className='pl-4 flex-wrap flex gap-6 list-decimal'>
								{queryData?.labTest?.map((test: any) => (
									<li key={test?.id}>
										<span>{test?.testType?.name}</span>
										<Text ml={3}>
											Result: <i>{test?.result}</i>
										</Text>
										<Text ml={3}>
											Info: <i>{test?.info}</i>
										</Text>
									</li>
								))}
							</ul>
						</div>
					</div>
					<div id='' className='flex gap-2 flex-wrap'>
						<Text>
							<b>Procedure:</b> <i>{queryData?.procedure?.name}</i>
						</Text>
					</div>
				</div>
			</section>
		</main>
	);
};
export default View;
