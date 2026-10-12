CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_kostenrechnungskreis_1 (krk_bez, krk_id, mandant_id, system_id,
mandant_bez) AS SELECT K.krk_bez,
 K.krk_id,
 K.mandant_id,
 K.system_id,
 M.mandant_bez
FROM kfl_production_dbp_view.v_l_kostenrechnungskreis_1 AS K
 INNER JOIN kfl_production_dbp_view.v_mandant_1 AS M ON K.mandant_id = M.mandant_id;