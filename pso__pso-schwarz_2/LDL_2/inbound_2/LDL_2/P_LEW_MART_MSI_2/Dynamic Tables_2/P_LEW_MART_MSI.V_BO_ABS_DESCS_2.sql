
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_BO_ABS_DESCS_2

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
SELECT
slsm.client_id,
rcd.country_desc,
rcd.country_id,
rct.country_iso_cd,
slsm.store_id,
ssom.orig_store_nr,
ssom.store_desc,
osc.city,
wh.wh_id,
wh.wh_desc,
slsm.sales_manager_id,
slsm.sales_manager_name,
accm.account_manager_id,
accm.account_manager_name,
COALESCE(ssom.dat_closing_ovis, TO_DATE('30.12.9999', 'dd.mm.yyyy')) AS  dat_closing_ovis
FROM p_lew_mart_msi.v_org_sales_manager_2 AS slsm
INNER JOIN p_lew_mart_msi.v_org_account_manager_2 AS accm
ON  slsm.account_manager_id = accm.account_manager_id
AND slsm.client_id = accm.client_id
AND slsm.wh_id = accm.wh_id
INNER JOIN p_lew_mart_msi.v_org_store_2 AS ssom
ON slsm.client_id = ssom.client_id
AND slsm.store_id = ssom.store_id
INNER JOIN p_lew_mart_msi.v_org_wh_2 AS wh
ON  slsm.client_id = wh.client_id
AND slsm.wh_id = wh.wh_id
INNER JOIN p_lew_mart_msi.v_org_store_contact_2 AS osc
ON  slsm.client_id = osc.client_id
AND slsm.store_id  = osc.store_id
INNER JOIN p_lew_mart_msi.v_ref_client_country_bo_2 AS rcc
ON  slsm.client_id = rcc.client_id
INNER JOIN p_lew_mart_msi.v_ref_country_act_bo_2 AS rct
ON  rcc.country_id  = rct.country_id
AND rct.language_id = rct.country_id
INNER JOIN p_lew_mart_msi.v_ref_country_desc_bo_2 AS rcd
ON  rcc.country_id = rcd.country_id
AND rcd.language_id = rcd.country_id;
