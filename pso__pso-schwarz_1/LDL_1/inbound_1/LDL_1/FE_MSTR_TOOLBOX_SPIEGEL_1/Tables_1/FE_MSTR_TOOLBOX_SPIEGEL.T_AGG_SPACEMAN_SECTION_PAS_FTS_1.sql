/*
#----------------------------------------------------------------------------
# Description:
# This table provides the agreggated KPIs on section level.
#
#-----------------------------------------------------------------------------
# History:
#  1.0     30.01.2023      Patrick Mueller          Initial Version
#
#-----------------------------------------------------------------------------
*/
CREATE TABLE FE_MSTR_TOOLBOX_SPIEGEL.T_AGG_SPACEMAN_SECTION_PAS_FTS_1
(
	  INT_ORG_SID NUMBER(38,0),
	 SPACEMAN_SECTION_SID NUMBER(38,0),
	 SECTION_WIDTH_MEAS NUMBER(38,11),
	 SHELF_WIDTH_MEAS NUMBER(38,11),
	 MAX_POTENTIAL_CONTACT_DISTANCE NUMBER(38,12),
	 MAX_POTENTIAL_CONTACT_DISTANCE_5 NUMBER(38,12),
	 AVG_KOLLI NUMBER(38,12),
	 AVG_EINZEL NUMBER(38,12),
	 CNT_CASES NUMBER(38,0),
	 CNT_ITEM_1 NUMBER(38,0),
	 SECTION_SELECTION_ID NUMBER(38,0),
	 METRIC_SYSTEM_ID NUMBER(38,0),
	 PAS_TYPE VARCHAR(20),
	 HIGHER_MEAS NUMBER(38,0),
	 SHELF_METER NUMBER(38,6)
);
