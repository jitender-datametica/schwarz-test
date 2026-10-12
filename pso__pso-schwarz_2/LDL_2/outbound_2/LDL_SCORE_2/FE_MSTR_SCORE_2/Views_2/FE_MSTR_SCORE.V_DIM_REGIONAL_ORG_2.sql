CREATE OR REPLACE VIEW ldl_score_fe_mstr_score.v_dim_regional_org_2 AS SELECT regional_org_sid,
 regional_org_nr,
 regional_org_name,
 national_org_sid,
 national_org_nr,
 national_org_name,
 regional_org_short_name,
  CASE
  WHEN is_onlineshop_fg
  THEN '1'
  WHEN NOT is_onlineshop_fg
  THEN '0'
  ELSE 'unknown'
  END AS is_onlineshop_fg,
 vat_nr
FROM ldl_score_core.t_dim_regional_org_2;