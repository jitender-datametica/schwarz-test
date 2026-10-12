
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_BO_DESCS_2

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
SELECT
st.client_id,
wrcd.country_desc,
wrcc.country_id,
wrca.country_iso_cd,
st.loc_sid_store AS store_id,
st.src_orig_store_nr AS orig_store_nr,
COALESCE(st.loc_name2, st.loc_name) AS store_desc,
addr.city,
wh.loc_sid_wh,
wh.src_wh_id AS wh_id,
COALESCE(wh.loc_name2, wh.loc_name) AS wh_desc,
COALESCE(mgr_infos.sales_manager_id, -100) AS sales_manager_id,
COALESCE(mgr_infos.sales_manager_name, 'Bezirksleiter') AS sales_manager_name,
COALESCE(mgr_infos.account_manager_id, -1) AS account_manager_id,
COALESCE(mgr_infos.account_manager_name, 'Vertriebsleiter') AS account_manager_name,
st.closing_dt AS dat_closing,
w_st.dat_closing_ovis AS dat_closing_ovis
FROM p_lew_bil_ac.v_store_2 AS st
-- LKP WaWI-Infos für DAT_CLOSING_OVIS
LEFT OUTER JOIN p_lew_core_ac.v_wawi_org_store_act_2 AS w_st
ON st.client_id = w_st.client_id
AND st.loc_sid_store = w_st.st_loc_sid
-- LKP Manager Infos (Sales_2- und Account_2-Manager) --> extrahiert aus V_MAT_ORG_SALES_MANAGER_2 und V_MAT_ORG_ACCOUNT_MANAGER_2
INNER JOIN p_lew_bil_ac.v_store_to_warehouse_lastknown_2 AS stwl
ON st.client_id = stwl.client_id
AND st.loc_sid_store = stwl.loc_sid_store
LEFT OUTER JOIN p_lew_bil_ac.v_location_organization_2 AS mgr_infos
ON  stwl.client_id = mgr_infos.client_id
AND stwl.loc_sid_wh = mgr_infos.loc_sid_wh
AND stwl.loc_sid_store = mgr_infos.loc_sid_store
-- LKP City --> Der zusätzliche LKP auf die WaWI-Tabelle T_WAWI_ORG_STORE_CONTACT_2 kann entfallen, da diese Tabelle keine zusätzlichen City-Informationen für fehlende Infos in T_ADDRESS_2 liefert
INNER JOIN p_lew_core_ac.v_address_2 AS addr
ON st.client_id = addr.client_id
AND st.addr_sid = addr.addr_sid
-- LKP WH
INNER JOIN p_lew_bil_ac.v_warehouse_2 AS wh
ON stwl.client_id = wh.client_id
AND stwl.loc_sid_wh = wh.loc_sid_wh
-- LKP Country_ID --> Im Unterschied zu V_CLIENT_2 ist hier noch nicht Serbien enthalten.
INNER JOIN p_lew_core_ac.v_wawi_ref_client_country_2 AS wrcc
ON st.client_id = wrcc.client_id
-- LKP Country_Desc (Landesname)
INNER JOIN p_lew_core_ac.v_wawi_ref_country_act_2 AS wrca
ON wrcc.country_id = wrca.country_id
AND wrcc.country_id = wrca.language_id
-- LKP Country_ISO_CD
INNER JOIN p_lew_core_ac.v_wawi_ref_country_desc_2 AS wrcd
ON wrcc.country_id = wrcd.country_id
AND wrcc.country_id = wrcd.language_id
WHERE st.dwh_actual_fg = 1
AND st.test_store_fg = 0
AND st.pseudo_store_fg = 0
AND wh.dwh_actual_fg = 1
AND wh.src_wh_id > 0
;
