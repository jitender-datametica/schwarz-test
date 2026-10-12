CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_BO_PERF_CAL_LIST_MTH_1
/*
#DescStart#
#$Revision: 7991 $, $LastChangedBy: hwieber $
#SubjectAreas#: Access Layer
#DescEnd#
*/
(
    cy_week
    , cy_week_seq
    , min_dat_calendar_week
    , max_dat_calendar_week
    , min_cy_month
    , max_cy_month
    , min_dat_calendar_month
    , dat_calc
    , max_dat_calendar_month_plan
    , min_dat_calendar_month_py
    , dat_calc_py
    , max_dat_calendar_month_py_plan
    , max_dat_calendar_month_act
    , max_dat_calendar_month_py_act
)
AS
SELECT
cy_week,
cy_week_seq,
min_dat_calendar_week,
max_dat_calendar_week,
min_cy_month,
max_cy_month,
min_dat_calendar_month,
dat_calc,
max_dat_calendar_month_plan,
min_dat_calendar_month_py,
dat_calc_py,
max_dat_calendar_month_py_plan,
max_dat_calendar_month_act,
max_dat_calendar_month_py_act
FROM p_lew_mart_msi.v_bo_perf_cal_list_mth_1
;





