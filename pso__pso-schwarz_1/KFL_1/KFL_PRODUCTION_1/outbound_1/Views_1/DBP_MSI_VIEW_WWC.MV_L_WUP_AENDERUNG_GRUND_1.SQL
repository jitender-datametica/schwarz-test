CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_l_wup_aenderung_grund_1 (mandant_id, wup_id,
wup_aenderung_grund_id, wup_aenderung_grund_bez) AS SELECT '1' AS mandant_id,
 V01.wup_id,
 V02.wup_aenderung_grund_id,
 V02.wup_aenderung_grund_bez
FROM kfl_production_dbp_view.v_wup_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_wup_aenderung_grund_spr_zu_1 AS V02 ON V01.wup_aenderung_grund_id = V02.wup_aenderung_grund_id
  
WHERE V02.spr_id = 22;