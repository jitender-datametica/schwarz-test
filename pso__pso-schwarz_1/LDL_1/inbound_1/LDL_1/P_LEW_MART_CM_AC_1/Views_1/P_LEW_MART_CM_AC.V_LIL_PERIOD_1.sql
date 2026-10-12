CREATE OR REPLACE VIEW P_LEW_MART_CM_AC.V_LIL_PERIOD_1
(
 per_id 
,per_text
,per_text_EN
,per_desc
,per_desc_EN
,per_tp_id
,per_lvl
,per_yr
,per_start_dat
,per_end_dat
,py_per_id
,py_per_desc
,py_per_desc_EN
,pq_per_id
,pq_per_desc
,pq_per_desc_EN
,pp_per_id
,pp_per_desc
,pp_per_desc_EN
,liam_avbl_fg
,lift_avbl_fg
) AS

SELECT
 per_id 
,per_text
,per_text_EN
,per_desc
,per_desc_EN
,per_tp_id
,per_lvl
,per_yr
,per_start_dat
,per_end_dat
,py_per_id
,py_per_desc
,py_per_desc_EN
,pq_per_id
,pq_per_desc
,pq_per_desc_EN
,pp_per_id
,pp_per_desc
,pp_per_desc_EN
,liam_avbl_fg
,lift_avbl_fg
FROM P_LEW_MART_CM.V_LIL_PERIOD_1 ;

