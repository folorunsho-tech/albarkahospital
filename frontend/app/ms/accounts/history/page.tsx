/* eslint-disable @typescript-eslint/no-explicit-any */
"use client";

import { useEffect, useState } from "react";
import { useFetch } from "@/queries";
import { useSearchParams } from "next/navigation";
import Link from "next/link";
import { Button, Table } from "@mantine/core";
import { format } from "date-fns";
import PaginatedTable from "@/components/PaginatedTable";
import { ArrowLeft } from "lucide-react";
const page = () => {
	const { fetch, loading } = useFetch();
	const [queryData, setQueryData] = useState<any[]>([]);
	const [sortedData, setSortedData] = useState<any[]>([]);
	const searchParams = useSearchParams();
	const id = searchParams.get("id");
	const rows = sortedData?.map((row, i: number) => (
		<Table.Tr key={row?.id}>
			<Table.Td>{i + 1}</Table.Td>
			<Table.Td>{row?.account?.username}</Table.Td>
			<Table.Td>{format(new Date(row?.loggedInAt), "dd/MM/yyyy, p")}</Table.Td>
			<Table.Td>
				{row?.loggedOutAt
					? format(new Date(row?.loggedOutAt), "dd/MM/yyyy, p")
					: "Did not log out"}
			</Table.Td>
		</Table.Tr>
	));
	useEffect(() => {
		(async function getAll() {
			const { data } = await fetch(`/accounts/history/${id}`);
			setQueryData(data);
		})();
	}, []);
	return (
		<main className='space-y-6'>
			<Button leftSection={<ArrowLeft />} component={Link} href='/ms/accounts'>
				Go back
			</Button>
			<PaginatedTable
				headers={["S/N", "Username", "Logged In", "Logged Out"]}
				sortedData={sortedData}
				rows={rows}
				showSearch={false}
				showPagination={true}
				data={queryData}
				setSortedData={setSortedData}
				tableLoading={loading}
			/>
		</main>
	);
};

export default page;
