CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_wbs_check_2 AS
SELECT 
    m.mandant_id AS MANDANT_ID,
    dat_prognoselauf AS RUN_DATE,
    'UDF FC' AS TABLE_NAME,
    MAX(t1.td_insert) AS MAX_TS,
    CASE
        WHEN DATE(MAX(t1.td_insert)) != CURRENT_DATE() THEN 0
        ELSE 1
    END AS CHECK_FG,
    COUNT(*) AS COUNTROWS
FROM kfl_production_dbp_data.mandant_2 m
LEFT JOIN kfl_production_dbp_data.udf_prognose_2 t1_2
    ON t1.mandant_id = m.mandant_id
    AND dat_prognoselauf IN (CURRENT_DATE(), DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY))
GROUP BY 1, 2, 3

UNION ALL

SELECT 
    m.mandant_id,
    dat_beladung,
    'Promo Changes',
    MAX(t1.td_insert),
    CASE
        WHEN DATE(MAX(t1.td_insert)) != CURRENT_DATE() THEN 0
        ELSE 1
    END,
    COUNT(*)
FROM kfl_production_dbp_data.mandant_2 m
LEFT JOIN kfl_production_dbp_data.wbs_werbeaenderungen_2 t1_2
    ON t1.mandant_id = m.mandant_id
    AND dat_beladung IN (CURRENT_DATE(), DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY))
GROUP BY 1, 2, 3

UNION ALL

SELECT 
    m.mandant_id,
    dat_ausfuehrung,
    'OP TP1',
    MAX(t1.td_insert),
    CASE
        WHEN DATE(MAX(t1.td_insert)) != CURRENT_DATE() THEN 0
        ELSE 1
    END,
    COUNT(*)
FROM kfl_production_dbp_data.mandant_2 m
LEFT JOIN kfl_production_dbp_data.best_vorschlag_wbs_2 t1_2
    ON t1.mandant_id = m.mandant_id
    AND dat_ausfuehrung IN (CURRENT_DATE(), DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY))
GROUP BY 1, 2, 3

UNION ALL

SELECT 
    m.mandant_id,
    dat_beladung,
    'Initial',
    MAX(t1.td_insert),
    CASE
        WHEN DATE(MAX(t1.td_insert)) != CURRENT_DATE() THEN 0
        ELSE 1
    END,
    COUNT(*)
FROM kfl_production_dbp_data.mandant_2 m
LEFT JOIN kfl_production_dbp_data.wbs_art_wup_aktion_initial_2 t1_2
    ON t1.mandant_id = m.mandant_id
    AND dat_beladung IN (CURRENT_DATE(), DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY))
GROUP BY 1, 2, 3

UNION ALL

SELECT 
    m.mandant_id,
    CURRENT_DATE(),
    'PMR Data',
    MAX(t1.td_update),
    CASE
        WHEN DATE(MAX(t1.td_update)) != CURRENT_DATE() THEN 0
        ELSE 1
    END,
    COUNT(*)
FROM kfl_production_dbp_data.mandant_2 m
LEFT JOIN kfl_production_dbp_data.angebot_2 t1_2
    ON t1.mandant_id = m.mandant_id
    AND DATE(t1.td_update) = CURRENT_DATE()
GROUP BY 1, 2, 3

/*UNION ALL

SELECT 
    m.mandant_id,
    CURRENT_DATE(),
    'Customizing CW0',
    MAX(t1.td_insert),
    CASE
        WHEN DATE(MAX(t1.td_insert)) != CURRENT_DATE() THEN 0
        ELSE 1
    END,
    COUNT(*)
FROM kfl_production_dbp_data.mandant_2 m
LEFT JOIN KFL_PRODUCTION.dbp_etl.customizing_cw_0_2 t1_2
    ON t1.src_mandant_id = m.mandant_id
GROUP BY 1, 2, 3
*/

UNION ALL

SELECT 
    m.mandant_id,
    DATE(t1.creation_time),
    'Materialization Promo Changes',
    MAX(t1.creation_time),
    CASE
        WHEN DATE(MAX(t1.creation_time)) != CURRENT_DATE() OR COUNT(*) <= 1 THEN 0
        ELSE 1
    END,
    COUNT(*)
FROM kfl_production_dbp_data.mandant_2 m
LEFT JOIN kfl_production_dbp_data.wbs_werbeaenderungen_2 t2
    ON m.mandant_id = t2.mandant_id
    AND t2.dat_beladung = CURRENT_DATE()
LEFT JOIN dbp_msi_view_scm_materialized.INFORMATION_SCHEMA.TABLES t1_2
    ON t1.table_name = 'mv_wbs_werbeaenderungen_2'
    AND t2.td_update < t1.creation_time
GROUP BY 1, 2, 3

UNION ALL

SELECT 
    m.mandant_id,
    DATE(t1.creation_time),
    'Materialization Initial Delivery',
    MAX(t1.creation_time),
    CASE
        WHEN DATE(MAX(t1.creation_time)) != CURRENT_DATE() OR COUNT(*) <= 1 THEN 0
        ELSE 1
    END,
    COUNT(*)
FROM kfl_production_dbp_data.mandant_2 m
LEFT JOIN kfl_production_dbp_data.wbs_art_wup_aktion_initial_2 t2
    ON m.mandant_id = t2.mandant_id
    AND t2.dat_beladung = CURRENT_DATE()
LEFT JOIN dbp_msi_view_scm_materialized.INFORMATION_SCHEMA.TABLES t1_2
    ON t1.table_name = 'mv_wbs_art_wup_aktion_initial_2'
    AND t2.mandant_id IS NOT NULL
    AND t2.td_update < t1.creation_time
GROUP BY 1, 2, 3;