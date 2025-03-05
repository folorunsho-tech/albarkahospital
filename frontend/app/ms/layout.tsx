/* eslint-disable @typescript-eslint/no-explicit-any */
"use client";
import { AppShell } from "@mantine/core";
import { userContext } from "@/context/User";
import { useContext, useEffect } from "react";
import { useRouter } from "next/navigation";
import NavMenu from "@/components/NavMenu";
import { useCookies } from "next-client-cookies";

export default function RootLayout({
	children,
}: Readonly<{
	children: React.ReactNode;
}>) {
	const { setUser, setPerm } = useContext(userContext);
	const cookies: any = useCookies();
	const router = useRouter();
	const gotten = cookies.get("albarkahospitalms");
	useEffect(() => {
		const parsed = gotten ? JSON.parse(gotten) : null;
		const menu = gotten ? JSON.parse(parsed?.menu) : [];
		if (!gotten) {
			router.push("/");
		} else {
			setUser(parsed);
			setPerm(menu);
		}
	}, []);
	return (
		<AppShell
			navbar={{
				width: 150,
				breakpoint: "sm",
			}}
			padding='sm'
		>
			<AppShell.Navbar>
				<NavMenu />
			</AppShell.Navbar>
			<AppShell.Main>{children}</AppShell.Main>
		</AppShell>
	);
}
