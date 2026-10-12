
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_CM.V_LIL_RETAILER_TYPE_1
(
   rtl_tp_id
  ,rtl_tp_desc
  ,rtl_tp_desc_EN
  ,rtl_tp_other
  ,rtl_tp_other_EN
  ,rtl_tp_total_of_selected
  ,rtl_tp_total_of_selected_EN
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_CM
AS
SELECT
   CAST(rty.rtl_tp_id AS BYTEINT) AS rtl_tp_id
  ,CAST(COALESCE(tdscde.trans_text, rty.rtl_tp_desc) AS VARCHAR(128)) AS rtl_tp_desc
  ,CAST(COALESCE(tdscen.trans_text, rty.rtl_tp_desc) AS VARCHAR(128)) AS rtl_tp_desc_EN
  ,CAST(COALESCE(tothde.trans_text, 'Other Retailers') AS VARCHAR(128)) AS rtl_tp_other
  ,CAST(COALESCE(tothen.trans_text, 'Other Retailers') AS VARCHAR(128)) AS rtl_tp_other_EN
  ,CAST(COALESCE(ttotselde.trans_text, 'Total of Selected') AS VARCHAR(128)) AS rtl_tp_total_of_selected
  ,CAST(COALESCE(ttotselen.trans_text, 'Total of Selected') AS VARCHAR(128)) AS rtl_tp_total_of_selected_EN
FROM P_LEW_PROCESS_MSTR_AC.v_lil_retailer_type_1 AS rty
LEFT OUTER JOIN P_LEW_PROCESS_MSTR_AC.v_lil_translation_1 AS tdscde
  ON tdscde.context = 'RTL_TP_DESC'
 AND tdscde.trans_id = rty.rtl_tp_id
 AND tdscde.lang_cd = 'DE'
 AND tdscde.active_fg = 1
 LEFT OUTER JOIN P_LEW_PROCESS_MSTR_AC.v_lil_translation_1 AS tdscen
  ON tdscen.context = 'RTL_TP_DESC'
 AND tdscen.trans_id = rty.rtl_tp_id
 AND tdscen.lang_cd = 'EN'
 AND tdscen.active_fg = 1
 LEFT OUTER JOIN P_LEW_PROCESS_MSTR_AC.v_lil_translation_1 AS tothde
  ON tothde.context = 'RTL_TP_OTHER'
 AND tothde.trans_id = 0
 AND tothde.lang_cd = 'DE'
 AND tothde.active_fg = 1
 LEFT OUTER JOIN P_LEW_PROCESS_MSTR_AC.v_lil_translation_1 AS tothen
  ON tothen.context = 'RTL_TP_OTHER'
 AND tothen.trans_id = 0
 AND tothen.lang_cd = 'EN'
 AND tothen.active_fg = 1
 LEFT OUTER JOIN P_LEW_PROCESS_MSTR_AC.v_lil_translation_1 AS ttotselde
  ON ttotselde.context = 'RTL_TP_TOTSEL'
 AND ttotselde.trans_id = 0
 AND ttotselde.lang_cd = 'DE'
 AND ttotselde.active_fg = 1
 LEFT OUTER JOIN P_LEW_PROCESS_MSTR_AC.v_lil_translation_1 AS ttotselen
  ON ttotselen.context = 'RTL_TP_TOTSEL'
 AND ttotselen.trans_id = 0
 AND ttotselen.lang_cd = 'EN'
 AND ttotselen.active_fg = 1;
