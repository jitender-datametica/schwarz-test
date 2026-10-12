CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_msi.v_bo_descs
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true) AS
-- LKP WaWI-Infos für DAT_CLOSING_OVIS
 SELECT ST.client_id,
 WRCD.country_desc,
 WRCC.country_id,
 WRCA.country_iso_cd,
 ST.loc_sid_store AS store_id,
 ST.src_orig_store_nr AS orig_store_nr,
 COALESCE(ST.loc_name2, ST.loc_name) AS store_desc,
 ADDR.city,
 WH.loc_sid_wh,
 WH.src_wh_id AS wh_id,
 COALESCE(WH.loc_name2, WH.loc_name) AS wh_desc,
 COALESCE(MGR_INFOS.sales_manager_id, - 100) AS sales_manager_id,
 COALESCE(MGR_INFOS.sales_manager_name, 'Bezirksleiter') AS sales_manager_name,
 COALESCE(MGR_INFOS.account_manager_id, - 1) AS account_manager_id,
 COALESCE(MGR_INFOS.account_manager_name, 'Vertriebsleiter') AS account_manager_name,
 ST.closing_dt AS dat_closing,
 W_ST.dat_closing_ovis
FROM ldl_p_lew_bil_ac.v_store AS ST
 LEFT JOIN ldl_p_lew_core_ac.v_wawi_org_store_act AS W_ST ON ST.client_id = W_ST.client_id AND ST.loc_sid_store = W_ST.st_loc_sid
   -- LKP Manager Infos (Sales- und Account-Manager) --> extrahiert aus V_MAT_ORG_SALES_MANAGER und V_MAT_ORG_ACCOUNT_MANAGER

   
 INNER JOIN ldl_p_lew_bil_ac.v_store_to_warehouse_lastknown AS STWL ON ST.client_id = STWL.client_id AND ST.loc_sid_store
    = STWL.loc_sid_store
 LEFT JOIN ldl_p_lew_bil_ac.v_location_organization AS MGR_INFOS ON STWL.client_id = MGR_INFOS.client_id AND STWL.loc_sid_wh
     = MGR_INFOS.loc_sid_wh AND STWL.loc_sid_store = MGR_INFOS.loc_sid_store
   -- LKP City --> Der zusätzliche LKP auf die WaWI-Tabelle T_WAWI_ORG_STORE_CONTACT kann entfallen, da diese Tabelle keine zusätzlichen City-Informationen für fehlende Infos in T_ADDRESS liefert

   
 INNER JOIN ldl_p_lew_core_ac.v_address AS ADDR ON ST.client_id = ADDR.client_id AND ST.addr_sid = ADDR.addr_sid
   -- LKP WH

 INNER JOIN ldl_p_lew_bil_ac.v_warehouse AS WH ON STWL.client_id = WH.client_id AND STWL.loc_sid_wh = WH.loc_sid_wh
   -- LKP Country_ID --> Im Unterschied zu V_CLIENT ist hier noch nicht Serbien enthalten.

 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_country AS WRCC ON ST.client_id = WRCC.client_id
  -- LKP Country_Desc (Landesname)

 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_country_act AS WRCA ON WRCC.country_id = WRCA.country_id AND WRCC.country_id =
   WRCA.language_id -- LKP Country_ISO_CD

 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_country_desc AS WRCD ON WRCC.country_id = WRCD.country_id AND WRCC.country_id =
   WRCD.language_id
WHERE ST.dwh_actual_fg = 1
 AND ST.test_store_fg = 0
 AND ST.pseudo_store_fg = 0
 AND WH.dwh_actual_fg = 1
 AND WH.src_wh_id > 0;