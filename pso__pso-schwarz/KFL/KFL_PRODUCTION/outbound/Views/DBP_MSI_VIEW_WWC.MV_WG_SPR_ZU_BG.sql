CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_wg_spr_zu_bg (matkl, spr_id, mandant_id, arthiertyp_id, wg_bez
, wg_id_bez) AS SELECT wg_id AS matkl,
 spr_id,
 mandant_id,
 arthiertyp_id,
 wg_bez,
    CASE
    WHEN wg_id < 10
    THEN '00' || CAST(wg_id AS STRING)
    WHEN wg_id < 100
    THEN '0' || CAST(wg_id AS STRING)
    ELSE CAST(wg_id AS STRING)
    END || ' ' || wg_bez AS wg_id_bez
FROM kfl_production_dbp_view.v_wg_spr_zu AS V01
WHERE spr_id = 18
 AND arthiertyp_id = 2;