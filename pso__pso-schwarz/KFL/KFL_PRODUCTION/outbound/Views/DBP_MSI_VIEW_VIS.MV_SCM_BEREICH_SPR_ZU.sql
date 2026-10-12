CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_scm_bereich_spr_zu (mandant_id, scm_bereich_id,
scm_bereich_bez, scm_bereich_bez_de, scm_bereich_bez_cz, scm_bereich_bez_sk, scm_bereich_bez_hr, scm_bereich_bez_pl,
scm_bereich_bez_ro, scm_bereich_bez_b) AS SELECT mandant_id,
 wg_hierarchie_id AS scm_bereich_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN wg_hierarchie_bez
   ELSE NULL
   END) AS scm_bereich_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN wg_hierarchie_bez
   ELSE NULL
   END) AS scm_bereich_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN wg_hierarchie_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN wg_hierarchie_bez
    ELSE NULL
    END)) AS scm_bereich_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN wg_hierarchie_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN wg_hierarchie_bez
    ELSE NULL
    END)) AS scm_bereich_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN wg_hierarchie_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN wg_hierarchie_bez
    ELSE NULL
    END)) AS scm_bereich_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN wg_hierarchie_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN wg_hierarchie_bez
    ELSE NULL
    END)) AS scm_bereich_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN wg_hierarchie_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN wg_hierarchie_bez
    ELSE NULL
    END)) AS scm_bereich_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN wg_hierarchie_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN wg_hierarchie_bez
    ELSE NULL
    END)) AS scm_bereich_bez_b
FROM kfl_production_dbp_view.v_wg_hierarchie_spr_zu
WHERE arthiertyp_id = 12
 AND wg_hierarchie_ebene_id = 1
GROUP BY mandant_id,
 scm_bereich_id
UNION DISTINCT
SELECT mandant_id,
 - 1,
 'Keine Zuordnung',
 'Keine Zuordnung',
 'Keine Zuordnung',
 'Keine Zuordnung',
 'Keine Zuordnung',
 'Keine Zuordnung',
 'Keine Zuordnung',
 'Keine Zuordnung'
FROM kfl_production_dbp_view.v_wg_hierarchie_spr_zu
WHERE arthiertyp_id = 12
 AND wg_hierarchie_ebene_id = 1
GROUP BY mandant_id,
 wg_hierarchie_id;