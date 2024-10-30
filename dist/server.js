"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = __importDefault(require("express"));
const kysely_1 = require("kysely");
const pg_1 = require("pg");
const dotenv_1 = __importDefault(require("dotenv"));
dotenv_1.default.config();
const db = new kysely_1.Kysely({
    dialect: new kysely_1.PostgresDialect({
        pool: new pg_1.Pool({
            host: process.env.DB_HOST,
            port: parseInt(process.env.DB_PORT || "5432", 10),
            user: process.env.DB_USER,
            password: process.env.DB_PASSWORD,
            database: process.env.DB_NAME,
        }),
    }),
});
// Test database connection
db.selectFrom("jewelry")
    .selectAll()
    .limit(1)
    .execute()
    .then(() => console.log("Database connected successfully"))
    .catch((error) => {
    console.error("Failed to connect to the database:", error);
    process.exit(1);
});
const app = (0, express_1.default)();
const PORT = 3000;
// Root route to avoid 404 on the base URL
app.get("/", (req, res) => {
    res.send("Welcome to the Jewelry API!");
});
// New route for viewing all jewelry data
app.get("/jewelry/all", async (req, res) => {
    try {
        const jewelryItems = await db.selectFrom("jewelry").selectAll().execute();
        res.json(jewelryItems);
    }
    catch (error) {
        console.error("Error fetching jewelry data:", error);
        res.status(500).json({ error: "Failed to fetch jewelry data" });
    }
});
app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
});
