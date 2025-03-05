/* eslint-disable @typescript-eslint/no-explicit-any */
"use client";

import { useFetch, useEdit } from "@/queries";
import {
	ActionIcon,
	Button,
	LoadingOverlay,
	ScrollArea,
	Select,
	Table,
	TextInput,
} from "@mantine/core";
import { IconPencil, IconX } from "@tabler/icons-react";
import { useEffect, useState } from "react";
import { nanoid } from "nanoid";

const Labtest = ({
	data,
	id,
	getEnc,
}: {
	data: any[];
	id: string | null;
	getEnc: any;
}) => {
	const [labTest, setLabTest] = useState<any[]>([]);
	const { fetch } = useFetch();
	const { edit, loading } = useEdit();
	const [testId, setTestId] = useState("");
	const [testInfo, setTestInfo] = useState("");
	const [testName, setTestName] = useState("");
	const [testResult, setTestResult] = useState("");
	const [testsList, setTestsList] = useState([]);
	const [search, setSearch] = useState("");

	useEffect(() => {
		const getAll = async () => {
			const { data: found } = await fetch("/settings/tests");
			const mapped = found?.map((test: any) => {
				return {
					value: test?.id,
					label: test?.name,
				};
			});
			setTestsList(mapped);
			setLabTest(
				data?.map((test) => {
					return {
						lab_id: test?.id,
						id: test?.test_id,
						name: test?.testType?.name,
						result: test?.result,
						info: test?.info,
					};
				})
			);
		};
		getAll();
		getEnc();
	}, []);

	return (
		<form
			className='space-y-6 my-4'
			onSubmit={async (e) => {
				e.preventDefault();
				await edit("/encounters/edit/labs/" + id, {
					labs: labTest,
				});
			}}
		>
			<section className='flex items-end gap-4'>
				<Select
					label='Lab Test'
					placeholder='Select or search test'
					data={testsList}
					className='w-[20rem]'
					value={testId}
					clearable
					onSearchChange={setSearch}
					searchValue={search}
					onChange={(value: any) => {
						const found: any = testsList.find(
							(drug: any) => drug?.value == value
						);
						setTestId(value);
						setTestName(found?.label);
					}}
					searchable
					nothingFoundMessage='Nothing found...'
				/>
				<TextInput
					label='Test Result'
					placeholder='Input test result'
					value={testResult}
					onChange={(e) => {
						setTestResult(e.target.value);
					}}
				/>
				<Select
					label='Test Info'
					placeholder='Select test info'
					data={[
						"High",
						"Low",
						"Normal",
						"Mod severe",
						"Negative",
						"Positive",
						"Severe",
					]}
					className='w-[20rem]'
					clearable
					value={testInfo}
					onChange={(value: any) => {
						setTestInfo(value);
					}}
					nothingFoundMessage='Nothing found...'
				/>

				<Button
					disabled={!(testInfo && testId)}
					onClick={() => {
						const filtered = labTest.filter((t: any) => testId !== t?.id);
						setLabTest([
							{
								lab_id: nanoid(10),
								id: testId,
								name: testName,
								result: testResult,
								info: testInfo,
							},
							...filtered,
						]);
						setTestId("");
						setSearch("");
						setTestResult("");
					}}
				>
					Add to list
				</Button>
			</section>
			<ScrollArea h={200} w={900}>
				<Table>
					<Table.Thead>
						<Table.Tr>
							<Table.Th>S/N</Table.Th>
							<Table.Th>Name</Table.Th>
							<Table.Th>Result</Table.Th>
							<Table.Th>Info</Table.Th>
							<Table.Th></Table.Th>
						</Table.Tr>
					</Table.Thead>
					<Table.Tbody>
						{labTest.map((test: any, i: number) => (
							<Table.Tr key={test?.lab_id}>
								<Table.Td>{i + 1}</Table.Td>
								<Table.Td>{test?.name}</Table.Td>
								<Table.Td>{test?.result}</Table.Td>
								<Table.Td>{test?.info}</Table.Td>

								<Table.Td className='flex items-center gap-2'>
									<ActionIcon
										color='teal'
										onClick={() => {
											setTestId(test?.id);
											setTestInfo(test?.info);
											setTestResult(test?.result);
											setTestName(test?.name);
										}}
									>
										<IconPencil />
									</ActionIcon>
									<ActionIcon
										color='red'
										onClick={() => {
											const filtered = labTest.filter(
												(t: any) => test?.id !== t?.id
											);

											setLabTest(filtered);
										}}
									>
										<IconX />
									</ActionIcon>
								</Table.Td>
							</Table.Tr>
						))}
					</Table.Tbody>
				</Table>
			</ScrollArea>
			<Button color='teal' w={200} type='submit'>
				Update labs
			</Button>
			<LoadingOverlay visible={loading} />
		</form>
	);
};

export default Labtest;
