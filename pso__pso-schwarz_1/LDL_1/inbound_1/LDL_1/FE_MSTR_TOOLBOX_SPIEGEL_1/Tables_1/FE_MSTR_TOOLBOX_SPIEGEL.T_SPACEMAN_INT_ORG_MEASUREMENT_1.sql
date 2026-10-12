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
CREATE TABLE FE_MSTR_TOOLBOX_SPIEGEL.T_SPACEMAN_INT_ORG_MEASUREMENT_1 (
	INT_ORG_SID NUMBER(38,0) NOT NULL,
	METRIC_SYSTEM_ID NUMBER(38,0) NOT NULL,
	METRIC_SYSTEM_NAME VARCHAR(20) NOT NULL,
	METRIC_SYSTEM_WEIGHT_NAME VARCHAR(20),
	FACTOR NUMBER(18,6) NOT NULL,
	FACTOR_WEIGHT NUMBER(18,6),
	DD_600_WIDTH NUMBER(38,6),
	DD_600_DEPTH NUMBER(38,6),
	DD_665_WIDTH NUMBER(38,6),
	DD_800_WIDTH NUMBER(38,6),
	DD_800_DEPTH NUMBER(38,6),
	EP_800_DEPTH NUMBER(38,6),
	EP_1200_WIDTH NUMBER(38,6),
	EP_1200_DEPTH NUMBER(38,6),
	EP_1330_WIDTH NUMBER(38,6),
	POD_620_DEPTH NUMBER(38,6)
);