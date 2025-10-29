🧠 Technical Test: Operations Intelligence Analyst
📌 Context
You have received transaction data from CloudWalk's payment processing system. Your goal is to analyze this data and create visualizations and KPIs that provide strategic insights to support decision-making.

📊 Dataset
The provided dataset is a CSV with the following fields:

day day
entity PF or PJ
product product used to make the transaction
price_tier Fee tier
anticipation_method anticipation method used
nitro_or_d0 IF uses Nitro or D0 anticipation
payment_method
installments
amount_transacted
quantity_transactions
quantity_of_merchants
🚩 Task
Prepare a presentation with visualizations addressing the following points(but not limited to):

🎯 Business KPIs
1. Total Payment Volume (TPV)

Calculate and visualize TPV segmented by entity, product, and payment method.
Compare products based on their TPV.
TPV is the sum of the amount of the transactions
4. Average Ticket

Calculate and visualize the average ticket size, segmented by entity, product, and payment method.
📈 Transactional Insights
5. Installments Analysis

Analyze how installment options impact transaction volume.
Provide visualizations showing transaction behavior across different installment options.
6. Price Tier Analysis

Identify and visualize differences in performance metrics (volume, transactions) across price tiers.
**7. What we expect

We expected you to able to answer general business questions with this data, eg: Which product has more tpv? How weekdays increase or decrease tpv? Which has the biggest avg tpv? And Avg Ticket? Which anticipation method is more used by each entity? and etc.
🤖 Automation Proposal
8. AI Assistant Proposal

Propose an AI-powered assistant or bot that automatically provides daily KPI updates, particularly Total Payment Volume (TPV).
The bot should include:
Daily summary of TPV performance.
Growth comparisons to the previous day, week, and month.
Automatic alerts if TPV or avg TPV is significantly low in any segment (entity, product, or payment method) compared to historical performance.
Practical examples of automated insights or alert messages the bot could generate.
📝 Presentation Deliverables
Brief description of context and methodology.
Clear, informative, and easy-to-understand visualizations.
Clearly articulated strategic insights or recommendations.
🛠️ Suggested Tools
SQL (BigQuery, Postgres)
BI Tools (Looker Studio, Metabase)
DON'T USE POWER BI.
Python (optional, but highly recommended for deeper analysis and advanced visualizations)
✅ Evaluation Criteria
Data accuracy
Clarity and quality of visualizations
Ability to generate relevant business insights
Creativity in leveraging AI and automation
