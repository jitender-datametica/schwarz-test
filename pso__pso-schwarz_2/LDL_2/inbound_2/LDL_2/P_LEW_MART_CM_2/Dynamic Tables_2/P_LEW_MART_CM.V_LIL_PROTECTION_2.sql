
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_CM.V_LIL_PROTECTION_2
(
  prot_fg
 ,description
 ,description_EN
 )
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_CM
AS
SELECT
   CAST(prot.prot_fg AS BYTEINT) AS prot_fg
  ,CAST(COALESCE(trde.trans_text, prot.description) AS VARCHAR(128)) AS description
  ,CAST(COALESCE(tren.trans_text, prot.description) AS VARCHAR(128)) AS description_EN
FROM P_LEW_PROCESS_MSTR_AC.v_lil_protection_2 AS prot
LEFT OUTER JOIN P_LEW_PROCESS_MSTR_AC.v_lil_translation_2 AS trde
  ON trde.context = 'PROT_DESC'
 AND trde.trans_id = prot.prot_fg
 AND trde.lang_cd = 'DE'
 AND trde.active_fg = 1
 LEFT OUTER JOIN P_LEW_PROCESS_MSTR_AC.v_lil_translation_2 AS tren
  ON tren.context = 'PROT_DESC'
 AND tren.trans_id = prot.prot_fg
 AND tren.lang_cd = 'EN'
 AND tren.active_fg = 1;
