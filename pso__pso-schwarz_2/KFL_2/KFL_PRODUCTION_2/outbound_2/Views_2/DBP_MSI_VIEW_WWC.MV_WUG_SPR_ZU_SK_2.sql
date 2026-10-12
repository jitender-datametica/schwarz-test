CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_wug_spr_zu_sk_2 (mandant_id, prdha, matkl, spr_id, wug_bez,
wg_wug_id_bez) AS SELECT mandant_id,
 wug_id AS prdha,
 wg_id AS matkl,
 spr_id,
 wug_bez,
    TRIM(CAST(wg_id AS STRING FORMAT '000')) || ' ' || TRIM(CAST(wug_id AS STRING FORMAT '000')) || wug_bez AS
 wg_wug_id_bez
FROM kfl_production_dbp_view.v_wug_spr_zu_2 AS V01
WHERE spr_id = 108
 AND arthiertyp_id = 2;