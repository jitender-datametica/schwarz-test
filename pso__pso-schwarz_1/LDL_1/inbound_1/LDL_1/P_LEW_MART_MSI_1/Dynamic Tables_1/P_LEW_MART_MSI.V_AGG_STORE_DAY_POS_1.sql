CREATE OR REPLACE DYNAMIC TABLE  P_LEW_MART_MSI.V_AGG_STORE_DAY_POS_1
(
     client_id
	,store_id
	,dat_dayend
	,checker_id
	,cnt_item_scan_ejr
	,cnt_item_man_ejr
	,dur_service_ejr

)

TARGET_LAG = '1 hour, 30 minutes' -- dummy_1 value; will be refreshed by Abinitio job
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS

     SELECT
     chst.client_id AS client_id
     ,chst.st_loc_sid AS store_id
     ,chst.dat_dayend AS dat_dayend
     ,chst.checker_id AS checker_id
     ,SUM(CASE WHEN cbal.recordtype_id_cashbalance = 'S' THEN chst.cnt_item_scanned ELSE 0 END) AS cnt_item_scan_ejr
     ,SUM(CASE WHEN cbal.recordtype_id_cashbalance = 'S' THEN chst.cnt_item_direct  ELSE 0 END) AS cnt_item_man_ejr
     ,SUM(CASE WHEN cbal.recordtype_id_cashbalance = 'S' THEN (chst.dur_service) ELSE 0.00 END) AS dur_service_ejr

      FROM p_lew_core_ac.v_wawi_ejr_checkerstatus_1             AS chst
     INNER JOIN (
     SELECT
     client_id
     ,st_loc_sid
     ,dat_dayend
     ,checker_id
     ,recordtype_id_cashbalance

     FROM p_lew_core_ac.v_wawi_ejr_cashbalance_1

     GROUP BY 1,2,3,4,5
     ) AS cbal
     ON  chst.client_id    =  cbal.client_id
     AND  chst.st_loc_sid      =   cbal.st_loc_sid
     AND  chst.checker_id   =  cbal.checker_id
     AND  chst.dat_dayend   =  cbal.dat_dayend

     GROUP BY   1,2,3,4
;