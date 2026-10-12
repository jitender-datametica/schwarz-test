CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_cost_element AS SELECT FA.acct_nr,
 COALESCE(CE.ctrl_area_cd, '-1') AS ctrl_area_cd,
 COALESCE(CE.ce_valid_from_dt, DATE('1900-01-01')) AS ce_valid_from_dt,
 COALESCE(CE.ce_valid_to_dt, DATE('1900-01-01')) AS ce_valid_to_dt,
 COALESCE(CE.chart_of_accounts_cd, '-1') AS chart_of_accounts_cd,
 COALESCE(CE.short_name_en, FA.short_name_en) AS short_name_en,
 COALESCE(CE.long_name_en, FA.long_name_en) AS long_name_en,
 COALESCE(CE.short_name_de, FA.short_name_de) AS short_name_de,
 COALESCE(CE.long_name_de, FA.long_name_de) AS long_name_de,
 COALESCE(CE.ce_group_lvl3_nr, '-1') AS ce_group_lvl3_nr,
 COALESCE(CE.ce_group_lvl3_name_en, '') AS ce_group_lvl3_name_en,
 COALESCE(CE.ce_group_lvl3_name_de, '') AS ce_group_lvl3_name_de,
 COALESCE(CE.ce_group_lvl2_nr, '-1') AS ce_group_lvl2_nr,
 COALESCE(CE.ce_group_lvl2_name_en, '') AS ce_group_lvl2_name_en,
 COALESCE(CE.ce_group_lvl2_name_de, '') AS ce_group_lvl2_name_de,
 COALESCE(CE.ce_group_lvl1_nr, '-1') AS ce_group_lvl1_nr,
 COALESCE(CE.ce_group_lvl1_name_en, '') AS ce_group_lvl1_name_en,
 COALESCE(CE.ce_group_lvl1_name_de, '') AS ce_group_lvl1_name_de
FROM (SELECT acct_nr,
   MAX(short_name_en) AS short_name_en,
   MAX(long_name_en) AS long_name_en,
   MAX(short_name_de) AS short_name_de,
   MAX(long_name_de) AS long_name_de
  FROM ldl_dig_lec_share.v_dim_financial_account
  WHERE dwh_valid_fg
   AND chart_of_accounts_cd = 'LDI1'
  GROUP BY acct_nr) AS FA
 LEFT JOIN (SELECT *
  FROM ldl_dig_lec_share.v_dim_cost_element AS CE
  WHERE chart_of_accounts_cd = 'LDI1') AS CE ON FA.acct_nr = CE.acct_nr;