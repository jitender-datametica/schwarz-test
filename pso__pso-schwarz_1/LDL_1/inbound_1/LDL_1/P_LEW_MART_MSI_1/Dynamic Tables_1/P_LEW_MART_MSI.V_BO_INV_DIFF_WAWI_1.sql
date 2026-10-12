
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_BO_INV_DIFF_WAWI_1

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI


AS
SELECT
act.client_id,
ctry.country_name         AS country_desc,
ctry.country_sid             AS country_id,
ctry.src_country_lidl_cd     AS country_iso_cd,
act.store_id,
osa.src_orig_store_nr AS orig_store_nr,
COALESCE(osa.loc_name, osa.loc_name2) AS store_desc,
adr.city AS city --osc.city
,
act.wh_id,
COALESCE(owh.loc_name, owh.loc_name2) AS wh_desc,
COALESCE(mgr_infos.sales_manager_id, -100)                         AS sales_manager_id,
COALESCE(mgr_infos.sales_manager_name, 'Bezirksleiter')         AS sales_manager_name,
COALESCE(mgr_infos.account_manager_id, -1)                      AS account_manager_id,
COALESCE(mgr_infos.account_manager_name, 'Vertriebsleiter')     AS account_manager_name,
act.inv_id,
act.cy_month,
act.busyear,
act.dat_formdate,
act.dat_valid_from,
act.dat_valid_until,
act.currency_iso_cd,
act.day_cnt,
act.diff_inv,
act.diff_net_inv,
 act.diff_inv / CASE WHEN act.day_cnt = 0 THEN NULL ELSE act.day_cnt END avg_diff_per_day,
   act.val_retail,
   act.val_retail_net,
   act.val_retail_cum_byr,
   act.val_retail_net_cum_byr,
   CAST(COALESCE(act.diff_inv    / CASE WHEN act.val_retail = 0 THEN NULL ELSE act.val_retail END,0) * 100                        AS DECIMAL (36,4)) inv_diff_to_val_rtl_pct,
   CAST(COALESCE(act.diff_net_inv    / CASE WHEN act.val_retail_net = 0 THEN NULL ELSE act.val_retail_net END,0) * 100                AS DECIMAL (36,4)) inv_diff_to_val_rtl_net_pct,
   act.diff_busyear_cum,
   act.diff_net_busyear_cum,
   act.diff_busyear_cum / CASE WHEN act.day_cnt_cum_byr = 0 THEN NULL ELSE act.day_cnt_cum_byr END avg_diff_per_day_cum,
   CAST(act.diff_busyear_cum    / CASE WHEN act.val_retail_cum_byr = 0 THEN NULL ELSE act.val_retail_cum_byr END * 100                    AS DECIMAL (36,4)) inv_diff_pct_cum,
   CAST(act.diff_net_busyear_cum / CASE WHEN act.val_retail_net_cum_byr = 0 THEN NULL ELSE act.val_retail_net_cum_byr END * 100               AS DECIMAL (36,4)) inv_diff_net_pct_cum,
   CAST(py.diff_busyear_cum    / CASE WHEN py.val_retail_cum_byr = 0 THEN NULL ELSE py.val_retail_cum_byr END * 100                      AS DECIMAL (36,4)) inv_diff_pct_cum_py,
   CAST(py.diff_net_busyear_cum    / CASE WHEN py.val_retail_net_cum_byr = 0 THEN NULL ELSE py.val_retail_net_cum_byr END * 100              AS DECIMAL (36,4)) inv_diff_net_pct_cum_py,
