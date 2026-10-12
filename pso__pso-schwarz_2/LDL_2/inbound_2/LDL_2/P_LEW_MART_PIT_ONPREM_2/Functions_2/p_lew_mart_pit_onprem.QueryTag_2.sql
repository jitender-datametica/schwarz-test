CREATE OR REPLACE FUNCTION ldl_p_lew_mart_pit_onprem.querytag(
    p_querylog STRING,
    p_applicationname STRING,
    p_runclusteringdesc STRING
)
RETURNS STRING
AS (
-- // ---------------------------------------------------------------------
-- // FUNCTION	:	QueryTag(p_QueryLog STRING, p_ApplicationName STRING, P_RunClusteringDesc STRING )
-- // Input		:   p_QueryLog 				STRING 
-- // 				p_ApplicationName 		STRING
-- //     			P_RunClusteringDesc    	STRING  iff NULL then Default [0] running in sequence
-- // Return		:	String concatenated with relevant execution infos
-- // Convert		:	None    
-- // Description	: 	Initialize Performance, there is a max Runs (:= 100) to prevent endless loops
-- //                 Logging is also enables  but must be enabled! 
-- // Example		:	SELECT QueryTag('PITonPREM', 'ETL Logging Start', NULL);
-- // ------------------------------------------------------------------------       
-- // # History:
-- // #  1.0  2021-07-01 Andreas Kurz    Initial version

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