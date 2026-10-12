/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for d_lew_mart_msi.v_org_successor_store_salesorg_2
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
#  1.5  29.10.2018    Arnold,Arne              V_LOC_MAP_KEY_2-Objekte mit V_STORE_2 und V_WAREHOUSE_2 ersetzt
#  1.6  16.03.2021    Dumitru Camerzan         20210316_2787_PRB0070246_MissingStores: Remap LOC_SID to STORE_ID in mart layer (part of TransALL Ablose DWH1.0 -> DWH2.0)
#----------------------------------------------------------------------------
*/
/*
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE TABLE ldl_p_lew_mart_msi.v_org_successor_store_salesorg_2 AS
/* 20210316_2787_PRB0070246_MissingStores: Remap LOC_SID to STORE_ID in mart layer (part of TransALL Ablose DWH1.0 -> DWH2.0) */
-- Auflosung Store
 -- Auflosung WH
 SELECT SORG.client_id,
 WH.src_wh_id AS wh_id,
 w.src_wh_id AS sales_wh_id,
 vt_store.src_wh_id AS wh_id_exp,
 vt_store.sales_manager_id,
 ST.loc_sid_store AS move_to_store_id,
 OSA.store_desc
FROM ldl_p_lew_core_ac.v_wawi_org_store_skey_act_2 AS SORG
 INNER JOIN ldl_p_lew_bil_ac.v_store_2 AS ST ON SORG.client_id = ST.client_id AND SORG.st_loc_sid = ST.loc_sid_store AND
   ST.dwh_actual_fg = 1 -- Auflosung WH

 INNER JOIN ldl_p_lew_bil_ac.v_warehouse_2 AS WH ON SORG.client_id = WH.client_id AND SORG.wh_loc_sid = WH.loc_sid_wh AND
   WH.dwh_actual_fg = 1 -- Bestimmung Store-Desc

 INNER JOIN ldl_p_lew_core_ac.v_wawi_org_store_act_2 AS OSA ON SORG.client_id = OSA.client_id AND SORG.st_loc_sid = OSA.st_loc_sid
   
 LEFT JOIN (SELECT WH_STORE.st_loc_sid,
   WH_STORE.client_id,
   WH_STORE.wh_type_id,
   WH_STORE.wh_loc_sid,
   WH0.src_wh_id,
   WH_STORE.dat_rec_start,
   WH_STORE.dat_rec_end
  FROM ldl_p_lew_core_ac.v_wawi_org_wh_store_2 AS WH_STORE
   INNER JOIN ldl_p_lew_bil_ac.v_warehouse_2 AS WH0 ON WH_STORE.client_id = WH0.client_id AND WH_STORE.wh_loc_sid = WH0.loc_sid_wh
       AND WH0.dwh_actual_fg = 1) AS w ON SORG.st_loc_sid = w.st_loc_sid AND SORG.client_id = w.client_id AND w.wh_type_id
      = 1 AND w.src_wh_id <> SORG.orig_store_nr AND CURRENT_DATE BETWEEN w.dat_rec_start AND w.dat_rec_end
 LEFT JOIN (SELECT RELOC.client_id,
   WH1.src_wh_id,
   ORG.sales_manager_id,
   RELOC.move_to_st_loc_sid
  FROM ldl_p_lew_core_ac.v_wawi_org_all_store_reloc_act_2 AS RELOC
   LEFT JOIN ldl_p_lew_core_ac.v_wawi_org_salesorg_2 AS ORG ON RELOC.client_id = ORG.client_id AND RELOC.move_to_st_loc_sid
       = ORG.st_loc_sid AND CURRENT_DATE BETWEEN ORG.dat_rec_start AND ORG.dat_rec_end -- Auflosung WH

   LEFT JOIN ldl_p_lew_bil_ac.v_warehouse_2 AS WH1 ON ORG.client_id = WH1.client_id AND ORG.wh_loc_sid_exp = WH1.loc_sid_wh
       AND WH1.dwh_actual_fg = 1
  GROUP BY RELOC.move_to_st_loc_sid,
   RELOC.client_id,
   ORG.sales_manager_id,
   WH1.src_wh_id) AS vt_store ON SORG.st_loc_sid = vt_store.move_to_st_loc_sid AND SORG.client_id = vt_store.client_id;


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