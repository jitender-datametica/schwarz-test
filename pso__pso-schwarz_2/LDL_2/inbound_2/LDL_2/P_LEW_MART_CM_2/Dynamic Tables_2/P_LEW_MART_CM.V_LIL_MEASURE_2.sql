
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_CM.V_LIL_MEASURE_2  
 (
   meas_id 
 ,meas_cd 
 ,meas_desc 
 ,meas_desc_EN
 ,meas_base_desc
 ,meas_base_desc_EN
 ,meas_tp_id 
 ,liam4_meas_grp_id 
 ,format_id 
 ,frac_lgth 
 ,liam1_srt_cd 
 ,liam2_srt_cd 
 ,liam3_srt_cd 
 ,liam4_srt_cd 
 ,lift1_srt_cd
 ,lcsd_srt_cd 
 ,monetary_fg
 )
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_CM
 AS
 SELECT 
  meas_id 
 ,CAST(meas_cd AS VARCHAR(100)) AS meas_cd
 ,CAST(COALESCE(trde.trans_text, mems.meas_desc) AS VARCHAR(128)) AS meas_desc
 ,CAST(COALESCE(tren.trans_text, mems.meas_desc) AS VARCHAR(128)) AS meas_desc_EN
 ,CAST(COALESCE(trmde.trans_text, mems.meas_base_desc) AS VARCHAR(128)) AS meas_base_desc
 ,CAST(COALESCE(trmen.trans_text, mems.meas_base_desc) AS VARCHAR(128)) AS meas_base_desc_EN
 ,CAST(meas_tp_id AS SMALLINT) AS meas_tp_id 
 ,CAST(liam4_meas_grp_id AS SMALLINT) AS liam4_meas_grp_id
 ,format_id
 ,CAST(frac_lgth AS SMALLINT) AS frac_lgth
 ,liam1_srt_cd 
 ,liam2_srt_cd 
 ,liam3_srt_cd 
 ,liam4_srt_cd 
 ,lift1_srt_cd
 ,lcsd_srt_cd 
 ,monetary_fg
 FROM P_LEW_PROCESS_MSTR_AC.v_lil_measure_2 AS mems
 LEFT OUTER JOIN P_LEW_PROCESS_MSTR_AC.v_lil_translation_2 AS trde
  ON trde.context = 'MEAS_DESC'
 AND trde.trans_id = mems.meas_id
 AND trde.lang_cd = 'DE'
 AND trde.active_fg = 1
 LEFT OUTER JOIN P_LEW_PROCESS_MSTR_AC.v_lil_translation_2 AS tren
  ON tren.context = 'MEAS_DESC'
 AND tren.trans_id = mems.meas_id
 AND tren.lang_cd = 'EN'
 AND tren.active_fg = 1
 LEFT OUTER JOIN P_LEW_PROCESS_MSTR_AC.v_lil_translation_2 AS trmde
  ON trmde.context = 'MEAS_BASE_DESC'
 AND trmde.trans_id = mems.meas_id
 AND trmde.lang_cd = 'DE'
 AND trmde.active_fg = 1
 LEFT OUTER JOIN P_LEW_PROCESS_MSTR_AC.v_lil_translation_2 AS trmen
  ON trmen.context = 'MEAS_BASE_DESC'
 AND trmen.trans_id = mems.meas_id
 AND trmen.lang_cd = 'EN'
 AND trmen.active_fg = 1;
