CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.java_owg_bez_1 (spr_id, owg_id, owg_bez) AS SELECT spr_id,
 owg_id,
 MAX(owg_bez) AS owg_bez
FROM kfl_production_dbp_view.v_owg_spr_zu_1
GROUP BY spr_id,
 owg_id;