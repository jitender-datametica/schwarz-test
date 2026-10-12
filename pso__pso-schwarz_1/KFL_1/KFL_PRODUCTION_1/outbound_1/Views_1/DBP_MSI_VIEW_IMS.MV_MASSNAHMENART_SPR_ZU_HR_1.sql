CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims.mv_massnahmenart_spr_zu_hr_1 AS SELECT V01.massnahme_id,
 COALESCE(v03.massnahmenart_bez, V02.massnahmenart_bez) AS massnahmenart_bez
FROM kfl_production_dbp_view.v_l_massnahme_1 AS V01
 LEFT JOIN kfl_production_dbp_view.v_massnahmenart_spr_zu_1 AS V02 ON V01.massnahmenart_id = V02.massnahmenart_id
 LEFT JOIN (SELECT *
  FROM kfl_production_dbp_view.v_massnahmenart_spr_zu_1
  WHERE spr_id = 65) AS v03 ON V02.massnahmenart_id = v03.massnahmenart_id
WHERE V02.spr_id = 22;