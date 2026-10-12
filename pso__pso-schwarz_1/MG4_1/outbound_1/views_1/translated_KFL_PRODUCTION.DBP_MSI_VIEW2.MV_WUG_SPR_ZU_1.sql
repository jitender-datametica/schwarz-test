CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_wug_spr_zu_1 (mandant_id, wug_id, arthiertyp_id, wg_id, spr_id,
wug_bez, wug_id_bez) AS SELECT mandant_id,
 wug_id,
 arthiertyp_id,
 wg_id,
 spr_id,
 wug_bez,
 SUBSTR(CAST(SUBSTR(CAST(wug_id AS STRING), 1, 10) || '   ' || wug_bez AS STRING), 1, 50) AS wug_id_bez
FROM kfl_production_dbp_view.v_wug_spr_zu_1
WHERE spr_id = 22
 AND mandant_id = 1
 AND arthiertyp_id = 2;