CREATE OR REPLACE VIEW s_conl.v_cal_week_partial_week_rel_2
AS
/* 
#DescStart# 
#$Revision: 6244 $, $LastChangedBy: hwieber $ 
#SubjectAreas#: Kalender 
#DescEnd# 
*/
SELECT
dat_calendar,
cy_week_partial_week_id1,
cy_week_partial_week_id2,
cy_week_partial_week_id,
cy_day_sequence
FROM p_lew_core_ac.v_wawi_cal_week_partial_week_rel_2;

/*** MSC-WARNING - MSCEWI3045 - MISSING DEPENDENT OBJECT "p_lew_bil_ac.v_item_2" ***/

