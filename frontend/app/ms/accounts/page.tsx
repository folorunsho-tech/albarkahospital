/* eslint-disable @typescript-eslint/no-explicit-any */
"use client";
import { useEffect, useState } from "react";
import PaginatedTable from "@/components/PaginatedTable";
import {
	Button,
	Table,
	rem,
	ActionIcon,
	Modal,
	TextInput,
	Group,
	Checkbox,
	LoadingOverlay,
	PasswordInput,
	Select,
} from "@mantine/core";
import { Pencil } from "lucide-react";
import { useDisclosure } from "@mantine/hooks";
import { useFetch, useEdit, usePost } from "@/queries";
const Accounts = () => {
	const [opened, { open, close }] = useDisclosure(false);
	const [popened, { open: popen, close: pclose }] = useDisclosure(false);
	const { loading, fetch, data } = useFetch();
	const { post, loading: pLoading } = usePost();
	const { loading: eLoading, edit } = useEdit();
	const [queryData, setQueryData] = useState<any[]>(data);
	const [sortedData, setSortedData] = useState<any[]>([]);
	const [menu, setMenu] = useState<{ label: string; link: string }[]>([]);
	const [Emenu, setEMenu] = useState<string[]>([]);
	const [eData, setEdata] = useState<any>([]);
	const [username, setUsername] = useState("");
	const [role, setRole] = useState("user");
	const [erole, setERole] = useState("");
	const [password, setPassword] = useState("");
	const [ePassword, setEPassword] = useState("");
	const menuExist = (list: string) => {
		return JSON.parse(list).map((m: any) => {
			return m.link;
		});
	};
	const rows = sortedData?.map((row, i: number) => (
		<Table.Tr key={row?.id}>
			<Table.Td>{i + 1}</Table.Td>
			<Table.Td>{row?.username}</Table.Td>
			<Table.Td>{row?.role}</Table.Td>
			<Table.Td>
				<ActionIcon
					onClick={() => {
						open();
						setEdata(row);
						setERole(row?.role);
						setEMenu(menuExist(row?.menu));
					}}
				>
					<Pencil style={{ width: rem(14), height: rem(14) }} />
				</ActionIcon>
			</Table.Td>
		</Table.Tr>
	));
	useEffect(() => {
		async function getAll() {
			const { data } = await fetch("/accounts");
			setQueryData(data);
		}
		getAll();
	}, []);

	const generateMenus = (links: string[]) => {
		return links.map((link) => {
			return {
				label: link,
				link,
			};
		});
	};

	return (
		<main className='space-y-6 py-4'>
			<div className='flex items-center justify-between'>
				<h2 className='text-xl font-bold'>Accounts</h2>
				<Button onClick={popen} color='teal'>
					Add new account
				</Button>
			</div>

			<Modal opened={popened} onClose={pclose} title='Account creation'>
				<form
					className='relative'
					onSubmit={async (e) => {
						e.preventDefault();
						await post("/accounts", {
							username,
							password,
							role,
							menu: JSON.stringify(
								menu.sort((a, b) => a.label.localeCompare(b.label))
							),
						});
						const { data } = await fetch("/accounts");
						setQueryData(data);
						setUsername("");
						setPassword("");
						setMenu([]);
						pclose();
					}}
				>
					<TextInput
						label='Username'
						placeholder='username'
						value={username}
						autoComplete=''
						onChange={(e) => {
							setUsername(e.currentTarget.value);
						}}
						required
					/>
					<PasswordInput
						label='Password'
						placeholder='Your password'
						autoComplete=''
						value={password}
						onChange={(e) => {
							setPassword(e.currentTarget.value);
						}}
						required
					/>
					<Select
						label='Role'
						data={["admin", "user"]}
						value={role}
						onChange={(value: any) => {
							setRole(value);
						}}
					/>
					<Checkbox.Group
						label="Select account's menus"
						onChange={(values) => {
							const generated = generateMenus(values);
							setMenu(generated);
						}}
						withAsterisk
						mt={20}
					>
						<Group mt='xs'>
							<Checkbox value='accounts' label='Accounts' />
							<Checkbox value='backup' label='Backup' />
							<Checkbox value='drugs' label='Drugs' />
							<Checkbox value='encounters' label='Encounters' />
							<Checkbox value='transactions' label='Transactions' />
							<Checkbox value='patients' label='Patients' />
							<Checkbox value='settings' label='Settings' />
						</Group>
					</Checkbox.Group>
					<Group mt={20} justify='end'>
						<Button onClick={pclose} color='black'>
							Cancel
						</Button>
						<Button disabled={!menu} type='submit' color='teal'>
							Add new account
						</Button>
					</Group>
				</form>
				<LoadingOverlay visible={pLoading} />
			</Modal>
			<PaginatedTable
				headers={["S/N", "Username", "Role", "Actions"]}
				placeholder=''
				sortedData={sortedData}
				rows={rows}
				showSearch={false}
				showPagination={true}
				data={queryData}
				setSortedData={setSortedData}
				tableLoading={loading}
			/>
			<Modal opened={opened} onClose={close} title='Update account'>
				<form
					onSubmit={async (e) => {
						e.preventDefault();
						await edit(`/accounts/edit/${eData?.id}`, {
							password: ePassword,
							role: erole,
							menu: JSON.stringify(
								generateMenus(Emenu).sort((a, b) =>
									a.label.localeCompare(b.label)
								)
							),
						});
						const { data } = await fetch("/accounts");
						setQueryData(data);
						setEPassword("");
						setEMenu([]);
						close();
					}}
				>
					<TextInput
						label='Username'
						placeholder='username'
						defaultValue={eData?.username}
						disabled
					/>
					<PasswordInput
						label='Password'
						placeholder='Your password'
						onChange={(e) => {
							setEPassword(e.currentTarget.value);
						}}
						mt='md'
					/>
					<Select
						label='Role'
						data={["admin", "user"]}
						value={erole}
						onChange={(value: any) => {
							setERole(value);
						}}
					/>
					<Checkbox.Group
						label="Select account's menus"
						value={Emenu}
						onChange={(values: any) => {
							setEMenu(values);
						}}
						withAsterisk
						mt={20}
					>
						<Group mt='xs'>
							<Checkbox value='accounts' label='Accounts' />
							<Checkbox value='backup' label='Backup' />
							<Checkbox value='drugs' label='Drugs' />
							<Checkbox value='encounters' label='Encounters' />
							<Checkbox value='transactions' label='Transactions' />
							<Checkbox value='patients' label='Patients' />
							<Checkbox value='settings' label='Settings' />
						</Group>
					</Checkbox.Group>
					<Group mt={20} justify='end'>
						<Button onClick={close} color='black'>
							Cancel
						</Button>
						<Button type='submit'>Update account</Button>
					</Group>
					<LoadingOverlay visible={eLoading} />
				</form>
			</Modal>
		</main>
	);
};

export default Accounts;
