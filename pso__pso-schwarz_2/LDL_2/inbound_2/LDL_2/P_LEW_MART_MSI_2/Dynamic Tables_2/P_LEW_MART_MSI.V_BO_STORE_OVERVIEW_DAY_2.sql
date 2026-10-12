
/*
  Story       : https://jira.schwarz/browse/REP4-10237
  Database    : LDL_PRODUCTION_CLONE_LEAD_LEW_MART
  Target      : P_LEW_MART_MSI.V_BO_STORE_OVERVIEW_DAY_2
  Source
    P_LEW_CORE_AC
        ptm   : v_workingtime_plan_store_day_2 (via p_lew_bil_ac.v_ptm_plan_time_store_day_2)
        c     : v_client_2
        d     : v_bo_descs_2
        cal   : v_cal_calendarday_2
        inv   : v_wawi_inv_store_2
        org   : v_org_store_merge_2
        
    P_LEW_BIL_AC
        txj   : v_agg_store_day_piece_perf_2
        plan  : v_agg_store_day_piece_perf_plan_pep_2 (via p_lew_bil_ac.v_ptm_plan_time_store_day_2)
        sfo   : v_agg_store_day_sfo_2
        s2wlk : v_store_to_warehouse_lastknown_2
     
  History:
    2021-11-03  zied.nanaa_ext@mail.schwarz     Script Teradata Migration from svn://l-as616.asp.lidl.net/ddl/lew/lew_mart_msi/lew_mart_msi_v_bo_store_overview_day.sql
    2022-05-12  Marcin Malec                    Instead of p_lew_core_ac.v_workingtime_plan_store_day_2 and p_lew_bil_ac.v_agg_store_day_piece_perf_plan_pep_2
                                                view p_lew_bil_ac.v_ptm_plan_time_store_day_2 is used, which combines them and has an adjustment for France turnover calculation
    2022-08-23  Marcin Malec                    Stueckleistung part 2 / SPEC0165308 - Adding column sales_pieces_py.
    2022-10-14  Michael Morris INC4885338, User Story: 343128 - Line 446: Added PCWO_REASON_ID 152 to list
*/
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_BO_STORE_OVERVIEW_DAY_2 COMMENT='Stückleistung Overview Day (Filialübersicht)'
(
    account_manager_id                COMMENT 'AUS BIL:v_location_organization_2'
  , account_manager_name              COMMENT 'AUS BIL:v_location_organization_2'
  , act_productivity                  COMMENT 'MART_MSI:t_bo_base_performance_list_2: Formel: val_retail / (time_working_netto_std + miss_times_perf)'
  , act_productivity_net              COMMENT 'MART_MSI:t_bo_base_performance_list_2: Formel: val_retail_net / (time_working_netto_std + miss_times_perf)'
  , city                              COMMENT 'AUS CORE.t_address_2'
  , client_id                         COMMENT 'DWH-Client im DWH = LIDL-Land_2 (country_2)'
  , cnt_customer_asis                 COMMENT 'CORE:v_agg_sales_store_day.cnt_customer'
  , country_desc                      COMMENT 'AUS MART_MSI.v_ref_country_act_bo_2 (letztlich aus CORE:t_wawi_ref_country_act_2 - für mehrsprachige Ländernamen)'
  , country_id                        COMMENT 'Wie client_id'
  , country_iso_cd                    COMMENT 'AUS MART_MSI.v_ref_country_act_bo_2 (letztlich aus CORE:t_wawi_ref_country_act_2 - für mehrsprachige Ländernamen)'
  , currency_iso_cd                   COMMENT 'AUS CORE:v_client_2'
  , dat_calendar                      COMMENT 'MART_MSI:v_bo_perf_cal_list_day_2: Fakten-Kalendertag'
  , diff_hours                        COMMENT 'MART_MSI:t_bo_base_performance_list_2: Formel: time_working_netto_std + miss_times_perf - plan_val_hours'
  , diff_val_retail_pct               COMMENT 'MART_MSI:t_bo_base_performance_list_2: Formel: 100*(val_retail-plan_val_turnover) / plan_val_turnover'
  , diff_val_retail_net_pct           COMMENT 'MART_MSI:t_bo_base_performance_list_2: Formel: 100*(val_retail_net-plan_val_turnover_net) / plan_val_turnover_net (wobei aktuell plan_val_turnover=plan_val_turnover_net)'
  , hrs_calc_prod_diff                COMMENT 'CORE:v_wawi_agg_wt_store_day_asis.time_working_netto_hrs; Wertausweis nur bis zum früheren Tag_2 aus (Maximaler Umsatztag, Maximaler Arbeitsstundentag) der Tagesauswahl pro Store!'
  , miss_times_perf                   COMMENT 'CORE:v_wawi_agg_wt_store_day_asis.perf_rel_absence_hrs'
  , miss_times_perf_calc_prod_diff    COMMENT 'CORE:v_wawi_agg_wt_store_day_asis.perf_rel_absence_hrs; Wertausweis nur bis zum früheren Tag_2 aus (Maximaler Umsatztag, Maximaler Arbeitsstundentag) der Tagesauswahl pro Store!'
  , orig_store_nr                     COMMENT 'NaturalKey des Stores aus Join mit v_lew_bil.v_store_2 über v_lew_bil.v_store_relocation_2; angezeigt wird der GewinnerStore bei Fusionen - nicht der untergegangene OriginalStore der Fakten'
  , plan_hours_calc_hrs_diff          COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.val_hours; Wertausweis nur bis zum Maximalen Umsatztag der Tagesauswahl pro Store!'
  , plan_hours_calc_prod_diff         COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.val_hours; Wertausweis nur bis zum früheren Tag_2 aus (Maximaler Umsatztag, Maximaler Arbeitsstundentag) der Tagesauswahl pro Store!'
  , plan_productivity                 COMMENT 'MART_MSI:t_bo_base_performance_list_2: Formel: plan_val_turnover / plan_val_hours'
  , plan_productivity_net             COMMENT 'MART_MSI:t_bo_base_performance_list_2: Formel: plan_val_turnover_net / plan_val_hours (wobei aktuell plan_val_turnover=plan_val_turnover_net)'
  , plan_turnover_calc_prod_diff      COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.val_turnover; Wertausweis nur bis zum früheren Tag_2 aus (Maximaler Umsatztag, Maximaler Arbeitsstundentag) der Tagesauswahl pro Store!'
  , plan_turnover_calc_pro_dif_net    COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.val_turnover (kein Schreibfehler!); Wertausweis nur bis zum früheren Tag_2 aus (Maximaler Umsatztag, Maximaler Arbeitsstundentag) der Tagesauswahl pro Store!'
  , plan_turnover_calc_ums_diff       COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.val_turnover; Wertausweis nur bis zum Maximalen Umsatztag der Tagesauswahl pro Store!'
  , plan_turnover_calc_ums_dif_net    COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.val_turnover (kein Schreibfehler!); Wertausweis nur bis zum Maximalen Umsatztag der Tagesauswahl pro Store!'
  , plan_val_hours                    COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.val_hours'
  , plan_val_inv_training             COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.(val_inventory + val_training)'
  , plan_val_turnover                 COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.val_turnover'
  , plan_val_turnover_net             COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.val_turnover (kein Schreibfehler!)'
  , plan_sales_pieces                 COMMENT 'Plan durchschnittliche Artikelpreis'
  , plan_avg_sales_price              COMMENT 'Plan durchschnittliche Artikelpreis'
  , plan_piece_performance            COMMENT 'Plan Stückleistung'
  , sales_pieces                      COMMENT 'Anzahl der abverkäuften Stk./Kg.'
  , sales_pieces_py                   COMMENT 'Anzahl der abverkäuften Stk./Kg aus dem Vorjahr'
  , avg_sales_price                   COMMENT 'Durchschnittliche Abverkaufspreis'
  , piece_receipt                     COMMENT 'Durchschnittliche Artikelanzahl pro Bon'
  , piece_performance                 COMMENT 'Stückleistung '
  , sales_manager_id                  COMMENT 'AUS BIL:v_location_organization_2'
  , sales_manager_name                COMMENT 'AUS BIL:v_location_organization_2'
  , sfo_to_val_retail_pct             COMMENT 'Sfo_To_k Bez. Einheit pct'
  , sfo_to_val_retail_net_pct         COMMENT 'Sfo_To_k Bez. Einheit pct'
  , store_desc                        COMMENT 'Benutzt wird loc_name2 vor loc_name (used_store_desc) aus v_lew_bil.v_store_2 -> letztlich aus Core:t_location_2'
  , store_id                          COMMENT 'DWHKey des Stores aus Join mit v_lew_bil.v_store_2 über v_lew_bil.v_store_relocation_2; angezeigt wird der GewinnerStore bei Fusionen - nicht der untergegangene OriginalStore der Fakten'
  , time_working_netto_std            COMMENT 'CORE:v_wawi_agg_wt_store_day_asis.time_working_netto_hrs'
  , val_retail_asis                   COMMENT 'CORE:v_agg_sales_store_day.val_retail'
  , val_retail_net_asis               COMMENT 'CORE:v_agg_sales_store_day.val_retail_net'
  , val_retail_calc_prod_diff         COMMENT 'CORE:v_agg_sales_store_day.val_retail; Wertausweis nur bis zum früheren Tag_2 aus (Maximaler Umsatztag, Maximaler Arbeitsstundentag) der Tagesauswahl pro Store!'
  , val_retail_calc_prod_diff_net     COMMENT 'CORE:v_agg_sales_store_day.val_retail_net; Wertausweis nur bis zum früheren Tag_2 aus (Maximaler Umsatztag, Maximaler Arbeitsstundentag) der Tagesauswahl pro Store!'
  , val_rtl_rl_sfo_store              COMMENT 'Val_Rtlk Bez. Einheit store'
  , val_rtl_rl_net_sfo_store          COMMENT 'Val_Rtlk Bez. Einheit store'
  , val_rtl_net_sfo_mhd_break         COMMENT 'Abschritften MHD & Bruch'
  , val_rtl_net_sfo_other_stc_loss    COMMENT 'Abschritften Sonstige Warenverluste'
  , val_rtl_net_sfo_str_deliv_qlty    COMMENT 'Abschritften Anlieferung Qualität'
  , wh_desc                           COMMENT 'Benutzt wird loc_name2 vor loc_name (used_wh_desc) aus CORE:t_location_2 über die dem Store (Gewinnerstore! - siehe loc_sid_store) in der Hauptlieferbeziehung zugeordneten Warehouse (aus BIL:v_store_to_warehouse_lastknown_2)'
  , wh_id                             COMMENT 'NaturalKey (src_wh_id) des dem Store (Gewinnerstore! - siehe loc_sid_store) über die Hauptlieferbeziehung zugeordneten Warehouse (aus BIL:v_store_to_warehouse_lastknown_2)'
)

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
SELECT   agg_lvl1.account_manager_id
       , agg_lvl1.account_manager_name
       , agg_lvl1.act_productivity
       , agg_lvl1.act_productivity_net
       , agg_lvl1.city
       , agg_lvl1.client_id
       , agg_lvl1.cnt_customer                                                      AS cnt_customer_asis
       , agg_lvl1.country_desc
       , agg_lvl1.country_id
       , agg_lvl1.country_iso_cd
       , agg_lvl1.currency_iso_cd
       , agg_lvl1.dat_calendar
       , agg_lvl1.diff_hours
       , agg_lvl1.diff_val_retail_pct
       , agg_lvl1.diff_val_retail_net_pct
       , CASE WHEN agg_lvl1.dat_calendar <= agg_lvl1.max_ums_dat_fact
               AND agg_lvl1.dat_calendar <= agg_lvl1.max_hrs_dat_fact
                   THEN agg_lvl1.time_working_netto_std
              ELSE NULL
          END                                                                       AS hrs_calc_prod_diff
       , ZEROIFNULL(agg_lvl1.miss_times_perf)                                       AS miss_times_perf
       , CASE WHEN agg_lvl1.dat_calendar <= agg_lvl1.max_ums_dat_fact
               AND agg_lvl1.dat_calendar <= agg_lvl1.max_hrs_dat_fact
                   THEN COALESCE(agg_lvl1.miss_times_perf, 0)
              ELSE 0
          END                                                                       AS miss_times_perf_calc_prod_diff
       , agg_lvl1.orig_store_nr
       , CASE WHEN agg_lvl1.dat_calendar <= agg_lvl1.max_hrs_dat_fact
                  THEN agg_lvl1.plan_val_hours
              ELSE NULL
          END                                                                       AS plan_hours_calc_hrs_diff
       , CASE WHEN agg_lvl1.dat_calendar <= agg_lvl1.max_ums_dat_fact
               AND agg_lvl1.dat_calendar <= agg_lvl1.max_hrs_dat_fact
                   THEN agg_lvl1.plan_val_hours
              ELSE NULL
          END                                                                       AS plan_hours_calc_prod_diff
       , agg_lvl1.plan_productivity
       , agg_lvl1.plan_productivity_net
       , CASE WHEN agg_lvl1.dat_calendar <= agg_lvl1.max_ums_dat_fact
               AND agg_lvl1.dat_calendar <= agg_lvl1.max_hrs_dat_fact
                   THEN agg_lvl1.plan_val_turnover
              ELSE NULL
          END                                                                       AS plan_turnover_calc_prod_diff
       , CASE WHEN agg_lvl1.dat_calendar <= agg_lvl1.max_ums_dat_fact
               AND agg_lvl1.dat_calendar <= agg_lvl1.max_hrs_dat_fact
                   THEN agg_lvl1.plan_val_turnover_net
              ELSE NULL
          END                                                                       AS plan_turnover_calc_pro_dif_net
       , CASE WHEN agg_lvl1.dat_calendar <= agg_lvl1.max_ums_dat_fact
                   THEN agg_lvl1.plan_val_turnover
              ELSE NULL
          END                                                                       AS plan_turnover_calc_ums_diff
       , CASE WHEN agg_lvl1.dat_calendar <= agg_lvl1.max_ums_dat_fact
                   THEN plan_val_turnover_net
              ELSE NULL
          END                                                                       AS plan_turnover_calc_ums_dif_net
       , agg_lvl1.plan_val_hours
       , agg_lvl1.plan_val_inv_training
       , agg_lvl1.plan_val_turnover
       , agg_lvl1.plan_val_turnover_net
