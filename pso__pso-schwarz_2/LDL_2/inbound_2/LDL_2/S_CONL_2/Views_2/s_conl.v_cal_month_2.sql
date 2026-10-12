CREATE OR REPLACE VIEW s_conl.v_cal_month_2
AS
/*
#DescStart#
#$Revision: 7108 $, $LastChangedBy: pmittler $
#SubjectAreas#: Kalender
#DescEnd#
*/
SELECT
c1.cy_month AS cy_month,
c1.cy_month_prev_1m AS prev_month,
c1.cy_month_prev_1y AS prev_cy_month,
c1.cy_month_prev_2y AS preprev_cy_month,
c1.cy           AS cy,
c1.busyear  AS  byr,
c1.cy_month_seq AS cy_month_sequence,
c1.month_id AS month_id
FROM p_lew_core_ac.v_cal_month_2  c1
WHERE c1.cy < (SELECT
max(cy)-6
FROM p_lew_core_ac.v_cal_month_2);

/*** MSC-WARNING - MSCEWI3045 - MISSING DEPENDENT OBJECTS "p_lew_core_ac.v_wawi_cal_month_desc_2", "p_lew_core_ac.v_wawi_cal_month_2" ***/

