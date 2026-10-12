CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_sortimentsgruppe_spr_zu_1 (sortimentsgruppe_id,
sortimentsgruppe_bez, sortimentsgruppe_bez_de, sortimentsgruppe_bez_cz, sortimentsgruppe_bez_sk, sortimentsgruppe_bez_hr
, sortimentsgruppe_bez_pl, sortimentsgruppe_bez_ro, sortimentsgruppe_bez_bg) AS SELECT wg_hierarchie_id AS
 sortimentsgruppe_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN wg_hierarchie_bez
   ELSE NULL
   END) AS sortimentsgruppe_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN wg_hierarchie_bez
   ELSE NULL
   END) AS sortimentsgruppe_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN wg_hierarchie_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN wg_hierarchie_bez
    ELSE NULL
    END)) AS sortimentsgruppe_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN wg_hierarchie_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN wg_hierarchie_bez
    ELSE NULL
    END)) AS sortimentsgruppe_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN wg_hierarchie_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN wg_hierarchie_bez
    ELSE NULL
    END)) AS sortimentsgruppe_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN wg_hierarchie_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN wg_hierarchie_bez
    ELSE NULL
    END)) AS sortimentsgruppe_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN wg_hierarchie_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN wg_hierarchie_bez
    ELSE NULL
    END)) AS sortimentsgruppe_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN wg_hierarchie_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN wg_hierarchie_bez
    ELSE NULL
    END)) AS sortimentsgruppe_bez_bg
FROM kfl_production_dbp_view.v_wg_hierarchie_spr_zu_1
WHERE arthiertyp_id = 11
 AND wg_hierarchie_ebene_id = 1
GROUP BY sortimentsgruppe_id;