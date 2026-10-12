CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_wbs_check_2 AS
SELECT 
    m.mandant_id,
    dat_prognoselauf AS run_date,
    'UDF FC' AS table_name,
    MAX(t1.td_insert) AS max_ts,
    CASE

        WHEN DATE(MAX(t1.td_insert)) <> CURRENT_DATE() THEN 0
        ELSE 1
    END AS check_fg,
    COUNT(*) AS countrows
FROM kfl_production_dbp_data.mandant_2 m
LEFT JOIN kfl_production_dbp_data.udf_prognose_2 t1_2
    ON t1.mandant_id = m.mandant_id
    AND dat_prognoselauf IN (CURRENT_DATE(), DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY))
GROUP BY 1, 2, 3

UNION ALL

SELECT 
    m.mandant_id,
    dat_beladung AS run_date,
    'Promo Changes' AS table_name,
    MAX(t1.td_insert) AS max_ts,
    CASE
        WHEN DATE(MAX(t1.td_insert)) <> CURRENT_DATE() THEN 0
        ELSE 1
    END AS check_fg,
    COUNT(*) AS countrows
FROM kfl_production_dbp_data.mandant_2 m
LEFT JOIN kfl_production_dbp_data.wbs_werbeaenderungen_2 t1_2
    ON t1.mandant_id = m.mandant_id
    AND dat_beladung IN (CURRENT_DATE(), DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY))
GROUP BY 1, 2, 3

UNION ALL

SELECT 
    m.mandant_id,
    dat_ausfuehrung AS run_date,
    'OP TP1' AS table_name,
    MAX(t1.td_insert) AS max_ts,
    CASE
        WHEN DATE(MAX(t1.td_insert)) <> CURRENT_DATE() THEN 0
        ELSE 1
    END AS check_fg,
    COUNT(*) AS countrows
FROM kfl_production_dbp_data.mandant_2 m
LEFT JOIN kfl_production_dbp_data.best_vorschlag_wbs_2 t1_2
    ON t1.mandant_id = m.mandant_id
    AND dat_ausfuehrung IN (CURRENT_DATE(), DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY))
GROUP BY 1, 2, 3

UNION ALL

SELECT 
    m.mandant_id,
    dat_beladung AS run_date,
    'Initial' AS table_name,
    MAX(t1.td_insert) AS max_ts,
    CASE
        WHEN DATE(MAX(t1.td_insert)) <> CURRENT_DATE() THEN 0
        ELSE 1
    END AS check_fg,
    COUNT(*) AS countrows
FROM kfl_production_dbp_data.mandant_2 m
LEFT JOIN kfl_production_dbp_data.wbs_art_wup_aktion_initial_2 t1_2
    ON t1.mandant_id = m.mandant_id
    AND dat_beladung IN (CURRENT_DATE(), DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY))
GROUP BY 1, 2, 3

UNION ALL

SELECT 
    m.mandant_id,
    CURRENT_DATE() AS run_date,
    'PMR Data' AS table_name,
    MAX(t1.td_update) AS max_ts,
    CASE
        WHEN DATE(MAX(t1.td_update)) <> CURRENT_DATE() THEN 0
        ELSE 1
    END AS check_fg,
    COUNT(*) AS countrows
FROM kfl_production_dbp_data.mandant_2 m
LEFT JOIN kfl_production_dbp_data.angebot_2 t1_2
    ON t1.mandant_id = m.mandant_id
    AND DATE(t1.td_update) = CURRENT_DATE()
GROUP BY 1, 2, 3

/* UNION ALL
SELECT 
    m.mandant_id,
    CURRENT_DATE() AS run_date,
    'Customizing CW0' AS table_name,
    MAX(t1.td_insert) AS max_ts,
    CASE
        WHEN DATE(MAX(t1.td_insert)) <> CURRENT_DATE() THEN 0
        ELSE 1
    END AS check_fg,
    COUNT(*) AS countrows
FROM kfl_production.dbp_data.mandant_2 m
LEFT JOIN kfl_production.dbp_etl.customizing_cw_0_2 t1_2
    ON t1.src_mandant_id = m.mandant_id
GROUP BY 1, 2, 3
*/

UNION ALL

SELECT 
    m.mandant_id,
    DATE(t1.creation_time) AS run_date,
    'Materialization Promo Changes' AS table_name,
    MAX(t1.creation_time) AS max_ts,
    CASE
        WHEN DATE(MAX(t1.creation_time)) <> CURRENT_DATE() OR COUNT(*) <= 1 THEN 0
        ELSE 1
    END AS check_fg,
    COUNT(*) AS countrows
FROM kfl_production_dbp_data.mandant_2 m
LEFT JOIN kfl_production_dbp_data.wbs_werbeaenderungen_2 t2
    ON m.mandant_id = t2.mandant_id
    AND t2.dat_beladung = CURRENT_DATE()
LEFT JOIN kfl_production_dbp_msi_view_scm_materialized.INFORMATION_SCHEMA.TABLES t1_2
    ON t1.table_name = 'MV_WBS_WERBEAENDERUNGEN_2'
    AND t2.td_update < t1.creation_time
GROUP BY 1, 2, 3

UNION ALL

SELECT 
    m.mandant_id,
    DATE(t1.creation_time) AS run_date,
    'Materialization Initial Delivery' AS table_name,
    MAX(t1.creation_time) AS max_ts,
    CASE
        WHEN DATE(MAX(t1.creation_time)) <> CURRENT_DATE() OR COUNT(*) <= 1 THEN 0
        ELSE 1
    END AS check_fg,
    COUNT(*) AS countrows
FROM kfl_production_dbp_data.mandant_2 m
LEFT JOIN kfl_production_dbp_data.wbs_art_wup_aktion_initial_2 t2
    ON m.mandant_id = t2.mandant_id
    AND t2.dat_beladung = CURRENT_DATE()

LEFT JOIN kfl_production_dbp_msi_view_scm_materialized.INFORMATION_SCHEMA.TABLES t1_2
    ON t1.table_name = 'MV_WBS_ART_WUP_AKTION_INITIAL_2'
    AND t2.mandant_id IS NOT NULL
    AND t2.td_update < t1.creation_time
GROUP BY 1, 2, 3;