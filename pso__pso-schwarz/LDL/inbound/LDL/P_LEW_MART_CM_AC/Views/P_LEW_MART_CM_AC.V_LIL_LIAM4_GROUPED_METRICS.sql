CREATE OR REPLACE VIEW P_LEW_MART_CM_AC.V_LIL_LIAM4_GROUPED_METRICS
(
   meas_id
 , liam4_meas_cd
 , liam4_meas_desc
 , liam4_meas_desc_EN
 , liam4_meas_smart_desc 
 , liam4_meas_smart_desc_EN
 , grp_id
 , grp_desc
 , grp_desc_EN
 , grp_smart_desc
 , grp_smart_desc_EN 
 , liam4_meas_id
) AS
SELECT
   meas_id
 , liam4_meas_cd
 , liam4_meas_desc
 , liam4_meas_desc_EN
 , liam4_meas_smart_desc 
 , liam4_meas_smart_desc_EN
 , grp_id
 , grp_desc
 , grp_desc_EN
 , grp_smart_desc
 , grp_smart_desc_EN 
 , liam4_meas_id
FROM P_LEW_MART_CM.V_LIL_LIAM4_GROUPED_METRICS;
