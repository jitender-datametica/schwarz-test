
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_CM.V_LIL_MEASURE_GROUP 
 (
  meas_grp_id 
 ,meas_grp_desc
 ,meas_grp_desc_EN
 )
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_CM
 AS
 SELECT 
 CAST(megm.meas_grp_id AS SMALLINT) AS meas_grp_id 
 ,CAST(COALESCE(trde.trans_text, megm.meas_grp_desc) AS VARCHAR(128)) AS meas_grp_desc
 ,CAST(COALESCE(tren.trans_text, megm.meas_grp_desc) AS VARCHAR(128)) AS meas_grp_desc_EN
 FROM P_LEW_PROCESS_MSTR_AC.v_lil_measure_group AS megm
LEFT OUTER JOIN P_LEW_PROCESS_MSTR_AC.v_lil_translation AS trde
  ON trde.context = 'MEAS_GRP_DESC'
 AND trde.trans_id = megm.meas_grp_id
 AND trde.lang_cd = 'DE'
 AND trde.active_fg = 1
LEFT OUTER JOIN P_LEW_PROCESS_MSTR_AC.v_lil_translation AS tren
  ON tren.context = 'MEAS_GRP_DESC'
 AND tren.trans_id = megm.meas_grp_id
 AND tren.lang_cd = 'EN'
 AND tren.active_fg = 1;
