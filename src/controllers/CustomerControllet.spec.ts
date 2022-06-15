import { Request, Response } from "express"
import { Customer } from "../domain/Customer"
import { mockedCustomers } from "../mock/mockedCustomers"
import { createCustomer, getCustomers } from "./CustomerController"

describe("CustomerController", () => {
    it("returns customers when getCustomers is called", () => {
        //Given
        const mockedRequest = {} as Request
        const mockedResponse = {
            status: jest.fn().mockReturnThis(),
            send: jest.fn().mockReturnThis()
        } as any as Response
        
        // When
        getCustomers(mockedRequest, mockedResponse)


        // Then

        expect(mockedResponse.status).toHaveBeenCalledWith(200)
        expect(mockedResponse.send).toHaveBeenCalledWith(mockedCustomers)
    })

    it("adds customer when createCustomer is called", () => {
         //Given
         const mockedRequest = {
            body: {
                id: "1",
                email: "test@test.com",
                name: "Test"
            } as Customer
         } as Request
         const mockedResponse = {
             status: jest.fn().mockReturnThis(),
             send: jest.fn().mockReturnThis()
         } as any as Response
         
         // When
         createCustomer(mockedRequest, mockedResponse)
         // Then
 
         expect(mockedResponse.status).toHaveBeenCalledWith(201)
         expect(mockedCustomers).toContain(mockedRequest.body)
    })
})