/*
  Story           : https://jira.schwarz/browse/REP4-10237
  Database        : LDL_PRODUCTION_CLONE_LEAD_LEW_MART
  Target          : P_LEW_MART_MSI.V_BO_STORE_OVERVIEW_MTH

  Source
    P_LEW_CORE_AC
    ptm           : v_workingtime_plan_store_day (via p_lew_bil_ac.v_ptm_plan_time_store_day)
    c             : v_client
    cal           : v_cal_calendarday
    inv           : v_wawi_inv_store
    store_act     : v_wawi_org_store_act
    store_reloc   : v_wawi_org_all_store_reloc_act

    P_LEW_BIL_AC
    txj           : v_agg_store_day_piece_perf
    plan          : v_agg_store_day_piece_perf_plan_pep (via p_lew_bil_ac.v_ptm_plan_time_store_day)
    sfo           : v_agg_store_day_sfo
    org           : v_org_store_merge

    P_LEW_MART_MSI
    d             : v_bo_descs


  History:
    2021-11-03  zied.nanaa_ext@mail.schwarz      Script Teradata Migration from svn://l-as616.asp.lidl.net/ddl/lew/lew_mart_msi/lew_mart_msi_v_bo_store_overview_mth.sql
    2022-05-12  Marcin Malec                     Instead of p_lew_core_ac.v_workingtime_plan_store_day and p_lew_bil_ac.v_agg_store_day_piece_perf_plan_pep
                                                 view p_lew_bil_ac.v_ptm_plan_time_store_day is used, which combines them and has an adjustment for France turnover calculation
    2022-08-23  Marcin Malec                     Stueckleistung part 2 / SPEC0165308 - Adding columns sales_pieces_ber, sales_pieces_py.
    2022-10-14  Michael Morris INC4885338, User Story: 343128 - Line 634: Added PCWO_REASON_ID 152 to list
    2022-10-14  Michael Morris INC5306134, User Story: 343128 - Missing JOIN criteria to currency table line 827.
*/

CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_BO_STORE_OVERVIEW_MTH COMMENT='Stückleistung Overview Month (Filialübersicht)'
(
    client_id                              COMMENT 'DWH-Client im DWH = LIDL-Land (country)'
  , country_desc                           COMMENT 'AUS MART_MSI.v_ref_country_act_bo (letztlich aus CORE:t_wawi_ref_country_act - für mehrsprachige Ländernamen)'
  , country_id                             COMMENT 'Wie client_id'
  , country_iso_cd                         COMMENT 'AUS MART_MSI.v_ref_country_act_bo (letztlich aus CORE:t_wawi_ref_country_act - für mehrsprachige Ländernamen)'
  , store_id                               COMMENT 'DWHKey des Stores aus Join mit v_lew_bil.v_store über v_lew_bil.v_store_relocation; angezeigt wird der GewinnerStore bei Fusionen - nicht der untergegangene OriginalStore der Fakten'
  , orig_store_nr                          COMMENT 'NaturalKey des Stores aus Join mit v_lew_bil.v_store über v_lew_bil.v_store_relocation; angezeigt wird der GewinnerStore bei Fusionen - nicht der untergegangene OriginalStore der Fakten'
  , store_desc                             COMMENT 'Benutzt wird loc_name2 vor loc_name (used_store_desc) aus v_lew_bil.v_store -> letztlich aus Core:t_location'
  , city                                   COMMENT 'AUS CORE.t_address'
  , wh_id                                  COMMENT 'NaturalKey (src_wh_id) des dem Store (Gewinnerstore! - siehe loc_sid_store) über die Hauptlieferbeziehung zugeordneten Warehouse (aus BIL:v_store_to_warehouse_lastknown)'
  , wh_desc                                COMMENT 'Benutzt wird loc_name2 vor loc_name (used_wh_desc) aus CORE:t_location über die dem Store (Gewinnerstore! - siehe loc_sid_store) in der Hauptlieferbeziehung zugeordneten Warehouse (aus BIL:v_store_to_warehouse_lastknown)'
  , sales_manager_id                       COMMENT 'AUS BIL:v_location_organization'
  , sales_manager_name                     COMMENT 'AUS BIL:v_location_organization'
  , account_manager_id                     COMMENT 'AUS BIL:v_location_organization'
  , account_manager_name                   COMMENT 'AUS BIL:v_location_organization'
  , dat_calendar                           COMMENT 'Datum zum Fakten-Kalendertag'
  , cy_month                               COMMENT 'Monat zum Fakten-Kalendertag'
  , currency_iso_cd                        COMMENT 'AUS CORE:v_client'
  , plan_val_turnover                      COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.val_turnover'
  , plan_val_turnover_net                  COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.val_turnover (kein Schreibfehler!)'
  , plan_val_hours                         COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.val_hours'
  , plan_val_inv_training                  COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.(val_inventory + val_training)'
  , plan_sales_pieces                      COMMENT 'Plan Abverkäufe Stück/Kg'
  , plan_avg_sales_price                   COMMENT 'Plan durchschnittliche Artikelpreis'
  , plan_piece_performance                 COMMENT 'Plan Stückleistung'
  , sales_pieces                           COMMENT 'Anzahl der abverkäuften Stk./Kg.'
  , sales_pieces_ber                       COMMENT 'Anzahl der abverkäuften Stk./Kg.'
  , sales_pieces_py                        COMMENT 'Anzahl der abverkäuften Stk./Kg aus dem Vorjahr'
  , avg_sales_price                        COMMENT 'Durchschnittliche Abverkaufspreis'
  , piece_receipt                          COMMENT 'Durchschnittliche Artikelanzahl pro Bon'
  , piece_performance                      COMMENT 'Stückleistung '
  , val_retail_asis                        COMMENT 'CORE:v_agg_sales_store_day.val_retail'
  , val_retail_net_asis                    COMMENT 'CORE:v_agg_sales_store_day.val_retail_net'
  , cnt_customer_asis                      COMMENT 'CORE:v_agg_sales_store_day.cnt_customer'
  , val_retail_asis_ber                    COMMENT 'Umsatz in lokaler Währung'
  , val_retail_net_asis_ber                COMMENT 'Umsatz in lokaler Währung'
  , cnt_customer_asis_ber                  COMMENT 'Anzahl von Kunden (Anzahl von Bons)'
  , val_retail_asis_py                     COMMENT 'CORE:v_agg_sales_store_day.val_retail; Vorjahresauswahl über die der ReportWoche (week_page) zugeordneten Intervallgrenzen aus MART_MSI:v_bo_perf_cal_list_mth'
  , val_retail_net_asis_py                 COMMENT 'CORE:v_agg_sales_store_day.val_retail_net; Vorjahresauswahl über die der ReportWoche (week_page) zugeordneten Intervallgrenzen aus MART_MSI:v_bo_perf_cal_list_mth'
  , cnt_customer_asis_py                   COMMENT 'CORE:v_agg_sales_store_day.cnt_customer; Vorjahresauswahl über die der ReportWoche (week_page) zugeordneten Intervallgrenzen aus MART_MSI:v_bo_perf_cal_list_mth'
  , sales_pieces_asis_py                   COMMENT 'Anzahl der abverkäuften Stk./Kg aus dem Vorjahr'
  , piece_performance_py                   COMMENT 'Stückleistung aus dem Vorjahr'
  , time_working_netto_std                 COMMENT 'CORE:v_wawi_agg_wt_store_day_asis.time_working_netto_hrs'
  , miss_times_perf                        COMMENT 'CORE:v_wawi_agg_wt_store_day_asis.perf_rel_absence_hrs'
  , plan_turnover_calc_ums_diff            COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.val_turnover; Monatssumme nur bis zum Maximalen Umsatztag der RepWoche!'
  , plan_turnover_calc_ums_dif_net         COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.val_turnover (kein Schreibfehler!); Monatssumme nur bis zum Maximalen Umsatztag der RepWoche!'
  , plan_sales_qty_calc_abv_diff           COMMENT 'MART_MSI:t_bo_base_performance_list.plan_sales_pieces; Wertausweis nur bis zum Maximalen Umsatztag der Tagesauswahl pro Store!'
  , plan_sales_qty_calc_prod_diff          COMMENT 'MART_MSI:t_bo_base_performance_list.plan_sales_pieces; Wertausweis nur bis zum Maximalen Umsatztag der Tagesauswahl pro Store!'
  , plan_hours_calc_hrs_diff               COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.val_hours; Monatssumme nur bis zum Maximalen Umsatztag der RepWoche!'
  , diff_hours                             COMMENT 'MART_MSI:t_bo_base_performance_list: Formel: time_working_netto_std + miss_times_perf - plan_val_hours; Realstunden(Arbeit+Schulung)-Planstunden'
  , plan_productivity                      COMMENT 'Plan_Prk Bez. Einheit productivity'
  , plan_productivity_net                  COMMENT 'Plan_Prk Bez. Einheit productivity net'
  , val_retail_calc_prod_diff              COMMENT 'Val_Retk Bez. Einheit diff'
  , val_retail_calc_prod_diff_net          COMMENT 'Val_Retk Bez. Einheit net'
  , hrs_calc_prod_diff                     COMMENT '??? Iststunden Hok Bez. Einheit diff'
  , miss_times_perf_calc_prod_diff         COMMENT 'Miss_Tik Bez. Einheit diff'
  , val_rtl_rl_sfo_store                   COMMENT 'Val_Rtlk Bez. Einheit store'
  , val_rtl_rl_net_sfo_store               COMMENT 'Val_Rtlk Bez. Einheit store'
  , sfo_to_val_retail_pct                  COMMENT 'Sfo_To_k Bez. Einheit pct'
  , sfo_to_val_retail_net_pct              COMMENT 'Sfo_To_k Bez. Einheit pct'
  , val_rtl_net_sfo_mhd_break              COMMENT 'Abschritften MHD & Bruch'
  , val_rtl_net_sfo_other_stc_loss         COMMENT 'Abschritften Sonstige Warenverluste'
  , val_rtl_net_sfo_str_deliv_qlty         COMMENT 'Abschritften Anlieferung Qualität'
  , plan_turnover_calc_prod_diff           COMMENT 'Plan_Tuk Bez. Einheit diff'
  , plan_turnover_calc_pro_dif_net         COMMENT 'Geplante Umsatz - Verwendet im Berich für Metrik Kalkulation'
  , plan_hours_calc_prod_diff              COMMENT 'Plan_Hok Bez. Einheit diff'
  , diff_val_retail_pct                    COMMENT '??? Inventurdifferenz Umsatz RTL in Prozent'
  , diff_val_retail_net_pct                COMMENT '??? Netto Inventurdifferenz Umsatz RTL in Prozent'
  , act_productivity                       COMMENT 'Aktive Produktivität'
  , act_productivity_net                   COMMENT 'Aktive Produktivität net'
  , diff_plan_act_productivity             COMMENT '??? Differenz Planung aktive Produktivität'
  , diff_plan_act_productivity_net         COMMENT '??? Differenz Planung aktive Produktivität net'
  , diff_inv                               COMMENT 'Differenzwert'
  , diff_net_inv                           COMMENT 'Differenzwert Netto'
  , val_retail_store_inv_stc               COMMENT 'Filialumsatz-Inventurzeitraum'
  , val_retail_store_net_inv_stc           COMMENT 'Währungswert auf Berichtswährung umgerechnet - aktuell kein Input zur Interpretation'
)

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS

