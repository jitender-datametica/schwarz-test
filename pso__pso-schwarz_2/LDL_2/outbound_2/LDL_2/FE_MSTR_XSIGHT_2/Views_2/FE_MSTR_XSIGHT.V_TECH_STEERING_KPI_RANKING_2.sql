CREATE OR REPLACE VIEW ldl_fe_mstr_xsight.v_tech_steering_kpi_ranking_2 (dashboard, group_id, group_name, kpi_rank_id,
kpi_rank_name, kpi_rank_name_en, tech_desc1, tech_desc2, kpi_desc, tech_desc1_en, kpi_desc_en) AS SELECT DISTINCT
 dashboard,
 group_id,
 group_name,
 kpi_id AS kpi_rank_id,
 kpi_name AS kpi_rank_name,
 kpi_name_en AS kpi_rank_name_en,
 SUBSTR(kpi_name, 7, LENGTH(kpi_name) - 3) AS tech_desc1,
 SUBSTR(SUBSTR(kpi_name, 7, LENGTH(kpi_name) - 3), 1, LENGTH(SUBSTR(kpi_name, 7, LENGTH(kpi_name) - 3)) - 1) AS
 tech_desc2,
 COALESCE(kpi_desc, SUBSTR(SUBSTR(kpi_name, 7, LENGTH(kpi_name) - 3), 1, LENGTH(SUBSTR(kpi_name, 7, LENGTH(kpi_name) - 3
       )) - 1)) AS kpi_desc,
 SUBSTR(kpi_name_en, 7, LENGTH(kpi_name_en) - 3) AS tech_desc1_en,
 SUBSTR(SUBSTR(kpi_name_en, 7, LENGTH(kpi_name_en) - 3), 1, LENGTH(SUBSTR(kpi_name_en, 7, LENGTH(kpi_name_en) - 3)) - 1
  ) AS kpi_desc_en
FROM ldl_fe_mstr_xsight.t_tech_steering_kpi_2
WHERE dashboard IN ('Item_2 Ranking - Ranking', 'Feature Analysis - Rank');