act.day_cnt_cum_byr,
inv_diff_pct_cum - inv_diff_pct_cum_py                                                        AS diff_inv_diff_pct_cum_act_py,
inv_diff_net_pct_cum - inv_diff_net_pct_cum_py                                                AS diff_inv_diff_net_pct_cum_py,
top_20.inv_diff_top_20                                                                        AS top20_inv_diff_to_val_rtl_pct,
top_20.inv_diff_top_20_net                                                                    AS top20_inv_dif_val_rtl_net_pct
FROM
(
-- Berechnung der aufgelaufenen Inventurdaten seit Beginn GJ
SELECT
a.client_id,
a.st_loc_sid  AS store_id,
tos.src_wh_id AS wh_id,
tos.loc_sid_wh,
a.inv_id,
b.cy_month,
c.busyear,
a.dat_formdate,
a.dat_valid_from,
a.dat_valid_until,
a.dat_valid_until - a.dat_valid_from + 1 AS day_cnt,
SUM(day_cnt) OVER (PARTITION BY a.client_id, a.st_loc_sid, c.busyear ORDER BY dat_valid_until ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)  day_cnt_cum_byr,
a.val_retail_store_inv_stc val_retail,
a.val_retail_store_net_inv_stc val_retail_net,
a.val_retail_busyear val_retail_cum_byr,
a.val_retail_net_busyear val_retail_net_cum_byr,
a.diff_inv,
a.diff_net_inv,
a.diff_busyear_cum,
a.diff_net_busyear_cum,
cry.curr_cd AS currency_iso_cd
FROM p_lew_core_ac.v_wawi_inv_store_1 AS a
JOIN p_lew_core_ac.v_cal_month_1 AS b
  
  
--ON b.cy_month = CAST(CAST(CAST(EXTRACT(YEAR FROM a.dat_valid_until ) AS INTEGER FORMAT '9999') AS CHAR(4)) !! CAST(CAST(EXTRACT(MONTH FROM a.dat_valid_until ) AS INTEGER FORMAT '99') AS CHAR(2)) AS INTEGER)
ON b.cy_month = TO_NUMBER(CONCAT(TO_CHAR(EXTRACT(YEAR FROM a.dat_valid_until),'0000'),TRIM(TO_CHAR(EXTRACT(MONTH FROM a.dat_valid_until),'00'))))  
  
  
JOIN p_lew_bil_ac.v_store_to_warehouse_lastknown_1 AS tos
ON a.client_id = tos.client_id
AND a.st_loc_sid = tos.loc_sid_store
JOIN p_lew_core_ac.v_cal_busyear_1 AS c
ON b.busyear = c.busyear
INNER JOIN p_lew_core_ac.v_client_1 AS cry
ON  a.client_id = cry.client_id
WHERE c.cy_by_seq IN (0,-1)
AND a.inv_fg = 71 -- inv_fg = 71 Vollinventuren
AND a.status_inv = 1
) act
JOIN p_lew_bil_ac.v_store_1 AS osa
ON act.client_id = osa.client_id
AND act.store_id = osa.loc_sid_store
AND osa.dwh_actual_fg = 1
AND osa.deleted_fg = 0
AND osa.test_store_fg = 0
JOIN p_lew_core_ac.v_address_1 AS adr
ON act.client_id = adr.client_id
AND osa.addr_sid = adr.addr_sid
JOIN p_lew_bil_ac.v_warehouse_1 AS owh
/*JOIN p_lew_bil_ac.v_warehouse_1 AS owh */
ON act.client_id = owh.client_id
AND act.wh_id = owh.src_wh_id
AND owh.dwh_actual_fg = 1
AND owh.bges_active_fg = 1
AND owh.deleted_fg = 0
LEFT OUTER JOIN
(
-- Berechnung der aufgelaufenen Inventurdaten seit Beginn GJ
SELECT
a.client_id,
a.st_loc_sid  AS store_id,
tos.src_wh_id AS wh_id,
a.inv_id,
b.cy_month,
c.busyear,
a.dat_formdate,
a.dat_valid_from,
a.dat_valid_until,
a.dat_valid_until - a.dat_valid_from + 1 AS day_cnt,
SUM(day_cnt) OVER (PARTITION BY a.client_id, a.st_loc_sid, c.busyear ORDER BY dat_valid_until ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)  day_cnt_cum_byr,
a.val_retail_store_inv_stc val_retail,
a.val_retail_store_net_inv_stc val_retail_net,
a.val_retail_busyear val_retail_cum_byr,
a.val_retail_net_busyear val_retail_net_cum_byr,
a.diff_inv,
a.diff_net_inv,
a.diff_busyear_cum,
a.diff_net_busyear_cum,
cry.curr_cd AS currency_iso_cd
FROM p_lew_core_ac.v_wawi_inv_store_1 AS a
JOIN p_lew_core_ac.v_cal_month_1 AS b
  
--ON b.cy_month = CAST(CAST(CAST(EXTRACT(YEAR FROM a.dat_valid_until ) AS INTEGER FORMAT '9999') AS CHAR(4)) !! CAST(CAST(EXTRACT(MONTH FROM a.dat_valid_until ) AS INTEGER FORMAT '99') AS CHAR(2)) AS INTEGER)
ON b.cy_month = TO_NUMBER(CONCAT(TO_CHAR(EXTRACT(YEAR FROM a.dat_valid_until),'0000'),TRIM(TO_CHAR(EXTRACT(MONTH FROM a.dat_valid_until),'00')))) 
  
JOIN p_lew_bil_ac.v_store_to_warehouse_lastknown_1 AS tos
ON a.client_id = tos.client_id
AND a.st_loc_sid = tos.loc_sid_store
JOIN p_lew_core_ac.v_cal_busyear_1 AS c
ON b.busyear = c.busyear
INNER JOIN p_lew_core_ac.v_client_1 AS cry
ON  a.client_id = cry.client_id
WHERE c.cy_by_seq IN (-1,-2)
AND a.inv_fg = 71 -- 71: Vollinventur
AND a.status_inv = 1
) py
 ON act.client_id = py.client_id
 AND act.store_id = py.store_id
 AND act.busyear -1 = py.busyear
 AND ADD_MONTHS(act.dat_valid_until +1 , -12) > py.dat_valid_until
