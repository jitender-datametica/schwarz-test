CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw_materialized.mv_wug_spr_zu (mandant_id, wug_id, arthiertyp_id,
wg_id, spr_id, wug_bez, wug_id_bez) AS SELECT V01.mandant_id,
 V01.wug_id,
 V01.arthiertyp_id,
 V01.wg_id,
 V01.spr_id,
 V01.wug_bez,
   CAST(V01.wug_id AS STRING) || '   ' || V01.wug_bez AS wug_id_bez
FROM kfl_production_dbp_view.v_wug_spr_zu AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_spr_zu AS V02 ON V01.spr_id = V02.spr_id
WHERE V01.mandant_id IN (1, 2)
 AND V01.arthiertyp_id = 2;