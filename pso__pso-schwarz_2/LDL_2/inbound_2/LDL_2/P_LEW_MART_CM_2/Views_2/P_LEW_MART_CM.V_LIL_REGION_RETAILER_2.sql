CREATE OR REPLACE VIEW P_LEW_MART_CM.V_LIL_REGION_RETAILER_2 
(
client_id
,rtl_id
,region_rtl_desc
,region_rtl_desc_EN
,rtl_lvl
)
AS
SELECT 
reg.region_id
,rtl.rtl_id
,rtl.region_rtl_desc_de
,rtl.region_rtl_desc_en
,rtl.rtl_lvl
FROM P_LEW_PROCESS_MSTR_AC.v_lil_region_retailer_2 AS rtl
INNER JOIN P_LEW_PROCESS_MSTR_AC.v_lil_region_2 AS reg
ON reg.region_sid = rtl.region_sid;
