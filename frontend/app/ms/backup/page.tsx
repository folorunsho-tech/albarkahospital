"use client";

import React from "react";
import { Button, Loader, Tabs, rem } from "@mantine/core";
import {
	IconDatabaseExport,
	IconDownload,
	IconX,
	IconCheck,
} from "@tabler/icons-react";
import { axiosInstance as axios } from "@/lib/config";
import { notifications } from "@mantine/notifications";
const Backup = () => {
	const [backingUp, setbackingUp] = React.useState(false);
	const iconStyle = { width: rem(20), height: rem(20) };
	const server = process.env.NEXT_PUBLIC_SERVER_API;
	const showBackedUp = (status: number) => {
		if (status == 200) {
			notifications.show({
				id: "BackedSucc",
				withCloseButton: true,
				autoClose: 1000,
				withBorder: true,
				className: "w-max absolute top-0  left-0",
				title: "Success !!!",
				message: "Successfully backed up !!!",
				color: "green",
				icon: <IconCheck />,
			});
		} else {
			notifications.show({
				id: "BackedErr",
				withCloseButton: true,
				autoClose: 1000,
				withBorder: true,
				className: "w-max absolute top-0  left-0",
				title: "Error!!!",
				message: "Error Backing up Database!!!",
				color: "red",
				icon: <IconX />,
			});
		}
	};

	return (
		<section className='py-2'>
			<Tabs
				className='bg-white'
				color='teal'
				defaultValue='generate'
				keepMounted={false}
			>
				<Tabs.List grow justify='justify-betwenn'>
					<Tabs.Tab
						value='generate'
						leftSection={<IconDatabaseExport style={iconStyle} />}
					>
						Generate Backup
					</Tabs.Tab>
				</Tabs.List>

				<Tabs.Panel value='generate' className='p-2 flex flex-col gap-6'>
					<div className='flex gap-4 items-end'>
						<Button
							disabled={backingUp}
							onClick={async () => {
								setbackingUp(true);
								const res = await axios.post("/backup/generate");
								setbackingUp(false);
								showBackedUp(res?.status);
							}}
						>
							Generate backup
						</Button>
						{backingUp && (
							<i className='flex gap-1 items-center'>
								<Loader color='blue' size='md' type='dots' /> Generating
								backup...
							</i>
						)}
					</div>
					<a href={server + "/backup/download"} className='w-max'>
						<Button
							color='teal'
							leftSection={<IconDownload style={iconStyle} />}
						>
							Download backup
						</Button>
					</a>
				</Tabs.Panel>
			</Tabs>
		</section>
	);
};

export default Backup;
