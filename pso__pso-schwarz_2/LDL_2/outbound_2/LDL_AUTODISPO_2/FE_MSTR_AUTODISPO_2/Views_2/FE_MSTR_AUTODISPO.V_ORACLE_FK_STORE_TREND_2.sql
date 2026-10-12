CREATE OR REPLACE VIEW ldl_autodispo_fe_mstr_autodispo.v_oracle_fk_store_trend_2 (country_2, fst_storetrend_id,
fst_trendtype, fst_wh, fst_store, fst_orderarea, fst_articlegroup, fst_group_nr, fst_subgroup_nr, fst_article,
fst_percent, fst_datefrom, fst_dateto, date_from, date_to, mod_date, scenario, fst_scenario, store_info_2, article_info,
source_extraction_tmsp, snflk_insert_tmsp, snflk_update_tmsp) AS SELECT S.country_2,
 S.fst_storetrend_id,
 S.fst_trendtype,
 S.fst_wh,
 S.fst_store,
 S.fst_calculationmethod AS fst_orderarea,
 S.fst_articlegroup,
 S.fst_group_nr,
 S.fst_subgroup_nr,
 S.fst_article,
 S.fst_percent,
 S.fst_datefrom,
 S.fst_dateto,
 DATE(DATE_ADD(CAST('0000-01-01' AS DATE), INTERVAL CAST(S.fst_datefrom - 365.25 * 4712 - 2 AS INTEGER) DAY)) AS
 date_from,
 DATE(DATE_ADD(CAST('0000-01-01' AS DATE), INTERVAL CAST(S.fst_dateto - 365.25 * 4712 - 2 AS INTEGER) DAY)) AS
 date_to,
 S.mod_date,
 CONCAT(CASE
   WHEN S.fst_store IS NULL AND S.fst_wh IS NULL
   THEN 'Country_2'
   WHEN S.fst_wh IS NULL
   THEN 'Store'
   ELSE 'Warehouse'
   END, ' & ', CASE
   WHEN S.fst_calculationmethod IS NULL AND S.fst_articlegroup IS NULL AND S.fst_group_nr IS NULL AND S.fst_subgroup_nr
     IS NULL AND S.fst_article IS NULL
   THEN 'All items'
   WHEN S.fst_calculationmethod IS NOT NULL
   THEN 'Calculation Method'
   WHEN S.fst_articlegroup IS NOT NULL
   THEN 'Family'
   WHEN S.fst_group_nr IS NOT NULL
   THEN 'Group'
   WHEN S.fst_subgroup_nr IS NOT NULL
   THEN 'Subgroup'
   ELSE 'Item_2'
   END) AS scenario,
 S.fst_scenario,
  CASE
  WHEN S.fst_store IS NULL AND S.fst_wh IS NULL
  THEN 'all'
  WHEN S.fst_wh IS NULL
  THEN CONCAT('STO ', S.fst_store)
  ELSE CONCAT('WH ', S.fst_wh)
  END AS store_info_2,
  CASE
  WHEN S.fst_calculationmethod IS NULL AND S.fst_articlegroup IS NULL AND S.fst_group_nr IS NULL AND S.fst_subgroup_nr
    IS NULL AND S.fst_article IS NULL
  THEN 'all'
  WHEN S.fst_calculationmethod IS NOT NULL
  THEN CONCAT('CM ', LEFT(CM.calculationmethod_name, 7))
  WHEN S.fst_group_nr IS NOT NULL
  THEN CONCAT('GRP ', S.fst_group_nr)
  WHEN S.fst_articlegroup IS NOT NULL
  THEN CONCAT('FAM ', S.fst_articlegroup)
  WHEN S.fst_subgroup_nr IS NOT NULL
  THEN CONCAT('SUB ', S.fst_subgroup_nr)
  ELSE CONCAT('ITM ', S.fst_article)
  END AS article_info,
 S.source_extraction_tmsp,
 S.snflk_insert_tmsp,
 S.snflk_update_tmsp
FROM ldl_autodispo_core.t_oracle_v_fk_store_trend_new_2 AS S
 LEFT JOIN ldl_autodispo_core.t_oracle_v_dic_calculationmethod_2 AS CM ON S.country_2 = CM.country_2 AND S.fst_calculationmethod
    = CM.calculationmethod;