LEFT OUTER JOIN
(
-- Berechnung der aufgelaufenen Inventurdaten für die Top20-Filialen seit Beginn GJ
-- es muss keinen Wert geben, deswegen LEFT JOIN
SELECT
client_id,
busyear,
wh_id,
dat_valid_until,
CAST(AVG(CAST(diff_busyear_cum AS DECIMAL(36,10))) / AVG((CAST(val_retail_cum_byr AS DECIMAL(36,10)))) * 100 AS DECIMAL(36,10)) inv_diff_top_20,
CAST(AVG(CAST(diff_net_busyear_cum AS DECIMAL(36,10))) / AVG(CASE WHEN CAST(val_retail_net_cum_byr AS DECIMAL(36,10)) = 0 THEN NULL ELSE CAST(val_retail_net_cum_byr AS DECIMAL(36,10)) END) * 100 AS DECIMAL(36,10)) inv_diff_top_20_net,
COUNT (*) CNT
FROM (SELECT
client_id,
store_id,
busyear,
wh_id,
dat_valid_until,
diff_busyear_cum,
diff_net_busyear_cum,
val_retail_cum_byr,
val_retail_net_cum_byr
FROM (SELECT
all_comb.client_id,
act.store_id,
all_comb.busyear,
all_comb.wh_id,
all_comb.dat_valid_until,
act.diff_busyear_cum,
act.diff_net_busyear_cum,
act.val_retail_cum_byr,
act.val_retail_net_cum_byr,
act.inv_diff
FROM
(
-- Berechnung der aufgelaufenen Inventurdaten seit Beginn GJ
SELECT
a.client_id,
a.st_loc_sid  AS store_id,
tos.src_wh_id AS wh_id,
a.inv_id,
b.cy_month,
c.busyear,
a.dat_formdate,
a.dat_valid_from,
a.dat_valid_until,
a.val_retail_busyear AS val_retail_cum_byr,
a.val_retail_net_busyear AS val_retail_net_cum_byr,
a.diff_busyear_cum,
a.diff_net_busyear_cum,
CAST(a.diff_busyear_cum AS DECIMAL(36,10)) / (val_retail_cum_byr) inv_diff
FROM p_lew_core_ac.v_wawi_inv_store_1 AS a
JOIN p_lew_core_ac.v_cal_month_1 AS b
--ON b.cy_month = CAST(CAST(CAST(EXTRACT(YEAR FROM a.dat_valid_until ) AS INTEGER FORMAT '9999') AS CHAR(4)) !! CAST(CAST(EXTRACT(MONTH FROM a.dat_valid_until ) AS INTEGER FORMAT '99') AS CHAR(2)) AS INTEGER)
  
ON b.cy_month = TO_NUMBER(CONCAT(TO_CHAR(EXTRACT(YEAR FROM a.dat_valid_until),'0000'),TRIM(TO_CHAR(EXTRACT(MONTH FROM a.dat_valid_until),'00')))) 
JOIN p_lew_bil_ac.v_store_to_warehouse_lastknown_1  AS tos
ON a.client_id = tos.client_id
AND a.st_loc_sid = tos.loc_sid_store
JOIN p_lew_core_ac.v_cal_busyear_1 AS c
ON b.busyear = c.busyear
INNER JOIN p_lew_core_ac.v_client_1 AS cry
ON  a.client_id = cry.client_id
WHERE c.cy_by_seq IN (0,-1)
AND val_retail_cum_byr <> 0
AND a.inv_fg = 71 -- inv_fg = 71 Vollinventuren
AND a.status_inv = 1
) AS act
INNER JOIN
(
-- alle client_id, wh, dat_valid_until Kombinationen
SELECT
a.client_id,
tos.src_wh_id AS wh_id,
b.busyear,
a.dat_valid_until
FROM p_lew_core_ac.v_wawi_inv_store_1 AS a
JOIN p_lew_core_ac.v_cal_month_1 AS b
--ON b.cy_month = CAST(CAST(CAST(EXTRACT(YEAR FROM a.dat_valid_until ) AS INTEGER FORMAT '9999') AS CHAR(4)) !! CAST(CAST(EXTRACT(MONTH FROM a.dat_valid_until ) AS INTEGER FORMAT '99') AS CHAR(2)) AS INTEGER)
  ON b.cy_month = TO_NUMBER(CONCAT(TO_CHAR(EXTRACT(YEAR FROM a.dat_valid_until),'0000'),TRIM(TO_CHAR(EXTRACT(MONTH FROM a.dat_valid_until),'00')))) 
  
JOIN p_lew_bil_ac.v_store_to_warehouse_lastknown_1 AS tos
ON a.client_id = tos.client_id
AND a.st_loc_sid = tos.loc_sid_store
JOIN p_lew_core_ac.v_cal_busyear_1 AS c
ON b.busyear = c.busyear
WHERE c.cy_by_seq IN (0,-1)
AND a.inv_fg = 71  -- 71: Vollinventuren
AND a.status_inv = 1
GROUP BY
a.client_id
, wh_id
, b.busyear
, a.dat_valid_until
) AS all_comb
ON act.client_id = all_comb.client_id
AND act.wh_id = all_comb.wh_id
AND all_comb.dat_valid_until >= act.dat_valid_until
AND act.busyear = all_comb.busyear
QUALIFY ROW_NUMBER () OVER (PARTITION BY all_comb.client_id, act.store_id, all_comb.busyear, all_comb.wh_id, all_comb.dat_valid_until ORDER BY act.dat_valid_until, act.dat_formdate, act.inv_id DESC NULLS LAST) = 1
) AS act
QUALIFY RANK () OVER (PARTITION BY client_id, busyear, wh_id , dat_valid_until ORDER BY inv_diff DESC NULLS LAST) <= 20
) AS act
  GROUP BY
     client_id
   , busyear
   , wh_id
   , dat_valid_until
 ) top_20
