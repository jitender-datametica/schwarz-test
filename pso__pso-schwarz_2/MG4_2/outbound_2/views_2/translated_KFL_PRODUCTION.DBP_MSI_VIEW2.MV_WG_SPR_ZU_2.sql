CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_wg_spr_zu_2 (wg_id, spr_id, arthiertyp_id, mandant_id, wg_bez,
wg_id_bez) AS SELECT wg_id,
 spr_id,
 arthiertyp_id,
 mandant_id,
 wg_bez,
    CASE
    WHEN wg_id < 10
    THEN '00' || CAST(wg_id AS STRING)
    WHEN wg_id < 100
    THEN '0' || CAST(wg_id AS STRING)
    ELSE CAST(wg_id AS STRING)
    END || '  ' || wg_bez AS wg_id_bez
FROM kfl_production_dbp_view.v_wg_spr_zu_2
WHERE spr_id = 22
 AND arthiertyp_id = 2
 AND mandant_id = 1
 AND wg_id >= - 3;