/* Stückleistung Spelaten */
       , agg_lvl1.plan_sales_pieces
       , agg_lvl1.plan_avg_sales_price
       , agg_lvl1.plan_piece_performance
       , agg_lvl1.sales_pieces
       , agg_lvl1.sales_pieces_py
       , agg_lvl1.avg_sales_price
       , agg_lvl1.piece_receipt
       , agg_lvl1.piece_performance
/* Ende Stückleistung Spalten */
       , agg_lvl1.sales_manager_id
       , agg_lvl1.sales_manager_name
       , agg_lvl1.sfo_to_val_retail_pct
       , agg_lvl1.sfo_to_val_retail_net_pct
       , agg_lvl1.store_desc
       , agg_lvl1.store_id
       , agg_lvl1.time_working_netto_std

       , agg_lvl1.val_retail                                                        AS val_retail_asis
       , agg_lvl1.val_retail_net                                                    AS val_retail_net_asis
       , CASE WHEN agg_lvl1.dat_calendar <= agg_lvl1.max_ums_dat_fact
               AND agg_lvl1.dat_calendar <= agg_lvl1.max_hrs_dat_fact
                   THEN agg_lvl1.val_retail
              ELSE NULL
          END                                                                       AS val_retail_calc_prod_diff
       , CASE WHEN agg_lvl1.dat_calendar <= agg_lvl1.max_ums_dat_fact
               AND agg_lvl1.dat_calendar <= agg_lvl1.max_hrs_dat_fact
                   THEN agg_lvl1.val_retail_net
              ELSE NULL
          END                                                                       AS val_retail_calc_prod_diff_net
       , agg_lvl1.val_rtl_rl_sfo_store
       , agg_lvl1.val_rtl_rl_net_sfo_store
       , agg_lvl1.val_rtl_net_sfo_mhd_break        /* writeoffs for mhd and break of stores      */
       , agg_lvl1.val_rtl_net_sfo_other_stc_loss   /* writeoffs for other stock losses of stores */
       , agg_lvl1.val_rtl_net_sfo_str_deliv_qlty   /* writeoffs for quality of delivery         */
       , agg_lvl1.wh_desc
       , agg_lvl1.wh_id
  FROM (
        SELECT   d.orig_store_nr
               , d.store_desc
               , d.country_desc
               , d.country_id
               , d.country_iso_cd
               , d.city
               , d.wh_id
               , d.wh_desc
               , d.sales_manager_id
               , d.sales_manager_name
               , d.account_manager_id
               , d.account_manager_name
               , c.curr_cd                                                                                                                   AS currency_iso_cd
               , agg_lvl0.client_id
               , agg_lvl0.store_id
               , agg_lvl0.dat_calendar
               , SUM(agg_lvl0.plan_val_turnover)                                                                                             AS plan_val_turnover
               , SUM(agg_lvl0.plan_val_turnover_net)                                                                                         AS plan_val_turnover_net
               , SUM(agg_lvl0.plan_val_hours)                                                                                                AS plan_val_hours
               , SUM(agg_lvl0.plan_val_inv_training)                                                                                         AS plan_val_inv_training
               , SUM(agg_lvl0.plan_sales_pieces)                                                                                             AS plan_sales_pieces
               , SUM(agg_lvl0.plan_avg_sales_price)                                                                                          AS plan_avg_sales_price
               , SUM(agg_lvl0.plan_piece_performance)                                                                                        AS plan_piece_performance
               , SUM(agg_lvl0.val_retail)                                                                                                    AS val_retail
               , SUM(agg_lvl0.val_retail_net)                                                                                                AS val_retail_net
               , SUM(agg_lvl0.cnt_customer)                                                                                                  AS cnt_customer
               , SUM(agg_lvl0.time_working_netto_std)                                                                                        AS time_working_netto_std
               , SUM(ZEROIFNULL(agg_lvl0.miss_times_perf))                                                                                   AS miss_times_perf
               , SUM(agg_lvl0.sales_pieces)                                                                                                  AS sales_pieces
               , SUM(agg_lvl0.sales_pieces_py)                                                                                               AS sales_pieces_py
               , SUM(agg_lvl0.avg_sales_price)                                                                                               AS avg_sales_price
               , SUM(agg_lvl0.piece_receipt)                                                                                                 AS piece_receipt
               , SUM(agg_lvl0.piece_performance)                                                                                             AS piece_performance
               , SUM(agg_lvl0.val_rtl_rl_sfo_store)                                                                                          AS val_rtl_rl_sfo_store
               , SUM(agg_lvl0.val_rtl_rl_net_sfo_store)                                                                                      AS val_rtl_rl_net_sfo_store
               , SUM(agg_lvl0.val_rtl_net_sfo_mhd_break)                                                                                     AS val_rtl_net_sfo_mhd_break        /* writeoffs for mhd and break of stores      */
               , SUM(agg_lvl0.val_rtl_net_sfo_other_stc_loss)                                                                                AS val_rtl_net_sfo_other_stc_loss   /* writeoffs for other stock losses of stores */
               , SUM(agg_lvl0.val_rtl_net_sfo_str_deliv_qlty)                                                                                AS val_rtl_net_sfo_str_deliv_qlty   /* writeoffs for quality of delivery          */
               , MAX(agg_lvl0.max_ums_dat_fact)                                                                                              AS max_ums_dat_fact
               , MAX(agg_lvl0.max_hrs_dat_fact)                                                                                              AS max_hrs_dat_fact
               , SUM(agg_lvl0.plan_val_turnover)     / NULLIFZERO(SUM(agg_lvl0.plan_val_hours))                                              AS plan_productivity
               , SUM(agg_lvl0.plan_val_turnover_net) / NULLIFZERO(SUM(agg_lvl0.plan_val_hours))                                              AS plan_productivity_net
               , SUM(agg_lvl0.val_retail)     / NULLIFZERO(SUM(agg_lvl0.time_working_netto_std) + COALESCE(SUM(agg_lvl0.miss_times_perf),0)) AS act_productivity
               , SUM(agg_lvl0.val_retail_net) / NULLIFZERO(SUM(agg_lvl0.time_working_netto_std) + COALESCE(SUM(agg_lvl0.miss_times_perf),0)) AS act_productivity_net
               , CASE WHEN SUM(agg_lvl0.val_retail) IS NOT NULL
                           THEN (SUM(agg_lvl0.val_retail) - SUM(agg_lvl0.plan_val_turnover)) / NULLIFZERO(SUM(agg_lvl0.plan_val_turnover)) * 100
                      ELSE NULL
                  END                                                                                                                        AS diff_val_retail_pct
               , CASE WHEN SUM(agg_lvl0.val_retail_net) IS NOT NULL
                           THEN (SUM(agg_lvl0.val_retail_net) - SUM(agg_lvl0.plan_val_turnover_net)) / NULLIFZERO(SUM(agg_lvl0.plan_val_turnover_net)) * 100
                      ELSE NULL
                  END                                                                                                                        AS diff_val_retail_net_pct
               , SUM(agg_lvl0.time_working_netto_std) + SUM(COALESCE(agg_lvl0.miss_times_perf, 0)) - SUM(agg_lvl0.plan_val_hours)            AS diff_hours
               , CAST(SUM(agg_lvl0.val_rtl_rl_sfo_store)     / NullIfZero(SUM(agg_lvl0.val_retail))     * 100 AS DECIMAL(36,10))             AS sfo_to_val_retail_pct
               , CAST(SUM(agg_lvl0.val_rtl_rl_net_sfo_store) / NullIfZero(SUM(agg_lvl0.val_retail_net)) * 100 AS DECIMAL(36,10))             AS sfo_to_val_retail_net_pct
          FROM (
            /* Dummy_2 Satz für Store und Tag_2, falls es keine Daten gibt  */
                SELECT   s2wlk.client_id
                       , s2wlk.loc_sid_store                      AS store_id
                       , cal.cal_dt                               AS dat_calendar
                       , c.curr_cd                                AS currency_iso_cd
                       , CAST(NULL AS DECIMAL(36,10))             AS plan_val_turnover
                       , CAST(NULL AS DECIMAL(36,10))             AS plan_val_turnover_net
                       , CAST(NULL AS DECIMAL(36,10))             AS plan_val_hours
                       , CAST(NULL AS DECIMAL(36,10))             AS plan_val_inv_training
/* New Plan columns */
                       , CAST(NULL AS DECIMAL(36,10))             AS plan_sales_pieces
                       , CAST(NULL AS DECIMAL(36,10))             AS plan_avg_sales_price
                       , CAST(NULL AS DECIMAL(36,10))             AS plan_piece_performance

                       , CAST(NULL AS DECIMAL(36,10))             AS val_retail
                       , CAST(NULL AS DECIMAL(36,10))             AS val_retail_net
                       , CAST(NULL AS DECIMAL(36,10))             AS cnt_customer
                       , CAST(NULL AS DECIMAL(36,10))             AS time_working_netto_std
                       , CAST(NULL AS DECIMAL(36,10))             AS miss_times_perf
/* New reported columns */
                       , CAST(NULL AS DECIMAL(36,10))             AS sales_pieces
                       , CAST(NULL AS DECIMAL(36,10))             AS sales_pieces_py
                       , CAST(NULL AS DECIMAL(36,10))             AS avg_sales_price
                       , CAST(NULL AS DECIMAL(36,10))             AS piece_receipt
                       , CAST(NULL AS DECIMAL(36,10))             AS piece_performance

                       , CAST(NULL AS DECIMAL(36,10))             AS val_rtl_rl_sfo_store
                       , CAST(NULL AS DECIMAL(36,10))             AS val_rtl_rl_net_sfo_store
                       , CAST(NULL AS DECIMAL(36,10))             AS val_rtl_net_sfo_mhd_break
                       , CAST(NULL AS DECIMAL(36,10))             AS val_rtl_net_sfo_other_stc_loss
                       , CAST(NULL AS DECIMAL(36,10))             AS val_rtl_net_sfo_str_deliv_qlty
                       , CAST(NULL AS DATE)                       AS max_ums_dat_fact
                       , CAST(NULL AS DATE)                       AS max_hrs_dat_fact

                  FROM P_LEW_BIL_AC.v_store_to_warehouse_lastknown_2 AS s2wlk
                 INNER JOIN P_LEW_CORE_AC.v_client_2                 AS c
                    ON s2wlk.client_id = c.client_id
                 CROSS JOIN (
                             SELECT cal.cal_dt
                               FROM (
                                     SELECT   MAX(cal_dt) - 9 AS date_from
                                            , MAX(cal_dt)     AS date_to
                                       FROM P_LEW_CORE_AC.v_cal_calendarday_2
                                      WHERE cy_day_seq BETWEEN -18 AND 0
                                        AND cal_dt < CURRENT_DATE
                                    )                                      AS zeitbereich
                              INNER JOIN P_LEW_CORE_AC.v_cal_calendarday_2 AS cal
                                 ON cal.cal_dt BETWEEN zeitbereich.date_from AND zeitbereich.date_to
                            ) AS cal
                 UNION ALL
              /*  Planumsatz und Planstunden  */
                SELECT   ptm_plan.client_id
                       , ptm_plan.store_id                                                                             AS store_id
                       , ptm_plan.dat_plantime                                                                         AS dat_calendar
                       , ptm_plan.currency_iso_cd                                                                      AS currency_iso_cd
                       , ptm_plan.val_turnover                                                                         AS plan_val_turnover
                       , ptm_plan.val_turnover                                                                         AS plan_val_turnover_net
                       , ptm_plan.val_inventory + ptm_plan.val_training + ptm_plan.val_misc + ptm_plan.val_working     AS plan_val_hours
                       , ptm_plan.val_inventory + ptm_plan.val_training + ptm_plan.val_misc                            AS plan_val_inv_training
                       , CAST(ptm_plan.val_sales_pieces_pep AS DECIMAL(36,10))                                         AS plan_sales_pieces
                       , CAST(ptm_plan.val_avg_price_pep AS DECIMAL(36,10))                                            AS plan_avg_sales_price
                       , CASE WHEN ptm_plan.val_sales_pieces_pep <> 0 AND ptm_plan.val_hours <> 0
                                   THEN CAST(ptm_plan.val_sales_pieces_pep / ptm_plan.val_hours  AS DECIMAL(36,10))
                                   ELSE CAST(NULL                                                AS DECIMAL(36,10))
                          END                                                                                          AS plan_piece_performance
                       , CAST(NULL AS DECIMAL(36,10))                                                                  AS val_retail
                       , CAST(NULL AS DECIMAL(36,10))                                                                  AS val_retail_net
                       , CAST(NULL AS DECIMAL(36,10))                                                                  AS cnt_customer
                       , CAST(NULL AS DECIMAL(36,10))                                                                  AS time_working_netto_std
                       , CAST(NULL AS DECIMAL(36,10))                                                                  AS miss_times_perf
                       , CAST(NULL AS DECIMAL(36,10))                                                                  AS sales_pieces
                       , CAST(NULL AS DECIMAL(36,10))                                                                  AS sales_pieces_py
                       , CAST(NULL AS DECIMAL(36,10))                                                                  AS avg_sales_price
                       , CAST(NULL AS DECIMAL(36,10))                                                                  AS piece_receipt
                       , CAST(NULL AS DECIMAL(36,10))                                                                  AS piece_performance
                       , CAST(NULL AS DECIMAL(36,10))                                                                  AS val_rtl_rl_sfo_store
                       , CAST(NULL AS DECIMAL(36,10))                                                                  AS val_rtl_rl_net_sfo_store
                       , CAST(NULL AS DECIMAL(36,10))                                                                  AS val_rtl_net_sfo_mhd_break
                       , CAST(NULL AS DECIMAL(36,10))                                                                  AS val_rtl_net_sfo_other_stc_loss
                       , CAST(NULL AS DECIMAL(36,10))                                                                  AS val_rtl_net_sfo_str_deliv_qlty
                       , CAST(NULL AS DATE)                                                                            AS max_ums_dat_fact
                       , CAST(NULL AS DATE)                                                                            AS max_hrs_dat_fact
                  FROM P_LEW_BIL_AC.v_ptm_plan_time_store_day_2     AS ptm_plan
                 INNER JOIN P_LEW_CORE_AC.v_client_2                AS c
                    ON ptm_plan.client_id       = c.client_id
                   AND ptm_plan.currency_iso_cd = c.curr_cd
                 INNER JOIN (
                             SELECT   MAX(cal_dt) - 9                   AS date_from
                                    , MAX(cal_dt)                       AS date_to
                               FROM P_LEW_CORE_AC.v_cal_calendarday_2
                              WHERE cy_day_seq BETWEEN -18 AND 0
                                AND cal_dt < CURRENT_DATE
                            ) AS cal
                    ON ptm_plan.dat_plantime BETWEEN cal.date_from AND cal.date_to
                 UNION ALL
                /* Istumsatz & Stunden_2 */
                SELECT   txj.client_id                                                              AS client_id
                       , txj.loc_sid_store                                                          AS store_id
                       , txj.dwh_cal_dt                                                             AS dat_calendar
                       , txj.currency_iso_cd                                                        AS currency_iso_cd
                       , CAST(NULL AS DECIMAL(36,10))                                               AS plan_val_turnover
                       , CAST(NULL AS DECIMAL(36,10))                                               AS plan_val_turnover_net
                       , CAST(NULL AS DECIMAL(36,10))                                               AS plan_val_hours
                       , CAST(NULL AS DECIMAL(36,10))                                               AS plan_val_inv_training
                       , CAST(NULL AS DECIMAL(36,10))                                               AS plan_sales_pieces
                       , CAST(NULL AS DECIMAL(36,10))                                               AS plan_avg_sales_price
                       , CAST(NULL AS DECIMAL(36,10))                                               AS plan_piece_performance
                       , txj.val_rtl_net                                                            AS val_retail
                       , txj.val_rtl_net                                                            AS val_retail_net
                       , txj.cnt_customer                                                           AS cnt_customer
                       , CAST(txj.work_time_total_hr AS DECIMAL(36,10))                             AS time_working_netto_std
                       , CAST(txj.training_time_hr   AS DECIMAL(36,10))                             AS miss_times_perf
                       , CAST(txj.sales_pieces       AS DECIMAL(36,10))                             AS sales_pieces
                       , CAST(NULL AS DECIMAL(36,10))                                               AS sales_pieces_py
                       , CAST(txj.avg_sales_price    AS DECIMAL(36,10))                             AS avg_sales_price
                       , CAST(txj.piece_receipt      AS DECIMAL(36,10))                             AS piece_receipt
                       , CAST(txj.piece_performance  AS DECIMAL(36,10))                             AS piece_performance
                       , CAST(NULL AS DECIMAL(36,10))                                               AS val_rtl_rl_sfo_store
                       , CAST(NULL AS DECIMAL(36,10))                                               AS val_rtl_rl_net_sfo_store
                       , CAST(NULL AS DECIMAL(36,10))                                               AS val_rtl_net_sfo_mhd_break
                       , CAST(NULL AS DECIMAL(36,10))                                               AS val_rtl_net_sfo_other_stc_loss
                       , CAST(NULL AS DECIMAL(36,10))                                               AS val_rtl_net_sfo_str_deliv_qlty
                       , MAX(txj.dwh_cal_dt) OVER (PARTITION BY txj.client_id, txj.loc_sid_store)   AS max_ums_dat_fact
                       , MAX(txj.dwh_cal_dt) OVER (PARTITION BY txj.client_id, txj.loc_sid_store)   AS max_hrs_dat_fact
                  FROM P_LEW_BIL_AC.v_agg_store_day_piece_perf_2       AS txj
                 INNER JOIN P_LEW_CORE_AC.v_client_2                   AS c
                    ON txj.client_id       = c.client_id
                   AND txj.currency_iso_cd = c.curr_cd
                 /* LKP Kalender  */
                 INNER JOIN (
                             SELECT   MAX(cal_dt) - 9                  AS date_from
                                    , MAX(cal_dt)                      AS date_to
                               FROM P_LEW_CORE_AC.v_cal_calendarday_2
                              WHERE cy_day_seq BETWEEN -18 AND 0
                                AND cal_dt < CURRENT_DATE
                            )                                                                 AS cal
                    ON txj.dwh_cal_dt BETWEEN cal.date_from AND cal.date_to
                 UNION ALL
                 /* Abschriften_2 */
                SELECT   sfo.client_id
                       , org.loc_sid_store_move_to                                                   AS store_id
                       , sfo.booking_dat                                                             AS dat_calendar
                       , c.curr_cd                                                                   AS currency_iso_cd
                       , CAST(NULL AS DECIMAL(36,10))                                                AS plan_val_turnover
                       , CAST(NULL AS DECIMAL(36,10))                                                AS plan_val_turnover_net
                       , CAST(NULL AS DECIMAL(36,10))                                                AS plan_val_hours
                       , CAST(NULL AS DECIMAL(36,10))                                                AS plan_val_inv_training
                       , CAST(NULL AS DECIMAL(36,10))                                                AS plan_sales_pieces
                       , CAST(NULL AS DECIMAL(36,10))                                                AS plan_avg_sales_price
                       , CAST(NULL AS DECIMAL(36,10))                                                AS plan_piece_performance
                       , CAST(NULL AS DECIMAL(36,10))                                                AS val_retail
                       , CAST(NULL AS DECIMAL(36,10))                                                AS val_retail_net
                       , CAST(NULL AS DECIMAL(36,10))                                                AS cnt_customer
                       , CAST(NULL AS DECIMAL(36,10))                                                AS time_working_netto_std
                       , CAST(NULL AS DECIMAL(36,10))                                                AS miss_times_perf
                       , CAST(NULL AS DECIMAL(36,10))                                                AS sales_pieces
                       , CAST(NULL AS DECIMAL(36,10))                                                AS sales_pieces_py
                       , CAST(NULL AS DECIMAL(36,10))                                                AS avg_sales_price
                       , CAST(NULL AS DECIMAL(36,10))                                                AS piece_receipt
                       , CAST(NULL AS DECIMAL(36,10))                                                AS piece_performance
                       , sfo.sfo_total_rtl_rl_val_asis                                               AS val_rtl_rl_sfo_store
                       , sfo.sfo_total_rtl_rl_net_val_asis                                           AS val_rtl_rl_net_sfo_store
                       , CASE WHEN sfo.pcwo_reason_id IN (  1, 127, 134, 135           /* mhd                            */
                                                           ,2, 128                     /* break                          */
                                                         )                             /* in total store writeoffs       */
                                  THEN sfo.sfo_total_rtl_rl_net_val_asis
                              ELSE CAST(0 AS DECIMAL(36,10))
                         END                                                                         AS val_rtl_net_sfo_mhd_break      /* writeoffs for mhd and break of stores         */
                       , CASE WHEN sfo.pcwo_reason_id IN (  3, 136, 137, 152           /* force majeure                  */
                                                           ,4, 101, 102, 110, 111, 129 /* Warenentnahme Filiale          */
                                                           ,7, 130, 131                /* Spenden Filiale                */
                                                         )                             /* in total "other stock losses"  */
                                  THEN sfo.sfo_total_rtl_rl_net_val_asis
                              ELSE CAST(0 AS DECIMAL(36,10))
                         END                                                                         AS val_rtl_net_sfo_other_stc_loss /* writeoffs for other stock losses of stores    */
                       , CASE WHEN sfo.pcwo_reason_id IN ( 8 )
                                  THEN sfo.sfo_total_rtl_rl_net_val_asis
                                  ELSE CAST(0 AS DECIMAL(36,10))
                         END                                                                         AS val_rtl_net_sfo_str_deliv_qlty /* writeoffs for quality of delivery             */
                       , CAST(NULL AS DATE)                                                          AS max_ums_dat_fact
                       , CAST(NULL AS DATE)                                                          AS max_hrs_dat_fact
                  FROM P_LEW_BIL_AC.v_agg_store_day_sfo_2                                  AS sfo
                 INNER JOIN P_LEW_CORE_AC.v_client_2                    AS c
                    ON sfo.client_id       = c.client_id
                  /* LKP Kalender */
                 INNER JOIN (
                             SELECT   MAX(cal_dt) - 9                 AS date_from
                                    , MAX(cal_dt)                     AS date_to
                               FROM P_LEW_CORE_AC.v_cal_calendarday_2
                              WHERE cy_day_seq BETWEEN -18 AND 0
                                AND cal_dt < CURRENT_DATE
                            )                                                              AS cal
                    ON sfo.booking_dat BETWEEN cal.date_from AND cal.date_to
                 INNER JOIN P_LEW_BIL_AC.v_org_store_merge_2                               AS org
                    ON sfo.client_id            = org.client_id
                   AND sfo.loc_sid_store        = org.loc_sid_store
                   AND org.aspect_id            = 1
                 WHERE sfo.sfotype_id IN (137, 147)
                 
                 UNION ALL
                /* Vorjahresdaten Umsatz, Kundenanzahl & Stunden_2 */
                SELECT   sales.client_id
                       , sales.loc_sid_store                                                                                    AS store_id
                       , cal.cal_dt                                                                                             AS dat_calendar
                       , sales.currency_iso_cd
                       , CAST(NULL AS DECIMAL(36,10))                                                                           AS plan_val_turnover
                       , CAST(NULL AS DECIMAL(36,10))                                                                           AS plan_val_turnover_net
                       , CAST(NULL AS DECIMAL(36,10))                                                                           AS plan_val_hours
                       , CAST(NULL AS DECIMAL(36,10))                                                                           AS plan_val_inv_training
                       , CAST(NULL AS DECIMAL(36,10))                                                                           AS plan_sales_pieces
                       , CAST(NULL AS DECIMAL(36,10))                                                                           AS plan_avg_sales_price
                       , CAST(NULL AS DECIMAL(36,10))                                                                           AS plan_piece_performance
                       , CAST(NULL AS DECIMAL(36,10))                                                                           AS val_retail
                       , CAST(NULL AS DECIMAL(36,10))                                                                           AS val_retail_net
                       , CAST(NULL AS DECIMAL(36,10))                                                                           AS cnt_customer
                       , CAST(NULL AS DECIMAL(36,10))                                                                           AS time_working_netto_std
                       , CAST(NULL AS DECIMAL(36,10))                                                                           AS miss_times_perf
                       , CAST(NULL AS DECIMAL(36,10))                                                                           AS sales_pieces
                       , CAST(sales.sales_pieces        AS DECIMAL(36,10))                                                      AS sales_pieces_py
                       , CAST(NULL AS DECIMAL(36,10))                                                                           AS avg_sales_price
                       , CAST(NULL AS DECIMAL(36,10))                                                                           AS piece_receipt
                       , CAST(NULL AS DECIMAL(36,10))                                                                           AS piece_performance
                       , CAST(NULL AS DECIMAL(36,10))                                                                           AS val_rtl_rl_sfo_store
                       , CAST(NULL AS DECIMAL(36,10))                                                                           AS val_rtl_rl_net_sfo_store
                       , CAST(NULL AS DECIMAL(36,10))                                                                           AS val_rtl_net_sfo_mhd_break
                       , CAST(NULL AS DECIMAL(36,10))                                                                           AS val_rtl_net_sfo_other_stc_loss
                       , CAST(NULL AS DECIMAL(36,10))                                                                           AS val_rtl_net_sfo_str_deliv_qlty
                       , CAST(NULL AS DATE)                                                                                     AS max_ums_dat_fact
                       , CAST(NULL AS DATE)                                                                                     AS max_hrs_dat_fact
                  FROM P_LEW_BIL_AC.v_agg_store_day_piece_perf_2      AS sales_2
                 INNER JOIN P_LEW_CORE_AC.v_client_2                    AS c
                    ON sales.client_id       = c.client_id
                   AND sales.currency_iso_cd = c.curr_cd
                 /* Gleichen Wochentag des Vorjahres bestimmen */
                 INNER JOIN P_LEW_CORE_AC.v_cal_calendarday_2 AS cal_py
                    ON cal_py.cal_dt_swday_prev_1y = sales.dwh_cal_dt
                 /* LKP Kalender  */
                 INNER JOIN (
                             SELECT cal.cal_dt
                               FROM (
                                     SELECT   MAX(cal_dt) - 9 AS date_from
                                            , MAX(cal_dt)     AS date_to
                                       FROM P_LEW_CORE_AC.v_cal_calendarday_2
                                      WHERE cy_day_seq BETWEEN -18 AND 0
                                        AND cal_dt < CURRENT_DATE
                                    )                                      AS zeitbereich
                              INNER JOIN P_LEW_CORE_AC.v_cal_calendarday_2 AS cal
                                 ON cal.cal_dt BETWEEN zeitbereich.date_from AND zeitbereich.date_to
                            ) AS cal
                    ON cal_py.cal_dt = cal.cal_dt
                 /* Reloc */
                 INNER JOIN P_LEW_CORE_AC.v_wawi_org_all_store_reloc_act_2 AS store_reloc
                    ON sales.client_id        = store_reloc.client_id
                   AND sales.loc_sid_store    = store_reloc.st_loc_sid
                  LEFT OUTER JOIN P_LEW_CORE_AC.v_wawi_org_store_act_2 AS store_act
                    ON store_reloc.client_id  = store_act.client_id
                   AND store_reloc.st_loc_sid = store_act.st_loc_sid
                 
              )                                                                       AS agg_lvl0
        INNER JOIN P_LEW_CORE_AC.v_client_2                                           AS c
           ON agg_lvl0.client_id = c.client_id
        INNER JOIN P_LEW_MART_MSI.v_bo_descs_2                                        AS d
           ON agg_lvl0.client_id = d.client_id
          AND agg_lvl0.store_id  = d.store_id
        WHERE agg_lvl0.dat_calendar <= COALESCE(d.dat_closing_ovis, d.dat_closing, TO_DATE('31.12.9999', 'dd.mm.yyyy'))   /* Buchung liegt vor Filialschließung */
          AND d.orig_store_nr <> d.wh_id      /* Ausschluss von Dummy_2-Filialen hinter denen ein WH steckt */
        GROUP BY   d.orig_store_nr
                 , d.store_desc
                 , d.country_desc
                 , d.country_id
                 , d.country_iso_cd
                 , d.city
                 , d.wh_id
                 , d.wh_desc
                 , d.sales_manager_id
                 , d.sales_manager_name
                 , d.account_manager_id
                 , d.account_manager_name
                 , c.curr_cd
                 , agg_lvl0.client_id
                 , agg_lvl0.store_id
                 , agg_lvl0.dat_calendar
       ) AS agg_lvl1
;
