/*
  Story      : https://jira.schwarz/browse/REP4-9791
  
  Description: Schnittstellenview Cube-Beladung BO
  Source
    P_LEW_CORE_AC
      V_CAL_CALENDARDAY
      V_CLIENT
    P_LEW_MART_MSI
      V_BO_BASE_PERFORMANCE_LIST
      V_BO_PERF_CAL_LIST_MTH
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
  Quellen: MART_MSI:t_bo_base_performance_list (alleinige Basisstruktur)
  Es erfolgt eine Standardeinschränkung auf Datensätze unterhalb des jeweiligen Store-closing-Datums (Gewinnerstore).
  Relevante Measure-Values werden ermittelt.
 
  SONDERBEDINGUNGEN AUFGRUND VON ÄNDERUNGEN IM VERGLEICH ZUR ÜBERKOMMENEN ALTSTRUKTUR:
  Bereich Umsätze:
  Früher wurden Auswahlen getroffen bzgl der Frage, ob das Datum des Umsatzes
       a) im Raum zwischen den Store-Attributen (WAWI) dat_calc_start_py und dat_calc_end_py liegen
       b) bzw. in ein hinten offenes Intervall dieser Attribute fallen
       c) bzw. auch hinter das Intervall fallen - bei wegfusionierten Stores
  Die dies erfüllenden Umsatzeilen wiesen die Felder val_retail, val_retail_net,cnt_customer erneut aus - diesmal mit dem Suffix "_ber" .
  Hierbei trat der (theoretische) Fall auf, daß bei nicht gesetztem CALC_Start-Datum der Wert ausgeblendet wurde (was wohl nicht intendiert war)
  Desweiteren ergibt eine Überlegung, daß wohl kaum Umsätze anfallen, wenn der Store nicht vorhanden ist bzw. in einem Status vorliegt,
  der keine Aktivität ermöglicht.
  Im Umkehrschluß muß wohl ein Store mit realen Umsätzen wohl auch wirtschaftlich aktiv sein.
  Ein Test ergab, daß die Auswahl keinerlei einschränkende Realwirkung entfaltet. - daher wurde sie eliminiert und damit auch die .._ber-Felder
  Für die Zielstruktur-Kompatibilität wurden die ..._ber-Felder als Duplikate der Originalfelder ausgewiesen
 
  Granularität (Gewinnerstore,
                DatenWoche (für PreviousYear um ein Jahr ins CurrentYear "shiftet")
                Reportwoche (Week-Page= Wochenauswahl nach MART_MSI:v_bo_perf_cal_list_mth; jede der Reportwochen inkludiert die Anzeige der 12 vorangehenden Datenwochen, sofern in der Grundgesamtheit für die Wochenebene vorgesehen)
               )
  Es findet ein Ranking der Stores innerhalb seiner Warehouse-Wochen-Gruppe nach der Produktivität statt.
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.v_bo_performance_list_week
OPTIONS(DESCRIPTION ='SCHNITTSTELLENVIEW CUBE-BELADUNG BO; PERFORMANCELIST DAY')
AS
/* aufblasen von gleichzeitig eine Woche(CY) und eine Woche (PY) repräsentierenden Zeilen in jeweils zwei Zeilen (erzwinge disjunktes Verhalten) */
/* teilcartesischer CROSS JOIN mit den Wochen der PerfoList-Basiswochenauswahl:
              Zu jeder Woche der PerfoList-Basiswochenauswahl werden die 12 davor liegenden Daten-Wochen aus Subselect "data_agg_per_week" zugeordnet
              Oder umgekehrt: Jede Datenwoche wird jeweils einer Woche der PerfoList-Basiswochenauswahl zugeordnet,
              wenn sie maximal 12 Wochen vor diese liegt, auf keinen Fall aber mit ihr identisch ist */
