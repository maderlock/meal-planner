import { Router } from 'express';
import { PrismaClient } from '@prisma/client';
import { authenticateUser } from '../middleware/auth';

const router = Router();
const prisma = new PrismaClient();

// Get user's favorite meals
router.get('/favorites', authenticateUser, async (req, res) => {
  try {
    const meals = await prisma.meal.findMany({
      where: {
        userId: req.user.id,
        isFavorite: true,
      },
      orderBy: {
        name: 'asc',
      },
    });
    res.json(meals);
  } catch (error) {
    console.error('Error fetching favorite meals:', error);
    res.status(500).json({ error: 'Failed to fetch favorite meals' });
  }
});

// Add a new meal
router.post('/', authenticateUser, async (req, res) => {
  try {
    const { name, description, isFavorite } = req.body;
    const meal = await prisma.meal.create({
      data: {
        name,
        description,
        isFavorite: isFavorite ?? false,
        userId: req.user.id,
      },
    });
    res.status(201).json(meal);
  } catch (error) {
    console.error('Error creating meal:', error);
    res.status(500).json({ error: 'Failed to create meal' });
  }
});

// Update a meal
router.put('/:id', authenticateUser, async (req, res) => {
  try {
    const { id } = req.params;
    const { name, description, isFavorite } = req.body;

    const meal = await prisma.meal.findUnique({
      where: { id },
    });

    if (!meal) {
      return res.status(404).json({ error: 'Meal not found' });
    }

    if (meal.userId !== req.user.id) {
      return res.status(403).json({ error: 'Not authorized to update this meal' });
    }

    const updatedMeal = await prisma.meal.update({
      where: { id },
      data: {
        name,
        description,
        isFavorite,
      },
    });

    res.json(updatedMeal);
  } catch (error) {
    console.error('Error updating meal:', error);
    res.status(500).json({ error: 'Failed to update meal' });
  }
});

// Delete a meal
router.delete('/:id', authenticateUser, async (req, res) => {
  try {
    const { id } = req.params;

    const meal = await prisma.meal.findUnique({
      where: { id },
    });

    if (!meal) {
      return res.status(404).json({ error: 'Meal not found' });
    }

    if (meal.userId !== req.user.id) {
      return res.status(403).json({ error: 'Not authorized to delete this meal' });
    }

    await prisma.meal.delete({
      where: { id },
    });

    res.status(204).send();
  } catch (error) {
    console.error('Error deleting meal:', error);
    res.status(500).json({ error: 'Failed to delete meal' });
  }
});

export { router as mealRoutes };
