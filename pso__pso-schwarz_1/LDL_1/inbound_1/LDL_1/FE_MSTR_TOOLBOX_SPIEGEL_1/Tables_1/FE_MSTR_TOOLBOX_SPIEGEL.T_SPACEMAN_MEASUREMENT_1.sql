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

CREATE TABLE FE_MSTR_TOOLBOX_SPIEGEL.T_SPACEMAN_MEASUREMENT_1
(
    METRIC_SYSTEM_ID NUMBER(38,0) NOT NULL,
    METRIC_SYSTEM_NAME VARCHAR(20) NOT NULL,
    SHELF_METER NUMBER(38,6) NOT NULL,
    HIGHER_MEAS NUMBER(38,0) NOT NULL,
    PAS_TYPE VARCHAR(20) NOT NULL DEFAULT'',
    METRIC_SYSTEM_DESC_FULL VARCHAR(25) NOT NULL DEFAULT'',
    METRIC_SYSTEM_DESC_FULL_EN VARCHAR(25) NOT NULL DEFAULT''
);