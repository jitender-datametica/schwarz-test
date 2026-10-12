CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_msi.v_ref_wawi_currency_rate_2
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT DISTINCT EXRT_H.client_id,
 COALESCE(WAWI_CURR.currency_nr, - 1) AS currency_nr,
 SUBSTR(EXRT_H.curr_cd_to, 1, 3) AS currency_iso_cd,
 EXRT_H.active_from_dt AS dat_valid_from,
 EXRT_H.active_to_dt AS dat_valid_until,
  CASE
  WHEN EXRT_H.client_id = 1 AND EXRT_H.curr_cd_to = 'ITL' AND EXRT_H.active_from_dt = DATE '1998-11-10'
  THEN 1.00
  WHEN EXRT_H.client_id = 1 AND EXRT_H.curr_cd_to IN ('ESP', 'ITL', 'PTE') AND EXRT_H.active_from_dt BETWEEN PARSE_DATE('%Y/%m/%d'
     , '1998/01/01') AND (PARSE_DATE('%Y/%m/%d', '1999/12/31'))
  THEN 100.00
  WHEN EXRT_H.client_id = 1 AND EXRT_H.curr_cd_to = 'GRD' AND EXRT_H.active_from_dt BETWEEN PARSE_DATE('%Y/%m/%d',
     '1998/01/01') AND (PARSE_DATE('%Y/%m/%d', '1999/01/19'))
  THEN 100.00
  WHEN EXRT_H.client_id = 12 AND EXRT_H.curr_cd_to = 'GBP' AND EXRT_H.active_to_dt = PARSE_DATE('%F', '2005-02-28')
  THEN 1.25
  WHEN EXRT_H.client_id = 12 AND EXRT_H.curr_cd_to = 'USD' AND EXRT_H.active_to_dt = PARSE_DATE('%F', '2005-02-28')
  THEN 1.57
  WHEN EXRT_H.client_id = 14 AND EXRT_H.curr_cd_to = 'CHF' AND EXRT_H.active_to_dt = PARSE_DATE('%F', '2011-03-05')
  THEN 100
  WHEN EXRT_H.client_id = 14 AND EXRT_H.curr_cd_to = 'EUR' AND EXRT_H.active_from_dt BETWEEN PARSE_DATE('%Y/%m/%d',
     '1998/01/18') AND (PARSE_DATE('%Y/%m/%d', '2000/12/27'))
  THEN 100.00
  WHEN EXRT_H.client_id = 14 AND EXRT_H.curr_cd_to = 'GBP' AND EXRT_H.active_from_dt BETWEEN PARSE_DATE('%Y/%m/%d',
     '2000/12/28') AND (PARSE_DATE('%Y/%m/%d', '2001/01/01'))
  THEN 100.00
  WHEN EXRT_H.client_id = 23 AND EXRT_H.curr_cd_to = 'US$' AND EXRT_H.active_from_dt BETWEEN PARSE_DATE('%Y/%m/%d',
     '1999/11/01') AND (PARSE_DATE('%Y/%m/%d', '2006/02/27'))
  THEN 1.57
  WHEN EXRT_H.client_id = 23 AND EXRT_H.curr_cd_to = 'USD' AND EXRT_H.active_from_dt BETWEEN PARSE_DATE('%Y/%m/%d',
     '1999/11/01') AND (PARSE_DATE('%Y/%m/%d', '2006/02/27'))
  THEN 1.57
  WHEN EXRT_H.client_id = 25 AND EXRT_H.curr_cd_to = 'USD' AND EXRT_H.active_from_dt BETWEEN PARSE_DATE('%Y/%m/%d',
     '2013/08/19') AND (PARSE_DATE('%Y/%m/%d', '2013/09/30'))
  THEN 1.33
  WHEN EXRT_H.client_id = 25 AND EXRT_H.curr_cd_to = 'USD' AND EXRT_H.active_from_dt BETWEEN PARSE_DATE('%Y/%m/%d',
     '2013/10/01') AND (PARSE_DATE('%Y/%m/%d', '2014/10/14'))
  THEN 1.30
  ELSE 1.00
  END AS unit_currency_exchange,
 EXRT_H.exchange_rate AS rate_currency_exchange,
  CASE
  WHEN EXRT_H.client_id = 1 AND EXRT_H.active_from_dt < DATE '2012-04-24'
  THEN PARSE_DATE('%F', '2012-04-24')
  WHEN EXRT_H.client_id = 2 AND EXRT_H.active_from_dt < DATE '2012-05-10'
  THEN PARSE_DATE('%F', '2012-05-10')
  WHEN EXRT_H.client_id = 3 AND EXRT_H.active_from_dt < DATE '2012-05-03'
  THEN PARSE_DATE('%F', '2012-05-03')
  WHEN EXRT_H.client_id = 4 AND EXRT_H.active_from_dt < DATE '2012-05-30'
  THEN PARSE_DATE('%F', '2012-05-30')
  WHEN EXRT_H.client_id = 5 AND EXRT_H.active_from_dt < DATE '2012-06-20'
  THEN PARSE_DATE('%F', '2012-06-20')
  WHEN EXRT_H.client_id = 6 AND EXRT_H.active_from_dt < DATE '2012-06-11'
  THEN PARSE_DATE('%F', '2012-06-11')
  WHEN EXRT_H.client_id = 8 AND EXRT_H.active_from_dt < DATE '2012-05-30'
  THEN PARSE_DATE('%F', '2012-05-30')
  WHEN EXRT_H.client_id = 10 AND EXRT_H.active_from_dt < DATE '2012-07-09'
  THEN PARSE_DATE('%F', '2012-07-09')
  WHEN EXRT_H.client_id = 11 AND EXRT_H.active_from_dt < DATE '2012-05-30'
  THEN PARSE_DATE('%F', '2012-05-30')
  WHEN EXRT_H.client_id = 12 AND EXRT_H.active_from_dt < DATE '2012-05-03'
  THEN PARSE_DATE('%F', '2012-05-03')
  WHEN EXRT_H.client_id = 13 AND EXRT_H.active_from_dt < DATE '2012-05-10'
  THEN PARSE_DATE('%F', '2012-05-10')
  WHEN EXRT_H.client_id = 14 AND EXRT_H.active_from_dt < DATE '2012-05-23'
  THEN PARSE_DATE('%F', '2012-05-23')
  WHEN EXRT_H.client_id = 15 AND EXRT_H.active_from_dt < DATE '2012-05-31'
  THEN PARSE_DATE('%F', '2012-05-31')
  WHEN EXRT_H.client_id = 16 AND EXRT_H.active_from_dt < DATE '2012-04-23'
  THEN PARSE_DATE('%F', '2012-04-23')
  WHEN EXRT_H.client_id = 17 AND EXRT_H.active_from_dt < DATE '2012-06-14'
  THEN PARSE_DATE('%F', '2012-06-14')
  WHEN EXRT_H.client_id = 18 AND EXRT_H.active_from_dt < DATE '2012-05-23'
  THEN PARSE_DATE('%F', '2012-05-23')
  WHEN EXRT_H.client_id = 19 AND EXRT_H.active_from_dt < DATE '2016-03-10'
  THEN PARSE_DATE('%F', '2016-03-10')
  WHEN EXRT_H.client_id = 21 AND EXRT_H.active_from_dt < DATE '2012-06-18'
  THEN PARSE_DATE('%F', '2012-06-18')
  WHEN EXRT_H.client_id = 22 AND EXRT_H.active_from_dt < DATE '2012-05-31'
  THEN PARSE_DATE('%F', '2012-05-31')
  WHEN EXRT_H.client_id = 24 AND EXRT_H.active_from_dt < DATE '2012-05-10'
  THEN PARSE_DATE('%F', '2012-05-10')
  WHEN EXRT_H.client_id = 25 AND EXRT_H.active_from_dt < DATE '2012-03-13'
  THEN PARSE_DATE('%F', '2012-03-13')
  WHEN EXRT_H.client_id = 26 AND EXRT_H.active_from_dt < DATE '2012-05-23'
  THEN PARSE_DATE('%F', '2012-05-23')
  WHEN EXRT_H.client_id = 27 AND EXRT_H.active_from_dt < DATE '2012-07-03'
  THEN PARSE_DATE('%F', '2012-07-03')
  WHEN EXRT_H.client_id = 28 AND EXRT_H.active_from_dt < DATE '2012-06-10'
  THEN PARSE_DATE('%F', '2012-06-10')
  WHEN EXRT_H.client_id = 29 AND EXRT_H.active_from_dt < DATE '2012-05-31'
  THEN PARSE_DATE('%F', '2012-05-31')
  WHEN EXRT_H.client_id = 31 AND EXRT_H.active_from_dt < DATE '2012-07-04'
  THEN PARSE_DATE('%F', '2012-07-04')
  WHEN EXRT_H.client_id = 32 AND EXRT_H.active_from_dt < DATE '2012-05-30'
  THEN PARSE_DATE('%F', '2012-05-30')
  WHEN EXRT_H.client_id IN (10, 31)
  THEN DATE_ADD(EXRT_H.active_from_dt, INTERVAL 1 DAY)
  ELSE EXRT_H.active_from_dt
  END AS dat_dayend,
 EXRT_H.dwh_load_id AS load_id
FROM ldl_p_lew_core_ac.v_exchange_rate_known_hist_2 AS EXRT_H
 LEFT JOIN ldl_p_lew_core_ac.v_wawi_ref_wawi_currency_rate_2 AS WAWI_CURR ON EXRT_H.client_id = WAWI_CURR.client_id AND
   SUBSTR(EXRT_H.curr_cd_to, 1, 3) = WAWI_CURR.currency_iso_cd
 INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_type_2 AS EXTY ON EXRT_H.client_id = EXTY.client_id AND EXRT_H.x_rate_type_sid
     = EXTY.x_rate_type_sid AND EXTY.src_kurst = '@WAWI'
WHERE EXRT_H.curr_cd_from NOT IN ('ATS', 'BEF', 'CSD', 'CYP', 'DEM', 'EEK', 'ESP', 'FIM', 'FRF', 'GRD', 'IEP', 'ITL',
   'LTL', 'LVL', 'MTL', 'NLG', 'PTE', 'ROL', 'SIT', 'SKK', 'TRL', 'VEB');