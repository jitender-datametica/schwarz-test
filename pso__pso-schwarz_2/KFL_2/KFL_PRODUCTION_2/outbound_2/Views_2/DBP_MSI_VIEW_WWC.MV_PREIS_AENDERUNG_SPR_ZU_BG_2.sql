CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_preis_aenderung_spr_zu_bg_2 (mandant_id, pv_grund,
preis_aend_grund_bez, spr_id) AS SELECT mandant_id,
 preis_aend_grund_id AS pv_grund,
 preis_aend_grund_bez,
 spr_id
FROM kfl_production_dbp_view.v_preis_aenderung_spr_zu_2
WHERE spr_id = 18;