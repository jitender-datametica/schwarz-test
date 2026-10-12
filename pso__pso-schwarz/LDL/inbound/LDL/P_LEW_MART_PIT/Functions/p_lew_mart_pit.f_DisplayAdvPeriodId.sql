/*
#-------------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : DDL for CNTL_PROCESSING_PARAM
#-------------------------------------------------------------------------------
# Describtion: Output ADV_PERIOD_ID in more human readable format
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2024-02-26 Andreas Kurz 	Changed Format to:
#										YYYYWW + '_' + YYYYMMDD + '_' + YYYYMMDD
#  1.1  2025-03-24 Nikolai Toknov	Change for Azure-pipeline
#-------------------------------------------------------------------------------
*/

/*
USE ROLE            R_LDL_D_PIT_ETL;
USE WAREHOUSE       WH_LDL_D_PIT_ETL_S;
USE DATABASE 		LDL_PRODUCTION_CLONE_PIT_R60001;
USE SCHEMA          P_LEW_MART_PIT;
 */
/* 
---------------------------------------------------------------------
Function	:	f_DisplayAdvPeriodID(pAdvWeekID INTEGER)
Input		:   pAdvWeekID INTEGER
Return		:	Parameter VARCHAR --> Default is ['-1']
Convert		:	None    
Description	: 	Retrieves the Adv Period ID Special Format 24 --> Tuesday to Thursday
Example		:	SELECT f_DisplayAdvPeriodID(2023052023052620230528) AS ADV_PERIOD_ID
------------------------------------------------------------------------
*/
CREATE OR REPLACE FUNCTION ldl_p_lew_mart_pit.f_displayadvperiodid(
  pAdvWeekID INT64
)
RETURNS STRING
AS (
  IF(
    pAdvWeekID < 0,
    '-1',
    CONCAT(
      SUBSTR(CAST(pAdvWeekID AS STRING), 1, 6),  '_',
      '20', SUBSTR(CAST(pAdvWeekID AS STRING), 7, 6), '_',
      '20', SUBSTR(CAST(pAdvWeekID AS STRING), 13, 6)
    )
  )
);

--SELECT P_LEW_MART_PIT.f_DisplayAdvPeriodID(202352231227240103)
-- End of f_GetAdvPeriodID 