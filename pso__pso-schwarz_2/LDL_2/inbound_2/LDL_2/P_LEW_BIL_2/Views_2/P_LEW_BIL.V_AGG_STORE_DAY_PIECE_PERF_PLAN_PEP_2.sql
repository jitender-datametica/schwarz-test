/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_BIL.v_agg_store_day_piece_perf_plan_pep_2
#----------------------------------------------------------------------------
# History:
#  1.0  2021-06-28    Marcin Malec          Initial
#  2.0  2021-10-04    Marcin Malec          Rebuilt to show data for one future month ahead
#  2.1  2022-05-09    Marcin Malec          Change of sales_pieces_pep logic for France
#  2.2  2022-08-08    Marcin Malec          Change of sales_pieces_pep logic for Hungary
#  2.3  2022-11-10    Marcin Malec          Stuckleistung 2, AP0152203, added column sales_pieces_pep_extrapol
#  2.4  2022-11-24    Marcin Malec          Adding sales_pieces_total_pep for Filiale Cockpit
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_BIL.v_agg_store_day_piece_perf_plan_pep_2 COMMENT = 'Stuckleistung plan pep values'
(
  client_id                COMMENT 'Client identifier'
, loc_sid_store            COMMENT 'Store identifier'
, dwh_cal_dt               COMMENT 'Record date'
, currency_iso_cd          COMMENT 'Currency code'
, avg_price_pep            COMMENT 'Average price based on last 3 months'
, sales_pieces_3_m         COMMENT 'Sales_2 pieces from last 3 months'
, sales_pieces_pep         COMMENT 'Sales_2 pieces based on pep turnover'
, sales_pieces_total_pep   COMMENT 'Sales_2 pieces total based on pep turnover'
, sales_pieces_pep_extrapol COMMENT 'Sales_2 pieces extrapolated, based on pep turnover'
, val_rtl_net_3_m          COMMENT 'Turnover based on last 3 months'
)
AS
SELECT
  quarter.client_id
, quarter.loc_sid_store
, cal.cal_dt AS dwh_cal_dt
, quarter.currency_iso_cd
, quarter.val_rtl_net_ / NULLIFZERO(quarter.sales_pieces_asis_) AS avg_price_pep
, quarter.sales_pieces_asis_ AS sales_pieces_3_m
, CASE WHEN quarter.client_id <> 12 THEN COALESCE(plan.sales_piece_qty, ((plan.turnover_net_val / quarter.exchange_rate) / NULLIFZERO(avg_price_pep)))
       ELSE plan.turnover_net_val / quarter.exchange_rate
  END AS sales_pieces_pep
, CASE WHEN quarter.client_id <> 12 THEN COALESCE(plan.sales_piece_qty, ((plan.turnover_net_val / quarter.exchange_rate) / NULLIFZERO(quarter.val_rtl_net_ / NULLIFZERO(quarter.sales_pieces_total_asis_))))
       ELSE plan.turnover_net_val / quarter.exchange_rate
  END AS sales_pieces_total_pep
, CASE WHEN quarter.client_id <> 12 THEN COALESCE(plan.sales_piece_qty, ((plan.turnover_net_val / quarter.exchange_rate) / NULLIFZERO(quarter.val_rtl_net_ / NULLIFZERO(quarter.sales_pieces_ext_))))
       ELSE plan.turnover_net_val / quarter.exchange_rate
  END AS sales_pieces_pep_extrapol
