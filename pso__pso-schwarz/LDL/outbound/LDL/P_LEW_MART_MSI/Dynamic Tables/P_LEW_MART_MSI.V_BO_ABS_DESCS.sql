CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_msi.v_bo_abs_descs
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT SLSM.client_id,
 RCD.country_desc,
 RCD.country_id,
 RCT.country_iso_cd,
 SLSM.store_id,
 SSOM.orig_store_nr,
 SSOM.store_desc,
 OSC.city,
 WH.wh_id,
 WH.wh_desc,
 SLSM.sales_manager_id,
 SLSM.sales_manager_name,
 ACCM.account_manager_id,
 ACCM.account_manager_name,
 COALESCE(SSOM.dat_closing_ovis, PARSE_DATE('%d.%m.%Y', '30.12.9999')) AS dat_closing_ovis
FROM ldl_p_lew_mart_msi.v_org_sales_manager AS SLSM
 INNER JOIN ldl_p_lew_mart_msi.v_org_account_manager AS ACCM ON SLSM.account_manager_id = ACCM.account_manager_id AND
    SLSM.client_id = ACCM.client_id AND SLSM.wh_id = ACCM.wh_id
 INNER JOIN ldl_p_lew_mart_msi.v_org_store AS SSOM ON SLSM.client_id = SSOM.client_id AND SLSM.store_id = SSOM.store_id
 INNER JOIN ldl_p_lew_mart_msi.v_org_wh AS WH ON SLSM.client_id = WH.client_id AND SLSM.wh_id = WH.wh_id
 INNER JOIN ldl_p_lew_mart_msi.v_org_store_contact AS OSC ON SLSM.client_id = OSC.client_id AND SLSM.store_id = OSC.store_id
   
 INNER JOIN ldl_p_lew_mart_msi.v_ref_client_country_bo AS RCC ON SLSM.client_id = RCC.client_id
 INNER JOIN ldl_p_lew_mart_msi.v_ref_country_act_bo AS RCT ON RCC.country_id = RCT.country_id AND RCT.language_id = RCT
   .country_id
 INNER JOIN ldl_p_lew_mart_msi.v_ref_country_desc_bo AS RCD ON RCC.country_id = RCD.country_id AND RCD.language_id = RCD
   .country_id;