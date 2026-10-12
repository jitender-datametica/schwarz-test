CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_ref_itm_list_type_buylist_agg_2 (agg_buying_list_type_id,
buying_list_type_id, buying_list_type_desc, agg_buying_list_type_desc) AS SELECT CASE
  WHEN buying_list_type_desc LIKE 'Aktions-Artikel_2 %'
  THEN 1
  WHEN buying_list_type_desc LIKE 'Ausgelistet %'
  THEN 2
  WHEN buying_list_type_desc LIKE 'Neu-Einlistung %'
  THEN 3
  WHEN buying_list_type_desc LIKE 'Normalsortiment %'
  THEN 4
  WHEN buying_list_type_desc LIKE 'Saison-Artikel_2 %'
  THEN 5
  WHEN buying_list_type_desc LIKE 'Test_2-Artikel_2 %'
  THEN 6
  ELSE NULL
  END AS agg_buying_list_type_id,
 buying_list_type_id,
 buying_list_type_desc,
  CASE
  WHEN buying_list_type_desc LIKE '% M' OR buying_list_type_desc LIKE '% EM'
  THEN RTRIM(SUBSTR(buying_list_type_desc, 1, (LENGTH(buying_list_type_desc) - LENGTH(CASE
          WHEN buying_list_type_desc IS NOT NULL
          THEN IFNULL(SPLIT(buying_list_type_desc, ' ')[SAFE_OFFSET(-1)], '')
          ELSE NULL
          END) - 1))) || ' EM+M'
  ELSE NULL
  END AS agg_buying_list_type_desc
FROM ldl_p_lew_mart_msi_ac.v_ref_itm_list_type_buylist_2
WHERE buying_list_type_id IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12);