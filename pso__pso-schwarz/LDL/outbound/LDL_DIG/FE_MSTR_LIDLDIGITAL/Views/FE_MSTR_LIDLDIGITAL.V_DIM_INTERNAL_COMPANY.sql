CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_internal_company (internal_company_sid, internal_company_cd,
internal_company_name, country_cd, company_nr, company_name, company_group, is_ker_relevant_fg) AS SELECT T1.internal_company_sid
 ,
 IFNULL(NULLIF(T1.internal_company_cd, ''), '-1') AS internal_company_cd,
 T1.internal_company_name,
 IFNULL(NULLIF(T1.country_cd, ''), '-1') AS country_cd,
 T1.company_nr,
 T1.company_name,
 COALESCE(T2.cc_group_lvl2_name_de, T2.cc_group_lvl2_name_en, '-1') AS company_group,
 IFNULL(T3.parameter_value_numeric <> 0, FALSE) AS is_ker_relevant_fg
FROM ldl_dig_lec_share.v_dim_internal_company AS T1
 LEFT JOIN ldl_dig_lec_share.v_dim_cost_center_group_lvl_4 AS T2 ON T1.internal_company_cd = T2.cc_group_lvl4_nr
 LEFT JOIN ldl_dig_lec_share.v_meta_report_parameter AS T3 ON T3.report = 'KER' AND T3.parameter_type = 'filter' AND T3
    .parameter_name = 'cc_group_lvl_2_nr' AND T2.cc_group_lvl2_nr = T3.parameter_value_char
WHERE T1.dwh_valid_fg
UNION ALL
SELECT ROUND(CAST('-1' AS BIGNUMERIC), 0),
 '-1',
 '',
 '-1',
 '-1',
 '',
 '-1',
 CAST('FALSE' AS BOOL);