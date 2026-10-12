
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_REF_WAWI_CURRENCY_RATE

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
/*
#DescStart#
#$Revision: 7106 $, $LastChangedBy: swebster $
#SubjectAreas#: Währung COEX
#DescEnd#
*/
-- Daten aus DWH2.0
SELECT DISTINCT
exrt_h.client_id AS client_id,
COALESCE(wawi_curr.currency_nr, -1) AS currency_nr,
SUBSTRING(exrt_h.curr_cd_to, 1, 3) AS currency_iso_cd,
exrt_h.active_from_dt AS dat_valid_from,
exrt_h.active_to_dt AS dat_valid_until,
CASE WHEN exrt_h.client_id = 1 AND exrt_h.curr_cd_to = 'ITL' AND exrt_h.active_from_dt = '1998-11-10' THEN CAST(1.00 AS DECIMAL(9,2))
WHEN exrt_h.client_id = 1 AND exrt_h.curr_cd_to IN ('ESP', 'ITL','PTE') AND exrt_h.active_from_dt BETWEEN TO_DATE('1998/01/01', 'YYYY/MM/DD') AND TO_DATE('1999/12/31', 'YYYY/MM/DD') THEN CAST(100.00 AS DECIMAL(9,2))
WHEN exrt_h.client_id = 1 AND exrt_h.curr_cd_to = 'GRD' AND exrt_h.active_from_dt BETWEEN TO_DATE('1998/01/01', 'YYYY/MM/DD') AND TO_DATE('1999/01/19', 'YYYY/MM/DD') THEN CAST(100.00 AS DECIMAL(9,2))
WHEN exrt_h.client_id = 12 AND exrt_h.curr_cd_to = 'GBP' AND exrt_h.active_to_dt = TO_DATE('2005-02-28', 'YYYY-MM-DD') THEN CAST(1.25 AS DECIMAL(9,2))
WHEN exrt_h.client_id = 12 AND exrt_h.curr_cd_to = 'USD' AND exrt_h.active_to_dt = TO_DATE('2005-02-28', 'YYYY-MM-DD') THEN CAST(1.57 AS DECIMAL(9,2))
WHEN exrt_h.client_id = 14 AND exrt_h.curr_cd_to = 'CHF' AND exrt_h.active_to_dt = TO_DATE('2011-03-05', 'YYYY-MM-DD') THEN CAST(100 AS DECIMAL(9,2))
WHEN exrt_h.client_id = 14 AND exrt_h.curr_cd_to = 'EUR' AND exrt_h.active_from_dt BETWEEN TO_DATE('1998/01/18', 'YYYY/MM/DD') AND TO_DATE('2000/12/27', 'YYYY/MM/DD') THEN CAST(100.00 AS DECIMAL(9,2))
WHEN exrt_h.client_id = 14 AND exrt_h.curr_cd_to = 'GBP' AND exrt_h.active_from_dt BETWEEN TO_DATE('2000/12/28', 'YYYY/MM/DD') AND TO_DATE('2001/01/01', 'YYYY/MM/DD') THEN CAST(100.00 AS DECIMAL(9,2))
WHEN exrt_h.client_id = 23 AND exrt_h.curr_cd_to = 'US$' AND exrt_h.active_from_dt BETWEEN TO_DATE('1999/11/01', 'YYYY/MM/DD') AND TO_DATE('2006/02/27', 'YYYY/MM/DD') THEN CAST(1.57 AS DECIMAL(9,2))
WHEN exrt_h.client_id = 23 AND exrt_h.curr_cd_to = 'USD' AND exrt_h.active_from_dt BETWEEN TO_DATE('1999/11/01', 'YYYY/MM/DD') AND TO_DATE('2006/02/27', 'YYYY/MM/DD') THEN CAST(1.57 AS DECIMAL(9,2))
WHEN exrt_h.client_id = 25 AND exrt_h.curr_cd_to = 'USD' AND exrt_h.active_from_dt BETWEEN TO_DATE('2013/08/19', 'YYYY/MM/DD') AND TO_DATE('2013/09/30', 'YYYY/MM/DD') THEN CAST(1.33 AS DECIMAL(9,2))
WHEN exrt_h.client_id = 25 AND exrt_h.curr_cd_to = 'USD' AND exrt_h.active_from_dt BETWEEN TO_DATE('2013/10/01', 'YYYY/MM/DD') AND TO_DATE('2014/10/14', 'YYYY/MM/DD') THEN CAST(1.30 AS DECIMAL(9,2))
ELSE CAST(1.00 AS DECIMAL(9,2)) END AS unit_currency_exchange,
exrt_h.exchange_rate AS rate_currency_exchange,
CASE WHEN exrt_h.client_id = 1 AND exrt_h.active_from_dt < '2012-04-24' THEN TO_DATE('2012-04-24', 'YYYY-MM-DD')
WHEN exrt_h.client_id = 2 AND exrt_h.active_from_dt < '2012-05-10' THEN TO_DATE('2012-05-10', 'YYYY-MM-DD')
WHEN exrt_h.client_id = 3 AND exrt_h.active_from_dt < '2012-05-03' THEN TO_DATE('2012-05-03', 'YYYY-MM-DD')
WHEN exrt_h.client_id = 4 AND exrt_h.active_from_dt < '2012-05-30' THEN TO_DATE('2012-05-30', 'YYYY-MM-DD')
WHEN exrt_h.client_id = 5 AND exrt_h.active_from_dt < '2012-06-20' THEN TO_DATE('2012-06-20', 'YYYY-MM-DD')
WHEN exrt_h.client_id = 6 AND exrt_h.active_from_dt < '2012-06-11' THEN TO_DATE('2012-06-11', 'YYYY-MM-DD')
WHEN exrt_h.client_id = 8 AND exrt_h.active_from_dt < '2012-05-30' THEN TO_DATE('2012-05-30', 'YYYY-MM-DD')
WHEN exrt_h.client_id = 10 AND exrt_h.active_from_dt < '2012-07-09' THEN TO_DATE('2012-07-09', 'YYYY-MM-DD')
WHEN exrt_h.client_id = 11 AND exrt_h.active_from_dt < '2012-05-30' THEN TO_DATE('2012-05-30', 'YYYY-MM-DD')
WHEN exrt_h.client_id = 12 AND exrt_h.active_from_dt < '2012-05-03' THEN TO_DATE('2012-05-03', 'YYYY-MM-DD')
WHEN exrt_h.client_id = 13 AND exrt_h.active_from_dt < '2012-05-10' THEN TO_DATE('2012-05-10', 'YYYY-MM-DD')
WHEN exrt_h.client_id = 14 AND exrt_h.active_from_dt < '2012-05-23' THEN TO_DATE('2012-05-23', 'YYYY-MM-DD')
WHEN exrt_h.client_id = 15 AND exrt_h.active_from_dt < '2012-05-31' THEN TO_DATE('2012-05-31', 'YYYY-MM-DD')
WHEN exrt_h.client_id = 16 AND exrt_h.active_from_dt < '2012-04-23' THEN TO_DATE('2012-04-23', 'YYYY-MM-DD')
WHEN exrt_h.client_id = 17 AND exrt_h.active_from_dt < '2012-06-14' THEN TO_DATE('2012-06-14', 'YYYY-MM-DD')
WHEN exrt_h.client_id = 18 AND exrt_h.active_from_dt < '2012-05-23' THEN TO_DATE('2012-05-23', 'YYYY-MM-DD')
WHEN exrt_h.client_id = 19 AND exrt_h.active_from_dt < '2016-03-10' THEN TO_DATE('2016-03-10', 'YYYY-MM-DD')
WHEN exrt_h.client_id = 21 AND exrt_h.active_from_dt < '2012-06-18' THEN TO_DATE('2012-06-18', 'YYYY-MM-DD')
WHEN exrt_h.client_id = 22 AND exrt_h.active_from_dt < '2012-05-31' THEN TO_DATE('2012-05-31', 'YYYY-MM-DD')
WHEN exrt_h.client_id = 24 AND exrt_h.active_from_dt < '2012-05-10' THEN TO_DATE('2012-05-10', 'YYYY-MM-DD')
WHEN exrt_h.client_id = 25 AND exrt_h.active_from_dt < '2012-03-13' THEN TO_DATE('2012-03-13', 'YYYY-MM-DD')
WHEN exrt_h.client_id = 26 AND exrt_h.active_from_dt < '2012-05-23' THEN TO_DATE('2012-05-23', 'YYYY-MM-DD')
WHEN exrt_h.client_id = 27 AND exrt_h.active_from_dt < '2012-07-03' THEN TO_DATE('2012-07-03', 'YYYY-MM-DD')
WHEN exrt_h.client_id = 28 AND exrt_h.active_from_dt < '2012-06-10' THEN TO_DATE('2012-06-10', 'YYYY-MM-DD')
WHEN exrt_h.client_id = 29 AND exrt_h.active_from_dt < '2012-05-31' THEN TO_DATE('2012-05-31', 'YYYY-MM-DD')
WHEN exrt_h.client_id = 31 AND exrt_h.active_from_dt < '2012-07-04' THEN TO_DATE('2012-07-04', 'YYYY-MM-DD')
WHEN exrt_h.client_id = 32 AND exrt_h.active_from_dt < '2012-05-30' THEN TO_DATE('2012-05-30', 'YYYY-MM-DD')
WHEN exrt_h.client_id IN (10,31) THEN exrt_h.active_from_dt +1
ELSE exrt_h.active_from_dt END AS dat_dayend 
,
exrt_h.dwh_load_id AS load_id
FROM p_lew_core_ac.v_exchange_rate_KNOWN_hist exrt_h
LEFT JOIN p_lew_core_ac.v_wawi_ref_wawi_currency_rate wawi_curr
ON exrt_h.client_id = wawi_curr.client_id
AND SUBSTRING(exrt_h.curr_cd_to, 1, 3) = wawi_curr.currency_iso_cd
-- Nur die Basis-Währung des Landes nutzen
INNER JOIN p_lew_core_ac.v_exchange_rate_type exty
-- Nur die Basis-Währung des Landes nutzen
ON exrt_h.client_id = exty.client_id
AND exrt_h.x_rate_type_sid = exty.x_rate_type_sid
AND exty.src_kurst = '@WAWI'
-- 1:1 Wechselkurse ausschliessen
-- durch Daten wie z.B. from EUR zu EUR5  werden die 1:1 Wechselkurse aber aufgebaut  (siehe alt -- build 1:1 rates for all handled countries)
-- Historische Währungen ausschliessen
WHERE exrt_h.curr_cd_from NOT IN ('ATS', 'BEF', 'CSD', 'CYP', 'DEM', 'EEK', 'ESP', 'FIM', 'FRF', 'GRD', 'IEP', 'ITL', 'LTL', 'LVL', 'MTL', 'NLG', 'PTE', 'ROL', 'SIT', 'SKK', 'TRL', 'VEB')
;
