
/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for d_lew_mart_msi.v_org_successor_store_salesorg_1
#----------------------------------------------------------------------------
# Subversion Infostamp Start          (DO NOT EDIT INFOSTAMP)
#----------------------------------------------------------------------------
# $Id: lew_mart_msi_v_org_successor_store_salesorg.sql 16791 2021-03-16 22:41:08Z dcamerzan $
# $Revision: 16791 $
# $LastChangedBy: dcamerzan $
# $LastChangedDate: 2021-03-16 23:41:08 +0100 (Tue, 16 Mar 2021) $
# $URL: svn://l-as616.asp.lidl.net/DDL/lew/lew_mart_msi/lew_mart_msi_v_org_successor_store_salesorg.sql $
#----------------------------------------------------------------------------
# Subversion Infostamp END
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  12.10.2017    Sklenarz,FlorenceAnpassung auf reine WAWI-View w www
#  1.2  18.10.2017    Sklenarz,FlorenceKorrektur der Anpassung v. 12.10.2017 7 777
#  1.3  15.11.2017    Wieber,Harald            Release 1.1
#  1.4  17.01.2018    Wieber,Harald            Release 2.2
#  1.5  29.10.2018    Arnold,Arne              V_LOC_MAP_KEY_1-Objekte mit V_STORE_1 und V_WAREHOUSE_1 ersetzt
#  1.6  16.03.2021    Dumitru Camerzan         20210316_2787_PRB0070246_MissingStores: Remap LOC_SID to STORE_ID in mart layer (part of TransALL Ablose DWH1.0 -> DWH2.0)
#----------------------------------------------------------------------------
*/
/*
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_ORG_SUCCESSOR_STORE_SALESORG_1 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
SELECT
  sorg.client_id
, wh.src_wh_id AS wh_id
, w.src_wh_id AS sales_wh_id
, vt_store.src_wh_id AS wh_id_exp
, vt_store.sales_manager_id
, st.loc_sid_store AS move_to_store_id /* 20210316_2787_PRB0070246_MissingStores: Remap LOC_SID to STORE_ID in mart layer (part of TransALL Ablose DWH1.0 -> DWH2.0) */
, osa.store_desc
FROM P_LEW_CORE_AC.v_wawi_org_store_skey_act_1 AS sorg
-- Auflosung Store
INNER JOIN P_LEW_BIL_AC.v_store_1 AS st
ON sorg.client_id = st.client_id
AND sorg.st_loc_sid = st.loc_sid_store
AND st.dwh_actual_fg = 1
-- Auflosung WH
INNER JOIN P_LEW_BIL_AC.v_warehouse_1 AS wh
ON sorg.client_id = wh.client_id
AND sorg.wh_loc_sid = wh.loc_sid_wh
AND wh.dwh_actual_fg = 1
-- Bestimmung Store-Desc
INNER JOIN P_LEW_CORE_AC.v_wawi_org_store_act_1 AS osa
ON  sorg.client_id = osa.client_id
AND sorg.st_loc_sid = osa.st_loc_sid
LEFT OUTER JOIN
(
SELECT
  wh_store.st_loc_sid
 ,wh_store.client_id
 ,wh_store.wh_type_id
 ,wh_store.wh_loc_sid
 ,wh.src_wh_id
 ,wh_store.dat_rec_start
 ,wh_store.dat_rec_end
FROM P_LEW_CORE_AC.v_wawi_org_wh_store_1 AS wh_store
 -- Auflosung WH
INNER JOIN P_LEW_BIL_AC.v_warehouse_1 AS wh
ON wh_store.client_id = wh.client_id
AND wh_store.wh_loc_sid = wh.loc_sid_wh
AND wh.dwh_actual_fg = 1
  )
 AS w
ON  sorg.st_loc_sid = w.st_loc_sid
AND sorg.client_id = w.client_id
AND w.wh_type_id = 1
AND w.src_wh_id <> sorg.orig_store_nr
AND CURRENT_DATE BETWEEN w.dat_rec_start AND w.dat_rec_end
LEFT OUTER JOIN (
SELECT
  reloc.client_id
, wh.src_wh_id
, org.sales_manager_id
, reloc.move_to_st_loc_sid
FROM P_LEW_CORE_AC.v_wawi_org_all_store_reloc_act_1 AS reloc
LEFT OUTER JOIN P_LEW_CORE_AC.v_wawi_org_salesorg_1 AS org
ON  reloc.client_id = org.client_id
AND reloc.move_to_st_loc_sid = org.st_loc_sid
AND CURRENT_DATE BETWEEN org.dat_rec_start AND org.dat_rec_end
-- Auflosung WH
LEFT OUTER JOIN P_LEW_BIL_AC.v_warehouse_1 AS wh
ON org.client_id = wh.client_id
AND org.wh_loc_sid_exp = wh.loc_sid_wh
AND wh.dwh_actual_fg = 1
GROUP BY
  reloc.client_id
, wh.src_wh_id
, org.sales_manager_id
, reloc.move_to_st_loc_sid
) AS vt_store
ON  vt_store.move_to_st_loc_sid = sorg.st_loc_sid
AND vt_store.client_id = sorg.client_id
;
/*
#-------------------------------------------------------------------------------
# Comments:
#-------------------------------------------------------------------------------
*/
--COMMENT ON  VIEW #X_LEW_MART_MSI#.n_org_successor_store_salesorg '$Revision: 16791 $. Auto Generated  9/18/2017';
/*COMMENT ON COLUMN #X_LEW_MART_MSI#.n_org_successor_store_salesorg.client_id  IS '';
COMMENT ON COLUMN #X_LEW_MART_MSI#.n_org_successor_store_salesorg.wh_id  IS '';
COMMENT ON COLUMN #X_LEW_MART_MSI#.n_org_successor_store_salesorg.sales_wh_id  IS '';
COMMENT ON COLUMN #X_LEW_MART_MSI#.n_org_successor_store_salesorg.wh_id_exp  IS '';
COMMENT ON COLUMN #X_LEW_MART_MSI#.n_org_successor_store_salesorg.sales_manager_id  IS '';
COMMENT ON COLUMN #X_LEW_MART_MSI#.n_org_successor_store_salesorg.move_to_store_id  IS '';
COMMENT ON COLUMN #X_LEW_MART_MSI#.n_org_successor_store_salesorg.store_desc  IS '';*/
