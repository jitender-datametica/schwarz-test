CREATE OR REPLACE VIEW s_conl_workbench.v_mis_elke_processen
AS
(SELECT
LJ.business_year,
CASE
WHEN LJ.report_month <=2 THEN cast(TRUNC(concat(trim(to_char(LJ.business_year+1,'0000')),trim(to_char(LJ.report_month,'00')))) as INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/
else cast(TRUNC(concat(trim(to_char(LJ.business_year,'0000')),trim(to_char(LJ.report_month,'00')))) as INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/ END as booking_month,
LJ.report_month,
LJ.warehouse_number as warehouse_id,
LJ.pallet_non_stores  as pallet_non_stores_lj,
VJ.pallet_non_stores  as pallet_non_stores_vj,
LJ.pallet_non_stores - VJ.pallet_non_stores as delta_vj_pallet_non_stores,
LJ.trucks_count as trucks_count_lj,
VJ.trucks_count as trucks_count_vj,
LJ.trucks_count - VJ.trucks_count as  delta_vj_trucks_count,
LJ.shifts_count as shifts_count_lj,
VJ.shifts_count as shifts_count_vj,
LJ.shifts_count - VJ.shifts_count as delta_vj_shifts_count,
LJ.time_used as time_used_lj,
VJ.time_used as time_used_vj,
LJ.time_used - VJ.time_used as delta_vj_time_used,
LJ.tours_count as tours_count_lj,
VJ.tours_count as tours_count_vj,
LJ.tours_count - VJ.tours_count as delta_vj_tours_count,
LJ.tours_per_shift as tours_per_shift_lj,
VJ.tours_per_shift as tours_per_shift_vj,
LJ.tours_per_shift - VJ.tours_per_shift as delta_vj_tours_per_shift,
LJ.pallets_per_shift as pallets_per_shift_lj,
VJ.pallets_per_shift as pallets_per_shift_vj,
LJ.pallets_per_shift - VJ.pallets_per_shift as delta_vj_pallets_per_shift,
LJ.kilometers as kilometers_lj,
VJ.kilometers as kilometers_vj,
LJ.kilometers - VJ.kilometers as delta_vj_kilometers,
LJ.km_per_pallet as km_per_pallet_lj,
VJ.km_per_pallet as km_per_pallet_vj,
LJ.km_per_pallet - VJ.km_per_pallet as delta_vj_km_per_pallet,
LJ.utilization_percentage as utilization_percentage_lj,
VJ.utilization_percentage as utilization_percentage_vj,
LJ.utilization_percentage - VJ.utilization_percentage as delta_vj_utilization_percentage
FROM
(SELECT
business_year,
report_month,
warehouse_number,
pallet_non_stores,
trucks_count,
shifts_count,
time_used,
tours_count,
tours_per_shift,
pallets_per_shift,
kilometers,
km_per_pallet,
utilization_percentage
FROM s_conl_workbench.t_i_elke_processen
 where business_year=2021
 ) as LJ
 inner join
 (SELECT
business_year,
report_month,
warehouse_number,
pallet_non_stores,
trucks_count,
shifts_count,
time_used,
tours_count,
tours_per_shift,
pallets_per_shift,
kilometers,
km_per_pallet,
utilization_percentage
FROM s_conl_workbench.t_i_elke_processen
 where business_year=2020
 ) as VJ
 on  LJ.report_month=VJ.report_month
 and LJ.warehouse_number=VJ.warehouse_number
 where 1 = 1
);




