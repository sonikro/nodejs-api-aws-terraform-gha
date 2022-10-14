import { mockedCustomers } from "../mock/mockedCustomers";
import {Request, Response} from "express"

export const getCustomers = (request: Request, response: Response) => {
    return response
        .status(200)
        .send(mockedCustomers)
}

export const createCustomer = (request: Request, response: Response) => {
    mockedCustomers.push(request.body)
    return response
        .status(201)
        .send()
}

