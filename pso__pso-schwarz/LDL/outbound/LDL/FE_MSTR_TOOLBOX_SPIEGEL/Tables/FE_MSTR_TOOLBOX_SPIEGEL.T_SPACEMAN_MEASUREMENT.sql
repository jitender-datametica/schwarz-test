/*
#----------------------------------------------------------------------------
# Description:
# This table provides static values for measurement calculations on measurement level (cm and inch).
#
#-----------------------------------------------------------------------------
# History:
#  1.0     30.01.2023      Patrick Mueller          Initial Version
#
#-----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_fe_mstr_toolbox_spiegel.t_spaceman_measurement (
metric_system_id BIGNUMERIC(38,0) NOT NULL,
metric_system_name STRING(20) NOT NULL,
shelf_meter BIGNUMERIC(38,6) NOT NULL,
higher_meas BIGNUMERIC(38,0) NOT NULL,
pas_type STRING(20) DEFAULT '' NOT NULL,
metric_system_desc_full STRING(25) DEFAULT '' NOT NULL,
metric_system_desc_full_en STRING(25) DEFAULT '' NOT NULL
);