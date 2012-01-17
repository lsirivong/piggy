*Piggy is a money management web app based on the 50/30/20 budgeting method.*

## The 50/30/20 Budget

The 50/30/20 budget works well because it prevents you from over-thinking how to categorize spending. Managing this kind of budget with spreadsheets is error prone and could also benefit from some automation.

In addition to support for easily tracking performance in the 50/30/20 budget, Piggy features Goals to help you plan for things like recurring bills (rent, utilities, etc.) or a big purchase you've had your eye on.

## Demo

You can view a demo at:
[http://gentle-journey-8227.herokuapp.com/](http://gentle-journey-8227.herokuapp.com/)

Piggy is currently only capable of very trivial tracking of spending and saving. Basically, you are able to set a total amount for a budget, allocate it into Savings, Wants, and Needs categories, and keep track of how much you've spent.

**The demo does not support authentication or encryption of data, so all data is reset nightly.**

## Todo

* Paginate the spending list
* Add some automation to goals: when you set a deadline for a goal Piggy should give you the option to allocate the amount that makes sense in a budget to achieve that goal.
* Visualize history: as budgets expire there should be a useful way to visualize how you performed over the past.
* Prompt and smartly create new budgets: add support to automatically create new budgets with preferred defaults when there is no current budget.
* Consider a worflow to handle surplus and deficit amounts in budgets.
* Provide a workflow for "spending" a goal. Once a goal is met and you spend that money, something needs to happen to that goal, and that purchase should be tracked.
* Provide automation for goals, if I know I have to pay the same amount of rent on the first of every month Piggy should handle the details for me.
* Visualize spending during a budget to help understand where you're spending the most money.

## Known issues

* When moving an entry from the spending list to a different category, the previous category's stats will not update.
* Budgets may be allocated into chunks that don't add up to 100%
