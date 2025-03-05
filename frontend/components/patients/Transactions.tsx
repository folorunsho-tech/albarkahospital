/* eslint-disable @typescript-eslint/no-explicit-any */
"use client";

import PaginatedTable from "../PaginatedTable";
import { Button, NumberFormatter, Table } from "@mantine/core";
import { format } from "date-fns";
import { Printer } from "lucide-react";
import { useEffect, useRef, useState } from "react";
import { useReactToPrint } from "react-to-print";
import { usePostNormal } from "@/queries";

const Transactions = ({ hosp_no, id }: { hosp_no: string; id: string }) => {
	const { post, loading, data } = usePostNormal();
	const [queryData, setQueryData] = useState<any[]>(data);
	const [sortedData, setSortedData] = useState<any[]>([]);
	const contentRef = useRef<HTMLDivElement>(null);
	const reactToPrintFn = useReactToPrint({
		contentRef,
		bodyClass: "print",
		documentTitle: `${hosp_no} - transactions-list`,
	});
	const rows = sortedData?.map((row, i: number) => (
		<Table.Tr key={row?.id}>
			<Table.Td>{i + 1}</Table.Td>
			<Table.Td>{row?.patient?.name}</Table.Td>
			<Table.Td>{row?.hosp_no}</Table.Td>
			<Table.Td>{row?._count?.items}</Table.Td>
			<Table.Td>
				<NumberFormatter prefix='N ' value={row?.amount} thousandSeparator />
			</Table.Td>
			<Table.Td>
				<NumberFormatter prefix='N ' value={row?.paid} thousandSeparator />
			</Table.Td>

			<Table.Td>{row?.method}</Table.Td>
			<Table.Td>{row?.status}</Table.Td>
			<Table.Td>{format(new Date(row?.date), "dd/MM/yyyy")}</Table.Td>
		</Table.Tr>
	));
	useEffect(() => {
		const getAll = async () => {
			const { data: found } = await post(`/patients/transactions`, { id });
			setQueryData(found);
		};
		getAll();
	}, []);
	return (
		<main className='space-y-4 mt-3'>
			<div className='flex gap-3 items-end'>
				<Button
					leftSection={<Printer />}
					onClick={() => {
						reactToPrintFn();
					}}
				>
					Print
				</Button>
			</div>
			<PaginatedTable
				headers={[
					"S/N",
					"Name",
					"Hosp No",
					"Item Count",
					"Amount",
					"Paid",
					"Method",
					"Status",
					"Date",
				]}
				placeholder='Search by hospital no'
				sortedData={sortedData}
				rows={rows}
				showSearch={false}
				showPagination={true}
				data={queryData}
				setSortedData={setSortedData}
				depth='patient'
				ref={contentRef}
				tableLoading={loading}
				printHeaders={[
					"S/N",
					"Name",
					"Hosp No",
					"Item Count",
					"Amount",
					"Paid",
					"Method",
					"Status",
					"Date",
				]}
				printRows={rows}
				tableReport='Patients Transactions record'
			/>
		</main>
	);
};

export default Transactions;
