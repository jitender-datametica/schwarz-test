CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_wug_spr_zu_en (mandant_id, prdha, matkl, wug_bez,
wg_wug_id_bez, spr_id) AS SELECT mandant_id,
 wug_id AS prdha,
 wg_id AS matkl,
 COALESCE(MAX(CASE
    WHEN spr_id = 24
    THEN wug_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN wug_bez
    ELSE NULL
    END)) AS wug_bez,
    TRIM(CAST(wg_id AS STRING FORMAT '000')) || ' ' || TRIM(CAST(wug_id AS STRING FORMAT '000')) || COALESCE(MAX(CASE
     WHEN spr_id = 24
     THEN wug_bez
     ELSE NULL
     END), MAX(CASE
     WHEN spr_id = 22
     THEN wug_bez
     ELSE NULL
     END)) AS wg_wug_id_bez,
 MAX(spr_id) AS spr_id
FROM kfl_production_dbp_view.v_wug_spr_zu AS V01
WHERE spr_id IN (22, 24)
 AND arthiertyp_id = 2
GROUP BY mandant_id,
 wug_id,
 wg_id;