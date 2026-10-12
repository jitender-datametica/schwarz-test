CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm_materialized.mv_werbegruppe_fleisch (werbegruppe_fleisch,
werbegruppe_fleisch_bez, werbegruppe_fleisch_bez_de, werbegruppe_fleisch_bez_cz, werbegruppe_fleisch_bez_sk,
werbegruppe_fleisch_bez_hr, werbegruppe_fleisch_bez_pl, werbegruppe_fleisch_bez_ro, werbegruppe_fleisch_bez_bg) AS
SELECT marktmerkmal_wert AS werbegruppe_fleisch,
 MAX(CASE
   WHEN spr_id = 22
   THEN marktmerkmal_wert_bez
   ELSE NULL
   END) AS werbegruppe_fleisch_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN marktmerkmal_wert_bez
   ELSE NULL
   END) AS werbegruppe_fleisch_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN marktmerkmal_wert_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN marktmerkmal_wert_bez
    ELSE NULL
    END)) AS werbegruppe_fleisch_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN marktmerkmal_wert_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN marktmerkmal_wert_bez
    ELSE NULL
    END)) AS werbegruppe_fleisch_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN marktmerkmal_wert_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN marktmerkmal_wert_bez
    ELSE NULL
    END)) AS werbegruppe_fleisch_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN marktmerkmal_wert_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN marktmerkmal_wert_bez
    ELSE NULL
    END)) AS werbegruppe_fleisch_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN marktmerkmal_wert_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN marktmerkmal_wert_bez
    ELSE NULL
    END)) AS werbegruppe_fleisch_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN marktmerkmal_wert_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN marktmerkmal_wert_bez
    ELSE NULL
    END)) AS werbegruppe_fleisch_bez_bg
FROM kfl_production_dbp_view.v_marktmerkmal_wert_spr_zu AS V01
WHERE marktmerkmal_id = '0051'
GROUP BY werbegruppe_fleisch;