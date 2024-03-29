import bodyParser from "body-parser";
import express from "express";
import { createCustomer, getCustomers } from "./controllers/CustomerController";


const app = express()

const PORT = process.env.PORT || 8080

app.use(bodyParser.json())
app.get("/customer", getCustomers)
app.post("/customer", createCustomer)
app.get("/health", (_, response) => {
    return response.status(200).send()
})
app.listen(PORT, () => {
    console.log(`Server listening at ${PORT}`)
})