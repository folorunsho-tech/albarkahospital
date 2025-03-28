/* eslint-disable @typescript-eslint/no-explicit-any */
"use client";
import DataLoader from "@/components/DataLoader";
import PaginatedTable from "@/components/PaginatedTable";
import { usePostNormal } from "@/queries";
import { ActionIcon, Button, rem, Table } from "@mantine/core";
import { format } from "date-fns";
import { Eye } from "lucide-react";
import Link from "next/link";
import { useState } from "react";

const Payments = () => {
	const { post, loading } = usePostNormal();
	const [queryData, setQueryData] = useState<any[]>([]);
	const [sortedData, setSortedData] = useState<any[]>([]);

	const rows = sortedData?.map((row, i: number) => (
		<Table.Tr key={row?.id}>
			<Table.Td>{i + 1}</Table.Td>
			<Table.Td>{row?.hosp_no}</Table.Td>
			<Table.Td>{row?.name}</Table.Td>
			<Table.Td>{row?.phone_no}</Table.Td>
			<Table.Td>{row?.address}</Table.Td>
			<Table.Td>{format(new Date(row?.date), "Pp")}</Table.Td>
			<Table.Td>
				<ActionIcon component={Link} href={`${row?.id}`} variant='subtle'>
					<Eye style={{ width: rem(14), height: rem(14) }} />
				</ActionIcon>
			</Table.Td>
		</Table.Tr>
	));

	return (
		<main className='space-y-6'>
			<div className='flex items-end justify-between w-full'>
				{/* <DataLoader
					post={post}
					setQueryData={setQueryData}
					link='/transaction'
				/> */}
				<div className='flex gap-3 items-end'>
					<Button color='teal' href='transactions/payment' component={Link}>
						Make a new transaction
					</Button>
					<Button color='orange' href='transactions/payment' component={Link}>
						Make a balance transaction
					</Button>
					<Button color='red' href='transactions/payment' component={Link}>
						Make a reversal
					</Button>
				</div>
			</div>
			<PaginatedTable
				headers={[
					"S/N",
					"Name",
					"Hosp No",
					"Group",
					"Sex",
					"Age",
					"Address",
					"Phone No",
					"Reg date",
					"Actions",
				]}
				placeholder='Search by name or hospital no'
				sortedData={sortedData}
				rows={rows}
				showSearch={true}
				showPagination={true}
				data={queryData}
				setSortedData={setSortedData}
				tableLoading={loading}
				depth='groups'
			/>
		</main>
	);
};

export default Payments;