SELECT
    agg_lvl3.client_id
  , agg_lvl3.country_desc
  , agg_lvl3.country_id
  , agg_lvl3.country_iso_cd
  , agg_lvl3.store_id
  , agg_lvl3.orig_store_nr
  , agg_lvl3.store_desc
  , agg_lvl3.city
  , agg_lvl3.wh_id
  , agg_lvl3.wh_desc
  , agg_lvl3.sales_manager_id
  , agg_lvl3.sales_manager_name
  , agg_lvl3.account_manager_id
  , agg_lvl3.account_manager_name
  , agg_lvl3.dat_calendar
  , agg_lvl3.cy_month
  , agg_lvl3.currency_iso_cd
  , agg_lvl3.plan_val_turnover
  , agg_lvl3.plan_val_turnover_net
  , agg_lvl3.plan_val_hours
  , agg_lvl3.plan_val_inv_training
/* Neue Spalten für Stückleistung */
  , agg_lvl3.plan_sales_pieces
  , agg_lvl3.plan_avg_sales_price
  , CASE WHEN agg_lvl3.plan_sales_pieces <> 0 AND agg_lvl3.plan_val_hours <> 0
              THEN agg_lvl3.plan_sales_pieces  / agg_lvl3.plan_val_hours
              ELSE CAST(NULL                                         AS DECIMAL(36,10))
    END                                                                                                                                      AS plan_piece_performance
  , agg_lvl3.sales_pieces
  , agg_lvl3.sales_pieces_ber
  , agg_lvl3.sales_pieces_py
  , agg_lvl3.avg_sales_price
  , agg_lvl3.piece_receipt
  , CASE WHEN agg_lvl3.sales_pieces <> 0 AND agg_lvl3.time_working_netto_std <> 0
              THEN agg_lvl3.sales_pieces  / agg_lvl3.time_working_netto_std
              ELSE CAST(NULL                                         AS DECIMAL(36,10))
    END                                                                                                                                      AS piece_performance
/* Ende neuen Spalten */
  , agg_lvl3.val_retail                                                                                                                       AS val_retail_asis
  , agg_lvl3.val_retail_net                                                                                                                   AS val_retail_net_asis
  , agg_lvl3.cnt_customer                                                                                                                     AS cnt_customer_asis
  , agg_lvl3.val_retail_ber                                                                                                                   AS val_retail_asis_ber
  , agg_lvl3.val_retail_net_ber                                                                                                               AS val_retail_net_asis_ber
  , agg_lvl3.cnt_customer_ber                                                                                                                 AS cnt_customer_asis_ber
  , agg_lvl3.val_retail_py                                                                                                                    AS val_retail_asis_py
  , agg_lvl3.val_retail_net_py                                                                                                                AS val_retail_net_asis_py
  , agg_lvl3.cnt_customer_py                                                                                                                  AS cnt_customer_asis_py
/* Neue Spalten für Stückleistung */
  , agg_lvl3.sales_pieces_py                                                                                                                  AS sales_pieces_asis_py
  , CASE WHEN agg_lvl3.sales_pieces_py <> 0 AND agg_lvl3.time_working_netto_std_py <> 0
              THEN agg_lvl3.sales_pieces_py  / agg_lvl3.time_working_netto_std_py
              ELSE CAST(NULL                                         AS DECIMAL(36,10))
    END                                                                                                                                      AS piece_performance_py
