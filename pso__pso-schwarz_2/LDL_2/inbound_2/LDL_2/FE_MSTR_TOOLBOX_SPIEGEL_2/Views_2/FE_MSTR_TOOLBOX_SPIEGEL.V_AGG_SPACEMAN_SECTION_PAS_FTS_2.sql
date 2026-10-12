/*
#----------------------------------------------------------------------------
# Description:
# This view provides the agreggated KPIs on section level.
#
#-----------------------------------------------------------------------------
# History:
#  1.0     30.01.2023      Patrick Mueller          Initial Version
#  2.0     10.10.2024      Simeon Nikolaev          PAS_TYPE
#
#-----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW FE_MSTR_TOOLBOX_SPIEGEL.V_AGG_SPACEMAN_SECTION_PAS_FTS_2
(
   INT_ORG_SID
 , SPACEMAN_SECTION_SID
 , SECTION_WIDTH_MEAS
 , SHELF_WIDTH_MEAS
 , MAX_POTENTIAL_CONTACT_DISTANCE
 , MAX_POTENTIAL_CONTACT_DISTANCE_5
 , AVG_KOLLI
 , AVG_EINZEL
 , CNT_CASES
 , CNT_ITEM_2
 , SECTION_SELECTION_ID
 , METRIC_SYSTEM_ID
 , PAS_TYPE
 , HIGHER_MEAS
 , SHELF_METER
) AS
SELECT 
	   INT_ORG_SID
     , SPACEMAN_SECTION_SID
     , SECTION_WIDTH_MEAS
     , SHELF_WIDTH_MEAS
     , MAX_POTENTIAL_CONTACT_DISTANCE
     , MAX_POTENTIAL_CONTACT_DISTANCE_5
     , AVG_KOLLI
     , AVG_EINZEL
     , CNT_CASES
     , CNT_ITEM_2
     , SECTION_SELECTION_ID
     , METRIC_SYSTEM_ID
	 , PAS_TYPE
     , HIGHER_MEAS
     , SHELF_METER
FROM FE_MSTR_TOOLBOX_SPIEGEL.T_AGG_SPACEMAN_SECTION_PAS_FTS_2;