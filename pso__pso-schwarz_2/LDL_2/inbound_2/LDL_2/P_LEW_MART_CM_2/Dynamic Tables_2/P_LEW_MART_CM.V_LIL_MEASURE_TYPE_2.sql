
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_CM.V_LIL_MEASURE_TYPE_2
 (
 meas_tp_id 
 ,meas_tp_desc
 ,meas_tp_desc_EN
 )
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_CM
 AS
 SELECT 
  CAST(metm.meas_tp_id AS SMALLINT) AS meas_tp_id
 ,CAST(COALESCE(trde.trans_text, metm.meas_tp_desc) AS VARCHAR(128)) AS meas_tp_desc
 ,CAST(COALESCE(tren.trans_text, metm.meas_tp_desc) AS VARCHAR(128)) AS meas_tp_desc_EN
 FROM P_LEW_PROCESS_MSTR_AC.v_lil_measure_type_2 AS metm
LEFT OUTER JOIN P_LEW_PROCESS_MSTR_AC.v_lil_translation_2 AS trde
  ON trde.context = 'MEAS_TP_DESC'
 AND trde.trans_id = metm.meas_tp_id
 AND trde.lang_cd = 'DE'
 AND trde.active_fg = 1
LEFT OUTER JOIN P_LEW_PROCESS_MSTR_AC.v_lil_translation_2 AS tren
  ON tren.context = 'MEAS_TP_DESC'
 AND tren.trans_id = metm.meas_tp_id
 AND tren.lang_cd = 'EN'
 AND tren.active_fg = 1;
