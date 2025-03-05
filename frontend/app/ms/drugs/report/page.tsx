/* eslint-disable @typescript-eslint/no-explicit-any */
"use client";

import {
	Button,
	LoadingOverlay,
	Text,
	NumberFormatter,
	Image,
	Table,
} from "@mantine/core";

import { ArrowLeft, Printer } from "lucide-react";
import { usePostNormal } from "@/queries";
import { useState, useRef } from "react";
import { useReactToPrint } from "react-to-print";
import DataLoader from "@/components/DataLoader";
import { format } from "date-fns";
import Link from "next/link";
const Report = () => {
	const { post, loading } = usePostNormal();
	const [queryData, setQueryData] = useState<any[]>([]);
	const contentRef = useRef<HTMLTableElement>(null);
	const reactToPrintFn = useReactToPrint({
		contentRef,
		bodyClass: "print",
		documentTitle: "Drugs report",
	});
	// console.log(queryData);
	return (
		<main className='space-y-6'>
			<div className='flex justify-between items-end'>
				<Link
					className='bg-blue-500 hover:bg-blue-600 p-1 px-2 rounded-lg text-white flex gap-3'
					href='/ms/drugs'
				>
					<ArrowLeft />
					Go back
				</Link>
				<DataLoader link='/report' post={post} setQueryData={setQueryData} />
				<Button
					leftSection={<Printer />}
					onClick={() => {
						reactToPrintFn();
					}}
				>
					Print
				</Button>
				<Text size='md'>Drugs report summary</Text>
			</div>

			<section ref={contentRef} className='printable'>
				<div className='flex items-start gap-4 mb-2'>
					<Image src='/hospital.svg' h={100} w={100} />
					<div className='space-y-1 w-full'>
						<div className='flex items-center w-full justify-between'>
							<h2 className='text-lg font-extrabold font-serif '>
								AL-BARKA HOSPITAL
							</h2>
							<p className='text-sm'>{format(new Date(), "PPPpp")}</p>
						</div>
						<h3 className='text-md '>P.O. Box 169 Tel: 08056713322</h3>
						<p className='text-sm  italic'>E-mail: hospitalalbarka@gmail.com</p>
						<p className='text-sm font-extrabold bg-black text-white p-1 px-2 text-center uppercase'>
							Drugs report summary
						</p>
					</div>
				</div>
				<Table miw={700}>
					<Table.Thead>
						<Table.Tr>
							<Table.Th>S/N</Table.Th>
							<Table.Th>Drug</Table.Th>
							<Table.Th>Total prescription</Table.Th>
							<Table.Th>Total price</Table.Th>
						</Table.Tr>
					</Table.Thead>
					<Table.Tbody>
						{queryData?.map((row, i) => (
							<Table.Tr key={row?.name + i}>
								<Table.Td>{i + 1}</Table.Td>
								<Table.Td>{row?.name}</Table.Td>
								<Table.Td>
									<NumberFormatter
										value={row?._sum?.quantity}
										thousandSeparator
									/>
								</Table.Td>
								<Table.Td>
									<NumberFormatter
										prefix='N '
										value={row?._sum?.price}
										thousandSeparator
									/>
								</Table.Td>
							</Table.Tr>
						))}
					</Table.Tbody>
				</Table>
			</section>
			<LoadingOverlay visible={loading} />
		</main>
	);
};

export default Report;
