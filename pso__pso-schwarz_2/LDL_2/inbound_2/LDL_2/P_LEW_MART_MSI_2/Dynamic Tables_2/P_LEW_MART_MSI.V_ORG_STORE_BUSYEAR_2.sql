
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_ORG_STORE_BUSYEAR_2

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
/*
#DescStart#
#$Revision: 7108 $, $LastChangedBy: pmittler $
#SubjectAreas#: Organisationsstruktur
#DescEnd#
*/
SELECT
osh.busyear,
osh.client_id,
osh.store_id,
CASE
 WHEN osh.open_fg   = 0                                 THEN 0
 WHEN osh.open_fg   = 1 AND osh.closed_fg  = 0          THEN 1
 WHEN osh.closed_fg = 1 AND osh.val_rtl_fg IS NOT NULL  THEN 1
 ELSE 0
 END  AS lead_open_store_fg
FROM (SELECT
cby.busyear,
cby.cy_by_sequence,
lctn.client_id,
lctn.store_id,
CASE
  WHEN COALESCE(lctn.dat_opening_ovis , DATE '9999-12-31') > CURRENT_DATE              THEN 0
  WHEN COALESCE(lctn.dat_opening_ovis , DATE '9999-12-31') < cby.dat_next_by_begin_day THEN 1
  ELSE 0
 END   AS open_fg,
CASE
  WHEN COALESCE(lctn.dat_closing_ovis, DATE '9999-12-31')  < cby.dat_by_begin_day  THEN 1
  ELSE 0
 END   AS closed_fg,
COALESCE(ato.val_rtl, MAX(ato.val_rtl)  OVER(PARTITION BY  lctn.client_id, lctn.store_id ORDER BY cby.busyear
                                         ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING) )   AS val_rtl_fg
FROM p_lew_mart_msi.v_org_store_2 AS lctn
CROSS JOIN (SELECT
busyear  AS busyear,
cy_by_seq AS cy_by_sequence,
--CAST(( ((busyear * 100 + 3) - 190000)* 100 + 1) AS DATE)           AS dat_by_begin_day,
--CAST(((((busyear * 100 + 3) - 190000)* 100 + 1) + 10000) AS DATE)  AS dat_next_by_begin_day
TO_DATE(TO_CHAR(busyear)   || 0301,'YYYYMMDD') AS dat_by_begin_day,
TO_DATE(TO_CHAR(busyear+1) || 0301,'YYYYMMDD') AS dat_next_by_begin_day  
            
            
            
FROM p_lew_core_ac.v_cal_busyear_2
-- the current and 3 previous business years
WHERE
cy_by_sequence BETWEEN  (-3) AND 0
) AS cby
LEFT OUTER JOIN
(SELECT
cby.byr AS busyear,
a12.client_id,
a12.store_id,
SUM(a12.val_retail_asis)     AS val_rtl
FROM p_lew_mart_msi.v_agg_str_mth_ejr_txj_ww_asis_2    AS a12
INNER JOIN p_lew_mart_msi.v_cal_calendarday_2     AS cal
ON a12.month_id      = cal.cy_month
INNER JOIN p_lew_mart_msi.v_cal_busyear_2         AS cby
ON  cal.byr  = cby.byr
-- turnover for the current and 3 previous business years
AND cby.cy_by_sequence BETWEEN (-3) AND 0
WHERE a12.currency_iso_cd = 'EUR'
GROUP BY 1,2,3
)  AS ato
ON  lctn.client_id = ato.client_id
AND lctn.store_id  = ato.store_id
AND cby.busyear  = ato.busyear

WHERE
lctn.test_store_fg = 0  -- Keine Testfilialen
-- Keine Testfilialen
) osh
WHERE
osh.cy_by_sequence BETWEEN -2 AND 0
UNION ALL
SELECT
osh.busyear,
osh.client_id,
osh.store_id_new,
0
FROM (SELECT
cby.busyear,
client_id,
(client_id *(-1)) AS store_id_new
FROM p_lew_mart_msi.v_org_store_merge_2
AS ds
CROSS JOIN (SELECT
byr AS busyear,
cy_by_sequence
FROM p_lew_mart_msi.v_cal_busyear_2)          AS cby
 WHERE store_id_new <0
 AND aspect_id=2
 -- Only the current and two previous business years have be be displayed
 AND cy_by_sequence BETWEEN -2 AND 0
 GROUP BY 1,2,3
 ) osh
;
