
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_CM.V_LIL_RPT_CCLIAM_RTL_GRP
(
 ccliam_rtl_grp_id
,ccliam_rtl_grp_desc
,ccliam_rtl_grp_desc_EN
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_CM
AS
SELECT 
 CAST(rcrg.ccliam_rtl_grp_id AS SMALLINT) AS ccliam_rtl_grp_id
,CAST(COALESCE(trde.trans_text, rcrg.ccliam_rtl_grp_desc) AS VARCHAR(128)) AS ccliam_rtl_grp_desc
,CAST(COALESCE(tren.trans_text, rcrg.ccliam_rtl_grp_desc) AS VARCHAR(128)) AS ccliam_rtl_grp_desc_EN
FROM P_LEW_PROCESS_MSTR_AC.v_lil_rpt_ccliam_rtl_grp AS rcrg
LEFT OUTER JOIN P_LEW_PROCESS_MSTR_AC.v_lil_translation AS trde
  ON trde.context = 'CCLIAM_RTL_GRP_DESC'
 AND trde.trans_id = rcrg.ccliam_rtl_grp_id
 AND trde.lang_cd = 'DE'
 AND trde.active_fg = 1
 LEFT OUTER JOIN P_LEW_PROCESS_MSTR_AC.v_lil_translation AS tren
  ON tren.context = 'CCLIAM_RTL_GRP_DESC'
 AND tren.trans_id = rcrg.ccliam_rtl_grp_id
 AND tren.lang_cd = 'EN'
 AND tren.active_fg = 1;
