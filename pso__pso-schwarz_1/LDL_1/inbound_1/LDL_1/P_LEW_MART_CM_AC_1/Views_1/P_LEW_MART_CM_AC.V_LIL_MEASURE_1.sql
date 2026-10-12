CREATE OR REPLACE VIEW P_LEW_MART_CM_AC.V_LIL_MEASURE_1
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
) AS
SELECT
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
FROM P_LEW_MART_CM.V_LIL_MEASURE_1;

