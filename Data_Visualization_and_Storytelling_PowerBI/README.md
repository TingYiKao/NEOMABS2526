# Data Visualization and Storytelling - Power BI

This folder contains coursework, in-class Power BI exercises, lecture materials, and the final group project for the NEOMA Business School course **Data Visualization and Storytelling**.

The final project analyzes Google Merchandise Store sales behavior with Power BI. The dashboard focuses on product category performance, country and device patterns, and purchase trends that can support a 25% sales improvement target by the end of 2026.

## Power BI Service Link

[Open the published Power BI dashboard](https://app.powerbi.com/links/BuzreBm9i9?ctid=ea847b31-dc73-4e64-b8e9-54cb237688f3&pbi_source=linkShare&bookmarkGuid=c81f8187-f04a-4425-be6c-96013022f3a1)

## Repository Structure

| Folder / File | Description |
|---|---|
| `README.md` | Course and project documentation for GitHub. |
| `reports/final_project/` | Final group project proposal documents, Power BI files, and source datasets. |
| `reports/final_project/Datasets/` | Google Merchandise Store CSV tables used in the final dashboard. |
| `reports/inclass_powerbi/` | In-class Power BI practice files. |
| `reports/lecture_materials/` | Course lecture PDF slides. |
| `reports/lecture_materials/Sample - Superstore.xlsx` | Sample Superstore Excel dataset used in Power BI practice. |
| `reports/lecture_materials/Guideline for answers in final exam.pdf` | Final exam answer guideline for chart critique and redesign. |
| `figures/final_project/` | Final project exported dashboard image. |
| `figures/inclass_powerbi/` | Exported in-class Power BI exercise image. |

## Final Project: Google Sales Analysis

| Item | Detail |
|---|---|
| Client / scenario | Google Merchandise Store, an e-commerce store selling Google-branded apparel, drinkware, accessories, and lifestyle products. |
| Business challenge | Identify product, geography, device, and time-based sales opportunities to support a 25% sales improvement target by the end of 2026. |
| Dataset source | Google Merchandise Sales Data from Kaggle. |
| Main Power BI file | `reports/final_project/Finalgroupproject.pbix` |
| Supporting Power BI files | `reports/final_project/data_load.pbix`, `reports/final_project/total revenue and purchase volume.pbix` |
| Proposal files | `reports/final_project/Google Merchandise_proposal.docx`, `reports/final_project/capstone-group-proposal.docx` |
| Dashboard image | `figures/final_project/MyDashboard.png` |

### Business Questions

| No. | Question | Dashboard approach |
|---:|---|---|
| 1 | Which product categories generate the most revenue and purchase volume? | KPI cards, clustered bar charts, and category contribution table. |
| 2 | Which countries contribute the most sales, and how does performance vary by device? | Map, country/device visuals, slicer, and pivot-style breakdown. |
| 3 | How do sales evolve over time, and are there visible peaks or drops? | Time-based purchase trend with month filtering and business recommendations. |

### Dataset Summary

| File | Rows | Key fields | Purpose |
|---|---:|---|---|
| `reports/final_project/Datasets/items.csv` | 1,381 | `id`, `name`, `brand`, `variant`, `category`, `price_in_usd` | Product catalog and price lookup. |
| `reports/final_project/Datasets/events.csv` | 758,884 | `user_id`, `ga_session_id`, `country`, `device`, `type`, `item_id`, `date` | Session, device, country, event type, and purchase behavior. |
| `reports/final_project/Datasets/users.csv` | 270,154 | `id`, `ltv`, `date` | User-level lifetime value and user creation date. |

The events table covers **2020-11-01 to 2021-01-31** and includes three main event types: `add_to_cart`, `begin_checkout`, and `purchase`.

### Key Dashboard Metrics

| Metric | Value |
|---|---:|
| Total purchase rows | 15,555 |
| Computed purchase revenue | `$307,114` |
| Top revenue category | Apparel |
| Apparel revenue share | 54.48% |
| Top countries by computed revenue | US, IN, CA, GB, ES |
| Main devices in event activity | Desktop, mobile, tablet |

### Dashboard Page Map

| Page | Main visuals | Story purpose |
|---|---|---|
| `Page 1` | Text boxes and image | Introduces the Google Merchandise Store context and business challenge. |
| `Question 1` | Cards, clustered bar charts, table | Shows that Apparel leads both revenue and purchase volume. |
| `Question 2` | Map, country/device chart, slicer, pivot table | Compares geography and device behavior. |
| `Question 3` | Combo trend chart, slicer, cards | Explains purchase volume changes over time and suggests planning actions. |
| `Page 2` | Funnel, scatter chart, recommendations | Summarizes recommendations around Apparel, checkout conversion, and inventory stability. |

### Figure 1: Final Project Dashboard

![Final project dashboard showing product category revenue and purchase volume](<figures/final_project/MyDashboard.png>)

The exported dashboard page shows total revenue of `$307.11K`, purchase volume of `16K`, and Apparel as the top category. Apparel contributes `54.48%` of total revenue, while Bags, New, and Campus Collection form the next tier.

## In-Class Power BI Practice

| File | Summary |
|---|---|
| `reports/inclass_powerbi/2026_0320_Inclass.pbix` | Introductory Power BI practice with bar chart, donut chart, and slicer. |
| `reports/inclass_powerbi/2026_0323_Inclass.pbix` | Early in-class Power BI file with loaded data but no report visuals. |
| `reports/inclass_powerbi/2026_0323_Inclass_dashboard.pbix` | Superstore dashboard practice covering profit analysis, scatter plot, sales by region, and a combined dashboard page. |
| `reports/inclass_powerbi/2026_0324_Inclass.pbix` | Advanced visualization practice: bump chart, ribbon chart, distribution chart, bar chart, line chart, scatter plot, treemap, map, card, and dashboard page. |
| `reports/inclass_powerbi/2026_0325_Inclass.pbix` | Chart improvement practice for hierarchy, comparability, profit/loss highlighting, and cognitive load reduction. |
| `reports/inclass_powerbi/2026_0326_Inclass.pbix` | Continued dashboard and table practice with slicers and KPI cards. |
| `reports/inclass_powerbi/2026_0327_Inclass.pbix` | Bookmark navigation, slicer, chart refinement, and dashboard interaction practice. |
| `reports/inclass_powerbi/2026_0331_Inclass.pbix` | Table, slicer, KPI, column chart, line chart, and YoY growth storytelling practice. |
| `figures/inclass_powerbi/YoY Exercise_Tingyi.png` | Exported YoY sales growth exercise image. |

### Figure 2: YoY Exercise

![Year-over-year sales growth exercise](<figures/inclass_powerbi/YoY Exercise_Tingyi.png>)

The YoY exercise emphasizes that growth is volatile: 2022 shows the lowest YoY growth at `-4.26%`, while 2023 and 2024 show strong recovery at `29.80%` and `21.44%`.

## Lecture Materials

| File | Topic |
|---|---|
| `reports/lecture_materials/Session 1.pdf` | Course introduction and data storytelling overview. |
| `reports/lecture_materials/Session 2.pdf` | Graphical perception and introduction to Power BI. |
| `reports/lecture_materials/Session 4.pdf` | Graphical integrity and Power BI practice. |
| `reports/lecture_materials/Session 5.pdf` | Choosing the right chart and matching visuals to data types and analysis goals. |
| `reports/lecture_materials/Session 6.pdf` | Dashboard design, design sophistication, accessibility, and affordances. |
| `reports/lecture_materials/Session 8.pdf` | Storytelling, dashboard-to-data-story flow, and delivery best practices. |

## Notes on Figure Order

Only two exported image files are currently present in this folder:

| Order | File | Placement |
|---:|---|---|
| 1 | `figures/final_project/MyDashboard.png` | Final project dashboard section. |
| 2 | `figures/inclass_powerbi/YoY Exercise_Tingyi.png` | In-class Power BI practice section. |

No `.R`, `.Rmd`, or related R code files were found in this folder, so the README keeps the available image filenames unchanged and arranges them according to the existing exported image sequence.

## GitHub Upload Steps

Run the upload commands from the `NEOMABS2526` repository root:

```bash
cd /Users/kao900531/Documents/GitHub/NEOMABS2526
git status --short
git add Data_Visualization_and_Storytelling_PowerBI ':!Data_Visualization_and_Storytelling_PowerBI/.DS_Store' ':!Data_Visualization_and_Storytelling_PowerBI/**/.DS_Store'
git status --short
git commit -m "Add Power BI data visualization course materials"
git push origin main
```

Before committing, check that `.DS_Store` files are not staged. If they appear in the staged list, unstage them with:

```bash
git restore --staged Data_Visualization_and_Storytelling_PowerBI/.DS_Store
git restore --staged "Data_Visualization_and_Storytelling_PowerBI/reports/.DS_Store"
git restore --staged "Data_Visualization_and_Storytelling_PowerBI/reports/final_project/.DS_Store"
git restore --staged "Data_Visualization_and_Storytelling_PowerBI/figures/.DS_Store"
```
