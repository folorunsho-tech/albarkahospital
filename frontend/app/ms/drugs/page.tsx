/* eslint-disable @typescript-eslint/no-explicit-any */
"use client";

import { useEffect, useRef, useState } from "react";
import PaginatedTable from "@/components/PaginatedTable";
import {
	Button,
	Table,
	rem,
	ActionIcon,
	Modal,
	Group,
	LoadingOverlay,
	NumberInput,
	TextInput,
	NumberFormatter,
} from "@mantine/core";
import { Pencil, Printer } from "lucide-react";
import { useDisclosure } from "@mantine/hooks";
import { useEdit, useFetch, usePost } from "@/queries";
import { useReactToPrint } from "react-to-print";
import { format } from "date-fns";
import Link from "next/link";

const DrugsInventory = () => {
	const { loading, fetch, data } = useFetch();
	const { post } = usePost();
	const { loading: eLoading, edit } = useEdit();
	const [opened, { open, close }] = useDisclosure(false);
	const [queryData, setQueryData] = useState<any[]>(data);
	const [printData, setPrintData] = useState<any[]>(queryData);
	const [sortedData, setSortedData] = useState<any[]>([]);
	const [drug, setDrug] = useState<string>("");
	const [stock_qty, setStock] = useState(0);
	const [added, setAdded] = useState(0);
	const [eAdded, setEAdded] = useState(0);
	const [eData, setEdata] = useState<any>(null);
	const rows = sortedData?.map((row, i: number) => (
		<Table.Tr key={row?.id}>
			<Table.Td>{i + 1}</Table.Td>
			<Table.Td>{row?.drug}</Table.Td>
			<Table.Td>
				<NumberFormatter value={row?.stock_qty} thousandSeparator />
			</Table.Td>
			<Table.Td>
				<NumberFormatter value={row?.added} thousandSeparator />
			</Table.Td>
			<Table.Td>{format(new Date(row?.updatedAt), "Pp")}</Table.Td>
			<Table.Td>
				<ActionIcon
					onClick={() => {
						open();
						setEdata(row);
					}}
				>
					<Pencil style={{ width: rem(14), height: rem(14) }} />
				</ActionIcon>
			</Table.Td>
		</Table.Tr>
	));
	const printRows = printData?.map((row, i: number) => (
		<Table.Tr key={row?.id}>
			<Table.Td>{i + 1}</Table.Td>
			<Table.Td>{row?.drug}</Table.Td>
			<Table.Td>
				<NumberFormatter value={row?.stock_qty} thousandSeparator />
			</Table.Td>
			<Table.Td>
				<NumberFormatter value={row?.added} thousandSeparator />
			</Table.Td>
			<Table.Td>{format(new Date(row?.updatedAt), "Pp")}</Table.Td>
		</Table.Tr>
	));
	const contentRef = useRef<HTMLDivElement>(null);
	const reactToPrintFn = useReactToPrint({
		contentRef,
		bodyClass: "print",
		documentTitle: "drugs-inventory",
	});
	async function getAll() {
		const { data } = await fetch("/drugsinventory");
		setQueryData(data);
	}
	useEffect(() => {
		getAll();
	}, []);
	return (
		<main className='space-y-6 py-4'>
			<section className='flex items-end justify-between'>
				<h2 className='text-xl font-bold'>Drugs Inventory</h2>
				<Group>
					<Button
						leftSection={<Printer />}
						onClick={() => {
							reactToPrintFn();
						}}
					>
						Print
					</Button>
					<Link
						className='bg-blue-500 hover:bg-blue-600 text-white p-2 text-sm rounded-sm transition duration-300'
						href='drugs/report'
					>
						Drugs report
					</Link>
					<Link
						className='bg-blue-500 hover:bg-blue-600 text-white p-2 text-sm rounded-sm transition duration-300'
						href='drugs/history'
					>
						Stock Update History
					</Link>
					<Link
						className='bg-blue-500 hover:bg-blue-600 text-white p-2 text-sm rounded-sm transition duration-300'
						href='drugs/purchase'
					>
						Drug Purchase Record
					</Link>
				</Group>
			</section>
			<form
				className='flex gap-6 w-full items-end'
				onSubmit={async (e) => {
					e.preventDefault();
					await post("/drugsinventory", {
						drug,
						stock_qty: Number(stock_qty) + Number(added),
						added,
						prevStock: stock_qty,
					});
					getAll();
					setStock(0);
					setAdded(0);
					setDrug("");
				}}
			>
				<TextInput
					label='Drug name'
					placeholder='name...'
					value={drug}
					onChange={(e) => {
						setDrug(e.currentTarget.value);
					}}
				/>

				<NumberInput
					label='Added quantity'
					placeholder='Added quantity...'
					value={added}
					min={0}
					onChange={(value: any) => {
						setAdded(value);
					}}
				/>

				<NumberInput
					label='Stock quantity'
					placeholder='Stock quantity...'
					value={Number(stock_qty) + Number(added)}
					hideControls={true}
					disabled
				/>

				<Button disabled={!drug} type='submit'>
					Add to inventory
				</Button>
			</form>
			<PaginatedTable
				headers={[
					"S/N",
					"Name",
					"Current Stock Quantity",
					"Last added amount",
					"Last Updated on",
					"Actions",
				]}
				printRows={printRows}
				printHeaders={[
					"S/N",
					"Name",
					"Current Stock Quantity",
					"Last added amount",
					"Last Updated on",
				]}
				placeholder='Search by drug name'
				sortedData={sortedData}
				rows={rows}
				showSearch={true}
				showPagination={true}
				data={queryData}
				setSortedData={setSortedData}
				tableLoading={loading}
				depth=''
				tableReport='Drugs Inventory record'
				ref={contentRef}
				setPrintData={setPrintData}
			/>

			<Modal
				opened={opened}
				onClose={() => {
					close();
					setEdata(null);
					setEAdded(0);
				}}
				title='Edit Test'
			>
				<form
					className='relative'
					onSubmit={async (e) => {
						e.preventDefault();
						await edit(`/drugsinventory/edit/${eData?.id}`, {
							added: eAdded,
							stock_qty: Number(eData?.stock_qty) + Number(eAdded),
							prevStock: eData?.stock_qty,
						});
						getAll();
						setEAdded(0);
						close();
					}}
				>
					<TextInput label='Drug' defaultValue={eData?.drug} disabled />
					<NumberInput
						label='Stock quantity'
						placeholder='Stock quantity...'
						value={Number(eData?.stock_qty) + Number(eAdded)}
						hideControls={true}
						disabled
					/>
					<NumberInput
						label='Added quantity'
						placeholder='Added quantity...'
						value={eAdded}
						required
						min={0}
						onChange={(value: any) => {
							setEAdded(value);
						}}
					/>

					<Group mt={20} justify='end'>
						<Button
							onClick={() => {
								close();
								setEdata(null);
								setEAdded(0);
							}}
							color='black'
						>
							Cancel
						</Button>
						<Button disabled={!eAdded} type='submit'>
							Update Inventory
						</Button>
					</Group>
				</form>
				<LoadingOverlay visible={eLoading} />
			</Modal>
		</main>
	);
};

export default DrugsInventory;
