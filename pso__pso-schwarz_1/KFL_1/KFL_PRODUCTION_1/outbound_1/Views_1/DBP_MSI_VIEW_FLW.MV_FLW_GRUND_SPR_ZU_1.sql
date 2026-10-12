CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_flw_grund_spr_zu_1 (mandant_id, flw_bew_grund_id,
flw_bew_grund_bez) AS SELECT V01.mandant_id,
 V01.flw_bew_grund_id,
 V01.flw_bew_grund_bez
FROM kfl_production_dbp_view.v_flw_bew_grund_spr_zu_1 AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_spr_zu_1 AS V02 ON V01.spr_id = V02.spr_id
WHERE V01.lager_bewart_id IN ('531');