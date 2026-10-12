
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_CM.V_LIL_CURRENCY 
 (
  currency_iso_cd
  ,currency_desc
  ,currency_desc_EN
  ,currency_srt_cd
  ,currency_srt
 )
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_CM
 AS
 SELECT 
  CAST(cums.currency_iso_cd AS CHAR(3)) AS currency_iso_cd
 ,CAST(COALESCE(trde.trans_text, cums.currency_desc) AS VARCHAR(128)) AS currency_desc
 ,CAST(COALESCE(tren.trans_text, cums.currency_desc) AS VARCHAR(128)) AS currency_desc_EN
 ,CAST(cums.currency_srt_cd AS SMALLINT) AS currency_srt_cd
 ,CAST(cums.currency_srt_cd AS SMALLINT) AS currency_srt
FROM P_LEW_PROCESS_MSTR_AC.v_lil_currency AS cums
LEFT OUTER JOIN P_LEW_PROCESS_MSTR_AC.v_lil_translation AS trde
  ON trde.context = 'CURRENCY_DESC'
 AND trde.src_trans_cd = cums.currency_iso_cd
 AND trde.lang_cd = 'DE'
 AND trde.active_fg = 1
 LEFT OUTER JOIN P_LEW_PROCESS_MSTR_AC.v_lil_translation AS tren
  ON tren.context = 'CURRENCY_DESC'
 AND tren.src_trans_cd = cums.currency_iso_cd
 AND tren.lang_cd = 'EN'
 AND tren.active_fg = 1;
