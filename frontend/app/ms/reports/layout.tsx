"use client";
import { NavLink } from "@mantine/core";
import Link from "next/link";
import { usePathname } from "next/navigation";
import React, { ReactNode } from "react";
const Layout = ({ children }: { children: ReactNode }) => {
	const url = usePathname();

	return (
		<main>
			<nav className='flex  items-center bg-teal-700 text-white navs rounded-r-full mb-3'>
				<NavLink
					variant='filled'
					color='teal'
					component={Link}
					href='/ms/reports'
					label='Patients'
					className='rounded-r-full'
					active={`/ms/reports` == url}
				/>
				<NavLink
					variant='filled'
					color='teal'
					component={Link}
					href='/ms/reports/encounters'
					label='Encounters'
					className='rounded-r-full'
					active={`/ms/reports/encounters` == url}
				/>
				<NavLink
					variant='filled'
					color='teal'
					component={Link}
					href='/ms/reports/drugs'
					label='Drugs'
					className='rounded-r-full'
					active={`/ms/reports/drugs` == url}
				/>
				<NavLink
					variant='filled'
					color='teal'
					component={Link}
					href='/ms/reports/deliveries'
					label='Delivery'
					className='rounded-r-full'
					active={`/ms/reports/deliveries` == url}
				/>
				<NavLink
					variant='filled'
					color='teal'
					component={Link}
					href='/ms/reports/labs'
					label='Labs'
					className='rounded-r-full'
					active={`/ms/reports/labs` == url}
				/>
				<NavLink
					variant='filled'
					color='teal'
					component={Link}
					href='/ms/reports/operations'
					label='Operation'
					className='rounded-r-full'
					active={`/ms/reports/operations` == url}
				/>
			</nav>
			{children}
		</main>
	);
};

export default Layout;
