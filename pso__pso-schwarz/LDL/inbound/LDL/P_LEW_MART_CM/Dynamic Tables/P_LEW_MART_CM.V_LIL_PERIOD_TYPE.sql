
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_CM.V_LIL_PERIOD_TYPE  
 (
  per_tp_id
 ,per_tp_desc
 ,per_tp_desc_EN
 )
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_CM
AS
SELECT 
 CAST(pety.period_type_id AS SMALLINT) AS per_tp_id
,CAST(COALESCE(trde.trans_text, pety.period_type_desc) AS VARCHAR(128)) AS per_tp_desc
,CAST(COALESCE(tren.trans_text, pety.period_type_desc) AS VARCHAR(128)) AS per_tp_desc_EN
FROM P_LEW_PROCESS_MSTR_AC.v_lil_period_type AS pety
LEFT OUTER JOIN P_LEW_PROCESS_MSTR_AC.v_lil_translation AS trde
  ON trde.context = 'PER_TP_DESC'
 AND trde.trans_id = pety.period_type_id
 AND trde.lang_cd = 'DE'
 AND trde.active_fg = 1
 LEFT OUTER JOIN P_LEW_PROCESS_MSTR_AC.v_lil_translation AS tren
  ON tren.context = 'PER_TP_DESC'
 AND tren.trans_id = pety.period_type_id
 AND tren.lang_cd = 'EN'
 AND tren.active_fg = 1;
