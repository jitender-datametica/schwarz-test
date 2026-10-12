/*
#----------------------------------------------------------------------------
# Description:
# This table provides static values for measurement calculations on measurement (cm and inch) and internal organisation level.
#
#-----------------------------------------------------------------------------
# History:
#  1.0     30.01.2023      Patrick Mueller          Initial Version
#
#-----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_fe_mstr_toolbox_spiegel.t_spaceman_int_org_measurement_1 (
int_org_sid BIGNUMERIC(38,0) NOT NULL,
metric_system_id BIGNUMERIC(38,0) NOT NULL,
metric_system_name STRING(20) NOT NULL,
metric_system_weight_name STRING(20),
factor NUMERIC(18,6) NOT NULL,
factor_weight NUMERIC(18,6),
dd_600_width BIGNUMERIC(38,6),
dd_600_depth BIGNUMERIC(38,6),
dd_665_width BIGNUMERIC(38,6),
dd_800_width BIGNUMERIC(38,6),
dd_800_depth BIGNUMERIC(38,6),
ep_800_depth BIGNUMERIC(38,6),
ep_1200_width BIGNUMERIC(38,6),
ep_1200_depth BIGNUMERIC(38,6),
ep_1330_width BIGNUMERIC(38,6),
pod_620_depth BIGNUMERIC(38,6)
);