, quarter.val_rtl_net_ AS val_rtl_net
FROM P_LEW_CORE_AC.v_cal_calendarday_2 AS cal
INNER JOIN 
    (
        SELECT
          month_qry.client_id
        , month_qry.loc_sid_store
        , month_qry.cy_month
        , month_qry.currency_iso_cd
        , month_qry.exchange_rate
        , CASE WHEN cy_month <= curr_cy_month THEN
              TO_NUMBER(SUM(month_qry.val_rtl_net)       OVER(PARTITION BY month_qry.client_id, month_qry.loc_sid_store, month_qry.currency_iso_cd ORDER BY month_qry.cy_month ROWS BETWEEN 3 PRECEDING AND 1 PRECEDING), 18, 6)
          ELSE 
              TO_NUMBER(SUM(month_qry.val_rtl_net)       OVER(PARTITION BY month_qry.client_id, month_qry.loc_sid_store, month_qry.currency_iso_cd ORDER BY month_qry.cy_month ROWS BETWEEN 4 PRECEDING AND 2 PRECEDING), 18, 6)
          END AS val_rtl_net_
        , CASE WHEN cy_month <= curr_cy_month THEN
              TO_NUMBER(SUM(month_qry.sales_pieces_asis) OVER(PARTITION BY month_qry.client_id, month_qry.loc_sid_store, month_qry.currency_iso_cd ORDER BY month_qry.cy_month ROWS BETWEEN 3 PRECEDING AND 1 PRECEDING), 18, 6)
          ELSE
              TO_NUMBER(SUM(month_qry.sales_pieces_asis) OVER(PARTITION BY month_qry.client_id, month_qry.loc_sid_store, month_qry.currency_iso_cd ORDER BY month_qry.cy_month ROWS BETWEEN 4 PRECEDING AND 2 PRECEDING), 18, 6)
          END AS sales_pieces_asis_
        , CASE WHEN cy_month <= curr_cy_month THEN
              TO_NUMBER(SUM(month_qry.sales_pieces_total_asis) OVER(PARTITION BY month_qry.client_id, month_qry.loc_sid_store, month_qry.currency_iso_cd ORDER BY month_qry.cy_month ROWS BETWEEN 3 PRECEDING AND 1 PRECEDING), 18, 6)
          ELSE
              TO_NUMBER(SUM(month_qry.sales_pieces_total_asis) OVER(PARTITION BY month_qry.client_id, month_qry.loc_sid_store, month_qry.currency_iso_cd ORDER BY month_qry.cy_month ROWS BETWEEN 4 PRECEDING AND 2 PRECEDING), 18, 6)
          END AS sales_pieces_total_asis_
        , CASE WHEN cy_month <= curr_cy_month THEN
              TO_NUMBER(SUM(month_qry.sales_pieces_ext) OVER(PARTITION BY month_qry.client_id, month_qry.loc_sid_store, month_qry.currency_iso_cd ORDER BY month_qry.cy_month ROWS BETWEEN 3 PRECEDING AND 1 PRECEDING), 18, 6)
          ELSE
              TO_NUMBER(SUM(month_qry.sales_pieces_ext) OVER(PARTITION BY month_qry.client_id, month_qry.loc_sid_store, month_qry.currency_iso_cd ORDER BY month_qry.cy_month ROWS BETWEEN 4 PRECEDING AND 2 PRECEDING), 18, 6)
          END AS sales_pieces_ext_
        FROM 
        (
            SELECT   
              EXTRACT (YEAR FROM COALESCE(bil_agg.dwh_cal_dt, plan.cal_dt)) * 100 + EXTRACT (MONTH FROM COALESCE(bil_agg.dwh_cal_dt, plan.cal_dt)) AS cy_month
            , EXTRACT (YEAR FROM CURRENT_DATE) * 100 + EXTRACT (MONTH FROM CURRENT_DATE) AS curr_cy_month
            , COALESCE(bil_agg.loc_sid_store, plan.loc_sid_store) AS loc_sid_store
            , COALESCE(bil_agg.client_id, plan.client_id) AS client_id
            , b.curr_cd_from AS currency_iso_cd
            , b.exchange_rate
            , SUM(bil_agg.val_rtl_net) AS val_rtl_net
            , SUM(bil_agg.sales_pieces) AS sales_pieces_asis
            , SUM(bil_agg.sales_pieces_total) AS sales_pieces_total_asis
            , SUM(bil_agg.sales_pieces_extrapol) AS sales_pieces_ext
            FROM  P_LEW_BIL_AC.v_agg_store_day_piece_perf_2 AS bil_agg
           
            FULL OUTER JOIN P_LEW_CORE_AC.v_workingtime_plan_store_day_2 AS plan
            ON  plan.client_id     = bil_agg.client_id
            AND plan.cal_dt        = bil_agg.dwh_cal_dt
            AND plan.loc_sid_store = bil_agg.loc_sid_store

            INNER JOIN P_LEW_CORE_AC.v_exchange_rate_known_hist_2 AS b
            ON  b.client_id    = COALESCE(bil_agg.client_id, plan.client_id)
            AND (b.curr_cd_from = bil_agg.currency_iso_cd
                OR
                (bil_agg.currency_iso_cd IS NULL AND b.curr_cd_from IN (SELECT currency_iso_cd 
                                                                        FROM   P_LEW_CORE_AC.v_wawi_ref_currency_act_2 
                                                                        WHERE  client_id = b.client_id 
                                                                        AND    (currency_iso_cd = to_currency_iso_cd OR currency_iso_cd ='EUR'))))
            AND CURRENT_DATE BETWEEN b.active_from_dt AND b.active_to_dt
            AND CURRENT_DATE BETWEEN b.dwh_valid_from AND b.dwh_valid_to
            
            INNER JOIN P_LEW_CORE_AC.v_exchange_rate_type_2 AS c
            ON  c.client_id       = b.client_id
            AND c.x_rate_type_sid = b.x_rate_type_sid
            AND c.src_kurst       = '@BEWE'
     
           GROUP BY 1,2,3,4,5,6
        ) AS month_qry
    ) AS quarter
ON quarter.cy_month = cal.cy_month

LEFT OUTER JOIN P_LEW_CORE_AC.v_workingtime_plan_store_day_2 AS plan
ON  plan.cal_dt        = cal.cal_dt
AND plan.client_id     = quarter.client_id
AND plan.loc_sid_store = quarter.loc_sid_store
;
