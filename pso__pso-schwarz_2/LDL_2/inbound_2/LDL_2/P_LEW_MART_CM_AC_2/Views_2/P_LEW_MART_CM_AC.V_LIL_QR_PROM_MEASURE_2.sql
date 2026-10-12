CREATE OR REPLACE VIEW P_LEW_MART_CM_AC.V_LIL_QR_PROM_MEASURE_2
(
    meas_id
   ,prom_meas_desc
   ,prom_meas_desc_EN
   ,srt_cd
   ,prom_meas_id
   ,meas_tp_id
) AS
SELECT
    meas_id
   ,prom_meas_desc
   ,prom_meas_desc_EN
   ,srt_cd
   ,prom_meas_id
   ,meas_tp_id
FROM P_LEW_MART_CM.V_LIL_QR_PROM_MEASURE_2 ;

