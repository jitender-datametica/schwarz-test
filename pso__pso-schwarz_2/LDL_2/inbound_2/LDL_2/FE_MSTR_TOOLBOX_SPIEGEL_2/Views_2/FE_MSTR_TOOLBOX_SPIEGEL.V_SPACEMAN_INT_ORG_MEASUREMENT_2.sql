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

CREATE OR REPLACE VIEW FE_MSTR_TOOLBOX_SPIEGEL.V_SPACEMAN_INT_ORG_MEASUREMENT_2(
   INT_ORG_SID
 , METRIC_SYSTEM_ID
 , METRIC_SYSTEM_NAME
 , METRIC_SYSTEM_WEIGHT_NAME
 , FACTOR
 , FACTOR_WEIGHT
 , DD_600_WIDTH
 , DD_600_DEPTH
 , DD_665_WIDTH
 , DD_800_WIDTH
 , DD_800_DEPTH
 , EP_800_DEPTH
 , EP_1200_WIDTH
 , EP_1200_DEPTH
 , EP_1330_WIDTH
 , POD_620_DEPTH
) AS
SELECT
   INT_ORG_SID
 , METRIC_SYSTEM_ID
 , METRIC_SYSTEM_NAME
 , METRIC_SYSTEM_WEIGHT_NAME
 , FACTOR
 , FACTOR_WEIGHT
 , DD_600_WIDTH
 , DD_600_DEPTH
 , DD_665_WIDTH
 , DD_800_WIDTH
 , DD_800_DEPTH
 , EP_800_DEPTH
 , EP_1200_WIDTH
 , EP_1200_DEPTH
 , EP_1330_WIDTH
 , POD_620_DEPTH
FROM FE_MSTR_TOOLBOX_SPIEGEL.T_SPACEMAN_INT_ORG_MEASUREMENT_2;