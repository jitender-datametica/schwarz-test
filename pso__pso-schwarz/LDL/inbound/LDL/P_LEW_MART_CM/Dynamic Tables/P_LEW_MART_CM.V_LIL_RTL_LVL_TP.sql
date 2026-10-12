
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_CM.V_LIL_RTL_LVL_TP
(
   rtl_lvl
  ,rtl_lvl_desc
  ,rtl_lvl_desc_EN
  ,rtl_tp_id
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_CM
AS
SELECT
   CAST(rlt.rtl_lvl AS SMALLINT) AS rtl_lvl
  ,CAST(COALESCE(trde.trans_text, lvl.rtl_lvl_desc) AS VARCHAR(128)) AS rtl_lvl_desc
  ,CAST(COALESCE(tren.trans_text, lvl.rtl_lvl_desc) AS VARCHAR(128)) AS rtl_lvl_desc_EN
  ,CAST(rlt.rtl_tp_id AS BYTEINT) AS rtl_tp_id
FROM P_LEW_PROCESS_MSTR_AC.v_lil_rtl_lvl_tp AS rlt
INNER JOIN P_LEW_PROCESS_MSTR_AC.v_lil_retailer_level AS lvl
  ON lvl.rtl_lvl = rlt.rtl_lvl
LEFT OUTER JOIN P_LEW_PROCESS_MSTR_AC.v_lil_translation AS trde
  ON trde.context = 'RTL_LVL_DESC'
 AND trde.trans_id = rlt.rtl_lvl
 AND trde.lang_cd = 'DE'
 AND trde.active_fg = 1
 LEFT OUTER JOIN P_LEW_PROCESS_MSTR_AC.v_lil_translation AS tren
  ON tren.context = 'RTL_LVL_DESC'
 AND tren.trans_id = rlt.rtl_lvl
 AND tren.lang_cd = 'EN'
 AND tren.active_fg = 1;
