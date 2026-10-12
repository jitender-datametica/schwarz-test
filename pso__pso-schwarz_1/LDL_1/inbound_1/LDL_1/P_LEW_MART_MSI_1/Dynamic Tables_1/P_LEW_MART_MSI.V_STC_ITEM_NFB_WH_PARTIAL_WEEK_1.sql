
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_STC_ITEM_NFB_WH_PARTIAL_WEEK_1

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
SELECT
COALESCE(a.client_id       , b.client_id       ) AS client_id,
COALESCE(a.wh_id           , b.wh_id           ) AS wh_id,
COALESCE(a.item_sid        , b.item_sid        ) AS item_id,
COALESCE(a.cy_week         , b.cy_week         ) AS cy_week,
COALESCE(a.cy_partial_week , b.cy_partial_week ) AS cy_partial_week,
COALESCE(a.qty_case_nfb    , 0                 ) AS qty_case_nfb_diff,
SUM(qty_case_nfb_diff) OVER (
           PARTITION BY
              COALESCE(a.client_id, b.client_id)
            , COALESCE(a.wh_id    , b.wh_id)
            , COALESCE(a.item_sid , b.item_sid)
           ORDER BY
              COALESCE(a.cy_week        , b.cy_week)
            , COALESCE(a.cy_partial_week, b.cy_partial_week)
           ROWS UNBOUNDED PRECEDING
 ) AS qty_case_nfb_continuous
FROM
(SELECT
stc.client_id,
wh.src_wh_id AS wh_id,
stc.item_sid,
cal.cy_week,
cal.cy_week_part AS cy_partial_week,
SUM(stc.delta_case_qty) AS qty_case_nfb
FROM p_lew_core_ac.v_item_wh_stock_nfb_1 AS stc
INNER JOIN p_lew_bil_ac.v_warehouse_1 AS wh
ON  wh.client_id     = stc.client_id
AND wh.loc_sid_wh    = stc.loc_sid
AND wh.dwh_actual_fg = 1
AND stc.deleted_fg = 0
INNER JOIN p_lew_core_ac.v_cal_calendarday_1 AS cal
ON  stc.delta_day_dt = cal.cal_dt
GROUP BY
  stc.client_id
, wh.src_wh_id
, stc.item_sid
, cal.cy_week
, cal.cy_week_part
) AS a
FULL OUTER JOIN
(SELECT
stc.client_id,
stc.wh_id,
stc.item_sid,
wkp.cy_week,
wkp.cy_week_part AS cy_partial_week
FROM p_lew_core_ac.v_cal_week_partial_1 AS wkp
CROSS JOIN
(SELECT
stc.client_id,
wh.src_wh_id AS wh_id,
stc.item_sid
FROM p_lew_core_ac.v_item_wh_stock_nfb_1 AS stc
INNER JOIN p_lew_bil_ac.v_warehouse_1 AS wh
ON  wh.client_id     = stc.client_id
AND wh.loc_sid_wh    = stc.loc_sid
AND wh.dwh_actual_fg = 1
GROUP BY
  stc.client_id
, wh.src_wh_id
, stc.item_sid
) AS stc
) AS b
ON  a.client_id       =  b.client_id
AND a.wh_id           =  b.wh_id
AND a.item_sid        =  b.item_sid
AND a.cy_week         =  b.cy_week
AND a.cy_partial_week =  b.cy_partial_week
;
