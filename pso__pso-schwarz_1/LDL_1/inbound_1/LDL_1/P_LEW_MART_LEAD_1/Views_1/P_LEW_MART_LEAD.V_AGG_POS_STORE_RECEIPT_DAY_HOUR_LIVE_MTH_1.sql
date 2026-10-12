create or replace view LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_MART_LEAD.V_AGG_POS_STORE_RECEIPT_DAY_HOUR_LIVE_MTH_1(
	CLIENT_ID,
	STORE_ID,
	MOVE_TO_STORE_ID,
	ASPECT_ID,
	DAT_FORMDATE,
	DAT_CALENDAR,
	RECEIPT_TMSP_HOUR,
	RECEIPT_TMSP_HALF_HOUR,
	IS_CLOSED_HOUR,
	LIDL_PLUS_FG,
	TURNOVER_RELEVANT_FG,
	IS_YEAR_SEQ,
	CNT_RECEIPT_SALES_ASIS,
	TOTAL_NET_VAL_ASIS,
	CURRENCY_ISO_CD,
	LAST_REFRESH
) as
SELECT
   agg.client_id                                   AS client_id
 , agg.loc_sid_store                               AS store_id
 , osm.loc_sid_store_move_to                       AS move_to_store_id
 , osm.aspect_id                                   AS aspect_id
 , agg.dwh_cal_dt                                  AS dat_formdate
 , CASE WHEN agg.is_year_seq = 1 THEN cal.cal_dt   ELSE agg.dwh_cal_dt END                          AS dat_calendar
 , agg.receipt_tmsp_hour                           AS receipt_tmsp_hour
 , agg.receipt_tmsp_half_hour                      AS receipt_tmsp_half_hour
 , CASE WHEN NVL(cl_hr.open_hr, HOUR(CURRENT_TIME)) > agg.receipt_tmsp_hour OR dat_calendar < CURRENT_DATE THEN 1 ELSE 0 END AS is_closed_hour
 , agg.lidl_plus_fg                                AS lidl_plus_fg
 , agg.turnover_relevant_fg                        AS turnover_relevant_fg
 , agg.is_year_seq                                 AS is_year_seq
 , agg.cnt_receipt_sales                           AS cnt_receipt_sales_asis
 , agg.total_net_val    / cry.exchange_rate        AS total_net_val_asis
 , cry.curr_cd_from                                AS currency_iso_cd
 , COALESCE(agc.last_refresh, agg.dwh_created)     AS last_refresh
FROM p_lew_bil_ac.v_agg_pos_store_receipt_day_hour_live_mth_1 AS agg


INNER JOIN p_lew_core_ac.v_exchange_rate_known_hist_1 AS cry
ON    agg.client_id       = cry.client_id
AND   CURRENT_DATE BETWEEN  cry.active_from_dt AND cry.active_to_dt
AND   CURRENT_DATE BETWEEN  cry.dwh_valid_from AND cry.dwh_valid_to


INNER JOIN p_lew_core_ac.v_exchange_rate_type_1 AS c
ON    c.client_id         = cry.client_id
AND   c.x_rate_type_sid   = cry.x_rate_type_sid
AND   c.src_kurst         = '@BEWE'


LEFT OUTER JOIN p_lew_bil_ac.v_org_store_merge_1 AS osm
ON  agg.client_id     = osm.client_id 
AND agg.loc_sid_store = osm.loc_sid_store



LEFT OUTER JOIN (
      SELECT 
        ctu.client_id
      , MAX(ctu.create_timestamp) AS last_refresh
      FROM   p_lew_process_ac.v_agc_core_table_update_1 AS ctu
      
      INNER JOIN 
       (
        SELECT 
          client_id
        , MAX(start_processing) AS start_processing 
        FROM   p_lew_process_ac.v_agc_run_log_1
        WHERE  aggregate_name  LIKE 't_agg_pos_store_receipt_day_hour_live_mth_1'
        AND    CAST(dwh_cal_dt AS DATE) >= CURRENT_DATE() - 1  
        AND    end_processing  IS NOT NULL  
        GROUP BY 1
       ) AS rlog
      ON    ctu.create_timestamp <= rlog.start_processing
      AND   ctu.client_id        = rlog.client_id
      WHERE ctu.core_table_name  = 't_pos_receiptline_live_1'
      AND   CAST(ctu.dwh_cal_dt AS DATE) = CURRENT_DATE() 
      GROUP BY 1
  ) AS agc
ON agg.client_id = agc.client_id

INNER JOIN p_lew_core_ac.v_cal_calendarday_1 AS cal
ON    agg.dwh_cal_dt = cal.cal_dt_swday_prev_1y

LEFT OUTER JOIN (
     SELECT DISTINCT
        agg.client_id
      , agg.loc_sid_store
      , agg.dwh_cal_dt
      , MAX(agg.receipt_tmsp_hour) OVER(PARTITION BY agg.client_id, cal.cal_dt) AS open_hr
     FROM p_lew_bil_ac.v_agg_pos_store_receipt_day_hour_live_1 AS agg
     INNER JOIN p_lew_core_ac.v_cal_calendarday_1 AS cal
     ON agg.dwh_cal_dt = cal.cal_dt_swday_prev_1y
) AS cl_hr
ON   agg.client_id     = cl_hr.client_id
AND  agg.loc_sid_store = cl_hr.loc_sid_store
AND  (CASE WHEN agg.is_year_seq = 1 THEN cal.cal_dt   ELSE agg.dwh_cal_dt END)    = cl_hr.dwh_cal_dt
;
