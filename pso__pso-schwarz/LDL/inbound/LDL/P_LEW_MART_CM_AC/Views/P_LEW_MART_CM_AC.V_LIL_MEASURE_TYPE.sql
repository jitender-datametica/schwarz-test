CREATE OR REPLACE VIEW P_LEW_MART_CM_AC.V_LIL_MEASURE_TYPE
(
 meas_tp_id 
 ,meas_tp_desc
 ,meas_tp_desc_EN
) AS
SELECT
 meas_tp_id 
 ,meas_tp_desc
 ,meas_tp_desc_EN
FROM P_LEW_MART_CM.V_LIL_MEASURE_TYPE ;

