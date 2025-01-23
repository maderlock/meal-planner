import { Router } from 'express';
import { PrismaClient } from '@prisma/client';
import { authenticateUser } from '../middleware/auth';

const router = Router();
const prisma = new PrismaClient();

// Get current week's plan
router.get('/current', authenticateUser, async (req, res) => {
  try {
    const now = new Date();
    const monday = new Date(now);
    monday.setDate(now.getDate() - now.getDay() + 1);
    monday.setHours(0, 0, 0, 0);

    let weeklyPlan = await prisma.weeklyPlan.findFirst({
      where: {
        userId: req.user.id,
        weekStartDate: monday,
      },
      include: {
        mealPlans: {
          include: {
            meal: true,
          },
        },
      },
    });

    if (!weeklyPlan) {
      // Create a new weekly plan if none exists
      weeklyPlan = await prisma.weeklyPlan.create({
        data: {
          userId: req.user.id,
          weekStartDate: monday,
        },
        include: {
          mealPlans: {
            include: {
              meal: true,
            },
          },
        },
      });
    }

    res.json(weeklyPlan);
  } catch (error) {
    console.error('Error fetching weekly plan:', error);
    res.status(500).json({ error: 'Failed to fetch weekly plan' });
  }
});

// Update meal for a specific day
router.put('/:planId/meals/:dayOfWeek', authenticateUser, async (req, res) => {
  try {
    const { planId, dayOfWeek } = req.params;
    const { mealId, mealType } = req.body;

    const weeklyPlan = await prisma.weeklyPlan.findUnique({
      where: { id: planId },
    });

    if (!weeklyPlan) {
      return res.status(404).json({ error: 'Weekly plan not found' });
    }

    if (weeklyPlan.userId !== req.user.id) {
      return res.status(403).json({ error: 'Not authorized to update this plan' });
    }

    // Delete existing meal plan for this day if it exists
    await prisma.mealPlan.deleteMany({
      where: {
        weeklyPlanId: planId,
        dayOfWeek: parseInt(dayOfWeek),
      },
    });

    if (mealId) {
      // Create new meal plan
      const mealPlan = await prisma.mealPlan.create({
        data: {
          weeklyPlanId: planId,
          mealId,
          dayOfWeek: parseInt(dayOfWeek),
          mealType,
        },
        include: {
          meal: true,
        },
      });

      res.json(mealPlan);
    } else {
      res.status(204).send();
    }
  } catch (error) {
    console.error('Error updating meal plan:', error);
    res.status(500).json({ error: 'Failed to update meal plan' });
  }
});

export { router as weeklyPlanRoutes };
