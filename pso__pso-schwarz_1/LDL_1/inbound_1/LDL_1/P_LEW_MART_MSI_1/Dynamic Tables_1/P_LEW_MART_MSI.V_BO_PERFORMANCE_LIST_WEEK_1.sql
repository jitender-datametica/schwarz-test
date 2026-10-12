
/*
  Story      : https://jira.schwarz/browse/REP4-9791
  
  Description: Schnittstellenview Cube-Beladung BO
  Source
    P_LEW_CORE_AC
      V_CAL_CALENDARDAY_1
      V_CLIENT_1
    P_LEW_MART_MSI
      V_BO_BASE_PERFORMANCE_LIST_1
      V_BO_PERF_CAL_LIST_MTH_1
  History:
    2021-11-09  zied.nanaa_ext@mail.schwarz     Script Teradata Migration from svn://l-as616.asp.lidl.net/ddl/lew/lew_mart_msi/lew_mart_msi_v_bo_performance_list_week.sql
    2022-08-11  Marcin Malec                    Stueckleistung part 2 / SPEC0165305 - Shift forward filter for Report week to include current data week, in addition to 11 previous data weeks.
    2022-08-23  Marcin Malec                    Stueckleistung part 2 / SPEC0165308 - Adding columns sales_pieces_ber, sales_pieces_py.
  Alias:
    PY:   Previous Year
    CY:   Current Year
  Comments from the original Teradata DDL:
  Created by Jens Thole
  on 14.06.2018
  Inhalt: finale Zielstruktur der Wochenebenen-Schnittstelle der BO_PERORMANCE_LIST
  Quellen: MART_MSI:t_bo_base_performance_list_1 (alleinige Basisstruktur)
  Es erfolgt eine_1 Standardeinschränkung auf Datensätze unterhalb des jeweiligen Store-closing-Datums (Gewinnerstore).
  Relevante Measure-Values werden ermittelt.
 
  SONDERBEDINGUNGEN AUFGRUND VON ÄNDERUNGEN IM VERGLEICH ZUR ÜBERKOMMENEN ALTSTRUKTUR:
  Bereich Umsätze:
  Früher wurden Auswahlen getroffen bzgl der Frage, ob das Datum des Umsatzes
       a) im Raum zwischen den Store-Attributen (WAWI) dat_calc_start_py und dat_calc_end_py liegen
       b) bzw. in ein hinten offenes Intervall dieser Attribute fallen
       c) bzw. auch hinter das Intervall fallen - bei wegfusionierten Stores
  Die dies erfüllenden Umsatzeilen wiesen die Felder val_retail, val_retail_net,cnt_customer erneut aus - diesmal mit dem Suffix "_ber" .
  Hierbei trat der (theoretische) Fall auf, daß bei nicht gesetztem CALC_Start-Datum der Wert ausgeblendet wurde (was wohl nicht intendiert war)
  Desweiteren ergibt eine_1 Überlegung, daß wohl kaum Umsätze anfallen, wenn der Store nicht vorhanden ist bzw. in einem Status_1 vorliegt,
  der keine Aktivität ermöglicht.
  Im Umkehrschluß muß wohl ein Store mit realen Umsätzen wohl auch wirtschaftlich aktiv sein.
  Ein Test_1 ergab, daß die Auswahl keinerlei einschränkende Realwirkung entfaltet. - daher wurde sie eliminiert und damit auch die .._ber-Felder
  Für die Zielstruktur-Kompatibilität wurden die ..._ber-Felder als Duplikate der Originalfelder ausgewiesen
 
  Granularität (Gewinnerstore,
                DatenWoche (für PreviousYear um ein Jahr ins CurrentYear "shiftet")
                Reportwoche (Week-Page= Wochenauswahl nach MART_MSI:v_bo_perf_cal_list_mth_1; jede der Reportwochen inkludiert die Anzeige der 12 vorangehenden Datenwochen, sofern in der Grundgesamtheit für die Wochenebene vorgesehen)
               )
  Es findet ein Ranking der Stores innerhalb seiner Warehouse-Wochen-Gruppe_1 nach der Produktivität statt.
*/

CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_BO_PERFORMANCE_LIST_WEEK_1 COMMENT = 'Schnittstellenview Cube-Beladung BO; Performancelist DAY'
(
    client_id                        COMMENT 'DWH-Client im DWH = LIDL-Land_1 (country_1)'
  , country_desc                     COMMENT 'AUS MART_MSI.v_ref_country_act_bo_1 (letztlich aus CORE:t_wawi_ref_country_act_1 - für mehrsprachige Ländernamen)'
  , country_id                       COMMENT '= client_id'
  , country_iso_cd                   COMMENT 'AUS MART_MSI.v_ref_country_act_bo_1 (letztlich aus CORE:t_wawi_ref_country_act_1 - für mehrsprachige Ländernamen)'
  , store_id                         COMMENT 'DWHKey des Stores aus Join mit #X_LEW_BIL#.v_store_1 über #X_LEW_BIL#.v_store_relocation. angezeigt wird der GewinnerStore bei Fusionen - nicht der untergegangene OriginalStore der Fakten'
  , orig_store_nr                    COMMENT 'NaturalKey des Stores aus Join mit #X_LEW_BIL#.v_store_1 über #X_LEW_BIL#.v_store_relocation. angezeigt wird der GewinnerStore bei Fusionen - nicht der untergegangene OriginalStore der Fakten'
  , store_desc                       COMMENT 'Benutzt wird loc_name2 vor loc_name (used_store_desc) aus #X_LEW_BIL#.v_store_1 -> letztlich aus Core:t_location_1'
  , city                             COMMENT 'AUS CORE.t_address_1'
  , wh_id                            COMMENT 'NaturalKey (src_wh_id) des dem Store (Gewinnerstore! - siehe loc_sid_store) über die Hauptlieferbeziehung zugeordneten Warehouse (aus BIL:v_store_to_warehouse_lastknown_1)'
  , wh_desc                          COMMENT 'Benutzt wird loc_name2 vor loc_name (used_wh_desc) aus CORE:t_location_1 über die dem Store (Gewinnerstore! - siehe loc_sid_store) in der Hauptlieferbeziehung zugeordneten Warehouse (aus BIL:v_store_to_warehouse_lastknown_1)'
  , sales_manager_id                 COMMENT 'AUS BIL:v_location_organization_1'
  , sales_manager_name               COMMENT 'AUS BIL:v_location_organization_1'
  , account_manager_id               COMMENT 'AUS BIL:v_location_organization_1'
  , account_manager_name             COMMENT 'AUS BIL:v_location_organization_1'
  , cy_week                          COMMENT 'MART_MSI:v_bo_perf_cal_list_day_1: Woche_1 zum Fakten-Kalendertag'
  , week_page_by                     COMMENT 'Wochenseite (für Reporting): Jede Reportingwoche, klammert die 12 der RepWoche vorangehenden Datenwochen (sofern in der Grundauswahl verfügbar)'
  , currency_iso_cd                  COMMENT 'AUS CORE:v_client_1'
  , plan_val_turnover                COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.val_turnover'
  , plan_val_turnover_net            COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.val_turnover (kein Schreibfehler!)'
  , plan_val_hours                   COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.val_hours'
  , plan_val_inv_training            COMMENT 'CORE:v_wawi_ptm_plantimeday_wh.(val_inventory + val_training)'
  , val_retail_asis                  COMMENT 'CORE:v_agg_sales_store_day.val_retail'
  , val_retail_net_asis              COMMENT 'CORE:v_agg_sales_store_day.val_retail_net'
  , cnt_customer_asis                COMMENT 'CORE:v_agg_sales_store_day.cnt_customer'
  , val_retail_ber                   COMMENT 'Identisch zu Feld val_retail_asis (Siehe View-Kopfkommentar im Quelltext)'
  , val_retail_net_ber               COMMENT 'Identisch zu Feld val_retail_net_asis (Siehe View-Kopfkommentar im Quelltext)'
  , cnt_customer_ber                 COMMENT 'Identisch zu Feld cnt_customer_asis (Siehe View-Kopfkommentar im Quelltext)'
  , sales_pieces_ber                 COMMENT 'Identisch zu Feld sales_qty_asis (Siehe View-Kopfkommentar im Quelltext)'
  , val_retail_py                    COMMENT 'CORE:v_agg_sales_store_day.val_retail (Vorjahr). Über die Kalenderfunktion cal_dt_swday_prev_1y wird der jeweilige Tagesumsatz des Vorjahres ermittelt und auf den koorespondierenden AktJahr-Tag_1 verschoben'
  , val_retail_net_py                COMMENT 'CORE:v_agg_sales_store_day.val_retail_net (Vorjahr). Über die Kalenderfunktion cal_dt_swday_prev_1y wird der jeweilige Tagesumsatz des Vorjahres ermittelt und auf den koorespondierenden AktJahr-Tag_1 verschoben'
  , cnt_customer_py                  COMMENT 'CORE:v_agg_sales_store_day.cnt_customer (Vorjahr). Über die Kalenderfunktion cal_dt_swday_prev_1y wird der jeweilige Tagesumsatz des Vorjahres ermittelt und auf den koorespondierenden AktJahr-Tag_1 verschoben'
  , sales_pieces_py                  COMMENT 'CORE:v_agg_sales_store_day.sales_qty_asis (Vorjahr). Über die Kalenderfunktion cal_dt_swday_prev_1y wird der jeweilige Tagesumsatz des Vorjahres ermittelt und auf den koorespondierenden AktJahr-Tag_1 verschoben'
  , time_working_netto_std           COMMENT 'CORE:v_wawi_agg_wt_store_day_asis.time_working_netto_hrs'
  , miss_times_perf                  COMMENT 'CORE:v_wawi_agg_wt_store_day_asis.perf_rel_absence_hrs'
  , act_productivity                 COMMENT 'MART_MSI:t_bo_base_performance_list_1: Formel: val_retail / (time_working_netto_std + miss_times_perf)'
  , act_productivity_net             COMMENT 'MART_MSI:t_bo_base_performance_list_1: Formel: val_retail_net / (time_working_netto_std + miss_times_perf)'
  , diff_val_retail_pct              COMMENT 'MART_MSI:t_bo_base_performance_list_1: Formel: 100*(val_retail-plan_val_turnover) / plan_val_turnover'
  , diff_val_retail_net_pct          COMMENT 'MART_MSI:t_bo_base_performance_list_1: Formel: 100*(val_retail_net-plan_val_turnover_net) / plan_val_turnover_net (wobei aktuell plan_val_turnover=plan_val_turnover_net)'
  , diff_sales_qty_asis_pct          COMMENT 'MART_MSI:t_bo_base_performance_list_1: Formel: (sales_qty_asis        - plan_sales_pieces)      / NULLIFZERO(plan_sales_pieces     ) * 100'
  , diff_piece_perf_asis_pct         COMMENT 'MART_MSI:t_bo_base_performance_list_1: Formel: (piece_performance     - plan_piece_performance) / NULLIFZERO(plan_piece_performance) * 100'
  , diff_hours                       COMMENT 'MART_MSI:t_bo_base_performance_list_1: Formel: time_working_netto_std + miss_times_perf - plan_val_hours'
  , sales_qty_asis                   COMMENT 'Abverkaufte Stück ist'
  , plan_sales_qty                   COMMENT 'Plan Abverkaufte Stück'
  , piece_perf_asis                  COMMENT 'Plan Stückleistung ist'
  , plan_perf_piece                  COMMENT 'Plan Stückleistung ist'
  , item_price_asis                  COMMENT 'Artikelpreis Ist'
  , top_20_val_retail_productivity   COMMENT 'Warehouse-Wochensumme val_retail_asis der Ranking (Feld rnk_prod) top-20-platzierten  Stores'
  , top20_val_rtl_net_productivity   COMMENT 'Warehouse-Wochensumme val_retail_net_asis der nach Ranking (Feld rnk_net_prod) top-20-platzierten Stores'
  , top_20_time_wrk_productivity     COMMENT 'Warehouse-Wochensumme time_working_netto_std der nach Ranking (Feld rnk_prod) top-20-platzierten Stores'
  , top20_time_wrk_prod_net          COMMENT 'Warehouse-Wochensumme time_working_netto_std der nach Ranking (Feld rnk_net_prod) top-20-platzierten Stores'
  , top_20_miss_times_perf_prod      COMMENT 'Warehouse-Wochensumme miss_times_perf (Schulungsstunden) der nach Ranking (Feld rnk_prod) top-20-platzierten Stores'
  , top20_miss_times_perf_prod_net   COMMENT 'Warehouse-Wochensumme miss_times_perf (Schulungsstunden) der nach Ranking (Feld rnk_net_prod) top-20-platzierten Stores'
  , top_20_sales_qty_piece_perf      COMMENT 'T20WWS(sales_qty_asis)'
  , top_20_time_wrk_piece_perf       COMMENT 'T20WWS(time_working_netto_std)'
  , top_20_miss_times_piece_perf     COMMENT 'T20WWS(miss_times_perf)'
  , top_20_act_productivity          COMMENT 'Top20-Warehouse-Wochensumme=i.W. "T20WWS".  T20WWS(val_retail_asis) / (T20WWS(time_working_netto_std) + T20WWS(miss_times_perf))'
  , top_20_act_productivity_net      COMMENT 'T20WWS(val_retail_net_asis) / (T20WWS(time_working_netto_std) + T20WWS(miss_times_perf))'
  , top_20_piece_perf                COMMENT 'T20WWS(sales_qty_asis) / (T20WWS(time_working_netto_std) + T20WWS(miss_times_perf))'
  , rnk_prod                         COMMENT 'Ranking der Stores pro Warehouse-Woche_1 nach Produktivität (Feld act_productivity)'
  , rnk_net_prod                     COMMENT 'Ranking der Stores pro Warehouse-Woche_1 nach Netto-Produktivität (Feld act_productivity_net)'
  , rnk_piece_perf                   COMMENT 'Ranking der Stores pro Warehouse-Woche_1 nach Stückleistung (Feld piece_perf_asis)'
)

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
SELECT
    client_id
  , country_desc
  , country_id
  , country_iso_cd
  , loc_sid_store                 AS store_id
  , orig_store_nr
  , used_store_desc               AS store_desc
  , city
  , src_wh_id                     AS wh_id
  , used_wh_desc                  AS wh_desc
  , sales_manager_id
  , sales_manager_name
  , account_manager_id
  , account_manager_name
  , data_cy_week                  AS cy_week
  , week_page_by
  , curr_cd                       AS currency_iso_cd
  , plan_val_turnover
  , plan_val_turnover_net
  , plan_val_hours
  , plan_val_inv_training
  , val_retail                    AS val_retail_asis
  , val_retail_net                AS val_retail_net_asis
  , cnt_customer                  AS cnt_customer_asis
  , val_retail                    AS val_retail_ber
  , val_retail_net                AS val_retail_net_ber
  , cnt_customer                  AS cnt_customer_ber
  , sales_qty_asis                AS sales_pieces_ber
  , val_retail_py
  , val_retail_net_py
  , cnt_customer_py
  , sales_pieces_py
  , time_working_netto_std
  , miss_times_perf
  , act_productivity
  , act_productivity_net
  , diff_val_retail_pct
  , diff_val_retail_net_pct
  , diff_sales_qty_asis_pct
  , diff_piece_perf_asis_pct
  , diff_hours
  , sales_qty_asis
  , plan_sales_qty
  , piece_perf_asis
  , plan_perf_piece
  , item_price_asis
  , SUM( CASE WHEN rnk_prod       <= 20 THEN val_retail             ELSE 0 END) OVER(PARTITION BY client_id, src_wh_id, data_cy_week, week_page_by)  AS top_20_val_retail_productivity
  , SUM( CASE WHEN rnk_net_prod   <= 20 THEN val_retail_net         ELSE 0 END) OVER(PARTITION BY client_id, src_wh_id, data_cy_week, week_page_by)  AS top20_val_rtl_net_productivity
  , SUM( CASE WHEN rnk_prod       <= 20 THEN time_working_netto_std ELSE 0 END) OVER(PARTITION BY client_id, src_wh_id, data_cy_week, week_page_by)  AS top_20_time_wrk_productivity
  , SUM( CASE WHEN rnk_net_prod   <= 20 THEN time_working_netto_std ELSE 0 END) OVER(PARTITION BY client_id, src_wh_id, data_cy_week, week_page_by)  AS top20_time_wrk_prod_net
  , SUM( CASE WHEN rnk_prod       <= 20 THEN miss_times_perf        ELSE 0 END) OVER(PARTITION BY client_id, src_wh_id, data_cy_week, week_page_by)  AS top_20_miss_times_perf_prod
  , SUM( CASE WHEN rnk_net_prod   <= 20 THEN miss_times_perf        ELSE 0 END) OVER(PARTITION BY client_id, src_wh_id, data_cy_week, week_page_by)  AS top20_miss_times_perf_prod_net
  , SUM( CASE WHEN rnk_piece_perf <= 20 THEN sales_qty_asis         ELSE 0 END) OVER(PARTITION BY client_id, src_wh_id, data_cy_week, week_page_by)  AS top_20_sales_qty_piece_perf
  , SUM( CASE WHEN rnk_piece_perf <= 20 THEN time_working_netto_std ELSE 0 END) OVER(PARTITION BY client_id, src_wh_id, data_cy_week, week_page_by)  AS top_20_time_wrk_piece_perf
  , SUM( CASE WHEN rnk_piece_perf <= 20 THEN miss_times_perf        ELSE 0 END) OVER(PARTITION BY client_id, src_wh_id, data_cy_week, week_page_by)  AS top_20_miss_times_piece_perf
  , CAST(COALESCE(top_20_val_retail_productivity ,0) / NULLIFZERO(top_20_time_wrk_productivity)                                   AS DECIMAL(36,2))  AS top_20_act_productivity
  , CAST(COALESCE(top20_val_rtl_net_productivity ,0) / NULLIFZERO(top20_time_wrk_prod_net     )                                   AS DECIMAL(36,2))  AS top_20_act_productivity_net
  , CAST(COALESCE(top_20_sales_qty_piece_perf    ,0) / NULLIFZERO(top_20_time_wrk_piece_perf  )                                   AS DECIMAL(36,2))  AS top_20_piece_perf
  , rnk_prod
  , rnk_net_prod
  , rnk_piece_perf
