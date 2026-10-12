CREATE OR REPLACE VIEW ldl_fe_mstr_xsight.v_tech_steering_kpi_1 (dashboard, group_id, group_name, group_name_en,
subgroup_id, subgroup_name, kpi_id, kpi_name_unique, kpi_name, kpi_name_en) AS SELECT DISTINCT dashboard,
 COALESCE(group_id, CASE
   WHEN kpi_name LIKE '%Lidl%'
   THEN 2
   WHEN kpi_name LIKE '%Benchmark%'
   THEN 3
   ELSE 1
   END) AS group_id,
 COALESCE(group_name, CASE
   WHEN kpi_name LIKE '%Lidl%'
   THEN 'Lidl'
   WHEN kpi_name LIKE '%Benchmark%'
   THEN 'Benchmark'
   ELSE 'Gesamtmarkt'
   END) AS group_name,
 COALESCE(group_name_en, CASE
   WHEN kpi_name LIKE '%Lidl%'
   THEN 'Lidl'
   WHEN kpi_name LIKE '%Benchmark%'
   THEN 'Benchmark'
   ELSE 'Total Market'
   END) AS group_name_en,
 COALESCE(subgroup_id, CASE
   WHEN kpi_name LIKE '%Umsatz%'
   THEN 3
   WHEN kpi_name LIKE '%konv%'
   THEN 2
   WHEN kpi_name LIKE '%Pack%'
   THEN 1
   WHEN kpi_name LIKE '%verkaufend%'
   THEN 4
   ELSE NULL
   END) AS subgroup_id,
 COALESCE(subgroup_name, CASE
   WHEN kpi_name LIKE '%Umsatz%'
   THEN 'Umsatz'
   WHEN kpi_name LIKE '%konv%'
   THEN 'Absatz konv.'
   WHEN kpi_name LIKE '%Pack%'
   THEN 'Absatz in Pack'
   WHEN kpi_name LIKE '%verkaufend%'
   THEN 'Anteil \u00d8 Anz. Artikel_1'
   ELSE NULL
   END) AS subgroup_name,
 kpi_id,
 CONCAT(kpi_name, ' ', group_name) AS kpi_name_unique,
 REPLACE(kpi_name, '?', 'Δ') AS kpi_name,
 REPLACE(kpi_name_en, '?', 'Δ') AS kpi_name_en
FROM ldl_fe_mstr_xsight.t_tech_steering_kpi_1
WHERE dashboard IN ('Item_1 Ranking - Tabelle', 'Feature Analysis - Tabelle', 'New Brand_1 Ranking - Tabelle');