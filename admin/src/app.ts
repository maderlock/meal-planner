import express from 'express';
import cors from 'cors';
import { mealRoutes } from './routes/meal.routes';
import { weeklyPlanRoutes } from './routes/weekly-plan.routes';

const app = express();

app.use(cors());
app.use(express.json());

// Routes
app.use('/api/meals', mealRoutes);
app.use('/api/weekly-plans', weeklyPlanRoutes);

export { app };