ON act.client_id = top_20.client_id
AND act.busyear = top_20.busyear
AND act.wh_id = top_20.wh_id
AND act.dat_valid_until = top_20.dat_valid_until
--v_msi_view.v_org_sales_manager_1
--v_msi_view.v_org_account_manager_1
-- LKP Manager Infos (Sales_1- und Account_1-Manager) --> extrahiert aus V_MAT_ORG_SALES_MANAGER_1 und V_MAT_ORG_ACCOUNT_MANAGER_1
LEFT OUTER JOIN p_lew_bil_ac.v_location_organization_1 AS mgr_infos
ON  act.client_id         = mgr_infos.client_id
AND act.loc_sid_wh         = mgr_infos.loc_sid_wh
AND act.store_id     = mgr_infos.loc_sid_store
/*
v_view.v_ref_client_country_1 rcc
v_view.v_ref_country_act_1 rct
v_view.v_ref_country_desc rcd
*/
JOIN
p_lew_core_ac.v_country_1 AS ctry
ON ctry.country_sid = act.client_id
QUALIFY RANK() OVER
(
PARTITION BY act.client_id, act.store_id, act.inv_id, act.cy_month
, act.busyear, act.dat_formdate, act.dat_valid_from, act.dat_valid_until
ORDER BY py.dat_valid_until DESC NULLS LAST
) = 1
;