/* Stueckleistung part 2 / SPEC0165305 - include also identical data week (equal to report week), shift the range one week forward */
SELECT client_id,
 country_desc,
 country_id,
 country_iso_cd,
 loc_sid_store AS store_id,
 orig_store_nr,
 used_store_desc AS store_desc,
 city,
 src_wh_id AS wh_id,
 used_wh_desc AS wh_desc,
 sales_manager_id,
 sales_manager_name,
 account_manager_id,
 account_manager_name,
 data_cy_week AS cy_week,
 week_page_by,
 curr_cd AS currency_iso_cd,
 plan_val_turnover,
 plan_val_turnover_net,
 plan_val_hours,
 plan_val_inv_training,
 val_retail AS val_retail_asis,
 val_retail_net AS val_retail_net_asis,
 cnt_customer AS cnt_customer_asis,
 val_retail AS val_retail_ber,
 val_retail_net AS val_retail_net_ber,
 cnt_customer AS cnt_customer_ber,
 sales_qty_asis AS sales_pieces_ber,
 val_retail_py,
 val_retail_net_py,
 cnt_customer_py,
 sales_pieces_py,
 time_working_netto_std,
 miss_times_perf,
 act_productivity,
 act_productivity_net,
 diff_val_retail_pct,
 diff_val_retail_net_pct,
 diff_sales_qty_asis_pct,
 diff_piece_perf_asis_pct,
 diff_hours,
 sales_qty_asis,
 plan_sales_qty,
 piece_perf_asis,
 plan_perf_piece,
 item_price_asis,
 SUM(CASE
   WHEN rnk_prod <= 20
   THEN val_retail
   ELSE 0
   END) OVER (PARTITION BY client_id, CAST(src_wh_id AS STRING), data_cy_week, CAST(week_page_by AS STRING)
  RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS top_20_val_retail_productivity,
 SUM(CASE
   WHEN rnk_net_prod <= 20
   THEN val_retail_net
   ELSE 0
   END) OVER (PARTITION BY client_id, CAST(src_wh_id AS STRING), data_cy_week, CAST(week_page_by AS STRING)
  RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS top20_val_rtl_net_productivity,
 SUM(CASE
   WHEN rnk_prod <= 20
   THEN time_working_netto_std
   ELSE 0
   END) OVER (PARTITION BY client_id, CAST(src_wh_id AS STRING), data_cy_week, CAST(week_page_by AS STRING)
  RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS top_20_time_wrk_productivity,
 SUM(CASE
   WHEN rnk_net_prod <= 20
   THEN time_working_netto_std
   ELSE 0
   END) OVER (PARTITION BY client_id, CAST(src_wh_id AS STRING), data_cy_week, CAST(week_page_by AS STRING)
  RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS top20_time_wrk_prod_net,
 SUM(CASE
   WHEN rnk_prod <= 20
   THEN miss_times_perf
   ELSE 0
   END) OVER (PARTITION BY client_id, CAST(src_wh_id AS STRING), data_cy_week, CAST(week_page_by AS STRING)
  RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS top_20_miss_times_perf_prod,
 SUM(CASE
   WHEN rnk_net_prod <= 20
   THEN miss_times_perf
   ELSE 0
   END) OVER (PARTITION BY client_id, CAST(src_wh_id AS STRING), data_cy_week, CAST(week_page_by AS STRING)
  RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS top20_miss_times_perf_prod_net,
 SUM(CASE
   WHEN rnk_piece_perf <= 20
   THEN sales_qty_asis
   ELSE 0
   END) OVER (PARTITION BY client_id, CAST(src_wh_id AS STRING), data_cy_week, CAST(week_page_by AS STRING)
  RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS top_20_sales_qty_piece_perf,
 SUM(CASE
   WHEN rnk_piece_perf <= 20
   THEN time_working_netto_std
   ELSE 0
   END) OVER (PARTITION BY client_id, CAST(src_wh_id AS STRING), data_cy_week, CAST(week_page_by AS STRING)
  RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS top_20_time_wrk_piece_perf,
 SUM(CASE
   WHEN rnk_piece_perf <= 20
   THEN miss_times_perf
   ELSE 0
   END) OVER (PARTITION BY client_id, CAST(src_wh_id AS STRING), data_cy_week, CAST(week_page_by AS STRING)
  RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS top_20_miss_times_piece_perf,
 CAST(COALESCE(SUM(CASE
      WHEN rnk_prod <= 20
      THEN val_retail
      ELSE 0
      END) OVER (PARTITION BY client_id, CAST(src_wh_id AS STRING), data_cy_week, CAST(week_page_by AS STRING)
     RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING), 0) / IF((SUM(CASE
        WHEN rnk_prod <= 20
        THEN time_working_netto_std
        ELSE 0
        END) OVER (PARTITION BY client_id, CAST(src_wh_id AS STRING), data_cy_week, CAST(week_page_by AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) = 0, NULL, SUM(CASE
      WHEN rnk_prod <= 20
      THEN time_working_netto_std
      ELSE 0
      END) OVER (PARTITION BY client_id, CAST(src_wh_id AS STRING), data_cy_week, CAST(week_page_by AS STRING)
     RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) AS BIGNUMERIC) AS top_20_act_productivity,
 CAST(COALESCE(SUM(CASE
      WHEN rnk_net_prod <= 20
      THEN val_retail_net
      ELSE 0
      END) OVER (PARTITION BY client_id, CAST(src_wh_id AS STRING), data_cy_week, CAST(week_page_by AS STRING)
     RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING), 0) / IF((SUM(CASE
        WHEN rnk_net_prod <= 20
        THEN time_working_netto_std
        ELSE 0
        END) OVER (PARTITION BY client_id, CAST(src_wh_id AS STRING), data_cy_week, CAST(week_page_by AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) = 0, NULL, SUM(CASE
      WHEN rnk_net_prod <= 20
      THEN time_working_netto_std
      ELSE 0
      END) OVER (PARTITION BY client_id, CAST(src_wh_id AS STRING), data_cy_week, CAST(week_page_by AS STRING)
     RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) AS BIGNUMERIC) AS top_20_act_productivity_net,
 CAST(COALESCE(SUM(CASE
      WHEN rnk_piece_perf <= 20
      THEN sales_qty_asis
      ELSE 0
      END) OVER (PARTITION BY client_id, CAST(src_wh_id AS STRING), data_cy_week, CAST(week_page_by AS STRING)
     RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING), 0) / IF((SUM(CASE
        WHEN rnk_piece_perf <= 20
        THEN time_working_netto_std
        ELSE 0
        END) OVER (PARTITION BY client_id, CAST(src_wh_id AS STRING), data_cy_week, CAST(week_page_by AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) = 0, NULL, SUM(CASE
      WHEN rnk_piece_perf <= 20
      THEN time_working_netto_std
      ELSE 0
      END) OVER (PARTITION BY client_id, CAST(src_wh_id AS STRING), data_cy_week, CAST(week_page_by AS STRING)
     RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) AS BIGNUMERIC) AS top_20_piece_perf,
 rnk_prod,
 rnk_net_prod,
 rnk_piece_perf
FROM (SELECT data_agg_per_week.data_cy_week,
   data_agg_per_week.data_cy_week_seq,
   data_agg_per_week.client_id,
   data_agg_per_week.loc_sid_store,
   data_agg_per_week.orig_store_nr,
   data_agg_per_week.used_store_desc,
   data_agg_per_week.src_wh_id,
   data_agg_per_week.used_wh_desc,
   data_agg_per_week.country_id,
   data_agg_per_week.country_desc,
   data_agg_per_week.country_iso_cd,
   data_agg_per_week.city,
   data_agg_per_week.sales_manager_id,
   data_agg_per_week.sales_manager_name,
   data_agg_per_week.account_manager_id,
   data_agg_per_week.account_manager_name,
   data_agg_per_week.curr_cd,
   data_agg_per_week.plan_val_turnover,
   data_agg_per_week.plan_val_turnover_net,
   data_agg_per_week.plan_val_hours,
   data_agg_per_week.plan_val_inv_training,
   data_agg_per_week.val_retail,
   data_agg_per_week.val_retail_net,
   data_agg_per_week.cnt_customer,
   data_agg_per_week.time_working_netto_std,
   data_agg_per_week.miss_times_perf,
   data_agg_per_week.sales_qty_asis,
   data_agg_per_week.avg_item_price,
   data_agg_per_week.val_retail_py,
   data_agg_per_week.val_retail_net_py,
   data_agg_per_week.cnt_customer_py,
   data_agg_per_week.sales_pieces_py,
   CAL0.cy_week AS week_page_by,
      (data_agg_per_week.val_retail - data_agg_per_week.plan_val_turnover) / IF(data_agg_per_week.plan_val_turnover = 0
      , NULL, data_agg_per_week.plan_val_turnover) * 100 AS diff_val_retail_pct,
      (data_agg_per_week.val_retail_net - data_agg_per_week.plan_val_turnover_net) / IF(data_agg_per_week.plan_val_turnover_net
        = 0, NULL, data_agg_per_week.plan_val_turnover_net) * 100 AS diff_val_retail_net_pct,
      (data_agg_per_week.sales_qty_asis - data_agg_per_week.plan_sales_pieces) / IF(data_agg_per_week.plan_sales_pieces
       = 0, NULL, data_agg_per_week.plan_sales_pieces) * 100 AS diff_sales_qty_asis_pct,
    data_agg_per_week.time_working_netto_std - data_agg_per_week.plan_val_hours AS diff_hours,
    data_agg_per_week.plan_val_turnover / IF(data_agg_per_week.plan_val_hours = 0, NULL, data_agg_per_week.plan_val_hours
     ) AS plan_productivity,
    data_agg_per_week.plan_val_turnover_net / IF(data_agg_per_week.plan_val_hours = 0, NULL, data_agg_per_week.plan_val_hours
     ) AS plan_productivity_net,
    data_agg_per_week.val_retail / IF(data_agg_per_week.time_working_netto_std = 0, NULL, data_agg_per_week.time_working_netto_std
     ) AS act_productivity,
    data_agg_per_week.val_retail_net / IF(data_agg_per_week.time_working_netto_std = 0, NULL, data_agg_per_week.time_working_netto_std
     ) AS act_productivity_net,
   data_agg_per_week.plan_sales_pieces AS plan_sales_qty,
    data_agg_per_week.sales_qty_asis / IF(data_agg_per_week.time_working_netto_std = 0, NULL, data_agg_per_week.time_working_netto_std
     ) AS piece_perf_asis,
    data_agg_per_week.plan_sales_pieces / IF(data_agg_per_week.plan_val_hours = 0, NULL, data_agg_per_week.plan_val_hours
     ) AS plan_perf_piece,
   data_agg_per_week.avg_item_price AS item_price_asis,
      (data_agg_per_week.sales_qty_asis / IF(data_agg_per_week.time_working_netto_std = 0, NULL, data_agg_per_week.time_working_netto_std
         ) - data_agg_per_week.plan_sales_pieces / IF(data_agg_per_week.plan_val_hours = 0, NULL, data_agg_per_week.plan_val_hours
         )) / IF(data_agg_per_week.plan_sales_pieces / IF(data_agg_per_week.plan_val_hours = 0, NULL, data_agg_per_week
         .plan_val_hours) = 0, NULL, data_agg_per_week.plan_sales_pieces / IF(data_agg_per_week.plan_val_hours = 0, NULL
        , data_agg_per_week.plan_val_hours)) * 100 AS diff_piece_perf_asis_pct,
   ROW_NUMBER() OVER (PARTITION BY data_agg_per_week.client_id, CAST(data_agg_per_week.src_wh_id AS STRING),
      data_agg_per_week.data_cy_week, CAST(CAL0.cy_week AS STRING) ORDER BY COALESCE(data_agg_per_week.val_retail / IF(data_agg_per_week
          .time_working_netto_std = 0, NULL, data_agg_per_week.time_working_netto_std), - 9999999) IS NULL DESC,
      COALESCE(data_agg_per_week.val_retail / IF(data_agg_per_week.time_working_netto_std = 0, NULL, data_agg_per_week.time_working_netto_std
         ), - 9999999) DESC) AS rnk_prod,
   ROW_NUMBER() OVER (PARTITION BY data_agg_per_week.client_id, CAST(data_agg_per_week.src_wh_id AS STRING),
      data_agg_per_week.data_cy_week, CAST(CAL0.cy_week AS STRING) ORDER BY COALESCE(data_agg_per_week.val_retail_net /
        IF(data_agg_per_week.time_working_netto_std = 0, NULL, data_agg_per_week.time_working_netto_std), - 9999999)
      IS NULL DESC, COALESCE(data_agg_per_week.val_retail_net / IF(data_agg_per_week.time_working_netto_std = 0, NULL,
         data_agg_per_week.time_working_netto_std), - 9999999) DESC) AS rnk_net_prod,
   ROW_NUMBER() OVER (PARTITION BY data_agg_per_week.client_id, CAST(data_agg_per_week.src_wh_id AS STRING),
      data_agg_per_week.data_cy_week, CAST(CAL0.cy_week AS STRING) ORDER BY COALESCE(data_agg_per_week.sales_qty_asis /
        IF(data_agg_per_week.time_working_netto_std = 0, NULL, data_agg_per_week.time_working_netto_std), - 9999999)
      IS NULL DESC, COALESCE(data_agg_per_week.sales_qty_asis / IF(data_agg_per_week.time_working_netto_std = 0, NULL,
         data_agg_per_week.time_working_netto_std), - 9999999) DESC) AS rnk_piece_perf
  FROM (SELECT CASE
      WHEN make_disjunkt.is_weekly_normal_level_row = 1
      THEN BASE.cy_week
      ELSE BASE.py_week_shifted
      END AS data_cy_week,
      CASE
      WHEN make_disjunkt.is_weekly_normal_level_row = 1
      THEN BASE.cy_week_seq
      ELSE BASE.py_week_seq_shifted
      END AS data_cy_week_seq,
     BASE.client_id,
     BASE.loc_sid_store,
     BASE.orig_store_nr,
     BASE.used_store_desc,
     BASE.src_wh_id,
     BASE.used_wh_desc,
     BASE.country_id,
     BASE.country_desc,
     BASE.country_iso_cd,
     BASE.city,
     BASE.sales_manager_id,
     BASE.sales_manager_name,
     BASE.account_manager_id,
     BASE.account_manager_name,
     BASE.curr_cd,
     SUM(CASE
       WHEN make_disjunkt.is_weekly_normal_level_row = 1
       THEN BASE.plan_val_turnover
       ELSE 0
       END) AS plan_val_turnover,
     SUM(CASE
       WHEN make_disjunkt.is_weekly_normal_level_row = 1
       THEN BASE.plan_val_turnover_net
       ELSE 0
       END) AS plan_val_turnover_net,
     SUM(CASE
       WHEN make_disjunkt.is_weekly_normal_level_row = 1
       THEN BASE.plan_val_hours
       ELSE 0
       END) AS plan_val_hours,
     SUM(CASE
       WHEN make_disjunkt.is_weekly_normal_level_row = 1
       THEN BASE.plan_val_inv_training
       ELSE 0
       END) AS plan_val_inv_training,
     SUM(CASE
       WHEN make_disjunkt.is_weekly_normal_level_row = 1
       THEN BASE.plan_sales_pieces
       ELSE 0
       END) AS plan_sales_pieces,
     SUM(CASE
       WHEN make_disjunkt.is_weekly_normal_level_row = 1
       THEN BASE.plan_avg_sales_price
       ELSE 0
       END) AS plan_avg_sales_price,
     SUM(CASE
       WHEN make_disjunkt.is_weekly_normal_level_row = 1
       THEN BASE.val_retail
       ELSE 0
       END) AS val_retail,
     SUM(CASE
       WHEN make_disjunkt.is_weekly_normal_level_row = 1
       THEN BASE.val_retail_net
       ELSE 0
       END) AS val_retail_net,
     SUM(CASE
       WHEN make_disjunkt.is_weekly_normal_level_row = 1
       THEN BASE.cnt_customer
       ELSE 0
       END) AS cnt_customer,
     SUM(CASE
       WHEN make_disjunkt.is_weekly_normal_level_row = 1
       THEN BASE.time_working_netto_std
       ELSE 0
       END) AS time_working_netto_std,
     SUM(CASE
       WHEN make_disjunkt.is_weekly_normal_level_row = 1
       THEN BASE.miss_times_perf
       ELSE 0
       END) AS miss_times_perf,
     SUM(CASE
       WHEN make_disjunkt.is_weekly_normal_level_row = 1
       THEN BASE.sales_qty_asis
       ELSE 0
       END) AS sales_qty_asis,
     MAX(CASE
       WHEN make_disjunkt.is_weekly_normal_level_row = 1
       THEN BASE.avg_item_price
       ELSE 0
       END) AS avg_item_price,
     SUM(CASE
       WHEN make_disjunkt.is_weekly_pyshift_level_row = 1
       THEN BASE.val_retail
       ELSE 0
       END) AS val_retail_py,
     SUM(CASE
       WHEN make_disjunkt.is_weekly_pyshift_level_row = 1
       THEN BASE.val_retail_net
       ELSE 0
       END) AS val_retail_net_py,
     SUM(CASE
       WHEN make_disjunkt.is_weekly_pyshift_level_row = 1
       THEN BASE.cnt_customer
       ELSE 0
       END) AS cnt_customer_py,
     SUM(CASE
       WHEN make_disjunkt.is_weekly_pyshift_level_row = 1
       THEN BASE.sales_qty_asis
       ELSE 0
       END) AS sales_pieces_py,
     SUM(CASE
       WHEN make_disjunkt.is_weekly_pyshift_level_row = 1
       THEN BASE.piece_receipt
       ELSE 0
       END) AS piece_receipt
    FROM ldl_p_lew_mart_msi.v_bo_base_performance_list AS BASE
     INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday AS CAL ON BASE.cal_dt = CAL.cal_dt
     INNER JOIN (SELECT ROW_NUMBER() OVER (ORDER BY client_id IS NULL, client_id) AS rnum,
        CASE
        WHEN (ROW_NUMBER() OVER (ORDER BY client_id IS NULL, client_id)) = 1
        THEN 1
        ELSE 0
        END AS is_weekly_normal_level_row,
        CASE
        WHEN (ROW_NUMBER() OVER (ORDER BY client_id IS NULL, client_id)) = 1
        THEN 0
        ELSE 1
        END AS is_weekly_pyshift_level_row
      FROM (SELECT client_id
        FROM ldl_p_lew_core_ac.v_client
        LIMIT 2) AS x) AS make_disjunkt ON BASE.is_weekly_normal_level_row = make_disjunkt.is_weekly_normal_level_row OR
       BASE.is_weekly_pyshift_level_row = make_disjunkt.is_weekly_pyshift_level_row
    WHERE (BASE.is_weekly_normal_level_row + BASE.is_weekly_pyshift_level_row > 0
        /* Stueckleistung part 2 / SPEC0165305 - include also current data week */ OR CASE
          WHEN make_disjunkt.is_weekly_normal_level_row = 1
          THEN BASE.cy_week_seq
          ELSE BASE.py_week_seq_shifted
          END = 0 AND make_disjunkt.is_weekly_normal_level_row + make_disjunkt.is_weekly_pyshift_level_row > 0)
     AND BASE.cal_dt <= BASE.used_closing_dt
    GROUP BY /* Woche-Wegverdichtung: */ data_cy_week,
     data_cy_week_seq,
     BASE.client_id,
     BASE.loc_sid_store,
     BASE.orig_store_nr,
     BASE.used_store_desc,
     BASE.src_wh_id,
     BASE.used_wh_desc,
     BASE.country_id,
     BASE.country_desc,
     BASE.country_iso_cd,
     BASE.city,
     BASE.sales_manager_id,
     BASE.sales_manager_name,
     BASE.account_manager_id,
     BASE.account_manager_name,
     BASE.curr_cd) AS data_agg_per_week
   INNER JOIN ldl_p_lew_mart_msi.v_bo_perf_cal_list_mth AS CAL0 ON data_agg_per_week.data_cy_week_seq BETWEEN CAL0.cy_week_seq
      - 11 AND CAL0.cy_week_seq) AS t2;
