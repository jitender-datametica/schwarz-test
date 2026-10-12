/*
#===============================================================================

#===============================================================================
# History
#  1.0 2021-05-28 Pawel Wieczorek   SF: adding new view
#===============================================================================
#
*/

/* ==============================================================================
   View DDL
   ============================================================================== */


CREATE OR REPLACE VIEW P_LEW_MART_LIDL_DIGITAL_AC.V_LIDLPLUS_CONFIG_CLIENT_2
COMMENT = 'Lidlplus : Config table'
(
 CLIENT_ID
,COUNTRY_CD
,ROLLOUT_START_DT
,FULL_CLIENT_ROLLOUT_DT
,REPORTING_START_DT
,DWH_LOAD_ID
,DWH_CREATED
,DWH_UPDATED
)
AS
SELECT
 CLIENT_ID
,COUNTRY_CD
,ROLLOUT_START_DT
,FULL_CLIENT_ROLLOUT_DT
,REPORTING_START_DT
,DWH_LOAD_ID
,DWH_CREATED
,DWH_UPDATED
FROM P_LEW_PROCESS.T_LIDLPLUS_CONFIG_CLIENT_2
;


