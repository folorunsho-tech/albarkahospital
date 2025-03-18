/* eslint-disable @typescript-eslint/no-explicit-any */
"use client";
import { ReactElement, ReactNode, useEffect, useRef, useState } from "react";
import { useReactToPrint } from "react-to-print";

import {
	ScrollArea,
	Table,
	TextInput,
	Text,
	keys,
	LoadingOverlay,
	Box,
	Button,
} from "@mantine/core";
import { Printer, Search } from "lucide-react";
import { format } from "date-fns";
import Image from "next/image";
import { useFetch } from "@/queries";

const ReportsTable = ({
	showSearch = true,
	headers,
	rows,
	data,
	setSortedData,
	sortedData,
	placeholder,
	tableLoading,
	depth = "",
	printHeaders,
	printRows,
	tableReport = "",
	tableFoot,
	showPrint = true,
	filters,
	filter,
	pdfTitle = "",
}: {
	showSearch?: boolean;
	headers: string[];
	rows: ReactElement[];
	printHeaders?: string[];
	printRows?: ReactElement[];
	data: any[];
	setSortedData: any;
	sortedData: any[];
	placeholder?: string;
	tableLoading?: boolean;
	depth?: string;
	tableReport?: string;
	tableFoot?: ReactElement;
	showPrint?: Boolean;
	filters?: ReactNode;
	filter: string;
	pdfTitle?: string;
}) => {
	const { loading, fetch } = useFetch();
	const contentRef = useRef<HTMLDivElement>(null);
	const reactToPrintFn = useReactToPrint({
		contentRef,
		bodyClass: "print",
		documentTitle: pdfTitle,
	});
	const [search, setSearch] = useState("");
	function filterData(data: any[], search: string) {
		const query = search.toLowerCase().trim();
		const filtered = data.filter((item: any) =>
			keys(data[0]).some((key) =>
				String(item[key]).toLowerCase().includes(query)
			)
		);

		return filtered;
	}
	const mappedData = data.map((mDtata) => {
		return {
			...mDtata,
			...mDtata[depth],
		};
	});
	const handleSearchChange = (event: React.ChangeEvent<HTMLInputElement>) => {
		const { value } = event.currentTarget;
		setSearch(value);
		const filtered = filterData(mappedData, value);
		setSortedData(filtered);
	};
	return (
		<Box pos='relative'>
			<section style={{ display: "none" }}>
				<div ref={contentRef} className='printable'>
					<div className='flex items-start gap-4 mb-2'>
						<Image
							src='/hospital.svg'
							height={120}
							width={120}
							alt='Albarka logo'
						/>
						<div className='space-y-1 w-full'>
							<div className='flex items-center w-full justify-between'>
								<h2 className='text-xl font-extrabold font-serif '>
									AL-BARKA HOSPITAL
								</h2>
								<p>{format(new Date(), "PPPpp")}</p>
							</div>
							<h3 className='text-lg '>P.O. Box 169 Tel: 08056713322</h3>
							<p className='text-md  italic'>
								E-mail: hospitalalbarka@gmail.com
							</p>
							<p className='text-lg font-extrabold bg-black text-white p-1 px-2 text-center uppercase'>
								{tableReport}
							</p>
						</div>
					</div>
					<Table miw={700}>
						<Table.Thead>
							<Table.Tr>
								{printHeaders?.map((head: string, index: number) => (
									<Table.Th key={head + index + 1}>{head}</Table.Th>
								))}
							</Table.Tr>
						</Table.Thead>
						<Table.Tbody>{printRows}</Table.Tbody>
						<Table.Tfoot className='font-semibold border border-black'>
							{tableFoot}
						</Table.Tfoot>
					</Table>
				</div>
			</section>
			<section className='flex flex-col gap-2'>
				<div className='flex gap-3 items-end justify-between'>
					{filters}
					{showPrint && (
						<Button
							onClick={() => {
								reactToPrintFn();
							}}
						>
							<Printer />
						</Button>
					)}
				</div>
				{showSearch && (
					<TextInput
						placeholder={placeholder}
						leftSection={<Search size={16} />}
						value={search}
						onChange={handleSearchChange}
					/>
				)}
				<ScrollArea h={700}>
					<Table
						miw={700}
						striped
						highlightOnHover
						withTableBorder
						withColumnBorders
					>
						<Table.Thead>
							<Table.Tr>
								{headers?.map((head: string, index: number) => (
									<Table.Th key={head + index}>{head}</Table.Th>
								))}
							</Table.Tr>
						</Table.Thead>
						<Table.Tbody>
							{sortedData?.length > 0 ? (
								rows
							) : (
								<Table.Tr>
									<Table.Td>
										<Text fw={500} ta='center'>
											Nothing found
										</Text>
									</Table.Td>
								</Table.Tr>
							)}
						</Table.Tbody>
					</Table>
				</ScrollArea>

				<LoadingOverlay visible={tableLoading} />
			</section>
		</Box>
	);
};

export default ReportsTable;
