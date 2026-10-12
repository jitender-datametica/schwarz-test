CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_ts_scm_werbegruppe_fleisch AS SELECT marktmerkmal_wert AS
 werbegruppe_fleisch,
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
GROUP BY werbegruppe_fleisch
UNION DISTINCT
SELECT '-1' AS werbegruppe_fleisch,
 'All (DIF)' AS marktmerkmal_wert_bez,
 'All (DIF)' AS werbegruppe_fleisch_bez_de,
 'All (DIF)' AS werbegruppe_fleisch_bez_cz,
 'All (DIF)' AS werbegruppe_fleisch_bez_sk,
 'All (DIF)' AS werbegruppe_fleisch_bez_hr,
 'All (DIF)' AS werbegruppe_fleisch_bez_pl,
 'All (DIF)' AS werbegruppe_fleisch_bez_ro,
 'All (DIF)' AS werbegruppe_fleisch_bez_bg;