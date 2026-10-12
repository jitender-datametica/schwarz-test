CREATE OR REPLACE VIEW P_LEW_MART_CM_AC.V_LIL_MEASURE_GROUP
(
  meas_grp_id 
 ,meas_grp_desc
 ,meas_grp_desc_EN
) AS
SELECT
  meas_grp_id 
 ,meas_grp_desc
 ,meas_grp_desc_EN
FROM P_LEW_MART_CM.V_LIL_MEASURE_GROUP ;

