CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_kpges_abschriften_gesamt_plan_mth_country_region_2 (client_id, cy_month,
currency_iso_cd, dat_dayend, val_indicator, gl_region_id, aspect_id, wh_id, val_indicator_gl) AS SELECT A11.client_id,
 A11.cy_month,
 A11.currency_iso_cd,
 A11.dat_dayend,
 A11.val_indicator,
 A12.gl_region_id,
 A13.aspect_id,
 A14.wh_id,
  CASE
  WHEN A12.gl_region_id > 0
  THEN 0
  ELSE A11.val_indicator
  END AS val_indicator_gl
FROM ldl_p_lew_mart_msi_ac.v_kpges_plan_mth_country_2 AS A11
 INNER JOIN ldl_p_lew_mart_msi_ac.v_ref_gl_region_2 AS A12 ON A11.client_id = A12.client_id
 INNER JOIN ldl_p_lew_mart_msi_ac.v_ref_aspect_2 AS A13 ON TRUE
 INNER JOIN ldl_p_lew_mart_msi_ac.v_org_wh_merge_2 AS A14 ON A11.client_id = A14.client_id AND A12.gl_region_id = A14.gl_region_id
     AND A13.aspect_id = A14.aspect_id
WHERE A11.indicator_id IN (314);