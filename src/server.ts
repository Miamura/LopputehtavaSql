import express, { Request, Response } from "express";
import { Kysely, PostgresDialect } from "kysely";
import { Pool } from "pg";
import dotenv from "dotenv";

dotenv.config();

interface GoldGrading {
  id: number;
  karat_grade: string;
  fineness: number;
  color: string;
  purity_percentage: number;
}

interface DiamondGrading {
  id: number;
  carat_weight: number;
  cut_grade: string;
  color_grade: string;
  clarity_grade: string;
}

interface Jewelry {
  id: number;
  name: string;
  type: string;
  price: number;
  gold_grading_id: number | null;
  diamond_grading_id: number | null;
  description: string;
}

interface Database {
  goldGrading: GoldGrading;
  diamondGrading: DiamondGrading;
  jewelry: Jewelry;
}

const db = new Kysely<Database>({
  dialect: new PostgresDialect({
    pool: new Pool({
      host: process.env.DB_HOST,
      port: parseInt(process.env.DB_PORT || "5432", 10),
      user: process.env.DB_USER,
      password: process.env.DB_PASSWORD,
      database: process.env.DB_NAME,
    }),
  }),
});

db.selectFrom("jewelry")
  .selectAll()
  .limit(1)
  .execute()
  .then(() => console.log("Database connected successfully"))
  .catch((error) => {
    console.error("Failed to connect to the database:", error);
    process.exit(1);
  });

const app = express();
const PORT = 3000;

app.get("/", (req: Request, res: Response) => {
  res.send("Welcome to the Jewelry API!");
});

app.get("/jewelry/all", async (req: Request, res: Response) => {
  try {
    const jewelryItems = await db.selectFrom("jewelry").selectAll().execute();
    res.json(jewelryItems);
  } catch (error) {
    console.error("Error fetching jewelry data:", error);
    res.status(500).json({ error: "Failed to fetch jewelry data" });
  }
});

app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});

/*
app.get("/jewelry/24k", async (req: Request, res: Response) => {
  try {
    // Step 1: Get the id for 24K gold from goldGrading
    const gold24kId = await db
      .selectFrom("goldGrading")
      .select("id")
      .where("karat_grade", "=", "24K")
      .execute();

    // Ensure we found a 24K gold grading entry
    if (!gold24kId.length) {
      return res.status(404).json({ error: "24K gold grading not found" });
    }

    // Extract the id for 24K gold grading
    const goldGradingId = gold24kId[0].id;

    // Step 2: Use the id to get jewelry with 24K gold grading
    const jewelry24k = await db
      .selectFrom("jewelry")
      .select(["name", "type", "price"])
      .where("gold_grading_id", "=", goldGradingId)
      .execute();

    res.json(jewelry24k);
  } catch (error) {
    console.error("Error fetching 24K jewelry data:", error);
    res.status(500).json({ error: "Failed to fetch 24K jewelry data" });
  }
});

*/
