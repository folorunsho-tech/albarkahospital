/* eslint-disable @typescript-eslint/no-explicit-any */
"use client";

import { useRef, useState } from "react";
import { Combobox, Loader, TextInput, useCombobox } from "@mantine/core";
import { axiosInstance as axios } from "@/lib/config";

function getAsyncData(searchQuery: string, signal: AbortSignal) {
	return new Promise<string[]>((resolve, reject) => {
		signal.addEventListener("abort", () => {
			reject(new Error("Request aborted"));
		});
		axios
			.post("/patients/search", { value: searchQuery })
			.then((result: any) => {
				resolve(result.data);
			});
	});
}

export default function PatientSearch({
	setSelected,
	setPatient,
}: {
	setSelected: any;
	setPatient: any;
}) {
	const combobox = useCombobox({
		onDropdownClose: () => combobox.resetSelectedOption(),
	});

	const [loading, setLoading] = useState(false);
	const [data, setData] = useState<any[] | null>(null);
	const [value, setValue] = useState("");
	const [empty, setEmpty] = useState(false);
	const abortController = useRef<AbortController | undefined>(null);

	const fetchOptions = (query: string) => {
		abortController.current?.abort();
		abortController.current = new AbortController();
		setLoading(true);

		getAsyncData(query, abortController.current.signal)
			.then((result) => {
				setData(result);
				setLoading(false);
				setEmpty(result.length === 0);
				abortController.current = undefined;
			})
			.catch(() => {});
	};

	const options = (data || []).map((item) => (
		<Combobox.Option value={item?.hosp_no} key={item?.hosp_no}>
			{item?.hosp_no} - {item?.name}
		</Combobox.Option>
	));

	return (
		<Combobox
			onOptionSubmit={(optionValue) => {
				setValue(optionValue);
				const id = data?.find(
					(patient: any) => patient?.hosp_no == optionValue
				);
				setSelected(id?.id);
				setPatient(
					data?.find((patient: any) => patient?.hosp_no == optionValue)
				);
				combobox.closeDropdown();
			}}
			withinPortal={false}
			store={combobox}
		>
			<Combobox.Target>
				<TextInput
					label='Patient Hosp No'
					placeholder='Search by hosp no '
					value={value}
					onChange={(event) => {
						setValue(event.currentTarget.value);
						fetchOptions(event.currentTarget.value);
						combobox.resetSelectedOption();
						combobox.openDropdown();
					}}
					onClick={() => combobox.openDropdown()}
					onFocus={() => {
						combobox.openDropdown();
						if (data === null) {
							fetchOptions(value);
						}
					}}
					onBlur={() => combobox.closeDropdown()}
					rightSection={loading && <Loader size={18} />}
					className='w-[15rem]'
				/>
			</Combobox.Target>

			<Combobox.Dropdown hidden={data === null}>
				<Combobox.Options>
					{options}
					{empty && <Combobox.Empty>No results found</Combobox.Empty>}
				</Combobox.Options>
			</Combobox.Dropdown>
		</Combobox>
	);
}
