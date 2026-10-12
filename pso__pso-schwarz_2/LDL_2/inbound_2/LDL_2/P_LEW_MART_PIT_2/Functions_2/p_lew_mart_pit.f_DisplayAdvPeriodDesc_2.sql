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
USE SCHEMA          P_LEW_MART_PIT_2;
 */
-- Example:
--SELECT P_LEW_MART_PIT.f_DisplayAdvPeriodDesc(20240301190121)
--2024/ WW03 2024-Jan-19, Fri bis 2024-Jan-21, Sun
CREATE OR REPLACE FUNCTION ldl_p_lew_mart_pit.f_displayadvperioddesc(pAdvWeekID INT64)
RETURNS STRING
AS (

IF(pAdvWeekID < 0
    , '-1'
    , CONCAT(
        SUBSTR(CAST(pAdvWeekID AS STRING),1,4) , '/ WW' ,
        SUBSTR(CAST(pAdvWeekID AS STRING),5,2) , ' ' ,
        --TO_CHAR(TO_DATE(SUBSTRING(TO_CHAR(pAdvWeekID),1,4) || SUBSTRING(TO_CHAR(pAdvWeekID),7,4),'YYYYMMDD'),'YYYY-MM_2-DD') || ' bis ' ||
        --TO_CHAR(TO_DATE(SUBSTRING(TO_CHAR(pAdvWeekID),1,4) || SUBSTRING(TO_CHAR(pAdvWeekID),11,4),'YYYYMMDD'),'YYYY-MM_2-DD')
        --TO_CHAR(TRY_TO_DATE(SUBSTRING(TO_CHAR(pAdvWeekID),1,4) || SUBSTRING(TO_CHAR(pAdvWeekID),7,6),'YYMMDD'),'YY-Mon-DD, DY') || ' bis ' ||
        FORMAT_DATE(
            '%Y-%b-%d, %a',
            SAFE.PARSE_DATE(
                '%Y%m%d',
                CONCAT(
                    '20',
                    SUBSTR(CAST(pAdvWeekID AS STRING),7,6)
                )
            )
        ) , ' bis ' ,
        FORMAT_DATE(
            '%Y-%b-%d, %a',
            SAFE.PARSE_DATE(
                '%Y%m%d',
                CONCAT(
                    '20',
                    SUBSTR(CAST(pAdvWeekID AS STRING),13,6)
                )
            )
        )
        --TO_CHAR(TRY_TO_DATE(SUBSTRING(TO_CHAR(pAdvWeekID),1,4) || SUBSTRING(TO_CHAR(pAdvWeekID),13,6),'YYMMDD'),'YY-Mon-DD, DY')
    )
)

);


--SELECT P_LEW_MART_PIT.f_DisplayAdvPeriodDesc(202352231227240103)

/* --- EOF - END OF FILE --- */