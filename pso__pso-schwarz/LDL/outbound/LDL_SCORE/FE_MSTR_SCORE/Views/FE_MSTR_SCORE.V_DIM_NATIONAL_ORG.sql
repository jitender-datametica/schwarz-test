CREATE OR REPLACE VIEW ldl_score_fe_mstr_score.v_dim_national_org AS SELECT national_org_sid,
 national_org_nr,
 national_org_name,
 national_org_short_name,
  CASE
  WHEN is_onlineshop_fg
  THEN '1'
  WHEN NOT is_onlineshop_fg
  THEN '0'
  ELSE 'unknown'
  END AS is_onlineshop_fg,
 vat_nr
FROM ldl_score_core.t_dim_national_org;