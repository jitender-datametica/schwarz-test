CREATE OR REPLACE VIEW s_conl_workbench.v_mis_elke_operations
AS
(SELECT
LJ.business_year,
CASE
WHEN LJ.report_month <=2 THEN cast(TRUNC(concat(trim(to_char(LJ.business_year+1,'0000')),trim(to_char(LJ.report_month,'00')))) as INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/
else cast(TRUNC(concat(trim(to_char(LJ.business_year,'0000')),trim(to_char(LJ.report_month,'00')))) as INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/ END as booking_month,
LJ.report_month,
LJ.warehouse_number as warehouse_id,
LJ.net_picking_return_op as net_picking_return_op_lj,
VJ.net_picking_return_op as net_picking_return_op_vj,
LJ.net_picking_return_op - VJ.net_picking_return_op as delta_vj_net_picking_return_op
FROM
(SELECT
business_year,
report_month,
warehouse_number,
net_picking_return_op
FROM s_conl_workbench.t_i_elke_operations
 where business_year=2020
 ) as LJ
 inner join
 (SELECT
business_year,
report_month,
warehouse_number,
net_picking_return_op
FROM s_conl_workbench.t_i_elke_operations
 where business_year=2019
 ) as VJ
 on  LJ.report_month=VJ.report_month
 and LJ.warehouse_number=VJ.warehouse_number
 where 1 = 1
);


