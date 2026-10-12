/*
#----------------------------------------------------------------------------
# Description:
# This view provides static values for measurement calculations on measurement (cm and inch) and internal organisation level.
#
#-----------------------------------------------------------------------------
# History:
#  1.0     30.01.2023      Patrick Mueller          Initial Version
#
#-----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_fe_mstr_toolbox_spiegel.v_spaceman_int_org_measurement (int_org_sid, metric_system_id,
metric_system_name, metric_system_weight_name, factor, factor_weight, dd_600_width, dd_600_depth, dd_665_width,
dd_800_width, dd_800_depth, ep_800_depth, ep_1200_width, ep_1200_depth, ep_1330_width, pod_620_depth) AS SELECT
 int_org_sid,
 metric_system_id,
 metric_system_name,
 metric_system_weight_name,
 factor,
 factor_weight,
 dd_600_width,
 dd_600_depth,
 dd_665_width,
 dd_800_width,
 dd_800_depth,
 ep_800_depth,
 ep_1200_width,
 ep_1200_depth,
 ep_1330_width,
 pod_620_depth
FROM ldl_fe_mstr_toolbox_spiegel.t_spaceman_int_org_measurement;