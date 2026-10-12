CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.tbl_mv_wg_spr_zu AS SELECT wg_id,
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
    END || ' ' || wg_bez AS wg_id_bez
FROM kfl_production_dbp_view.v_wg_spr_zu AS V01
WHERE arthiertyp_id = 2
 AND wg_id >= - 3;