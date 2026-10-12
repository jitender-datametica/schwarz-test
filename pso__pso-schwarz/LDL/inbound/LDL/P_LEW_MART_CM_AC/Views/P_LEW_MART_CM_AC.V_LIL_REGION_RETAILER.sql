CREATE OR REPLACE VIEW P_LEW_MART_CM_AC.V_LIL_REGION_RETAILER
(
client_id
,rtl_id
,region_rtl_desc
,region_rtl_desc_EN
,rtl_lvl
) AS
SELECT
client_id
,rtl_id
,region_rtl_desc
,region_rtl_desc_EN
,rtl_lvl
FROM P_LEW_MART_CM.V_LIL_REGION_RETAILER ;

