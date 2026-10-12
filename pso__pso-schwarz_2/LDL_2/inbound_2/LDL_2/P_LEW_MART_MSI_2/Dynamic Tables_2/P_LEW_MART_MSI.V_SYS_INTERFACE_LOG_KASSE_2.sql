
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_SYS_INTERFACE_LOG_KASSE_2

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
/*
#DescStart#
#$Revision: 11751 $, $LastChangedBy: mahdi $
#SubjectAreas#: Systemtabellen
#DescEnd#
*/
SELECT
il.dc_load_id                             AS dc_load_id,
il.dc_server_id                           AS dc_server_id,
il.system_key                             AS system_key,
ssy.system_desc                           AS system_desc,
il.interface_key                          AS interface_key,
ifc.comment_string                        AS interface_desc,
il.ctrcode                                AS ctrcode,
rcc.client_id                             AS client_id,
wh.src_wh_id                              AS wh_id,
il.orig_store_nr                          AS orig_store_nr,
COALESCE(sty.st_loc_sid,st.loc_sid_store) AS store_id,
il.dat_dayend                             AS dat_dayend,
il.dc_service_id                          AS dc_service_id,
il.mail_rows                              AS mail_rows,
il.mail_bytes                             AS mail_bytes,
il.conv_rows                              AS conv_rows,
il.conv_bytes                             AS conv_bytes,
il.load_rows                              AS load_rows,
NULL                                      AS mload_rows,
trans_row_cnt                             AS target_rows,
CASE
      WHEN Cnt.trans_row_cnt IS NULL THEN 0
      ELSE 1
   END                                       AS trans_fg,
il.timestamp_load                         AS timestamp_load,
il.source_sent_tmsp                       AS source_sent_tmsp,
il.mail_in_tmsp                           AS mail_in_tmsp
FROM
(SELECT
dc_load_id,
dc_server_id,
system_key,
interface_key,
ctrcode,
wh_loc_sid,
orig_store_nr,
dat_dayend,
dc_service_id,
mail_rows,
mail_bytes,
conv_rows,
conv_bytes,
load_rows,
timestamp_load,
source_sent_tmsp,
mail_in_tmsp
FROM p_lew_process_ac.v_wawi_sys_interface_log_base_2
   WHERE dat_dayend >= CURRENT_DATE- 1
UNION
SELECT
dc_load_id,
dc_server_id,
system_key,
interface_key,
ctrcode,
wh_loc_sid,
orig_store_nr,
dat_dayend,
dc_service_id,
mail_rows,
mail_bytes,
conv_rows,
conv_bytes,
load_rows,
timestamp_load,
source_sent_tmsp,
mail_in_tmsp
FROM p_lew_process_ac.v_wawi_sys_interface_log_l_0_2
) AS il
INNER JOIN p_lew_bil_ac.v_warehouse_2 AS wh
ON  wh.loc_sid_wh = il.wh_loc_sid
AND wh.dwh_actual_fg = 1
INNER JOIN p_lew_core_ac.v_wawi_ref_interface_2 AS ifc
ON  il.system_key    = ifc.system_key
AND il.interface_key = ifc.interface_key
INNER JOIN p_lew_core_ac.v_wawi_ref_subsystem_2 AS ssy
ON  il.system_key = ssy.system_key
INNER JOIN p_lew_core_ac.v_wawi_ref_country_2 AS rc
ON  rc.country_iso_cd = il.ctrcode
INNER JOIN p_lew_core_ac.v_wawi_ref_client_country_2 AS rcc
ON  rc.country_id = rcc.country_id
LEFT OUTER JOIN p_lew_core_ac.v_wawi_org_store_skey_2 AS sty
ON  rcc.client_id    = sty.client_id
AND il.orig_store_nr = sty.orig_store_nr
AND il.dat_dayend BETWEEN sty.dat_rec_start AND sty.dat_rec_end
-- Ermittlung surrogate key für store_id = 0
LEFT OUTER JOIN p_lew_bil_ac.v_store_2 AS st
ON  st.client_id = rcc.client_id
AND st.src_store_id = 0
AND st.dwh_actual_fg = 1
LEFT OUTER JOIN p_lew_process_ac.v_wawi_sys_trans_cnt_2 AS Cnt
ON  Cnt.system_key    = il.system_key
AND Cnt.interface_key = il.interface_key
AND Cnt.client_id     = rcc.client_id
AND Cnt.wh_loc_sid    = il.wh_loc_sid
AND Cnt.st_loc_sid    = sty.st_loc_sid
AND Cnt.dat_dayend    = il.dat_dayend
WHERE il.system_key IN (2,13)
;
