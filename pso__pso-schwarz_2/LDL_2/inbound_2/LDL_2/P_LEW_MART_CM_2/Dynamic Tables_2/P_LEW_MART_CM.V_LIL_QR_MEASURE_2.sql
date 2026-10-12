
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_CM.V_LIL_QR_MEASURE_2
(
   qr_meas_id
  ,qr_meas_desc
  ,qr_meas_desc_EN
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_CM 
AS
SELECT
   CAST(qrm.key_field AS SMALLINT) AS qr_meas_id
  ,CAST(COALESCE(trde.trans_text, qrm.val) AS VARCHAR(128)) AS qr_meas_desc
  ,CAST(COALESCE(tren.trans_text, qrm.val) AS VARCHAR(128)) AS qr_meas_desc_EN
FROM (
  SELECT
    key_field
  , val
  FROM P_LEW_PROCESS_MSTR_AC.v_lil_code_2
  WHERE main_code = 'QR_MEASURE'
    AND sub_code  = 'QR_MEAS_DESC'
) AS qrm
LEFT OUTER JOIN P_LEW_PROCESS_MSTR_AC.v_lil_translation_2 AS trde
  ON trde.context = 'QR_MEAS_DESC'
 AND trde.trans_id = CAST(qrm.key_field AS SMALLINT)
 AND trde.lang_cd = 'DE'
 AND trde.active_fg = 1
 LEFT OUTER JOIN P_LEW_PROCESS_MSTR_AC.v_lil_translation_2 AS tren
  ON tren.context = 'QR_MEAS_DESC'
 AND tren.trans_id = CAST(qrm.key_field AS SMALLINT)
 AND tren.lang_cd = 'EN'
 AND tren.active_fg = 1;
