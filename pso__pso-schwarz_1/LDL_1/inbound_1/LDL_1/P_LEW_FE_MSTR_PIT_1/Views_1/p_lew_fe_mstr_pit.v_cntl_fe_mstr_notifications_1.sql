/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022/2023
#-------------------------------------------------------------------------------
# Interface : View for ETL_LOGGING
#-------------------------------------------------------------------------------
# Describtion: Create View for ETL_LOGGING
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2023-03-10 Andreas Kurz	    Initial version
#  1.1  2023-03-13 Nikolai Toknov	Cosmetic changes
#  1.2  2025-02-04 Nikolai Toknov	replace ampersand to char(38)
#  1.3  2025-03-24 Nikolai Toknov	Change for Azure-pipeline
#-------------------------------------------------------------------------------
*/

/*
USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R60001;
--USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_QS;
--USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_CLONE_AP0123442_AKTIONSTYPEN;
USE SCHEMA 		P_LEW_FE_MSTR_PIT; 
*/

/* 
---------------------------------------------------------------------
0. Create View Table in V_ETL_LOGGING
------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_FE_MSTR_PIT.V_CNTL_FE_MSTR_NOTIFICATIONS_1
COMMENT = 'Access View Kontroll Enduser Notifications on Startpage'
AS
SELECT

	  nt.NOTIFICATION_ID 			
	, nt.NOTIFICATION_HTML_DESCR_DE		
	, nt.NOTIFICATION_HTML_DESCR_EN


	, nt.NOTIFICATION_AUTHOR			
	, nt.NOTIFICATION_ENTRY_DT	
	, TO_CHAR(nt.NOTIFICATION_ENTRY_DT, 'YYYY-MM_1-DD')				AS NOTIFICATION_ENTRY_DT_CHAR	

	-- HTML Anzeige Text
	, iff(nt.NOTIFICATION_VISIBLE_FG = 1
		,'<p><h3>'
		|| 'Wichtige Mitteilung | Important Notification vom / of: ' || COALESCE(NOTIFICATION_ENTRY_DT_CHAR,'88881231')
		|| '</h3>'
		|| '<br>'
		|| COALESCE(NOTIFICATION_HTML_DESCR_DE,'')
		|| '<hr>'
		|| '<br>'
		|| COALESCE(NOTIFICATION_HTML_DESCR_EN,'')		
		|| '<br>'
		|| '<em>' || COALESCE(NOTIFICATION_AUTHOR,'')
		||  CHAR(38)||'nbsp;vom'|| CHAR(38)||'nbsp;'
		||  COALESCE(NOTIFICATION_ENTRY_DT_CHAR,'88881231')
		|| '</em>'		
		|| '</p>'
		, NULL
		) AS NOTIFICATION_HTML_TAG
	  
	, nt.NOTIFICATION_VISIBLE_FG		

	, nt.VALID_FROM_DT 				
	, nt.VALID_TO_DT 				
	, nt.VERSION_NR 					
	, nt.CURRENT_FG 					

	, nt.SOURCE_SYSTEM_ID 			

	-- technical fields
	, nt.DELETED_FG			
	, nt.DWH_CREATED_TS		
	, nt.DWH_UPDATED_TS		
	-- FORMAT Load ID yyyyMMddHHmmssffff + 99
	, TO_CHAR( nt.LOAD_ID ) 																AS LOAD_ID



	, iff (
			  nt.NOTIFICATION_ID >= 0
			, (DENSE_RANK () OVER (ORDER BY nt.NOTIFICATION_ID, nt.NOTIFICATION_ENTRY_DT ASC) -2 ) * (-1) 
			, NULL
		)
		MOVING_RUN_ID_FROM_CURRENT

	, MAX(nt.NOTIFICATION_ID) OVER(ORDER BY NULL)											AS MAX_NOTIFICATION_ID
FROM 

	P_LEW_FE_MSTR_PIT.T_CNTL_FE_MSTR_NOTIFICATIONS_1 nt
		
WHERE TRUE 	
	AND nt.DELETED_FG 					= 0
	AND nt.CURRENT_FG 					= 1
	--AND nt.NOTIFICATION_ID				> 0
	AND CURRENT_DATE()					BETWEEN nt.VALID_FROM_DT AND nt.VALID_TO_DT
;

-- SELECT * FROM P_LEW_FE_MSTR_PIT.V_CNTL_FE_MSTR_NOTIFICATIONS_1 WHERE TRUE 
/* --- EOF - END OF FILE --- */


