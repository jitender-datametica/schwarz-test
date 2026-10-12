CREATE OR REPLACE VIEW FE_MSTR_MASTER.V_FACT_TURNOVER_EXT_BY_STORE_DAY
AS
WITH
cal_calc_map AS (
    SELECT
        cal_dt
      , cal_dt - DayOfWeekISO(cal_dt) + 1 + 364   + 7 AS cal_dt_calc_start_p1y
      , cal_dt - DayOfWeekISO(cal_dt)             + 7 AS cal_dt_calc_end_p1y
    FROM CORE_DIM.t_dim_calendar_date
)
, store_act_move AS (
    SELECT
        str.int_org_sid
      , str.cal_dt_opening_move
      , str.cal_dt_closing_move
      , cal_start.cal_dt_calc_start_p1y
      , Coalesce(cal_end.cal_dt_calc_end_p1y, DATE'9999-12-31') AS cal_dt_calc_end_p1y
    FROM
    (
        SELECT
            int_org_sid
          , Min(open_dt) AS cal_dt_opening_move
          , Max(CASE WHEN close_dt IS NULL THEN DATE'9999-12-31' ELSE close_dt END) AS cal_dt_closing_move
        FROM
        (
            SELECT
                int_org_sid
              , open_dt
              , Coalesce(close_dt, DATE'9999-12-31') AS close_dt
            FROM CORE_DIM.t_dim_internal_organization
            WHERE curr_int_org_nr <> '@'
              AND int_org_type_cd = 'STORE'
            QUALIFY Row_Number() OVER (PARTITION BY int_org_sid, curr_int_org_nr
                                       ORDER BY
                                           CASE WHEN dwh_valid_fg THEN 1 ELSE 2 END
                                         , dwh_valid_from_tmsp DESC) = 1
        )
        GROUP BY 1
    ) AS str
    LEFT OUTER JOIN cal_calc_map AS cal_start
    ON  str.cal_dt_opening_move = cal_start.cal_dt
    LEFT OUTER JOIN cal_calc_map AS cal_end
    ON  str.cal_dt_closing_move = cal_end.cal_dt
)
, base AS (
    SELECT
        src.bus_dt
      , src.int_org_sid
      , src.int_org_type_cd
      , src.country_org_cd
      , src.curr_cd
      , src.turnover_net_val
      , src.receipt_cnt
      , CASE WHEN src.bus_dt BETWEEN store.cal_dt_calc_start_p1y AND store.cal_dt_calc_end_p1y
                 THEN 1
                 ELSE 0
        END AS bereinigt_fg
      , CASE WHEN wk_p1y.cal_dt BETWEEN store.cal_dt_calc_start_p1y AND store.cal_dt_calc_end_p1y
                 THEN 1
                 ELSE 0
        END AS bereinigt_vjw_fg
      , CASE WHEN mt_p1y.cal_dt BETWEEN store.cal_dt_calc_start_p1y AND store.cal_dt_calc_end_p1y
                 THEN 1
                 ELSE 0
        END AS bereinigt_vjm_fg
      , CASE WHEN src.bus_dt BETWEEN Next_Day(store.cal_dt_opening_move, 'mo') AND Previous_Day(store.cal_dt_closing_move, 'su')
                 THEN 1
                 ELSE 0
        END AS bereinigt_excl_opn_cls_wk_fg
      , CASE WHEN wk_p1y.cal_dt BETWEEN Next_Day(store.cal_dt_opening_move, 'mo') AND Previous_Day(store.cal_dt_closing_move, 'su')
                 THEN 1
                 ELSE 0
        END AS bereinigt_excl_opn_cls_wk_vjw_fg
      , CASE WHEN mt_p1y.cal_dt BETWEEN Next_Day(store.cal_dt_opening_move, 'mo') AND Previous_Day(store.cal_dt_closing_move, 'su')
                 THEN 1
                 ELSE 0
        END AS bereinigt_excl_opn_cls_wk_vjm_fg
    FROM CORE_DIM.t_fact_turnover_by_store_day AS src

    LEFT OUTER JOIN store_act_move AS store
    ON  src.int_org_sid = store.int_org_sid

    LEFT OUTER JOIN CORE_REL.t_cal_date_adjusted_relationship AS wk_p1y
    ON  wk_p1y.rel_cal_dt            = src.bus_dt
    AND wk_p1y.cal_dt_adjust_type_cd = 'W'
    AND wk_p1y.bus_year_diff         = 1

    LEFT OUTER JOIN CORE_REL.t_cal_date_adjusted_relationship AS mt_p1y
    ON  mt_p1y.rel_cal_dt            = src.bus_dt
    AND mt_p1y.cal_dt_adjust_type_cd = 'MC'
    AND mt_p1y.bus_year_diff         = 1
)
, base_by AS (
    SELECT
        b.int_org_sid
      , c.bus_year
      , Min(b.bus_dt)          AS min_by_cal_dt
      , Max(y.bus_year_end_dt) AS max_by_cal_dt
    FROM base AS b
    INNER JOIN CORE_DIM.t_dim_calendar_date AS c
    ON  b.bus_dt = c.cal_dt
    INNER JOIN CORE_DIM.t_dim_business_year AS y
    ON c.bus_year = y.bus_year
    GROUP BY 1,2
)
, bytd AS (
    SELECT
        c.cal_dt AS bus_dt
      , bb.int_org_sid
      , Sum(b.turnover_net_val * b.bereinigt_fg) OVER (PARTITION BY bb.int_org_sid, bb.bus_year ORDER BY c.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS turnover_bytd_net_val
      , Sum(b.receipt_cnt      * b.bereinigt_fg) OVER (PARTITION BY bb.int_org_sid, bb.bus_year ORDER BY c.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS receipt_bytd_cnt
      , Sum(b.turnover_net_val * b.bereinigt_excl_opn_cls_wk_fg) OVER (PARTITION BY bb.int_org_sid, bb.bus_year ORDER BY c.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS turnover_ewk_bytd_net_val
      , Sum(b.receipt_cnt      * b.bereinigt_excl_opn_cls_wk_fg) OVER (PARTITION BY bb.int_org_sid, bb.bus_year ORDER BY c.cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS receipt_ewk_bytd_cnt
    FROM base_by AS bb
    INNER JOIN CORE_DIM.t_dim_calendar_date AS c
    ON  c.cal_dt BETWEEN bb.min_by_cal_dt AND bb.max_by_cal_dt
    LEFT OUTER JOIN base AS b
    ON  bb.int_org_sid = b.int_org_sid
    AND c.cal_dt       = b.bus_dt
)
, py_m AS (
    SELECT
        dr.cal_dt AS bus_dt
      , b.int_org_sid
      , Sum(b.turnover_net_val * b.bereinigt_vjm_fg) AS turnover_py_net_val
      , Sum(b.receipt_cnt      * b.bereinigt_vjm_fg) AS receipt_py_cnt
      , Sum(b.turnover_net_val * b.bereinigt_excl_opn_cls_wk_vjm_fg) AS turnover_ewk_py_net_val
      , Sum(b.receipt_cnt      * b.bereinigt_excl_opn_cls_wk_vjm_fg) AS receipt_ewk_py_cnt
    FROM base AS b
    INNER JOIN CORE_REL.t_cal_date_adjusted_relationship AS dr
    ON  b.bus_dt = dr.rel_cal_dt
    AND dr.cal_dt_adjust_type_cd IN ('M')
    AND dr.bus_year_diff = 1
    GROUP BY 1,2
)
, py_w AS (
    SELECT
        dr.cal_dt AS bus_dt
      , b.int_org_sid
      , Sum(b.turnover_net_val * b.bereinigt_vjw_fg) AS turnover_py_swday_net_val
      , Sum(b.receipt_cnt      * b.bereinigt_vjw_fg) AS receipt_py_swday_cnt
      , Sum(b.turnover_net_val * b.bereinigt_excl_opn_cls_wk_vjw_fg) AS turnover_ewk_py_swday_net_val
      , Sum(b.receipt_cnt      * b.bereinigt_excl_opn_cls_wk_vjw_fg) AS receipt_ewk_py_swday_cnt
    FROM base AS b
    INNER JOIN CORE_REL.t_cal_date_adjusted_relationship AS dr
    ON  b.bus_dt = dr.rel_cal_dt
    AND dr.cal_dt_adjust_type_cd IN ('W')
    AND dr.bus_year_diff = 1
    GROUP BY 1,2
)
, py_bytd_m AS (
    SELECT
        cal_dt AS bus_dt
      , int_org_sid
      , Sum(turnover_net_val) OVER (PARTITION BY int_org_sid, bus_year ORDER BY cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS turnover_py_bytd_net_val
      , Sum(receipt_cnt     ) OVER (PARTITION BY int_org_sid, bus_year ORDER BY cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS receipt_py_bytd_cnt
      , Sum(turnover_ewk_net_val) OVER (PARTITION BY int_org_sid, bus_year ORDER BY cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS turnover_ewk_py_bytd_net_val
      , Sum(receipt_ewk_cnt     ) OVER (PARTITION BY int_org_sid, bus_year ORDER BY cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS receipt_ewk_py_bytd_cnt
    FROM
    (
        SELECT
            c.cal_dt
          , bb.int_org_sid
          , Max(c.bus_year) AS bus_year
          , Sum(b.turnover_net_val * b.bereinigt_vjm_fg) AS turnover_net_val
          , Sum(b.receipt_cnt      * b.bereinigt_vjm_fg) AS receipt_cnt
          , Sum(b.turnover_net_val * b.bereinigt_excl_opn_cls_wk_vjm_fg) AS turnover_ewk_net_val
          , Sum(b.receipt_cnt      * b.bereinigt_excl_opn_cls_wk_vjm_fg) AS receipt_ewk_cnt
        FROM base_by AS bb
        INNER JOIN CORE_DIM.t_dim_calendar_date AS c
        ON  bb.bus_year + 1 = c.bus_year
        INNER JOIN CORE_REL.t_cal_date_adjustment_type AS dat
        ON  dat.cal_dt_adjust_type_cd IN ('MC')
        AND dat.lang_cd = 'EN'
        LEFT OUTER JOIN CORE_REL.t_cal_date_adjusted_relationship AS dr
        ON  c.cal_dt = dr.cal_dt
        AND dat.cal_dt_adjust_type_cd = dr.cal_dt_adjust_type_cd
        AND dr.bus_year_diff = 1
        LEFT OUTER JOIN base AS b
        ON  bb.int_org_sid = b.int_org_sid
        AND dr.rel_cal_dt  = b.bus_dt
        GROUP BY 1,2
    )
)
, py_bytd_w AS (
    SELECT
        cal_dt AS bus_dt
      , int_org_sid
      , Sum(turnover_net_val) OVER (PARTITION BY int_org_sid, bus_year ORDER BY cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS turnover_py_swday_bytd_net_val
      , Sum(receipt_cnt     ) OVER (PARTITION BY int_org_sid, bus_year ORDER BY cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS receipt_py_swday_bytd_cnt
      , Sum(turnover_ewk_net_val) OVER (PARTITION BY int_org_sid, bus_year ORDER BY cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS turnover_ewk_py_swday_bytd_net_val
      , Sum(receipt_ewk_cnt     ) OVER (PARTITION BY int_org_sid, bus_year ORDER BY cal_dt ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS receipt_ewk_py_swday_bytd_cnt
    FROM
    (
        SELECT
            c.cal_dt
          , bb.int_org_sid
          , Max(c.bus_year) AS bus_year
          , Sum(b.turnover_net_val * b.bereinigt_vjw_fg) AS turnover_net_val
          , Sum(b.receipt_cnt      * b.bereinigt_vjw_fg) AS receipt_cnt
          , Sum(b.turnover_net_val * b.bereinigt_excl_opn_cls_wk_vjw_fg) AS turnover_ewk_net_val
          , Sum(b.receipt_cnt      * b.bereinigt_excl_opn_cls_wk_vjw_fg) AS receipt_ewk_cnt
        FROM base_by AS bb
        INNER JOIN CORE_DIM.t_dim_calendar_date AS c
        ON  bb.bus_year + 1 = c.bus_year
        INNER JOIN CORE_REL.t_cal_date_adjustment_type AS dat
        ON  dat.cal_dt_adjust_type_cd IN ('WC')
        AND dat.lang_cd = 'EN'
        LEFT OUTER JOIN CORE_REL.t_cal_date_adjusted_relationship AS dr
        ON  c.cal_dt = dr.cal_dt
        AND dat.cal_dt_adjust_type_cd = dr.cal_dt_adjust_type_cd
        AND dr.bus_year_diff = 1
        LEFT OUTER JOIN base AS b
        ON  bb.int_org_sid = b.int_org_sid
        AND dr.rel_cal_dt  = b.bus_dt
        GROUP BY 1,2
    )
)
SELECT
    b.bus_dt      AS cal_dt
  , b.int_org_sid AS store_sid
  , b.int_org_type_cd
  , b.country_org_cd
  , fer.src_curr_cd AS curr_cd
  , Decode(fer.src_curr_cd, 'EUR', 1, 0)                    AS curr_group_fg
  , Decode(fer.src_curr_cd, fer.tgt_curr_cd, 1, 0)          AS curr_local_fg

  /*DEBUG*/
  , b.bereinigt_fg
  , b.bereinigt_vjm_fg
  , b.bereinigt_vjw_fg
  , b.bereinigt_excl_opn_cls_wk_fg
  , b.bereinigt_excl_opn_cls_wk_vjw_fg
  , b.bereinigt_excl_opn_cls_wk_vjm_fg

  , b.turnover_net_val * b.bereinigt_fg  / fer.exchange_rate AS turnover_net_val
  , bytd.turnover_bytd_net_val           / fer.exchange_rate AS turnover_bytd_net_val
  , py_m.turnover_py_net_val             / fer.exchange_rate AS turnover_py_net_val
  , pyb_m.turnover_py_bytd_net_val       / fer.exchange_rate AS turnover_py_bytd_net_val
  , py_w.turnover_py_swday_net_val       / fer.exchange_rate AS turnover_py_swday_net_val
  , pyb_w.turnover_py_swday_bytd_net_val / fer.exchange_rate AS turnover_py_swday_bytd_net_val

  , b.receipt_cnt * b.bereinigt_fg  AS receipt_cnt
  , bytd.receipt_bytd_cnt           AS receipt_bytd_cnt
  , py_m.receipt_py_cnt             AS receipt_py_cnt
  , pyb_m.receipt_py_bytd_cnt       AS receipt_py_bytd_cnt
  , py_w.receipt_py_swday_cnt       AS receipt_py_swday_cnt
  , pyb_w.receipt_py_swday_bytd_cnt AS receipt_py_swday_bytd_cnt

  , b.turnover_net_val * b.bereinigt_excl_opn_cls_wk_fg
                                             / fer.exchange_rate AS turnover_ewk_net_val
  , bytd.turnover_ewk_bytd_net_val           / fer.exchange_rate AS turnover_ewk_bytd_net_val
  , py_m.turnover_ewk_py_net_val             / fer.exchange_rate AS turnover_ewk_py_net_val
  , pyb_m.turnover_ewk_py_bytd_net_val       / fer.exchange_rate AS turnover_ewk_py_bytd_net_val
  , py_w.turnover_ewk_py_swday_net_val       / fer.exchange_rate AS turnover_ewk_py_swday_net_val
  , pyb_w.turnover_ewk_py_swday_bytd_net_val / fer.exchange_rate AS turnover_ewk_py_swday_bytd_net_val

  , b.receipt_cnt * b.bereinigt_excl_opn_cls_wk_fg  AS receipt_ewk_cnt
  , bytd.receipt_ewk_bytd_cnt                       AS receipt_ewk_bytd_cnt
  , py_m.receipt_ewk_py_cnt                         AS receipt_ewk_py_cnt
  , pyb_m.receipt_ewk_py_bytd_cnt                   AS receipt_ewk_py_bytd_cnt
  , py_w.receipt_ewk_py_swday_cnt                   AS receipt_ewk_py_swday_cnt
  , pyb_w.receipt_ewk_py_swday_bytd_cnt             AS receipt_ewk_py_swday_bytd_cnt
FROM base AS b
LEFT OUTER JOIN bytd AS bytd
ON  b.int_org_sid = bytd.int_org_sid
AND b.bus_dt      = bytd.bus_dt
LEFT OUTER JOIN py_m AS py_m
ON  b.int_org_sid = py_m.int_org_sid
AND b.bus_dt      = py_m.bus_dt
LEFT OUTER JOIN py_w AS py_w
ON  b.int_org_sid = py_w.int_org_sid
AND b.bus_dt      = py_w.bus_dt
LEFT OUTER JOIN py_bytd_m AS pyb_m
ON  b.int_org_sid = pyb_m.int_org_sid
AND b.bus_dt      = pyb_m.bus_dt
LEFT OUTER JOIN py_bytd_w AS pyb_w
ON  b.int_org_sid = pyb_w.int_org_sid
AND b.bus_dt      = pyb_w.bus_dt
INNER JOIN  CORE_DIM.t_fact_exchange_rate AS fer
ON  b.curr_cd = fer.tgt_curr_cd
AND fer.exchange_rate_type_cd = 'BEW_ISK'
AND (fer.src_curr_cd = 'EUR' OR fer.src_curr_cd = fer.tgt_curr_cd)
AND fer.active_fg = TRUE
;