FROM (
        SELECT    data_agg_per_week.data_cy_week
              , data_agg_per_week.data_cy_week_seq
              , data_agg_per_week.client_id
              , data_agg_per_week.loc_sid_store
              , data_agg_per_week.orig_store_nr
              , data_agg_per_week.used_store_desc
              , data_agg_per_week.src_wh_id
              , data_agg_per_week.used_wh_desc
              , data_agg_per_week.country_id
              , data_agg_per_week.country_desc
              , data_agg_per_week.country_iso_cd
              , data_agg_per_week.city
              , data_agg_per_week.sales_manager_id
              , data_agg_per_week.sales_manager_name
              , data_agg_per_week.account_manager_id
              , data_agg_per_week.account_manager_name
              , data_agg_per_week.curr_cd
              , data_agg_per_week.plan_val_turnover
              , data_agg_per_week.plan_val_turnover_net
              , data_agg_per_week.plan_val_hours
              , data_agg_per_week.plan_val_inv_training
              , data_agg_per_week.val_retail
              , data_agg_per_week.val_retail_net
              , data_agg_per_week.cnt_customer
              , data_agg_per_week.time_working_netto_std
              , data_agg_per_week.miss_times_perf
              , data_agg_per_week.sales_qty_asis
              , data_agg_per_week.avg_item_price
              , data_agg_per_week.val_retail_py
              , data_agg_per_week.val_retail_net_py
              , data_agg_per_week.cnt_customer_py
              , data_agg_per_week.sales_pieces_py
              , cal.cy_week AS week_page_by
              , (data_agg_per_week.val_retail     - data_agg_per_week.plan_val_turnover    ) / NULLIFZERO(data_agg_per_week.plan_val_turnover    ) * 100                AS diff_val_retail_pct
              , (data_agg_per_week.val_retail_net - data_agg_per_week.plan_val_turnover_net) / NULLIFZERO(data_agg_per_week.plan_val_turnover_net) * 100                AS diff_val_retail_net_pct
              , (data_agg_per_week.sales_qty_asis - data_agg_per_week.plan_sales_pieces)     / NULLIFZERO(data_agg_per_week.plan_sales_pieces     ) * 100               AS diff_sales_qty_asis_pct
              , data_agg_per_week.time_working_netto_std - data_agg_per_week.plan_val_hours                                                                             AS diff_hours
              , data_agg_per_week.plan_val_turnover      / NULLIFZERO(data_agg_per_week.plan_val_hours)                                                                 AS plan_productivity
              , data_agg_per_week.plan_val_turnover_net  / NULLIFZERO(data_agg_per_week.plan_val_hours)                                                                 AS plan_productivity_net
              , data_agg_per_week.val_retail             / NULLIFZERO(data_agg_per_week.time_working_netto_std)                                                         AS act_productivity
              , data_agg_per_week.val_retail_net         / NULLIFZERO(data_agg_per_week.time_working_netto_std)                                                         AS act_productivity_net
              , data_agg_per_week.plan_sales_pieces                                                                                                                     AS plan_sales_qty
              , data_agg_per_week.sales_qty_asis        / NULLIFZERO(data_agg_per_week.time_working_netto_std)                                                          AS piece_perf_asis
              , data_agg_per_week.plan_sales_pieces     / NULLIFZERO(data_agg_per_week.plan_val_hours)                                                                  AS plan_perf_piece
              , data_agg_per_week.avg_item_price                                                                                                                        AS item_price_asis
              , (piece_perf_asis - plan_perf_piece) / NULLIFZERO(plan_perf_piece) * 100                                                                                 AS diff_piece_perf_asis_pct
              , ROW_NUMBER () OVER (PARTITION BY data_agg_per_week.client_id, data_agg_per_week.src_wh_id, data_agg_per_week.data_cy_week, cal.cy_week ORDER BY COALESCE(act_productivity  , -9999999) DESC) AS rnk_prod
              , ROW_NUMBER () OVER (PARTITION BY data_agg_per_week.client_id, data_agg_per_week.src_wh_id, data_agg_per_week.data_cy_week, cal.cy_week ORDER BY COALESCE(act_productivity_net, -9999999) DESC) AS rnk_net_prod
              , ROW_NUMBER () OVER (PARTITION BY data_agg_per_week.client_id, data_agg_per_week.src_wh_id, data_agg_per_week.data_cy_week, cal.cy_week ORDER BY COALESCE(piece_perf_asis   , -9999999) DESC) AS rnk_piece_perf
        FROM (
                SELECT  CASE WHEN make_disjunkt.is_weekly_normal_level_row=1 THEN base.cy_week     ELSE base.py_week_shifted     END AS data_cy_week
                    , CASE WHEN make_disjunkt.is_weekly_normal_level_row=1 THEN base.cy_week_seq ELSE base.py_week_seq_shifted END AS data_cy_week_seq
                    , base.client_id
                    , base.loc_sid_store
                    , base.orig_store_nr
                    , base.used_store_desc
                    , base.src_wh_id
                    , base.used_wh_desc
                    , base.country_id
                    , base.country_desc
                    , base.country_iso_cd
                    , base.city
                    , base.sales_manager_id
                    , base.sales_manager_name
                    , base.account_manager_id
                    , base.account_manager_name
                    , base.curr_cd
                    , SUM(CASE WHEN make_disjunkt.is_weekly_normal_level_row  = 1 THEN base.plan_val_turnover      ELSE 0 END) AS plan_val_turnover
                    , SUM(CASE WHEN make_disjunkt.is_weekly_normal_level_row  = 1 THEN base.plan_val_turnover_net  ELSE 0 END) AS plan_val_turnover_net
                    , SUM(CASE WHEN make_disjunkt.is_weekly_normal_level_row  = 1 THEN base.plan_val_hours         ELSE 0 END) AS plan_val_hours
                    , SUM(CASE WHEN make_disjunkt.is_weekly_normal_level_row  = 1 THEN base.plan_val_inv_training  ELSE 0 END) AS plan_val_inv_training
                    , SUM(CASE WHEN make_disjunkt.is_weekly_normal_level_row  = 1 THEN base.plan_sales_pieces      ELSE 0 END) AS plan_sales_pieces
                    , SUM(CASE WHEN make_disjunkt.is_weekly_normal_level_row  = 1 THEN base.plan_avg_sales_price   ELSE 0 END) AS plan_avg_sales_price

                    , SUM(CASE WHEN make_disjunkt.is_weekly_normal_level_row  = 1 THEN base.val_retail             ELSE 0 END) AS val_retail
                    , SUM(CASE WHEN make_disjunkt.is_weekly_normal_level_row  = 1 THEN base.val_retail_net         ELSE 0 END) AS val_retail_net
                    , SUM(CASE WHEN make_disjunkt.is_weekly_normal_level_row  = 1 THEN base.cnt_customer           ELSE 0 END) AS cnt_customer
                    , SUM(CASE WHEN make_disjunkt.is_weekly_normal_level_row  = 1 THEN base.time_working_netto_std ELSE 0 END) AS time_working_netto_std
                    , SUM(CASE WHEN make_disjunkt.is_weekly_normal_level_row  = 1 THEN base.miss_times_perf        ELSE 0 END) AS miss_times_perf
                    , SUM(CASE WHEN make_disjunkt.is_weekly_normal_level_row  = 1 THEN base.sales_qty_asis         ELSE 0 END) AS sales_qty_asis
                    , MAX(CASE WHEN make_disjunkt.is_weekly_normal_level_row  = 1 THEN base.avg_item_price         ELSE 0 END) AS avg_item_price
                    , SUM(CASE WHEN make_disjunkt.is_weekly_pyshift_level_row = 1 THEN base.val_retail             ELSE 0 END) AS val_retail_py
                    , SUM(CASE WHEN make_disjunkt.is_weekly_pyshift_level_row = 1 THEN base.val_retail_net         ELSE 0 END) AS val_retail_net_py
                    , SUM(CASE WHEN make_disjunkt.is_weekly_pyshift_level_row = 1 THEN base.cnt_customer           ELSE 0 END) AS cnt_customer_py
                    , SUM(CASE WHEN make_disjunkt.is_weekly_pyshift_level_row = 1 THEN base.sales_qty_asis         ELSE 0 END) AS sales_pieces_py
                    , SUM(CASE WHEN make_disjunkt.is_weekly_pyshift_level_row = 1 THEN base.piece_receipt          ELSE 0 END) AS piece_receipt
                  FROM P_LEW_MART_MSI.V_BO_BASE_PERFORMANCE_LIST_1 AS base
                 INNER JOIN P_LEW_CORE_AC.V_CAL_CALENDARDAY_1     AS cal
                    ON base.cal_dt =cal.cal_dt
                 INNER JOIN (/* aufblasen von gleichzeitig eine_1 Woche_1(CY) und eine_1 Woche_1 (PY) repräsentierenden Zeilen in jeweils zwei Zeilen (erzwinge disjunktes Verhalten) */
                              SELECT ROW_NUMBER() OVER (ORDER BY client_id) AS rnum
                                   , CASE WHEN rnum=1 THEN 1 ELSE 0 END     AS is_weekly_normal_level_row
                                   , CASE WHEN rnum=1 THEN 0 ELSE 1 END     AS is_weekly_pyshift_level_row
                              FROM (SELECT client_id FROM P_LEW_CORE_AC.V_CLIENT_1 LIMIT 2) AS x
                             ) AS  make_disjunkt
                    ON make_disjunkt.is_weekly_normal_level_row     = base.is_weekly_normal_level_row
                       OR make_disjunkt.is_weekly_pyshift_level_row = base.is_weekly_pyshift_level_row
                 WHERE (base.is_weekly_normal_level_row + base.is_weekly_pyshift_level_row >  0
                        /* Stueckleistung part 2 / SPEC0165305 - include also current data week */
                        OR (data_cy_week_seq = 0 AND make_disjunkt.is_weekly_normal_level_row + make_disjunkt.is_weekly_pyshift_level_row >  0))
                   AND base.cal_dt                                                        <= base.used_closing_dt
                 GROUP BY  /*Woche_1-Wegverdichtung: */
                          data_cy_week
                      , data_cy_week_seq
                      , base.client_id
                      , base.loc_sid_store
                        /* restcols dienen nur der formalen Guppierung nach Attributen, die aber durch loc_sid_store bereits determiniert sind */
                      , base.orig_store_nr
                      , base.used_store_desc
                      , base.src_wh_id
                      , base.used_wh_desc
                      , base.country_id
                      , base.country_desc
                      , base.country_iso_cd
                      , base.city
                      , base.sales_manager_id
                      , base.sales_manager_name
                      , base.account_manager_id
                      , base.account_manager_name
                      , base.curr_cd
              ) AS data_agg_per_week
            /*
              teilcartesischer Join mit den Wochen der PerfoList-Basiswochenauswahl:
              Zu jeder Woche_1 der PerfoList-Basiswochenauswahl werden die 12 davor liegenden Daten-Wochen aus Subselect "data_agg_per_week" zugeordnet
              Oder umgekehrt: Jede Datenwoche wird jeweils einer Woche_1 der PerfoList-Basiswochenauswahl zugeordnet,
              wenn sie maximal 12 Wochen vor diese liegt, auf keinen Fall aber mit ihr identisch ist
            */
            /*
              Stueckleistung part 2 / SPEC0165305 - include also identical data week (equal to report week), shift the range one week forward
            */
            INNER JOIN P_LEW_MART_MSI.V_BO_PERF_CAL_LIST_MTH_1 AS cal
               ON data_agg_per_week.data_cy_week_seq BETWEEN cal.cy_week_seq -11 AND cal.cy_week_seq
     ) AS t2
;
