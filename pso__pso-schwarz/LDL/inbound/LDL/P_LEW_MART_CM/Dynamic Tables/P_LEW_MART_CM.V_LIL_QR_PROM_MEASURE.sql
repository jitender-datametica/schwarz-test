
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_CM.V_LIL_QR_PROM_MEASURE
(
    meas_id
   ,prom_meas_desc
   ,prom_meas_desc_EN
   ,srt_cd
   ,prom_meas_id
   ,meas_tp_id
) 
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_CM
AS
SELECT
   qprm.meas_id
  ,COALESCE(trde.trans_text, qprm.prom_meas_desc) AS prom_meas_desc
  ,COALESCE(tren.trans_text, qprm.prom_meas_desc) AS prom_meas_desc_EN
  ,qprm.srt_cd
  ,qprm.prom_meas_id
  ,meas.meas_tp_id
FROM (
 SELECT
    MIN(CAST(TRUNC(DECODE(sub_code, 'MEAS_ID', val)) AS INTEGER) ) AS meas_id,
    MIN(CAST(DECODE(sub_code, 'PROM_MEAS_DESC', val) AS VARCHAR(128))) AS prom_meas_desc,
    CAST(TRUNC(key_field) AS INTEGER)  AS srt_cd,
    MIN(CAST(TRUNC(DECODE(sub_code, 'PROM_MEAS_ID', val)) AS INTEGER) ) AS prom_meas_id
  FROM P_LEW_PROCESS_MSTR_AC.v_lil_code
  WHERE main_code = 'QR_PROM_MEASURE'
  GROUP BY srt_cd
) AS qprm
INNER JOIN P_LEW_MART_CM.v_lil_measure AS meas
ON meas.meas_id = qprm.meas_id
LEFT OUTER JOIN P_LEW_PROCESS_MSTR_AC.v_lil_translation AS trde
  ON trde.context = 'PROM_MEAS_DESC'
 AND trde.trans_id = qprm.srt_cd
 AND trde.lang_cd = 'DE'
 AND trde.active_fg = 1
 LEFT OUTER JOIN P_LEW_PROCESS_MSTR_AC.v_lil_translation AS tren
  ON tren.context = 'PROM_MEAS_DESC'
 AND tren.trans_id = qprm.srt_cd
 AND tren.lang_cd = 'EN'
 AND tren.active_fg = 1;
