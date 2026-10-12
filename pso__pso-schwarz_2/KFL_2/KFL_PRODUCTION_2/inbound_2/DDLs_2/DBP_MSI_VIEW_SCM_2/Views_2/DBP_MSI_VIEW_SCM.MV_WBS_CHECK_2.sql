create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_SCM.MV_WBS_CHECK_2(
	MANDANT_ID,
	RUN_DATE,
	TABLE_NAME,
	MAX_TS,
	CHECK_FG,
	COUNTROWS
) as
  SELECT m.mandant_id
         ,dat_prognoselauf  AS run_date
         ,'UDF FC'          AS table_name
         ,MAX(t1.td_insert) AS max_ts
         ,CASE
            WHEN max_ts :: DATE <> CURRENT_DATE THEN 0
            ELSE 1
          END               AS check_fg
         ,COUNT(*)          AS countrows
  FROM   dbp_data.mandant_2 m
         LEFT JOIN dbp_data.udf_prognose_2 t1_2
                ON t1.mandant_id = m.mandant_id
                   AND dat_prognoselauf IN ( CURRENT_DATE, CURRENT_DATE - 7 )
  GROUP  BY 1
            ,2
            ,3
  UNION
  SELECT m.mandant_id
         ,dat_beladung      AS run_date
         ,'Promo Changes'   AS table_name
         ,MAX(t1.td_insert) AS max_ts
         ,CASE
            WHEN max_ts :: DATE <> CURRENT_DATE THEN 0
            ELSE 1
          END               AS check_fg
         ,COUNT(*)          AS countrows
  FROM   dbp_data.mandant_2 m
         LEFT JOIN dbp_data.wbs_werbeaenderungen_2 t1_2
                ON t1.mandant_id = m.mandant_id
                   AND dat_beladung IN ( CURRENT_DATE, CURRENT_DATE - 7 )
  GROUP  BY 1
            ,2
            ,3
  UNION
  SELECT m.mandant_id
         ,dat_ausfuehrung   AS run_date
         ,'OP TP1'          AS table_name
         ,MAX(t1.td_insert) AS max_ts
         ,CASE
            WHEN max_ts :: DATE <> CURRENT_DATE THEN 0
            ELSE 1
          END               AS check_fg
         ,COUNT(*)          AS countrows
  FROM   dbp_data.mandant_2 m
         LEFT JOIN dbp_data.best_vorschlag_wbs_2 t1_2
                ON t1.mandant_id = m.mandant_id
                   AND dat_ausfuehrung IN ( CURRENT_DATE, CURRENT_DATE - 7 )
  GROUP  BY 1
            ,2
            ,3
  UNION
  SELECT m.mandant_id
         ,dat_beladung      AS run_date
         ,'Initial'         AS table_name
         ,MAX(t1.td_insert) AS max_ts
         ,CASE
            WHEN max_ts :: DATE <> CURRENT_DATE THEN 0
            ELSE 1
          END               AS check_fg
         ,COUNT(*)          AS countrows
  FROM   dbp_data.mandant_2 m
         LEFT JOIN dbp_data.wbs_art_wup_aktion_initial_2 t1_2
                ON t1.mandant_id = m.mandant_id
                   AND dat_beladung IN ( CURRENT_DATE, CURRENT_DATE - 7 )
  GROUP  BY 1
            ,2
            ,3
  UNION
  SELECT m.mandant_id
         ,CURRENT_DATE      AS run_date
         ,'PMR Data'        AS table_name
         ,MAX(t1.td_update) AS max_ts
         ,CASE
            WHEN max_ts :: DATE <> CURRENT_DATE THEN 0
            ELSE 1
          END               AS check_fg
         ,COUNT(*)          AS countrows
  FROM   dbp_data.mandant_2 m
         LEFT JOIN dbp_data.angebot_2 t1_2
                ON t1.mandant_id = m.mandant_id
                   AND t1.td_update :: DATE = CURRENT_DATE
  GROUP  BY 1
            ,2
            ,3
  /*UNION
  SELECT m.mandant_id
         ,CURRENT_DATE      AS run_date
         ,'Customizing CW0' AS table_name
         ,MAX(t1.td_insert) AS max_ts
         ,CASE
            WHEN max_ts :: DATE <> CURRENT_DATE THEN 0
            ELSE 1
          END               AS check_fg
         ,COUNT(*)          AS countrows
  FROM   dbp_data.mandant_2 m
         LEFT JOIN dbp_etl.customizing_cw_0_2 t1_2
                ON t1.src_mandant_id = m.mandant_id
  GROUP  BY 1
            ,2
            ,3
            */
  UNION
  SELECT m.mandant_id
         ,last_altered :: DATE            AS run_date
         ,'Materialization Promo Changes' AS table_name
         ,MAX(t1.last_altered)            AS max_ts
         ,CASE
            WHEN max_ts :: DATE <> CURRENT_DATE OR COUNT(*) <= 1 THEN 0
            ELSE 1
          END                             AS check_fg
         ,COUNT(*)                        AS countrows
  FROM   dbp_data.mandant_2 m
         
                  LEFT JOIN dbp_data.wbs_werbeaenderungen_2 t2
                ON m.mandant_id = t2.mandant_id
                   AND t2.dat_beladung = CURRENT_DATE
                   LEFT JOIN information_schema.TABLES t1_2
                ON table_name = 'MV_WBS_WERBEAENDERUNGEN_2'
                   AND table_schema = 'DBP_MSI_VIEW_SCM_MATERIALIZED'
                   AND t2.td_update < t1.created
  GROUP  BY 1
            ,2
            ,3
  UNION
  SELECT m.mandant_id
         ,last_altered :: DATE               AS run_date
         ,'Materialization Initial Delivery' AS table_name
         ,MAX(t1.last_altered)               AS max_ts
         ,CASE
            WHEN max_ts :: DATE <> CURRENT_DATE OR COUNT(*) <= 1 THEN 0
            ELSE 1
          END                             AS check_fg
         ,COUNT(*)                           AS countrows
  FROM   dbp_data.mandant_2 m
         LEFT JOIN dbp_data.wbs_art_wup_aktion_initial_2
                   t2
                ON m.mandant_id = t2.mandant_id
                   AND t2.dat_beladung = CURRENT_DATE
         LEFT JOIN information_schema.TABLES t1_2
                ON table_name = 'MV_WBS_ART_WUP_AKTION_INITIAL_2'
                   AND table_schema = 'DBP_MSI_VIEW_SCM_MATERIALIZED'
                   AND t2.mandant_id IS NOT NULL
                   AND t2.td_update < t1.created
  GROUP  BY 1
            ,2
            ,3  
            
            ;
