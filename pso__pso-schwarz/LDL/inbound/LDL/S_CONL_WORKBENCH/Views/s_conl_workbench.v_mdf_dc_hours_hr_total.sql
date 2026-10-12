CREATE OR REPLACE VIEW s_conl_workbench.v_mdf_dc_hours_hr_total
AS
(SELECT
intern.business_year,
intern.booking_month,
intern.warehouse_nr,
intern.cost_center,
intern.head_count_lj,
intern.head_count_vj,
intern.head_count_hk_lj,
intern.head_count_hk_vj,
intern.temporary_helper_12_hours_lj,
intern.temporary_helper_12_hours_vj,
intern.contract_non_permanent_ft_lj,
intern.contract_non_permanent_ft_vj,
intern.contract_non_permanent_pt_lj,
intern.contract_non_permanent_pt_vj,
intern.contract_non_permanent_hk_lj,
intern.contract_non_permanent_hk_vj,
intern.contract_permanent_ft_lj,
intern.contract_permanent_ft_vj,
intern.contract_permanent_pt_lj,
intern.contract_permanent_pt_vj,
intern.contract_permanent_0_hours_lj,
intern.contract_permanent_0_hours_vj,
intern.contract_permanent_hk_lj,
intern.contract_permanent_hk_vj,
intern.years_service_lj,
intern.years_service_vj,
intern.amount_women_diversity_lj,
intern.amount_women_diversity_vj,
intern.amount_total_diversity_lj,
intern.amount_total_diversity_vj,
intern.FTE_lj,
intern.FTE_vj,
intern.fte_hours_month_lj,
intern.fte_hours_month_vj,
intern.employee_inflow_lj,
intern.employee_inflow_vj,
intern.employee_outflow_lj,
intern.employee_outflow_vj,
intern.cla_hourly_wage_lj,
intern.cla_hourly_wage_vj,
intern.hours_nett_lj,
intern.hours_nett_vj,
intern.hours_gross_lj,
intern.hours_gross_vj,
intern.hours_gross_hk_lj,
intern.hours_gross_hk_vj,
intern.hours_overtime_lj,
intern.hours_overtime_vj,
intern.hours_worked_hk_lj,
intern.hours_worked_hk_vj,
intern.hours_vacation_lj,
intern.hours_vacation_vj,
intern.hours_holiday_lj,
intern.hours_holiday_vj,
intern.hours_sick_lj,
intern.hours_sick_vj,
intern.hours_sick_absent_9GLC_lj,
intern.hours_sick_absent_9GLC_vj,
intern.hours_other_lj,
intern.hours_other_vj,
intern.hours_contract_lj,
intern.hours_contract_vj,
intern.hours_contract_excl_hk_lj,
intern.hours_contract_excl_hk_vj,
intern.hours_contract_hk_lj,
intern.hours_contract_hk_vj,
intern.surcharge_overtime_lj,
intern.surcharge_overtime_vj,
intern.surcharge_late_night_hours_lj,
intern.surcharge_late_night_hours_vj,
extern.hours_external_lj,
extern.hours_external_vj,
ages.Headcount_21min_lj,
ages.Headcount_21plus_lj,
ages.Headcount_21min_vj,
ages.Headcount_21plus_vj,
yos.years_service2_lj,
yos.years_service2_vj,
yos.Fte_parttime_factor_lj,
yos.Fte_parttime_factor_vj
FROM
(
-- INTERN
SELECT
business_year,
booking_month,
warehouse_nr,
cost_center,
sum(head_count_lj)  as head_count_lj,
sum(head_count_vj)  as head_count_vj,
sum(head_count_hk_lj)  as head_count_hk_lj,
sum(head_count_hk_vj)  as head_count_hk_vj,
sum(temporary_helper_12_hours_lj) as temporary_helper_12_hours_lj,
sum(temporary_helper_12_hours_vj) as temporary_helper_12_hours_vj,
sum(contract_non_permanent_ft_lj) as contract_non_permanent_ft_lj,
sum(contract_non_permanent_ft_vj) as contract_non_permanent_ft_vj,
sum(contract_non_permanent_pt_lj) as contract_non_permanent_pt_lj,
sum(contract_non_permanent_pt_vj) as contract_non_permanent_pt_vj,
sum(contract_non_permanent_hk_lj) as contract_non_permanent_hk_lj,
sum(contract_non_permanent_hk_vj) as contract_non_permanent_hk_vj,
sum(contract_permanent_ft_lj) as contract_permanent_ft_lj,
sum(contract_permanent_ft_vj) as contract_permanent_ft_vj,
sum(contract_permanent_pt_lj) as contract_permanent_pt_lj,
sum(contract_permanent_pt_vj) as contract_permanent_pt_vj,
sum(contract_permanent_0_hours_lj) as contract_permanent_0_hours_lj,
sum(contract_permanent_0_hours_vj) as contract_permanent_0_hours_vj,
sum(contract_permanent_hk_lj) as contract_permanent_hk_lj,
sum(contract_permanent_hk_vj) as contract_permanent_hk_vj,
sum(years_service_lj) as years_service_lj,
sum(years_service_vj) as years_service_vj,
sum(amount_women_diversity_lj) as amount_women_diversity_lj,
sum(amount_women_diversity_vj) as amount_women_diversity_vj,
sum(amount_total_diversity_lj) as amount_total_diversity_lj,
sum(amount_total_diversity_vj) as amount_total_diversity_vj,
sum(FTE_lj)  as FTE_lj,
sum(FTE_vj)  as FTE_vj,
AVG(fte_hours_month_lj) as fte_hours_month_lj,
AVG(fte_hours_month_vj) as fte_hours_month_vj,
sum(employee_inflow_lj) as employee_inflow_lj,
sum(employee_inflow_vj) as employee_inflow_vj,
sum(employee_outflow_lj)as employee_outflow_lj,
sum(employee_outflow_vj)as employee_outflow_vj,
AVG(CASE
WHEN cla_hourly_wage_lj>0 THEN cla_hourly_wage_lj
else null END) cla_hourly_wage_lj,
AVG(CASE
WHEN cla_hourly_wage_vj>0 THEN cla_hourly_wage_vj
else null END) cla_hourly_wage_vj,
CAST(sum(hours_nett_lj) AS Number(38,5)) as hours_nett_lj,
CAST(sum(hours_nett_vj) AS Number(38,5)) as hours_nett_vj,
CAST(sum(hours_gross_lj) AS Number(38,5)) as hours_gross_lj,
CAST(sum(hours_gross_vj) AS Number(38,5)) as hours_gross_vj,
CAST(sum(hours_gross_hk_lj) AS Number(38,5)) as hours_gross_hk_lj,
CAST(sum(hours_gross_hk_vj) AS Number(38,5)) as hours_gross_hk_vj,
CAST(sum(hours_overtime_lj) AS Number(38,5)) as hours_overtime_lj,
CAST(sum(hours_overtime_vj) AS Number(38,5)) as hours_overtime_vj,
CAST(sum(hours_worked_hk_lj) AS Number(38,5)) as hours_worked_hk_lj,
CAST(sum(hours_worked_hk_vj) AS Number(38,5)) as hours_worked_hk_vj,
CAST(sum(hours_vacation_lj) AS Number(38,5)) as hours_vacation_lj,
CAST(sum(hours_vacation_vj) AS Number(38,5)) as hours_vacation_vj,
CAST(sum(hours_holiday_lj) AS Number(38,5)) as hours_holiday_lj,
CAST(sum(hours_holiday_vj) AS Number(38,5)) as hours_holiday_vj,
CAST(sum(hours_sick_lj) AS Number(38,5)) as hours_sick_lj,
CAST(sum(hours_sick_vj) AS Number(38,5)) as hours_sick_vj,
CAST(sum(hours_sick_absent_9GLC_lj) AS Number(38,5)) as hours_sick_absent_9GLC_lj,
CAST(sum(hours_sick_absent_9GLC_vj) AS Number(38,5)) as hours_sick_absent_9GLC_vj,
CAST(sum(hours_other_lj) AS Number(38,5)) as hours_other_lj,
CAST(sum(hours_other_vj) AS Number(38,5)) as hours_other_vj,
CAST(sum(hours_contract_lj) AS Number(38,5)) as hours_contract_lj,
CAST(sum(hours_contract_vj) AS Number(38,5)) as hours_contract_vj,
CAST(sum(hours_contract_excl_hk_lj) AS Number(38,5)) as hours_contract_excl_hk_lj,
CAST(sum(hours_contract_excl_hk_vj) AS Number(38,5)) as hours_contract_excl_hk_vj,
CAST(sum(hours_contract_hk_lj) AS Number(38,5)) as hours_contract_hk_lj,
CAST(sum(hours_contract_hk_vj) AS Number(38,5)) as hours_contract_hk_vj,
CAST(sum(surcharge_overtime_lj) AS Number(38,5)) as surcharge_overtime_lj,
CAST(sum(surcharge_overtime_vj) AS Number(38,5)) as surcharge_overtime_vj,
CAST(sum(surcharge_late_night_hours_lj) AS Number(38,5)) as surcharge_late_night_hours_lj,
CAST(sum(surcharge_late_night_hours_vj) AS Number(38,5)) as surcharge_late_night_hours_vj
FROM s_conl_workbench.v_mdf_dc_hours_hr_intern
group by
 business_year
,booking_month
,warehouse_nr
,cost_center
) as INTERN
LEFT OUTER JOIN
(
-- EXTERN
SELECT
business_year,
booking_month,
warehouse_nr,
cost_center,
sum(hours_external_lj) as hours_external_lj,
sum(hours_external_vj) as hours_external_vj
FROM s_conl_workbench.v_mdf_dc_hours_hr_extern
group by
 business_year
,booking_month
,warehouse_nr
,cost_center
) as EXTERN
ON  intern.business_year = extern.business_year
and intern.booking_month = extern.booking_month
and intern.warehouse_nr = extern.warehouse_nr
and intern.cost_center = extern.cost_center
LEFT OUTER JOIN
(
-- AGES
SELECT
business_year,
booking_month,
warehouse_nr,
cost_center,
sum(Headcount_21min_lj)  as Headcount_21min_lj,
sum(Headcount_21plus_lj) as Headcount_21plus_lj,
sum(Headcount_21min_vj)  as Headcount_21min_vj,
sum(Headcount_21plus_vj) as Headcount_21plus_vj
FROM s_conl_workbench.v_mdf_dc_hours_hr_ages
group by
 business_year
,booking_month
,warehouse_nr
,cost_center
) as Ages
ON  intern.business_year = ages.business_year
and intern.booking_month = ages.booking_month
and intern.warehouse_nr = ages.warehouse_nr
and intern.cost_center = ages.cost_center
LEFT OUTER JOIN
(
-- Years of service
SELECT
business_year,
booking_month,
warehouse_nr,
cost_center,
sum(years_service_lj) as years_service2_lj,
sum(years_service_vj) as years_service2_vj,
CAST(sum(Fte_parttime_factor_lj/100) AS Number(38,5)) as Fte_parttime_factor_lj,
CAST(sum(Fte_parttime_factor_vj/100) AS Number(38,5)) as Fte_parttime_factor_vj
FROM s_conl_workbench.v_mdf_dc_hours_hr_years_services
group by
 business_year
,booking_month
,warehouse_nr
,cost_center
) as YOS
ON  intern.business_year = yos.business_year
and intern.booking_month = yos.booking_month
and intern.warehouse_nr = yos.warehouse_nr
and intern.cost_center = yos.cost_center
);



