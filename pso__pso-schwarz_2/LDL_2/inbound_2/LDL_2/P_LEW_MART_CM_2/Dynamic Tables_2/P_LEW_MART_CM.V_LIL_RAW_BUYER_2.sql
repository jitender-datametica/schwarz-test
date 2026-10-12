
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_CM.V_LIL_RAW_BUYER_2
 (
  raw_buyer_id
 ,description
 ,description_EN
 )
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_CM
 AS
 SELECT
   CAST(dcf.data_confidence_fg AS SMALLINT) AS raw_buyer_id
  ,CAST(COALESCE(trde.trans_text, dcf.data_confidence_desc) AS VARCHAR(128)) AS description
  ,CAST(COALESCE(tren.trans_text, dcf.data_confidence_desc) AS VARCHAR(128)) AS description_EN
 FROM P_LEW_PROCESS_MSTR_AC.v_lil_data_confidence_2 AS dcf
 LEFT OUTER JOIN P_LEW_PROCESS_MSTR_AC.v_lil_translation_2 AS trde
  ON trde.context = 'RAW_BUYER_DESC'
 AND trde.trans_id = dcf.data_confidence_fg
 AND trde.lang_cd = 'DE'
 AND trde.active_fg = 1
 LEFT OUTER JOIN P_LEW_PROCESS_MSTR_AC.v_lil_translation_2 AS tren
  ON tren.context = 'RAW_BUYER_DESC'
 AND tren.trans_id = dcf.data_confidence_fg
 AND tren.lang_cd = 'EN'
 AND tren.active_fg = 1;