/* Ende neuen Spalten */
  , agg_lvl3.time_working_netto_std
  , agg_lvl3.miss_times_perf
  , agg_lvl3.plan_turnover_calc_ums_diff
  , agg_lvl3.plan_turnover_calc_ums_dif_net
  , agg_lvl3.plan_sales_qty_calc_abv_diff
  , agg_lvl3.plan_sales_qty_calc_prod_diff
  , agg_lvl3.plan_hours_calc_hrs_diff
  , agg_lvl3.time_working_netto_std + agg_lvl3.miss_times_perf - agg_lvl3.plan_hours_calc_hrs_diff                                            AS diff_hours
  , agg_lvl3.plan_val_turnover     / NULLIFZERO(agg_lvl3.plan_val_hours)                                                                      AS plan_productivity
  , agg_lvl3.plan_val_turnover_net / NULLIFZERO(agg_lvl3.plan_val_hours)                                                                      AS plan_productivity_net
  , agg_lvl3.val_retail_calc_prod_diff
  , agg_lvl3.val_retail_calc_prod_diff_net
  , agg_lvl3.hrs_calc_prod_diff
  , COALESCE(agg_lvl3.miss_times_perf_calc_prod_diff, 0)                                                                                      AS miss_times_perf_calc_prod_diff
  , agg_lvl3.val_rtl_rl_sfo_store
  , agg_lvl3.val_rtl_rl_net_sfo_store
  , agg_lvl3.val_rtl_rl_sfo_store     / NULLIFZERO(agg_lvl3.val_retail)                                                                       AS sfo_to_val_retail_pct
  , agg_lvl3.val_rtl_rl_net_sfo_store / NULLIFZERO(agg_lvl3.val_retail_net)                                                                   AS sfo_to_val_retail_net_pct
  , agg_lvl3.val_rtl_net_sfo_mhd_break
  , agg_lvl3.val_rtl_net_sfo_other_stc_loss
  , agg_lvl3.val_rtl_net_sfo_str_deliv_qlty
  , agg_lvl3.plan_turnover_calc_prod_diff
  , agg_lvl3.plan_turnover_calc_pro_dif_net
  , agg_lvl3.plan_hours_calc_prod_diff
  , (agg_lvl3.val_retail     - agg_lvl3.plan_turnover_calc_ums_diff)    / NULLIFZERO(agg_lvl3.plan_turnover_calc_ums_diff) * 100              AS diff_val_retail_pct
  , (agg_lvl3.val_retail_net - agg_lvl3.plan_turnover_calc_ums_dif_net) / NULLIFZERO(agg_lvl3.plan_turnover_calc_ums_dif_net) * 100           AS diff_val_retail_net_pct
  , agg_lvl3.val_retail_calc_prod_diff     / NULLIFZERO(agg_lvl3.hrs_calc_prod_diff + COALESCE(agg_lvl3.miss_times_perf_calc_prod_diff,0))    AS act_productivity
  , agg_lvl3.val_retail_calc_prod_diff_net / NULLIFZERO(agg_lvl3.hrs_calc_prod_diff + COALESCE(agg_lvl3.miss_times_perf_calc_prod_diff,0))    AS act_productivity_net
  , (agg_lvl3.val_retail_calc_prod_diff    / NULLIFZERO(agg_lvl3.hrs_calc_prod_diff + COALESCE(agg_lvl3.miss_times_perf_calc_prod_diff,0))) /* act_productivity */
      - (agg_lvl3.plan_turnover_calc_prod_diff   / NULLIFZERO(agg_lvl3.plan_hours_calc_prod_diff))                                            AS diff_plan_act_productivity
  , (agg_lvl3.val_retail_calc_prod_diff_net      / NULLIFZERO(agg_lvl3.hrs_calc_prod_diff + COALESCE(agg_lvl3.miss_times_perf_calc_prod_diff, 0))) /* act_productivity_net */
      - (agg_lvl3.plan_turnover_calc_pro_dif_net / NULLIFZERO(agg_lvl3.plan_hours_calc_prod_diff))                                            AS diff_plan_act_productivity_net
  , agg_lvl3.diff_inv
  , agg_lvl3.diff_net_inv
  , agg_lvl3.val_retail_store_inv_stc
  , agg_lvl3.val_retail_store_net_inv_stc
