CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims.mv_massnahmenart_spr_zu AS SELECT V01.massnahme_id,
 V02.massnahmenart_bez
FROM kfl_production_dbp_view.v_l_massnahme AS V01
 LEFT JOIN kfl_production_dbp_view.v_massnahmenart_spr_zu AS V02 ON V01.massnahmenart_id = V02.massnahmenart_id
WHERE V02.spr_id = 22;