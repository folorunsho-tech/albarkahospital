/* eslint-disable react-refresh/only-export-components */
/* eslint-disable @typescript-eslint/no-explicit-any */
"use client";
import React, { ReactNode } from "react";
const userContext = React.createContext<{
	user: any;
	permissions: any[];
	setUser: any;
	setPerm: any;
}>({
	user: null,
	permissions: [],
	setUser: () => {},
	setPerm: () => {},
});
const UserProvider = ({ children }: { children: ReactNode }) => {
	const [user, setUser] = React.useState<any>(null);
	const [permissions, setPerm] = React.useState<any[]>([]);

	return (
		<userContext.Provider value={{ user, setUser, permissions, setPerm }}>
			{children}
		</userContext.Provider>
	);
};

export { userContext, UserProvider };
