/*
  Story       : https://jira.schwarz/browse/REP4-9791
  
  Description: Materialisierung P_LEW_MART_MSI.V_MAT_BO_BASE_PERFORMANCE_LIST_2
               Basistab für alle BO_PERFORMANCELIST-Views

  Sources
    CORE:
               t_wawi_agg_wt_store_day_asis
               t_wawi_ptm_plantimeday_wh
    BIL:
               v_agg_sales_store_day_2

  History:
    2021-11-09  zied.nanaa_ext@mail.schwarz
    Script Teradata Migration from svn://l-as616.asp.lidl.net/ddl/lew/lew_mart_msi/lew_mart_msi_t_bo_base_performance_list.sql
*/

CREATE TABLE P_LEW_MART_MSI.T_BO_BASE_PERFORMANCE_LIST_2 COMMENT='Materialisierung der P_LEW_MART_MSI.V_MAT_BO_BASE_PERFORMANCE_LIST. Basistab für alle BO_PERFORMANCELIST-Views'
(
    CLIENT_ID                   INTEGER                        COMMENT 'DWH-Client im DWH = LIDL-Land_2 (country_2)'
  , LOC_SID_STORE               INTEGER                        COMMENT 'DWHKey des Stores aus Join mit #X_LEW_BIL#.v_store_2 über #X_LEW_BIL#.v_store_relocation. Angezeigt wird der GewinnerStore bei Fusionen - nicht der untergegangene OriginalStore der Fakten'
  , CAL_DT                      DATE                           COMMENT 'MART_MSI:v_bo_perf_cal_list_day_2: Fakten-Kalendertag'
  , PY_CALDT_SHIFTED            DATE                           COMMENT 'MART_MSI:v_bo_perf_cal_list_day_2: Nur für Wochenauswahl: der über die Kalenderfunktion cal_dt_swday_prev_1y ins Currentyear verschobene Tag_2 der PrevYear-Woche_2'
  , CY_WEEK                     INTEGER                        COMMENT 'MART_MSI:v_bo_perf_cal_list_day_2: Woche_2 zum Fakten-Kalendertag'
  , PY_WEEK_SHIFTED             INTEGER                        COMMENT 'MART_MSI:v_bo_perf_cal_list_day_2: Nur für Wochenauswahl: über Kalenderfunktion cal_dt_swday_prev_1y ins Currentyear verschobene PrevYear-Woche_2'
  , CY_WEEK_SEQ                 INTEGER                        COMMENT 'MART_MSI:v_bo_perf_cal_list_day_2: Relativ-Sequenz der Woche_2 zum Fakten-Kalendertag'
  , PY_WEEK_SEQ_SHIFTED         INTEGER                        COMMENT 'MART_MSI:v_bo_perf_cal_list_day_2: Nur für Wochenauswahl: Relativ-Sequenz der über die Kalenderfunktion cal_dt_swday_prev_1y ins Currentyear verschobenen PrevYear-Woche_2'
  , CY_MONTH                    INTEGER                        COMMENT 'MART_MSI:v_bo_perf_cal_list_day_2: Monat_2 zum Fakten-Kalendertag'
  , ORIG_STORE_NR               INTEGER                        COMMENT 'NaturalKey des Stores aus Join mit #X_LEW_BIL#.v_store_2 über #X_LEW_BIL#.v_store_relocation. Angezeigt wird der GewinnerStore bei Fusionen - nicht der untergegangene OriginalStore der Fakten'
  , USED_STORE_DESC             VARCHAR(100) COLLATE 'en-ci'   COMMENT 'Benutzt wird loc_name2 vor loc_name aus #X_LEW_BIL#.v_store_2 -> letztlich aus Core:t_location_2'
  , USED_CLOSING_DT             DATE                           COMMENT 'Ist Opening_DT (#X_LEW_BIL#.v_store.opening_dt vor 30.12.9999) real, dann BIL:v_store.dat_closing_ovis vor BIL:v_store.closing_dt vor 30.12.9999'
  , CITY                        VARCHAR(100) COLLATE 'en-ci'   COMMENT 'AUS CORE.n_address'
  , COUNTRY_ID                  SMALLINT                       COMMENT '= client_id'
  , COUNTRY_DESC                VARCHAR(35) COLLATE 'en-ci'    COMMENT 'AUS MART_MSI.v_ref_country_act_bo_2 (letztlich aus CORE:t_wawi_ref_country_act_2 - für mehrsprachige Ländernamen)'
  , COUNTRY_ISO_CD              CHAR(3)     COLLATE 'en-ci'    COMMENT 'AUS MART_MSI.v_ref_country_act_bo_2 (letztlich aus CORE:t_wawi_ref_country_act_2 - für mehrsprachige Ländernamen)'
  , CURR_CD                     VARCHAR(20) COLLATE 'en-ci'    COMMENT 'AUS CORE:v_client_2'
  , PLAN_VAL_TURNOVER           DECIMAL(18,4)                  COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.val_turnover'
  , PLAN_VAL_TURNOVER_NET       DECIMAL(18,4)                  COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.val_turnover (kein Schreibfehler!)'
  , PLAN_VAL_HOURS              DECIMAL(18,4)                  COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.val_hours'
  , PLAN_VAL_INV_TRAINING       DECIMAL(18,4)                  COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.(val_inventory + val_training)'
  , VAL_RETAIL                  DECIMAL(18,5)                  COMMENT 'CORE:v_agg_sales_store_day.val_retail'
  , VAL_RETAIL_NET              DECIMAL(18,5)                  COMMENT 'CORE:v_agg_sales_store_day.val_retail_net'
  , CNT_CUSTOMER                DECIMAL(18,4)                  COMMENT 'CORE:v_agg_sales_store_day.cnt_customer'
  , TIME_WORKING_NETTO_STD      DECIMAL(18,4)                  COMMENT 'CORE:v_wawi_agg_wt_store_day_asis.time_working_netto_hrs'
  , MISS_TIMES_PERF             DECIMAL(18,4)                  COMMENT 'CORE:v_wawi_agg_wt_store_day_asis.perf_rel_absence_hrs'
  , IS_DAILY_LEVEL_ROW          INTEGER                        COMMENT 'MART_MSI:v_bo_perf_cal_list_day_2: 1= Kalendertag ist Teil der Normal-Auswahl Tagesebene. 0= außerhalb'
  , IS_WEEKLY_NORMAL_LEVEL_ROW  INTEGER                        COMMENT 'MART_MSI:v_bo_perf_cal_list_day_2: 1= Kalendertag ist Teil der Normal-Auswahl Wochenebene. 0= außerhalb'
  , IS_WEEKLY_PYSHIFT_LEVEL_ROW INTEGER                        COMMENT 'MART_MSI:v_bo_perf_cal_list_day_2: 1= Kalendertag ist Teil der PrevYear-Auswahl Wochenebene. 0= außerhalb'
  , IS_MONTHLY_LEVEL_ROW        INTEGER                        COMMENT 'MART_MSI:v_bo_perf_cal_list_day_2: 1= Kalendertag ist Teil der Normal-Auswahl Monatsebene. 0= außerhalb'
  , SALES_QTY_ASIS              DECIMAL(18,5)                  COMMENT 'Abverkaufte Stück ist'
  , AVG_ITEM_PRICE              DECIMAL(18,5)                  COMMENT 'Average item_2 price'
  , PLAN_SALES_PIECES           DECIMAL(18,5)                  COMMENT 'Plan Abverkauf Stk/Kg'
  , PLAN_AVG_SALES_PRICE        DECIMAL(18,5)                  COMMENT 'Plan durchschnittliche Artikelpreis'
  , PLAN_PIECE_PERFORMANCE      DECIMAL(18,5)                  COMMENT 'Plan Stückleistung'
  , PIECE_RECEIPT               DECIMAL(18,5)                  COMMENT 'Durchschnittliche Anzahl Artikeln/Bon'
  , PIECE_PERFORMANCE           DECIMAL(18,5)                  COMMENT 'IST Stückleistung'
  , UNIQUE
    (
        client_id
      , loc_sid_store
      , cal_dt
      , is_daily_level_row
      , is_weekly_normal_level_row
      , is_weekly_pyshift_level_row
      , is_monthly_level_row
  )
);