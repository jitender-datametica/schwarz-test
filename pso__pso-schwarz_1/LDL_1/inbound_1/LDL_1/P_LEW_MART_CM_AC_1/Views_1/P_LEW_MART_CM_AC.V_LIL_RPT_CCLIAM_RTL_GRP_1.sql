CREATE OR REPLACE VIEW P_LEW_MART_CM_AC.V_LIL_RPT_CCLIAM_RTL_GRP_1
(
 ccliam_rtl_grp_id
,ccliam_rtl_grp_desc
,ccliam_rtl_grp_desc_EN
) AS
SELECT
 ccliam_rtl_grp_id
,ccliam_rtl_grp_desc
,ccliam_rtl_grp_desc_EN
FROM P_LEW_MART_CM.V_LIL_RPT_CCLIAM_RTL_GRP_1 ;
