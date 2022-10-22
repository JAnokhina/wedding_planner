import 'package:flutter/material.dart';
import 'package:wedding_planner/firebase_models/budget_model.dart';
import 'package:wedding_planner/firebase_services/budget_service.dart';
import 'package:wedding_planner/locator.dart';

class BudgetState with ChangeNotifier {
  BudgetModel _budget = BudgetModel(
      total: 0,
      venueAndFood: 0,
      photos: 0,
      music: 0,
      flowers: 0,
      decor: 0,
      attire: 0,
      transport: 0,
      stationary: 0,
      favours: 0,
      cake: 0);

  BudgetModel get budget => _budget;

  set budget(BudgetModel value) {
    _budget = value;
    notifyListeners();
  }

  setBudgetData({required double budget}) async {
    await locator<BudgetService>().setBudgetDetails(budget);
  }

  refreshBudgetData() async {
    budget = await locator<BudgetService>().getBudgetData();
  }
}