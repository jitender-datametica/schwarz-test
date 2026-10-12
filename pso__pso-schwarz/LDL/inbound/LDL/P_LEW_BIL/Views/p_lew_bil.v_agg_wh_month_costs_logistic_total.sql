CREATE OR REPLACE VIEW p_lew_bil.v_agg_wh_month_costs_logistic_total
AS
(SELECT
  agg.client_id
, agg.cy_month
, agg.wh_id
, agg.curr_cd AS currency_iso_cd
, SUM (agg.current_year_act_val_        ) AS current_year_act_val
, SUM (agg.current_year_plan_val_    ) AS current_year_plan_val
, SUM (agg.prev_year_act_val_            ) AS prev_year_act_val
FROM (
-- Landeswährung
SELECT
  lwh.client_id
, lwh.country_cd
, lwh.wh_id
, lwh.loc_sid
, lwh.cy_month
, lwh.curr_cd
, CAST((lwh.current_year_act_val         ) AS DECIMAL(18,5))     AS current_year_act_val_
, CAST((lwh.current_year_plan_val         ) AS DECIMAL(18,5))     AS current_year_plan_val_
, CAST((lwh.prev_year_act_val             ) AS DECIMAL(18,5))        AS prev_year_act_val_
FROM p_lew_precore_ac.v_cache_metric_logistics_warehouse_month_hist AS lwh
WHERE     lwh.deleted_fg = 0
  AND Current_Date BETWEEN lwh.dwh_valid_from AND lwh.dwh_valid_to
GROUP BY 1,2,3,4,5,6,7,8,9
UNION ALL
/*
Umrechnung aller nicht EUR in EUR 
Ausnahme Kroatien (aufgrund der Kroatischen EURO Umstellung und der Anforderung KUNA Werte vorerst zu bewahren): 
in diesem Fall werden EURO Werte nach KUNA umgerechnet. 
*/
SELECT
  lwh.client_id
, lwh.country_cd
, lwh.wh_id
, lwh.loc_sid
, lwh.cy_month
, b.curr_cd_from AS curr_cd
, CAST((lwh.current_year_act_val     / b.exchange_rate    ) AS DECIMAL(18,5))     AS current_year_act_val_
, CAST((lwh.current_year_plan_val     / b.exchange_rate    ) AS DECIMAL(18,5))     AS current_year_plan_val_
, CAST((lwh.prev_year_act_val         / b.exchange_rate    ) AS DECIMAL(18,5))        AS prev_year_act_val_
FROM p_lew_precore_ac.v_cache_metric_logistics_warehouse_month_hist AS lwh
  INNER JOIN p_lew_core_ac.v_exchange_rate_known_hist AS b
    ON     b.client_id     = lwh.client_id
    AND b.curr_cd_to    = lwh.curr_cd
    AND CURRENT_DATE     BETWEEN b.active_from_dt AND b.active_to_dt
    AND CURRENT_DATE     BETWEEN b.dwh_valid_from AND b.dwh_valid_to
    AND CASE 
    	  WHEN lwh.client_id <> 15 THEN b.curr_cd_from = 'EUR'
    	  WHEN lwh.client_id = 15 THEN b.curr_cd_from = 'HRK'
        END
    AND lwh.deleted_fg = 0
  INNER JOIN p_lew_core_ac.v_exchange_rate_type AS c
    ON c.client_id             = b.client_id
    AND c.x_rate_type_sid     = b.x_rate_type_sid
    AND c.src_kurst         = '@BEWE'
WHERE  lwh.deleted_fg         = 0
  AND CURRENT_DATE BETWEEN lwh.dwh_valid_from AND lwh.dwh_valid_to
  AND CASE lwh.CLIENT_ID 
        WHEN 15 THEN lwh.curr_cd =  'EUR'
        ELSE lwh.curr_cd <> 'EUR'
      END
GROUP BY 1,2,3,4,5,6,7,8,9
) AS agg
GROUP BY client_id, cy_month, wh_id, currency_iso_cd
)
;