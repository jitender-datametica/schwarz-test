CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_sortimentsbereich_spr_zu_1 (sortimentsbereich_id,
sortimentsbereich_bez, sortimentsbereich_bez_de, sortimentsbereich_bez_cz, sortimentsbereich_bez_sk,
sortimentsbereich_bez_hr, sortimentsbereich_bez_pl, sortimentsbereich_bez_ro, ssortimentsbereich_bez_bg) AS SELECT
 wg_hierarchie_id AS sortimentsbereich_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN wg_hierarchie_bez
   ELSE NULL
   END) AS sortimentsbereich_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN wg_hierarchie_bez
   ELSE NULL
   END) AS sortimentsbereich_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN wg_hierarchie_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN wg_hierarchie_bez
    ELSE NULL
    END)) AS sortimentsbereich_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN wg_hierarchie_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN wg_hierarchie_bez
    ELSE NULL
    END)) AS sortimentsbereich_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN wg_hierarchie_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN wg_hierarchie_bez
    ELSE NULL
    END)) AS sortimentsbereich_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN wg_hierarchie_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN wg_hierarchie_bez
    ELSE NULL
    END)) AS sortimentsbereich_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN wg_hierarchie_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN wg_hierarchie_bez
    ELSE NULL
    END)) AS sortimentsbereich_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN wg_hierarchie_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN wg_hierarchie_bez
    ELSE NULL
    END)) AS ssortimentsbereich_bez_bg
FROM kfl_production_dbp_view.v_wg_hierarchie_spr_zu_1
WHERE arthiertyp_id = 13
 AND wg_hierarchie_ebene_id = 1
GROUP BY sortimentsbereich_id
UNION DISTINCT
SELECT - 1,
 'Keine Zuordnung',
 'Keine Zuordnung',
 'Keine Zuordnung',
 'Keine Zuordnung',
 'Keine Zuordnung',
 'Keine Zuordnung',
 'Keine Zuordnung',
 'Keine Zuordnung';