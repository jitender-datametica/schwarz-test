-- CAST(( ((busyear * 100 + 3) - 190000)* 100 + 1) AS DATE)           AS dat_by_begin_day,

-- the current and 3 previous business years

-- CAST(((((busyear * 100 + 3) - 190000)* 100 + 1) + 10000) AS DATE)  AS dat_next_by_begin_day
 CREATE OR REPLACE TABLE
ldl_p_lew_mart_msi.v_org_store_busyear AS
SELECT busyear,
 client_id,
 store_id,
  CASE
  WHEN open_fg = 0
  THEN 0
  WHEN open_fg = 1 AND closed_fg = 0 OR closed_fg = 1 AND val_rtl_fg IS NOT NULL
  THEN 1
  ELSE 0
  END AS lead_open_store_fg
FROM (SELECT cby.busyear,
   cby.cy_by_sequence,
   LCTN.client_id,
   LCTN.store_id,
    CASE
    WHEN COALESCE(LCTN.dat_opening_ovis, DATE '9999-12-31') > CURRENT_DATE
    THEN 0
    WHEN COALESCE(LCTN.dat_opening_ovis, DATE '9999-12-31') < cby.dat_next_by_begin_day
    THEN 1
    ELSE 0
    END AS open_fg,
    CASE
    WHEN COALESCE(LCTN.dat_closing_ovis, DATE '9999-12-31') < cby.dat_by_begin_day
    THEN 1
    ELSE 0
    END AS closed_fg,
   COALESCE(ato.val_rtl, MAX(ato.val_rtl) OVER (PARTITION BY CAST(LCTN.client_id AS STRING), CAST(LCTN.store_id AS STRING)
       ORDER BY cby.busyear IS NULL, cby.busyear ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING)) AS val_rtl_fg
  FROM ldl_p_lew_mart_msi.v_org_store AS LCTN
   INNER JOIN (SELECT busyear,
     cy_by_seq AS cy_by_sequence,
     PARSE_DATE('%Y%m%d', CAST(busyear AS STRING) || '301') AS dat_by_begin_day,
     PARSE_DATE('%Y%m%d', CAST(busyear + 1 AS STRING) || '301') AS dat_next_by_begin_day
    FROM ldl_p_lew_core_ac.v_cal_busyear
    WHERE cy_by_seq BETWEEN - 3 AND 0) AS cby ON TRUE
   LEFT JOIN (SELECT CBY.byr AS busyear,
     A12.client_id,
     A12.store_id,
     SUM(A12.val_retail_asis) AS val_rtl
    FROM ldl_p_lew_mart_msi.v_agg_str_mth_ejr_txj_ww_asis AS A12
     INNER JOIN ldl_p_lew_mart_msi.v_cal_calendarday AS CAL ON A12.month_id = CAL.cy_month
     INNER JOIN ldl_p_lew_mart_msi.v_cal_busyear AS CBY ON CAL.byr = CBY.byr
       -- turnover for the current and 3 previous business years
 AND CBY.cy_by_sequence BETWEEN - 3 AND 0
    WHERE A12.currency_iso_cd = 'EUR'
    GROUP BY busyear,
     A12.client_id,
     A12.store_id) AS ato ON LCTN.client_id = ato.client_id AND LCTN.store_id = ato.store_id AND cby.busyear = ato.busyear
     
  WHERE LCTN.test_store_fg = 0 -- Keine Testfilialen
 -- Keine Testfilialen
) AS osh
WHERE cy_by_sequence BETWEEN - 2 AND 0
UNION ALL
SELECT cby.busyear,
 DS.client_id,
  DS.client_id * - 1 AS store_id_new,
 0
FROM ldl_p_lew_mart_msi.v_org_store_merge AS DS
 INNER JOIN (SELECT byr AS busyear,
   cy_by_sequence
  FROM ldl_p_lew_mart_msi.v_cal_busyear) AS cby ON TRUE
WHERE DS.client_id * - 1 < 0
 AND DS.aspect_id = 2 -- Only the current and two previous business years have be be displayed

 AND cby.cy_by_sequence BETWEEN - 2 AND 0
GROUP BY cby.busyear,
 DS.client_id,
 store_id_new;