import axios from "axios";
export const axiosInstance = axios.create({
	baseURL: process.env.NEXT_PUBLIC_SERVER_API,
	responseType: "json",
	timeout: 5000,
	validateStatus: function (status) {
		return status < 510; // Resolve only if the status code is less than 500
	},
});
