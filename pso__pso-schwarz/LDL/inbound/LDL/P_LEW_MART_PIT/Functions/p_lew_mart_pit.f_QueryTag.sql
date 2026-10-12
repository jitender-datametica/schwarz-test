/*
#-------------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : DDL for f_QueryTag(STRING)
#-------------------------------------------------------------------------------
# Describtion: Create DDL for f_QueryTag(STRING)
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-07-01 Andreas Kurz    Initial version
#-------------------------------------------------------------------------------
*/

/*
USE ROLE			R_LDL_D_PIT_ETL;
USE WAREHOUSE		WH_LDL_D_PIT_ETL_S;
--USE DATABASE		LDL_PRODUCTION_CLONE_PIT;
--USE DATABASE 		LDL_PRODUCTION_CLONE_HRK2EUR_PIT;
USE DATABASE		LDL_PRODUCTION_CLONE_EK_WA;
USE SCHEMA			P_LEW_MART_PIT;


 */
/* 
---------------------------------------------------------------------
FUNCTION	:	f_QueryTag(p_QueryLog STRING, p_ApplicationName STRING, P_RunClusteringDesc STRING )
Input		:   p_QueryLog 				STRING 
				p_ApplicationName 		STRING
    			P_RunClusteringDesc    	STRING --> iff NULL then Default [0] running in sequence
Return		:	String concatenated with relevant execution infos
Convert		:	None    
Description	: 	Initialize Performance, there is a max Runs (:= 100) to prevent endless loops
                Logging is also enables  but must be enabled! 
Example		:	SELECT f_QueryTag('PITonCloud', 'ETL Logging Start', NULL);
------------------------------------------------------------------------
*/


CREATE OR REPLACE FUNCTION ldl_p_lew_mart_pit.f_querytag(
    p_querylog STRING,
    p_applicationname STRING,
    p_runclusteringdesc STRING
)
RETURNS STRING
AS (
    SUBSTR(
        COALESCE(
            CONCAT(
                '<LOGGING ',
                'CLUSTER="', COALESCE(SUBSTR(p_runclusteringdesc,1,25),'[0]'), '" ',
                'APP="', COALESCE(SUBSTR(p_applicationname,1,25),'N/A'), '" ',
                'SESSION="N/A" ',
                'ROLE="N/A"',
                'DB="LDL_PRODUCTION" ',
                'USER="', SESSION_USER(), '" ',
                'WH="N/A"',
                'CLIENT="N/A"',
                COALESCE(SUBSTR(p_querylog,1,30),'N/A'),
                '</LOGGING>'
            ),
            'N/A - Error'
        ),
        1,
        250
    )
);
 -- End of f_QueryTag function

/* Testing f_QueryTag function */
/*
SET v_QUERY_TAG = (SELECT f_QueryTag('ETL Logging','PITonCloud',NULL))
;
ALTER SESSION SET QUERY_TAG = $v_QUERY_TAG
; 
*/

/* --- EOF - END OF FILE --- */    