FROM (
  SELECT   agg_lvl2.client_id
          , agg_lvl2.store_id
          , agg_lvl2.cy_month
          , agg_lvl2.dat_calendar
          , agg_lvl2.orig_store_nr
          , agg_lvl2.store_desc
          , agg_lvl2.country_desc
          , agg_lvl2.country_id
          , agg_lvl2.country_iso_cd
          , agg_lvl2.city
          , agg_lvl2.wh_id
          , agg_lvl2.wh_desc
          , agg_lvl2.sales_manager_id
          , agg_lvl2.sales_manager_name
          , agg_lvl2.account_manager_id
          , agg_lvl2.account_manager_name
          , agg_lvl2.currency_iso_cd
          , SUM(agg_lvl2.plan_val_turnover)                                               AS plan_val_turnover
          , SUM(agg_lvl2.plan_val_turnover_net)                                           AS plan_val_turnover_net
          , SUM(agg_lvl2.plan_val_hours)                                                  AS plan_val_hours
          , SUM(agg_lvl2.plan_val_inv_training)                                           AS plan_val_inv_training

          , SUM(agg_lvl2.plan_sales_pieces)                                               AS plan_sales_pieces
          , AVG(agg_lvl2.plan_avg_sales_price)                                            AS plan_avg_sales_price

          , SUM(agg_lvl2.sales_pieces)                                                    AS sales_pieces
          , SUM(agg_lvl2.sales_pieces_ber)                                                AS sales_pieces_ber
          , AVG(agg_lvl2.avg_sales_price)                                                 AS avg_sales_price
          , AVG(agg_lvl2.piece_receipt)                                                   AS piece_receipt

          , SUM(agg_lvl2.val_retail)                                                      AS val_retail
          , SUM(agg_lvl2.val_retail_net)                                                  AS val_retail_net
          , SUM(agg_lvl2.cnt_customer)                                                    AS cnt_customer
          , SUM(agg_lvl2.val_retail_ber)                                                  AS val_retail_ber
          , SUM(agg_lvl2.val_retail_net_ber)                                              AS val_retail_net_ber
          , SUM(agg_lvl2.cnt_customer_ber)                                                AS cnt_customer_ber
          , SUM(agg_lvl2.val_retail_py)                                                   AS val_retail_py
          , SUM(agg_lvl2.val_retail_net_py)                                               AS val_retail_net_py
          , SUM(agg_lvl2.cnt_customer_py)                                                 AS cnt_customer_py

          , SUM(agg_lvl2.sales_pieces_py)                                                 AS sales_pieces_py
          , SUM(agg_lvl2.time_working_netto_std_py)                                       AS time_working_netto_std_py

          , SUM(agg_lvl2.time_working_netto_std)                                          AS time_working_netto_std
          , SUM(agg_lvl2.miss_times_perf)                                                 AS miss_times_perf
          , SUM(agg_lvl2.val_rtl_rl_sfo_store)                                            AS val_rtl_rl_sfo_store
          , SUM(agg_lvl2.val_rtl_rl_net_sfo_store)                                        AS val_rtl_rl_net_sfo_store
          , SUM(agg_lvl2.val_rtl_net_sfo_mhd_break)                                       AS val_rtl_net_sfo_mhd_break
          , SUM(agg_lvl2.val_rtl_net_sfo_str_deliv_qlty)                                  AS val_rtl_net_sfo_str_deliv_qlty
          , SUM(agg_lvl2.val_rtl_net_sfo_other_stc_loss)                                  AS val_rtl_net_sfo_other_stc_loss
          , SUM(agg_lvl2.diff_inv)                                                        AS diff_inv
          , SUM(agg_lvl2.diff_net_inv)                                                    AS diff_net_inv
          , SUM(agg_lvl2.val_retail_store_inv_stc)                                        AS val_retail_store_inv_stc
          , SUM(agg_lvl2.val_retail_store_net_inv_stc)                                    AS val_retail_store_net_inv_stc
          , SUM(
                CASE WHEN agg_lvl2.dat_fact <= agg_lvl2.max_ums_dat_fact
                          THEN agg_lvl2.plan_val_turnover
                    ELSE NULL
                END
              )                                                                          AS plan_turnover_calc_ums_diff
          , SUM(
                CASE WHEN agg_lvl2.dat_fact <= agg_lvl2.max_ums_dat_fact
                          THEN agg_lvl2.plan_val_turnover_net
                    ELSE NULL
                END
              )                                                                          AS plan_turnover_calc_ums_dif_net
          , SUM(
                CASE WHEN agg_lvl2.dat_fact <= agg_lvl2.max_ums_dat_fact
                      AND agg_lvl2.dat_fact <= agg_lvl2.max_hrs_dat_fact
                          THEN agg_lvl2.plan_val_turnover
                    ELSE NULL
                END
                )                                                                         AS plan_turnover_calc_prod_diff
          , SUM(
                CASE WHEN agg_lvl2.dat_fact <= agg_lvl2.max_ums_dat_fact
                      AND agg_lvl2.dat_fact <= agg_lvl2.max_hrs_dat_fact
                          THEN agg_lvl2.plan_val_turnover_net
                    ELSE NULL
                END
                )                                                                         AS plan_turnover_calc_pro_dif_net
          , SUM(
                CASE WHEN agg_lvl2.dat_fact <= agg_lvl2.max_hrs_dat_fact
                          THEN agg_lvl2.plan_sales_pieces
                    ELSE NULL
                END
                )                                                                         AS plan_sales_qty_calc_abv_diff
          , SUM(
                CASE WHEN agg_lvl2.dat_fact <= agg_lvl2.max_ums_dat_fact
                      AND agg_lvl2.dat_fact <= agg_lvl2.max_hrs_dat_fact
                          THEN agg_lvl2.plan_sales_pieces
                    ELSE NULL
                END
                )                                                                         AS plan_sales_qty_calc_prod_diff
          , SUM(
                CASE WHEN agg_lvl2.dat_fact <= agg_lvl2.max_hrs_dat_fact
                          THEN agg_lvl2.plan_val_hours
                    ELSE NULL
                END
                )                                                                         AS plan_hours_calc_hrs_diff
          , SUM(
                CASE WHEN agg_lvl2.dat_fact <= agg_lvl2.max_ums_dat_fact
                      AND agg_lvl2.dat_fact <= agg_lvl2.max_hrs_dat_fact
                          THEN agg_lvl2.plan_val_hours
                    ELSE NULL
                END
                )                                                                         AS plan_hours_calc_prod_diff
          , SUM(
                CASE WHEN agg_lvl2.dat_fact <= agg_lvl2.max_ums_dat_fact
                      AND agg_lvl2.dat_fact <= agg_lvl2.max_hrs_dat_fact
                          THEN agg_lvl2.val_retail
                    ELSE NULL
                END
                )                                                                         AS val_retail_calc_prod_diff
          , SUM(
                CASE WHEN agg_lvl2.dat_fact <= agg_lvl2.max_ums_dat_fact
                      AND agg_lvl2.dat_fact <= agg_lvl2.max_hrs_dat_fact
                          THEN agg_lvl2.val_retail_net
                    ELSE NULL
                END
                )                                                                         AS val_retail_calc_prod_diff_net
          , SUM(
                CASE WHEN agg_lvl2.dat_fact <= agg_lvl2.max_ums_dat_fact
                      AND agg_lvl2.dat_fact <= agg_lvl2.max_hrs_dat_fact
                          THEN agg_lvl2.time_working_netto_std
                    ELSE NULL
                END
                )                                                                         AS hrs_calc_prod_diff
          , SUM(
                CASE WHEN agg_lvl2.dat_fact <= agg_lvl2.max_ums_dat_fact
                      AND agg_lvl2.dat_fact <= agg_lvl2.max_hrs_dat_fact
                          THEN agg_lvl2.miss_times_perf
                    ELSE NULL
                END
                )                                                                         AS miss_times_perf_calc_prod_diff
    FROM (
          SELECT   agg_lvl1.client_id
                  , agg_lvl1.store_id
                  , agg_lvl1.dat_fact
                  , agg_lvl1.cy_month
                  , agg_lvl1.dat_calendar
                  , agg_lvl1.plan_val_turnover
                  , agg_lvl1.plan_val_turnover_net
                  , agg_lvl1.plan_val_hours
                  , agg_lvl1.plan_val_inv_training

                  , agg_lvl1.plan_sales_pieces
                  , agg_lvl1.plan_avg_sales_price
                  , agg_lvl1.sales_pieces
                  , agg_lvl1.sales_pieces_ber
                  , agg_lvl1.avg_sales_price
                  , agg_lvl1.piece_receipt

                  , agg_lvl1.val_retail
                  , agg_lvl1.val_retail_net
                  , agg_lvl1.cnt_customer
                  , agg_lvl1.val_retail_ber
                  , agg_lvl1.val_retail_net_ber
                  , agg_lvl1.cnt_customer_ber
                  , agg_lvl1.val_retail_py
                  , agg_lvl1.val_retail_net_py
                  , agg_lvl1.cnt_customer_py

                  , agg_lvl1.sales_pieces_py
                  , agg_lvl1.time_working_netto_std_py

                  , agg_lvl1.time_working_netto_std
                  , agg_lvl1.miss_times_perf
                  , agg_lvl1.val_rtl_rl_sfo_store
                  , agg_lvl1.val_rtl_rl_net_sfo_store
                  , agg_lvl1.val_rtl_net_sfo_mhd_break
                  , agg_lvl1.val_rtl_net_sfo_other_stc_loss
                  , agg_lvl1.val_rtl_net_sfo_str_deliv_qlty
                  , agg_lvl1.max_ums_dat_fact
                  , MAX(agg_lvl1.max_hrs_dat_fact) OVER (PARTITION BY agg_lvl1.client_id, agg_lvl1.store_id, agg_lvl1.dat_calendar) AS max_hrs_dat_fact
                  , agg_lvl1.diff_inv
                  , agg_lvl1.diff_net_inv
                  , agg_lvl1.val_retail_store_inv_stc
                  , agg_lvl1.val_retail_store_net_inv_stc
                  , d.orig_store_nr
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
                  , c.curr_cd                                                                                                       AS currency_iso_cd
            FROM (
                  SELECT   agg_lvl0.client_id
                          , agg_lvl0.store_id
                          , agg_lvl0.dat_calendar
                          , agg_lvl0.cy_month
                          , agg_lvl0.dat_fact
                          , SUM(agg_lvl0.plan_val_turnover)                    AS plan_val_turnover
                          , SUM(agg_lvl0.plan_val_turnover_net)                AS plan_val_turnover_net
                          , SUM(agg_lvl0.plan_val_hours)                       AS plan_val_hours
                          , SUM(agg_lvl0.plan_val_inv_training)                AS plan_val_inv_training

                          , SUM(agg_lvl0.plan_sales_pieces)                    AS plan_sales_pieces
                          , AVG(agg_lvl0.plan_avg_sales_price)                 AS plan_avg_sales_price

                          , SUM(agg_lvl0.sales_pieces)                         AS sales_pieces
                          , SUM(agg_lvl0.sales_pieces_ber)                     AS sales_pieces_ber
                          , AVG(agg_lvl0.avg_sales_price)                      AS avg_sales_price
                          , AVG(agg_lvl0.piece_receipt)                        AS piece_receipt

                          , SUM(agg_lvl0.val_retail)                           AS val_retail
                          , SUM(agg_lvl0.val_retail_net)                       AS val_retail_net
                          , SUM(agg_lvl0.cnt_customer)                         AS cnt_customer
                          , SUM(agg_lvl0.val_retail_ber)                       AS val_retail_ber
                          , SUM(agg_lvl0.val_retail_net_ber)                   AS val_retail_net_ber
                          , SUM(agg_lvl0.cnt_customer_ber)                     AS cnt_customer_ber
                          , SUM(agg_lvl0.val_retail_py)                        AS val_retail_py
                          , SUM(agg_lvl0.val_retail_net_py)                    AS val_retail_net_py
                          , SUM(agg_lvl0.cnt_customer_py)                      AS cnt_customer_py

                          , SUM(agg_lvl0.sales_pieces_py)                      AS sales_pieces_py
                          , SUM(agg_lvl0.time_working_netto_std_py)            AS time_working_netto_std_py

                          , SUM(agg_lvl0.time_working_netto_std)               AS time_working_netto_std
                          , SUM(ZEROIFNULL(agg_lvl0.miss_times_perf))          AS miss_times_perf
                          , SUM(agg_lvl0.val_rtl_rl_sfo_store)                 AS val_rtl_rl_sfo_store
                          , SUM(agg_lvl0.val_rtl_rl_net_sfo_store)             AS val_rtl_rl_net_sfo_store
                          , SUM(agg_lvl0.val_rtl_net_sfo_mhd_break)            AS val_rtl_net_sfo_mhd_break
                          , SUM(agg_lvl0.val_rtl_net_sfo_other_stc_loss)       AS val_rtl_net_sfo_other_stc_loss
                          , SUM(agg_lvl0.val_rtl_net_sfo_str_deliv_qlty)       AS val_rtl_net_sfo_str_deliv_qlty
                          , MAX(agg_lvl0.max_ums_dat_fact)                     AS max_ums_dat_fact
                          , MAX(agg_lvl0.max_hrs_dat_fact)                     AS max_hrs_dat_fact
                          , SUM(agg_lvl0.diff_inv)                             AS diff_inv
                          , SUM(agg_lvl0.diff_net_inv)                         AS diff_net_inv
                          , SUM(agg_lvl0.val_retail_store_inv_stc)             AS val_retail_store_inv_stc
                          , SUM(agg_lvl0.val_retail_store_net_inv_stc)         AS val_retail_store_net_inv_stc
                    FROM (

                          /* Planumsatz und Planstunden  */
                          SELECT    ptm_plan.client_id
                                  , ptm_plan.store_id                                                                             AS store_id
                                  , cal.cal_dt                                                                                    AS dat_calendar
                                  , ptm_plan.currency_iso_cd                                                                      AS currency_iso_cd
                                  , cal.cy_month
                                  , ptm_plan.dat_plantime                                                                         AS dat_fact
                                  , ptm_plan.val_turnover                                                                         AS plan_val_turnover
                                  , ptm_plan.val_turnover                                                                         AS plan_val_turnover_net
                                  , ptm_plan.val_inventory + ptm_plan.val_training + ptm_plan.val_misc + ptm_plan.val_working     AS plan_val_hours
                                  , ptm_plan.val_inventory + ptm_plan.val_training + ptm_plan.val_misc                            AS plan_val_inv_training

                                  , CAST(ptm_plan.val_sales_pieces_pep AS DECIMAL(36,10))                                         AS plan_sales_pieces
                                  , CAST(ptm_plan.val_avg_price_pep AS DECIMAL(36,10))                                            AS plan_avg_sales_price

                                  , CAST(NULL AS DECIMAL(36,10))                                                                  AS sales_pieces
                                  , CAST(NULL AS DECIMAL(36,10))                                                                  AS sales_pieces_ber
                                  , CAST(NULL AS DECIMAL(36,10))                                                                  AS avg_sales_price
                                  , CAST(NULL AS DECIMAL(36,10))                                                                  AS piece_receipt
                                  , CAST(NULL AS DECIMAL(36,10))                                                                  AS val_retail
                                  , CAST(NULL AS DECIMAL(36,10))                                                                  AS val_retail_net
                                  , CAST(NULL AS DECIMAL(36,10))                                                                  AS cnt_customer
                                  , CAST(NULL AS DECIMAL(36,10))                                                                  AS val_retail_ber
                                  , CAST(NULL AS DECIMAL(36,10))                                                                  AS val_retail_net_ber
                                  , CAST(NULL AS DECIMAL(36,10))                                                                  AS cnt_customer_ber
                                  , CAST(NULL AS DECIMAL(36,10))                                                                  AS val_retail_py
                                  , CAST(NULL AS DECIMAL(36,10))                                                                  AS val_retail_net_py
                                  , CAST(NULL AS DECIMAL(36,10))                                                                  AS cnt_customer_py

                                  , CAST(NULL AS DECIMAL(36,10))                                                                  AS sales_pieces_py
                                  , CAST(NULL AS DECIMAL(36,10))                                                                  AS time_working_netto_std_py
                                  , CAST(NULL AS DECIMAL(36,10))                                                                  AS time_working_netto_std
                                  , CAST(NULL AS DECIMAL(36,10))                                                                  AS miss_times_perf
                                  , CAST(NULL AS DECIMAL(36,10))                                                                  AS val_rtl_rl_sfo_store
                                  , CAST(NULL AS DECIMAL(36,10))                                                                  AS val_rtl_rl_net_sfo_store
                                  , CAST(NULL AS DECIMAL(36,10))                                                                  AS val_rtl_net_sfo_mhd_break
                                  , CAST(NULL AS DECIMAL(36,10))                                                                  AS val_rtl_net_sfo_other_stc_loss
                                  , CAST(NULL AS DECIMAL(36,10))                                                                  AS val_rtl_net_sfo_str_deliv_qlty
                                  , CAST(NULL AS DATE)                                                                            AS max_ums_dat_fact
                                  , CAST(NULL AS DATE)                                                                            AS max_hrs_dat_fact
                                  , CAST(NULL AS DECIMAL(36,10))                                                                  AS diff_inv
                                  , CAST(NULL AS DECIMAL(36,10))                                                                  AS diff_net_inv
                                  , CAST(NULL AS DECIMAL(36,10))                                                                  AS val_retail_store_inv_stc
                                  , CAST(NULL AS DECIMAL(36,10))                                                                  AS val_retail_store_net_inv_stc
                            FROM P_LEW_BIL_AC.v_ptm_plan_time_store_day     AS ptm_plan

                            INNER JOIN P_LEW_CORE_AC.v_client                AS c
                              ON ptm_plan.client_id = c.client_id
                             AND ptm_plan.currency_iso_cd = c.curr_cd

                            INNER JOIN (
                                        SELECT   cal.cal_dt
                                              , cal.cy_month
                                              , cal.cal_dt - cal.day_of_month + 1                    AS dt_from /* Monatserster des letzten Tages im Betrachtungszeitraum */
                                              , ADD_MONTHS(cal.cal_dt - cal.day_of_month + 1, 1) - 1 AS dt_to   /* Monatsletzter des ersten Tages im Betrachtungszeitraum */
                                          FROM P_LEW_CORE_AC.v_cal_calendarday AS cal
                                        INNER JOIN (
                                                    SELECT   MAX(cal_dt) - 9 AS date_from
                                                            , MAX(cal_dt)     AS date_to
                                                      FROM P_LEW_CORE_AC.v_cal_calendarday
                                                      WHERE cy_day_seq BETWEEN -18 AND 0
                                                        AND cal_dt < CURRENT_DATE
                                                    ) AS zeitbereich
                                            ON cal.cal_dt BETWEEN zeitbereich.date_from AND zeitbereich.date_to
                                      ) AS cal
                              ON ptm_plan.dat_plantime BETWEEN cal.dt_from AND cal.dt_to

                            UNION ALL

                            /* Istumsatz & Stunden*/
                          SELECT   txj.client_id                                                                                          AS client_id
                                  , txj.loc_sid_store                                                                                      AS store_id
                                  , cal.cal_dt                                                                                             AS dat_calendar
                                  , txj.currency_iso_cd                                                                                    AS currency_iso_cd
                                  , cal.cy_month
                                  , txj.dwh_cal_dt                                                                                         AS dat_fact
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS plan_val_turnover
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS plan_val_turnover_net
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS plan_val_hours
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS plan_val_inv_training

                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS plan_sales_pieces
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS plan_avg_sales_price
                                  , CAST(txj.sales_pieces       AS DECIMAL(36,10))                                                         AS sales_pieces
                                  , CASE WHEN txj.dwh_cal_dt BETWEEN store_act.dat_calc_start_py AND store_act.dat_calc_end_py
                                          OR (txj.dwh_cal_dt >= store_act.dat_calc_start_py AND store_reloc.move_fg = 1)
                                          OR (txj.dwh_cal_dt >= store_act.dat_calc_start_py AND store_act.dat_calc_end_py IS NULL)
                                              THEN CAST(txj.sales_pieces       AS DECIMAL(36,10))
                                        ELSE NULL
                                    END                                                                                                    AS sales_pieces_ber
                                  , CAST(txj.avg_sales_price    AS DECIMAL(36,10))                                                         AS avg_sales_price
                                  , CAST(txj.piece_receipt      AS DECIMAL(36,10))                                                         AS piece_receipt

                                  , txj.val_rtl_net                                                                                        AS val_retail
                                  , txj.val_rtl_net                                                                                        AS val_retail_net
                                  , txj.cnt_customer                                                                                       AS cnt_customer
                                  , CASE WHEN txj.dwh_cal_dt BETWEEN store_act.dat_calc_start_py AND store_act.dat_calc_end_py
                                          OR (txj.dwh_cal_dt >= store_act.dat_calc_start_py AND store_reloc.move_fg = 1)
                                          OR (txj.dwh_cal_dt >= store_act.dat_calc_start_py AND store_act.dat_calc_end_py IS NULL)
                                              THEN txj.val_rtl_net
                                        ELSE NULL
                                    END                                                                                                   AS val_retail_ber
                                  , CASE WHEN txj.dwh_cal_dt BETWEEN store_act.dat_calc_start_py AND store_act.dat_calc_end_py
                                          OR (txj.dwh_cal_dt >= store_act.dat_calc_start_py AND store_reloc.move_fg = 1)
                                          OR (txj.dwh_cal_dt >= store_act.dat_calc_start_py AND store_act.dat_calc_end_py IS NULL)
                                              THEN txj.val_rtl_net
                                        ELSE NULL
                                    END                                                                                                   AS val_retail_net_ber
                                  , CASE WHEN txj.dwh_cal_dt BETWEEN store_act.dat_calc_start_py AND store_act.dat_calc_end_py
                                          OR (txj.dwh_cal_dt >= store_act.dat_calc_start_py AND store_reloc.move_fg = 1)
                                          OR (txj.dwh_cal_dt >= store_act.dat_calc_start_py AND store_act.dat_calc_end_py IS NULL)
                                              THEN txj.cnt_customer
                                        ELSE NULL
                                    END                                                                                                   AS cnt_customer_ber
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS val_retail_py
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS val_retail_net_py
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS cnt_customer_py
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS sales_pieces_py
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS time_working_netto_std_py

                                  , CAST(txj.work_time_total_hr AS DECIMAL(36,10))                                                         AS time_working_netto_std
                                  , CAST(txj.training_time_hr AS DECIMAL(36,10))                                                           AS miss_times_perf
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS val_rtl_rl_sfo_store
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS val_rtl_rl_net_sfo_store
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS val_rtl_net_sfo_mhd_break
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS val_rtl_net_sfo_other_stc_loss
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS val_rtl_net_sfo_str_deliv_qlty
                                  , MAX(txj.dwh_cal_dt) OVER (PARTITION BY txj.client_id, txj.loc_sid_store, cal.cal_dt)                   AS max_ums_dat_fact
                                  , MAX(txj.dwh_cal_dt) OVER (PARTITION BY txj.client_id, txj.loc_sid_store, cal.cal_dt)                   AS max_hrs_dat_fact
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS diff_inv
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS diff_net_inv
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS val_retail_store_inv_stc
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS val_retail_store_net_inv_stc
                            FROM P_LEW_BIL_AC.v_agg_store_day_piece_perf        AS txj

                            INNER JOIN P_LEW_CORE_AC.v_client                    AS c
                              ON txj.client_id       = c.client_id
                             AND txj.currency_iso_cd = c.curr_cd

                            /* LKP Kalender */
                            INNER JOIN (
                                        SELECT   cal.cal_dt
                                              , cal.cy_month
                                              , cal.cal_dt - cal.day_of_month + 1 AS dt_from /* Monatserster des letzten Tages im Betrachtungszeitraum */
                                          FROM P_LEW_CORE_AC.v_cal_calendarday AS cal
                                        INNER JOIN (
                                                    SELECT   MAX(cal_dt) - 9 AS date_from
                                                            , MAX(cal_dt)     AS date_to
                                                      FROM P_LEW_CORE_AC.v_cal_calendarday
                                                      WHERE cy_day_seq BETWEEN -18 AND 0
                                                        AND cal_dt < CURRENT_DATE
                                                    ) AS zeitbereich
                                            ON cal.cal_dt BETWEEN zeitbereich.date_from AND zeitbereich.date_to
                                      )                                              AS cal
                              ON txj.dwh_cal_dt BETWEEN cal.dt_from AND cal.cal_dt
                            /* Store-Infos */
                            INNER JOIN P_LEW_CORE_AC.v_wawi_org_all_store_reloc_act AS store_reloc
                              ON txj.client_id     = store_reloc.client_id
                              AND txj.loc_sid_store = store_reloc.st_loc_sid
                            LEFT OUTER JOIN P_LEW_CORE_AC.v_wawi_org_store_act     AS store_act
                              ON store_reloc.client_id  = store_act.client_id
                              AND store_reloc.st_loc_sid = store_act.st_loc_sid

                            UNION ALL
                          /* Abschriften */
                          SELECT   sfo.client_id
                                  , org.loc_sid_store_move_to                                                                              AS store_id
                                  , cal.cal_dt                                                                                             AS dat_calendar
                                  , c.curr_cd                                                                                              AS currency_iso_cd
                                  , cal.cy_month
                                  , sfo.booking_dat                                                                                        AS dat_fact
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS plan_val_turnover
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS plan_val_turnover_net
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS plan_val_hours
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS plan_val_inv_training
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS plan_sales_pieces
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS plan_avg_sales_price
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS sales_pieces
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS sales_pieces_ber
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS avg_sales_price
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS piece_receipt

                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS val_retail
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS val_retail_net
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS cnt_customer
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS val_retail_ber
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS val_retail_net_ber
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS cnt_customer_ber
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS val_retail_py
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS val_retail_net_py
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS cnt_customer_py
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS sales_pieces_py
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS time_working_netto_std_py

                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS time_working_netto_std
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS miss_times_perf
                                  , sfo.sfo_total_rtl_rl_val_asis                                                                          AS val_rtl_rl_sfo_store
                                  , sfo.sfo_total_rtl_rl_net_val_asis                                                                      AS val_rtl_rl_net_sfo_store
                                  , CASE WHEN sfo.pcwo_reason_id IN (1, 127, 134, 135,2, 128)
                                              THEN sfo.sfo_total_rtl_rl_net_val_asis
                                        ELSE CAST(0 AS DECIMAL(36,10))
                                    END                                                                                                   AS val_rtl_net_sfo_mhd_break
                                  , CASE WHEN sfo.pcwo_reason_id IN (3, 136, 137, 152, 4, 101, 102, 110, 111, 129,7, 130, 131)
                                              THEN sfo.sfo_total_rtl_rl_net_val_asis
                                        ELSE CAST(0 AS DECIMAL(36,10))
                                    END                                                                                                   AS val_rtl_net_sfo_other_stc_loss
                                  , CASE WHEN sfo.pcwo_reason_id IN (8)
                                              THEN sfo.sfo_total_rtl_rl_net_val_asis
                                        ELSE CAST(0 AS DECIMAL(36,10))
                                    END                                                                                                   AS val_rtl_net_sfo_str_deliv_qlty
                                  , CAST(NULL AS DATE)                                                                                     AS max_ums_dat_fact
                                  , CAST(NULL AS DATE)                                                                                     AS max_hrs_dat_fact
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS diff_inv
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS diff_net_inv
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS val_retail_store_inv_stc
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS val_retail_store_net_inv_stc
                            FROM P_LEW_BIL_AC.v_agg_store_day_sfo AS sfo

                            INNER JOIN P_LEW_CORE_AC.v_client                    AS c
                              ON sfo.client_id       = c.client_id

                            /* LKP Kalender */
                            INNER JOIN (
                                        SELECT   cal.cal_dt
                                              , cal.cy_month
                                              , cal.cal_dt - cal.day_of_month + 1 AS dt_from /* Monatserster des letzten Tages im Betrachtungszeitraum */
                                          FROM P_LEW_CORE_AC.v_cal_calendarday AS cal
                                        INNER JOIN (
                                                    SELECT   MAX(cal_dt) - 9 AS date_from
                                                            , MAX(cal_dt)     AS date_to
                                                      FROM P_LEW_CORE_AC.v_cal_calendarday
                                                      WHERE cy_day_seq BETWEEN -18 AND 0
                                                        AND cal_dt < CURRENT_DATE
                                                    ) AS zeitbereich
                                            ON cal.cal_dt BETWEEN zeitbereich.date_from AND zeitbereich.date_to
                                      ) AS cal
                              ON sfo.booking_dat BETWEEN cal.dt_from AND cal.cal_dt

                            INNER JOIN P_LEW_BIL_AC.v_org_store_merge                               AS org
                              ON sfo.client_id            = org.client_id
                              AND sfo.loc_sid_store        = org.loc_sid_store
                              AND org.aspect_id            = 1

                            WHERE sfo.sfotype_id IN (137, 147)

                            UNION ALL

                          /* Inventurdaten */
                          SELECT   inv.client_id                                                                                          AS client_id
                                  , org.loc_sid_store_move_to                                                                              AS store_id
                                  , cal.cal_dt                                                                                             AS dat_calendar
                                  , c.curr_cd                                                                                              AS currency_iso_cd
                                  , cal.cy_month
                                  , inv.dat_valid_until                                                                                    AS dat_fact
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS plan_val_turnover
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS plan_val_turnover_net
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS plan_val_hours
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS plan_val_inv_training

                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS plan_sales_pieces
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS plan_avg_sales_price
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS sales_pieces
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS sales_pieces_ber
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS avg_sales_price
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS piece_receipt

                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS val_retail
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS val_retail_net
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS cnt_customer
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS val_retail_ber
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS val_retail_net_ber
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS cnt_customer_ber
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS val_retail_py
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS val_retail_net_py
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS cnt_customer_py

                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS sales_pieces_py
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS time_working_netto_std_py

                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS time_working_netto_std
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS miss_times_perf
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS val_rtl_rl_sfo_store
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS val_rtl_rl_net_sfo_store
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS val_rtl_net_sfo_mhd_break
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS val_rtl_net_sfo_other_stc_loss
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS val_rtl_net_sfo_str_deliv_qlty
                                  , CAST(NULL AS DATE)                                                                                     AS ums_dat_fact
                                  , CAST(NULL AS DATE)                                                                                     AS hrs_dat_fact
                                  , inv.diff_inv
                                  , inv.diff_net_inv
                                  , inv.val_retail_store_inv_stc
                                  , inv.val_retail_store_net_inv_stc
                            FROM P_LEW_CORE_AC.v_wawi_inv_store AS inv

                            INNER JOIN P_LEW_CORE_AC.v_client                    AS c
                              ON inv.client_id       = c.client_id

                            /* LKP Kalender */
                            INNER JOIN (
                                        SELECT   cal.cal_dt
                                              , cal.cy_month
                                              , cal.cal_dt - cal.day_of_month + 1 AS dt_from /* Monatserster des letzten Tages im Betrachtungszeitraum */
                                          FROM P_LEW_CORE_AC.v_cal_calendarday AS cal
                                        INNER JOIN (
                                                    SELECT   MAX(cal_dt) - 9 AS date_from
                                                            , MAX(cal_dt)     AS date_to
                                                      FROM P_LEW_CORE_AC.v_cal_calendarday
                                                      WHERE cy_day_seq BETWEEN -18 AND 0
                                                        AND cal_dt < CURRENT_DATE
                                                    ) AS zeitbereich
                                            ON cal.cal_dt BETWEEN zeitbereich.date_from AND zeitbereich.date_to
                                        ) AS cal
                              ON inv.dat_valid_until BETWEEN cal.dt_from AND cal.cal_dt

                            INNER JOIN P_LEW_BIL_AC.v_org_store_merge                               AS org
                              ON inv.client_id            = org.client_id
                              AND inv.st_loc_sid           = org.loc_sid_store
                              AND org.aspect_id            = 1

                            WHERE inv.inv_fg         = 71 /* Inventur */
                              AND inv.status_inv_sic = 64 /* Inventur ist gespeichert und verbucht (Logik von eLWIS DWH übernommen, im WaWI DWH existiert diese Bedingung nicht) */

                            UNION ALL

                          /* Vorjahresdaten Umsatz und Kundenanzahl */
                          SELECT   sales.client_id
                                  , sales.loc_sid_store                                                                                    AS store_id
                                  , cal.cal_dt                                                                                             AS dat_calendar
                                  , sales.currency_iso_cd
                                  , cal.cy_month
                                  , ADD_MONTHS(sales.dwh_cal_dt, 12)                                                                       AS dat_fact
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS plan_val_turnover
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS plan_val_turnover_net
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS plan_val_hours
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS plan_val_inv_training

                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS plan_sales_pieces
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS plan_avg_sales_price
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS sales_pieces
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS sales_pieces_ber
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS avg_sales_price
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS piece_receipt

                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS val_retail
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS val_retail_net
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS cnt_customer
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS val_retail_ber
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS val_retail_net_ber
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS cnt_customer_ber
                                  , CASE WHEN    (ADD_MONTHS(sales.dwh_cal_dt, 12) >=  store_act.dat_calc_start_py
                                                  AND store_reloc.move_fg = 1)
                                              OR (ADD_MONTHS(sales.dwh_cal_dt, 12) BETWEEN store_act.dat_calc_start_py
                                                  AND store_act.dat_calc_end_py)
                                              OR (ADD_MONTHS(sales.dwh_cal_dt, 12) >=  store_act.dat_calc_start_py
                                                  AND store_act.dat_calc_end_py IS NULL)
                                              THEN sales.val_rtl_net
                                        ELSE 0
                                    END                                                                                                   AS val_retail_py
                                  , CASE WHEN    (ADD_MONTHS(sales.dwh_cal_dt, 12) >=  store_act.dat_calc_start_py
                                                  AND store_reloc.move_fg = 1)
                                              OR (ADD_MONTHS(sales.dwh_cal_dt, 12) BETWEEN store_act.dat_calc_start_py
                                                  AND store_act.dat_calc_end_py)
                                              OR (ADD_MONTHS(sales.dwh_cal_dt, 12) >=  store_act.dat_calc_start_py
                                                  AND store_act.dat_calc_end_py IS NULL)
                                              THEN sales.val_rtl_net
                                        ELSE 0
                                    END                                                                                                   AS val_retail_net_py
                                  , CASE WHEN    (ADD_MONTHS(sales.dwh_cal_dt, 12) >=  store_act.dat_calc_start_py
                                                  AND store_reloc.move_fg = 1)
                                              OR (ADD_MONTHS(sales.dwh_cal_dt, 12) BETWEEN store_act.dat_calc_start_py
                                                  AND store_act.dat_calc_end_py)
                                              OR (ADD_MONTHS(sales.dwh_cal_dt, 12) >=  store_act.dat_calc_start_py
                                                  AND store_act.dat_calc_end_py IS NULL)
                                              THEN sales.cnt_customer
                                        ELSE 0
                                    END                                                                                                   AS cnt_customer_py

                                  , CAST(sales.sales_pieces       AS DECIMAL(36,10))                                                       AS sales_pieces_py
                                  , CAST(sales.work_time_total_hr  AS DECIMAL(36,10))                                                      AS time_working_netto_std_py

                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS time_working_netto_std
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS miss_times_perf
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS val_rtl_rl_sfo_store
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS val_rtl_rl_net_sfo_store
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS val_rtl_net_sfo_mhd_break
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS val_rtl_net_sfo_other_stc_loss
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS val_rtl_net_sfo_str_deliv_qlty
                                  , MAX(sales.dwh_cal_dt) OVER (PARTITION BY sales.client_id, sales.loc_sid_store, cal.cal_dt)             AS max_ums_dat_fact
                                  , CAST(NULL AS DATE)                                                                                     AS max_hrs_dat_fact
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS diff_inv
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS diff_net_inv
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS val_retail_store_inv_stc
                                  , CAST(NULL AS DECIMAL(36,10))                                                                           AS val_retail_store_net_inv_stc
                            FROM P_LEW_BIL_AC.v_agg_store_day_piece_perf      AS sales

                            INNER JOIN P_LEW_CORE_AC.v_client                    AS c
                              ON sales.client_id       = c.client_id
                             AND sales.currency_iso_cd = c.curr_cd

                            /* LKP Kalender */
                            INNER JOIN (
                                        SELECT   cal.cal_dt
                                              , cal.cy_month
                                              , cal.cal_dt_prev_1y - cal.day_of_month + 1 AS dt_from /* Monatserster des letzten Tages im Betrachtungszeitraum */
                                              , cal.cal_dt_prev_1y                        AS dt_to
                                          FROM P_LEW_CORE_AC.v_cal_calendarday AS cal
                                        INNER JOIN (
                                                    SELECT   MAX(cal_dt) - 9 AS date_from
                                                            , MAX(cal_dt)     AS date_to
                                                      FROM P_LEW_CORE_AC.v_cal_calendarday
                                                      WHERE cy_day_seq BETWEEN -18 AND 0
                                                        AND cal_dt < CURRENT_DATE
                                                    ) AS zeitbereich
                                            ON cal.cal_dt BETWEEN zeitbereich.date_from AND zeitbereich.date_to
                                        )                                              AS cal
                              ON sales.dwh_cal_dt BETWEEN cal.dt_from AND cal.dt_to
                            /* Reloc */
                            INNER JOIN  P_LEW_CORE_AC.v_wawi_org_all_store_reloc_act AS store_reloc
                              ON sales.client_id     = store_reloc.client_id
                              AND sales.loc_sid_store = store_reloc.st_loc_sid
                            LEFT OUTER JOIN P_LEW_CORE_AC.v_wawi_org_store_act      AS store_act
                              ON store_reloc.client_id  = store_act.client_id
                              AND store_reloc.st_loc_sid = store_act.st_loc_sid

                          ) AS agg_lvl0
                    GROUP BY   agg_lvl0.client_id
                            , agg_lvl0.store_id
                            , agg_lvl0.dat_calendar
                            , agg_lvl0.cy_month
                            , agg_lvl0.dat_fact
                  ) AS agg_lvl1
            INNER JOIN P_LEW_CORE_AC.v_client    AS c
                ON agg_lvl1.client_id = c.client_id
            INNER JOIN P_LEW_MART_MSI.v_bo_descs AS d
                ON agg_lvl1.client_id = d.client_id
              AND agg_lvl1.store_id  = d.store_id
            WHERE agg_lvl1.dat_fact <= COALESCE(d.dat_closing_ovis, d.dat_closing, TO_DATE('31.12.9999', 'dd.mm.yyyy')) /* Buchung liegt vor Filialschließung */
              AND d.orig_store_nr   <> d.wh_id                                                                                       /* Ausschluss von Dummy-Filialen hinter denen ein WH steckt */
          ) AS agg_lvl2
    GROUP BY   agg_lvl2.client_id
              , agg_lvl2.store_id
              , agg_lvl2.cy_month
              , agg_lvl2.dat_calendar
              , agg_lvl2.orig_store_nr
              , agg_lvl2.store_desc
              , agg_lvl2.country_desc
              , agg_lvl2.country_id
              , agg_lvl2.country_iso_cd
              , agg_lvl2.city
              , agg_lvl2.wh_id
              , agg_lvl2.wh_desc
              , agg_lvl2.sales_manager_id
              , agg_lvl2.sales_manager_name
              , agg_lvl2.account_manager_id
              , agg_lvl2.account_manager_name
              , agg_lvl2.currency_iso_cd
  ) AS agg_lvl3
;
