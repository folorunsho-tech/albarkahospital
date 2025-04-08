/* eslint-disable @typescript-eslint/no-explicit-any */
"use client";
import { useFetchSingle } from "@/queries";
import { ReactNode, createContext, useEffect, useState } from "react";
import { useCookies } from "next-client-cookies";
import { useRouter } from "next/navigation";

const userContext = createContext<{
	user: any;
	authId: null | string;
	permissions: any[];
	setUser: any;
	setPerm: any;
	setAuthId: any;
	setToken: any;
	token: null | string;
}>({
	user: null,
	authId: null,
	permissions: [],
	setUser: () => {},
	setPerm: () => {},
	setAuthId: () => {},
	setToken: () => {},
	token: null,
});
const UserProvider = ({ children }: { children: ReactNode }) => {
	const router = useRouter();
	const { fetch } = useFetchSingle();
	const [user, setUser] = useState<any>(null);
	const [token, setToken] = useState<null | string>(null);
	const [authId, setAuthId] = useState<any>(null);
	const [permissions, setPerm] = useState<any[]>([]);
	const getData = async (id: string) => {
		const { data } = await fetch(`/auth/${id}/basic`);
		setUser(data);
		setPerm(JSON.parse(data?.menu));
	};
	const cookies: any = useCookies();
	const gotten = cookies.get("albarkahospitalms");
	useEffect(() => {
		if (!gotten) {
			router.push("/");
		} else {
			const parsed = gotten ? JSON.parse(gotten) : null;
			getData(parsed?.userId);
		}
	}, [authId, token]);

	return (
		<userContext.Provider
			value={{
				user,
				setUser,
				permissions,
				setPerm,
				authId,
				setAuthId,
				token,
				setToken,
			}}
		>
			{children}
		</userContext.Provider>
	);
};

export { userContext, UserProvider };
