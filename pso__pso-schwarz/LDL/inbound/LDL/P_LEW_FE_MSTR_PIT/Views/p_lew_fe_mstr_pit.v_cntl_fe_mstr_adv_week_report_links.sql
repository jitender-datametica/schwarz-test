/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : VIEW fOR V_CNTL_FE_MSTR_ADV_WEEK_REPORT_LINKS
#-------------------------------------------------------------------------------
# Describtion: CREATE VIEW fOR V_CNTL_FE_MSTR_ADV_WEEK_REPORT_LINKS
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2022-07-20 Andreas Kurz  Initial version
#  2.2	2022-07-22 Nikolai Toknov  	Changing the script for DevOps
#  4.0  2023-11-06 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC. 
#-------------------------------------------------------------------------------
*/
/*
USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R60001;
USE SCHEMA 		P_LEW_FE_MSTR_PIT; 


SELECT get_ddl('table','P_LEW_MART_PIT.T_CNTL_FE_MSTR_REPORT_TOC');

DESC TABLE P_LEW_FE_MSTR_PIT.T_CNTL_FE_MSTR_REPORT_TOC;
DESC TABLE P_LEW_FE_MSTR_PIT.T_CNTL_FE_MSTR_PARAM;

DROP VIEW P_LEW_FE_MSTR_PIT.V_CNTL_FE_MSTR_ADV_WEEK_REPORT_LINKS

*/


CREATE OR REPLACE VIEW P_LEW_FE_MSTR_PIT.V_CNTL_FE_MSTR_ADV_WEEK_REPORT_LINKS
COMMENT = 'Source View Control Table for Adv.-Week Rport Links'
AS
SELECT
     toc.REPORT_ID
   , adw.client_id
   , adw.ADV_WEEK_MSTR_ID

   , toc.VALID_FROM_DT
   , toc.VALID_TO_DT
   , toc.REPORT_SORT_VAL
   , toc.REPORT_NAME
   , toc.REPORT_GUID
   , toc.REPORT_ANNOTATION
   , toc.REPORT_VISIBLE_FG
   , toc.REPORT_TEASER_FG
   , toc.REPORT_TYPE_FG
   , toc.REPORT_PANEL_NAME
   , toc.REPORT_PANEL_PSKEY
   , toc.REPORT_PANEL_PKEY
   , 1::INTEGER 						AS _COUNT
   
   -- 
   , CASE WHEN toc.REPORT_TEASER_FG = 0 AND REPORT_TYPE_FG = 0 THEN
        '<a style="color:#ffffff;text-decoration: none;" title="Detailanzeige f' || CHAR (38) ||'uuml;r erweiterte Grafische Analyse'
     || toc.REPORT_NAME
     || ' f' || CHAR (38) || 'uuml;r Werbewoche: '
     || adw.ADV_WEEK_LDESCR
     || ' und Land: '
     || adw.COUNTRY_DESCR

     || '" HREF="mstrWeb'
     -- ?
     || CHR(63)
     || pa.PA41_VALUE
     || toc.REPORT_GUID
     || pa.PA39_VALUE
	 || CHAR (38)
     || 'elementsPromptAnswers='

     -- E  Land ( Basic ) = ?!
     || CASE WHEN pa.PA06_VALUE IS NOT NULL THEN
         pa.PA06_VALUE || TO_CHAR( adw.client_id ) || ','
        ELSE NULL END
	
	--  E Vergleichswerbewoche = ?!  
     || CASE WHEN pa.PA09_VALUE IS NOT NULL THEN
         pa.PA09_VALUE || '#RLTDADVWEEKMSTRID#' || ','
         ELSE NULL END
		 
     -- E Werbewoche = ?!
     || CASE WHEN pa.PA08_VALUE IS NOT NULL THEN
         pa.PA08_VALUE ||TO_CHAR( adw.ADV_WEEK_MSTR_ID ) ||  ','
        ELSE NULL END


     || '" '
     || pa.PA26_VALUE
     || '> '
     || pa.PA44_VALUE
     || '<center>'
     || pa.PA37_VALUE
     || pa.PA42_VALUE
     || SUBSTR(toc.REPORT_NAME,1,35)
     || '</span></center></div>'
     || '</a>'
   ELSE
        pa.PA44_VALUE
     || '<center>'
     || pa.PA38_VALUE
     || pa.PA43_VALUE
     || SUBSTR(toc.REPORT_NAME,1,35)
     || '</span></center></div>'
   END AS HTML_WEB_LINK_IMAGE

   , CASE WHEN toc.REPORT_TEASER_FG = 0 AND REPORT_TYPE_FG = 0 THEN
        '<a style="color:#000000" title="Detailanzeige f'|| CHAR (38) ||'uuml;r Erweiterte Grafische Analyse'
     || toc.REPORT_NAME
     || ' f'|| CHAR (38) ||'uuml;r Werbewoche: '
     || adw.ADV_WEEK_LDESCR
     || ' und Land: '
     || adw.COUNTRY_DESCR

     || '" HREF="mstrWeb'
     -- ?
     || CHR(63)
     || pa.pa41_value
     || toc.REPORT_GUID
     || pa.PA39_VALUE
	 || CHAR (38) 
     || 'elementsPromptAnswers='

     -- E  Land ( Basic ) = ?!
     || CASE WHEN pa.PA06_VALUE IS NOT NULL THEN
         pa.PA06_VALUE || TO_CHAR( adw.CLIENT_ID ) || ','
        ELSE NULL END

	--  E Vergleichswerbewoche = ?!  
     || CASE WHEN pa.PA09_VALUE IS NOT NULL THEN
         pa.PA09_VALUE || '#RLTDADVWEEKMSTRID#' || ','
         ELSE NULL END
		   
     -- E Werbewoche = ?!
     || CASE WHEN pa.PA08_VALUE IS NOT NULL THEN
         pa.PA08_VALUE || TO_CHAR( adw.ADV_WEEK_MSTR_ID ) ||  ','
        ELSE NULL END
     || '" '
     || pa.PA03_VALUE
     || '> '
     || toc.REPORT_NAME
     || '</a>'
   ELSE
        toc.REPORT_NAME
   END AS HTML_WEB_LINK
   
   , CASE WHEN REPORT_TYPE_FG = 1 THEN
			pa.PA25_VALUE
		|| CASE WHEN toc.REPORT_PANEL_NAME IS NOT NULL THEN CHAR (38) ||'nbsp;'|| CHAR (38) ||'nbsp;' ELSE '' END /* Further list ordering */
		|| '<a style="color:#000000" title="Detailanzeige f'|| CHAR (38) ||'uuml;r Bericht'
		|| toc.REPORT_NAME
		|| ' f'|| CHAR (38) ||'uuml;r Werbewoche: '
		|| adw.ADV_WEEK_LDESCR
		|| ' und Land: '
		|| adw.COUNTRY_DESCR
		|| CASE WHEN toc.REPORT_PANEL_NAME IS NOT NULL THEN ' f'|| CHAR (38) ||'uuml;r Panel ' || toc.REPORT_PANEL_NAME ELSE '' END
		|| pa.PA39_VALUE
		|| '" HREF="mstrWeb'
		-- ?
		|| CHR(63)
		|| 'evt=2048001'|| CHAR (38) ||'src=mstrWeb.2048001'|| CHAR (38) ||'documentID='
		|| toc.REPORT_GUID
	
        || CASE WHEN toc.REPORT_PANEL_NAME IS NOT NULL THEN
            CHAR (38) ||'psKey=' || toc.REPORT_PANEL_PSKEY || CHAR (38) || 'pKey=' || toc.REPORT_PANEL_PKEY || pa.PA24_VALUE 
			ELSE '' END
		|| '" '
		|| pa.PA03_VALUE
		|| '> '
		|| toc.REPORT_NAME || CASE WHEN toc.REPORT_PANEL_NAME IS NOT NULL THEN ' mit Panel ' || toc.REPORT_PANEL_NAME ELSE '' END
		|| '</a>'
	ELSE
			NULL
	END 									AS HTML_WEB_LINK_LIST
   
   , 'mstrWeb'
		-- ?
		|| CHR(63)
		|| pa.PA41_VALUE
		|| toc.REPORT_GUID
		|| pa.PA39_VALUE 					AS HTML_WEB_LINK_NATIVE
   FROM 
   
   	-- Table of Reports
   	( 
   		SELECT
			  REPORT_ID
			, REPORT_SORT_VAL
			, REPORT_NAME
			, REPORT_GUID
			, REPORT_ANNOTATION
			, REPORT_VISIBLE_FG
			, REPORT_TEASER_FG
			, REPORT_TYPE_FG
			, REPORT_PANEL_NAME
			, REPORT_PANEL_PSKEY
			, REPORT_PANEL_PKEY
			, VALID_FROM_DT
			, VALID_TO_DT
			, VERSION_NR
			, CURRENT_FG
			, REJECT_FG
			, REJECT_REASON_ID
			, SOURCE_SYSTEM_ID
			, DELETED_FG
			, DWH_CREATED_TS
			, DWH_UPDATED_TS
			, LOAD_ID   		
   		FROM P_LEW_FE_MSTR_PIT.T_CNTL_FE_MSTR_REPORT_TOC
   		WHERE TRUE
   		  	AND CURRENT_DATE() 		BETWEEN VALID_FROM_DT AND VALID_TO_DT
  			AND REPORT_VISIBLE_FG 	= 1
   	) toc
   
	-- Adv.Week 
	CROSS JOIN
	(
		SELECT 
			  CLIENT_ID
			, COUNTRY_DESCR
			, ADV_WEEK_MSTR_ID
			, ADV_WEEK_LDESCR
			, ADV_WEEK_ID                       
		FROM P_LEW_FE_MSTR_PIT.V_DIM_ADV_WEEK 
		WHERE TRUE
			AND DELETED_FG  			= 0
			AND REJECT_FG   			= 0
			
			AND PROCESSED_ADV_WEEK_FG 	= 1	
	) AS adw
   
   -- Frontend Parameter
   CROSS JOIN
   (
	SELECT
		  MAX(CASE WHEN FE_MSTR_PARAM_ID =  1 THEN COALESCE(FE_MSTR_PARAM_VALUE,'<!-- ERROR SPAN Tag -->') END)          AS PA01_VALUE
		, MAX(CASE WHEN FE_MSTR_PARAM_ID =  2 THEN COALESCE(FE_MSTR_PARAM_VALUE,'<!-- ERROR IMG Tag  -->') END)          AS PA02_VALUE
		, MAX(CASE WHEN FE_MSTR_PARAM_ID =  3 THEN COALESCE(FE_MSTR_PARAM_VALUE,'<!-- ERROR Target Attribute -->') END)  AS PA03_VALUE
		, MAX(CASE WHEN FE_MSTR_PARAM_ID =  4 THEN FE_MSTR_PARAM_VALUE END)                                              AS PA04_VALUE
		, MAX(CASE WHEN FE_MSTR_PARAM_ID =  5 THEN FE_MSTR_PARAM_VALUE END)                                              AS PA05_VALUE
		, MAX(CASE WHEN FE_MSTR_PARAM_ID =  6 THEN FE_MSTR_PARAM_VALUE END)                                              AS PA06_VALUE
		, MAX(CASE WHEN FE_MSTR_PARAM_ID =  7 THEN COALESCE(FE_MSTR_PARAM_VALUE,'N/A')END)                               AS PA07_VALUE
		, MAX(CASE WHEN FE_MSTR_PARAM_ID =  8 THEN FE_MSTR_PARAM_VALUE END)                                              AS PA08_VALUE
		, MAX(CASE WHEN FE_MSTR_PARAM_ID =  9 THEN FE_MSTR_PARAM_VALUE END)                                              AS PA09_VALUE
		, MAX(CASE WHEN FE_MSTR_PARAM_ID = 10 THEN FE_MSTR_PARAM_VALUE END)                                              AS PA10_VALUE
		, MAX(CASE WHEN FE_MSTR_PARAM_ID = 11 THEN FE_MSTR_PARAM_VALUE END)                                              AS PA11_VALUE
		, MAX(CASE WHEN FE_MSTR_PARAM_ID = 12 THEN COALESCE(FE_MSTR_PARAM_VALUE,'N/A') END)                              AS PA12_VALUE
		, MAX(CASE WHEN FE_MSTR_PARAM_ID = 13 THEN FE_MSTR_PARAM_VALUE END)                                              AS PA13_VALUE
		, MAX(CASE WHEN FE_MSTR_PARAM_ID = 14 THEN FE_MSTR_PARAM_VALUE END)                                              AS PA14_VALUE
		, MAX(CASE WHEN FE_MSTR_PARAM_ID = 15 THEN COALESCE(FE_MSTR_PARAM_VALUE,'<!-- ERROR IMG Tag  -->') END)          AS PA15_VALUE
		, MAX(CASE WHEN FE_MSTR_PARAM_ID = 16 THEN FE_MSTR_PARAM_VALUE END)                                              AS PA16_VALUE
		, MAX(CASE WHEN FE_MSTR_PARAM_ID = 17 THEN FE_MSTR_PARAM_VALUE END)                                              AS PA17_VALUE
		, MAX(CASE WHEN FE_MSTR_PARAM_ID = 18 THEN FE_MSTR_PARAM_VALUE END)                                              AS PA18_VALUE
		, MAX(CASE WHEN FE_MSTR_PARAM_ID = 19 THEN FE_MSTR_PARAM_VALUE END)                                              AS PA19_VALUE
		, MAX(CASE WHEN FE_MSTR_PARAM_ID = 20 THEN FE_MSTR_PARAM_VALUE END)                                              AS PA20_VALUE
		, MAX(CASE WHEN FE_MSTR_PARAM_ID = 21 THEN FE_MSTR_PARAM_VALUE END)                                              AS PA21_VALUE
		, MAX(CASE WHEN FE_MSTR_PARAM_ID = 22 THEN FE_MSTR_PARAM_VALUE END)                                              AS PA22_VALUE
		, MAX(CASE WHEN FE_MSTR_PARAM_ID = 23 THEN FE_MSTR_PARAM_VALUE END)                                              AS PA23_VALUE
		, MAX(CASE WHEN FE_MSTR_PARAM_ID = 24 THEN FE_MSTR_PARAM_VALUE END)                                              AS PA24_VALUE
		, MAX(CASE WHEN FE_MSTR_PARAM_ID = 25 THEN FE_MSTR_PARAM_VALUE END)                                              AS PA25_VALUE
		, MAX(CASE WHEN FE_MSTR_PARAM_ID = 26 THEN FE_MSTR_PARAM_VALUE END)                                              AS PA26_VALUE
		, MAX(CASE WHEN FE_MSTR_PARAM_ID = 27 THEN FE_MSTR_PARAM_VALUE END)                                              AS PA27_VALUE
		, MAX(CASE WHEN FE_MSTR_PARAM_ID = 28 THEN FE_MSTR_PARAM_VALUE END)                                              AS PA28_VALUE
		, MAX(CASE WHEN FE_MSTR_PARAM_ID = 29 THEN FE_MSTR_PARAM_VALUE END)                                              AS PA29_VALUE
		, MAX(CASE WHEN FE_MSTR_PARAM_ID = 30 THEN FE_MSTR_PARAM_VALUE END)                                              AS PA30_VALUE
		, MAX(CASE WHEN FE_MSTR_PARAM_ID = 31 THEN FE_MSTR_PARAM_VALUE END)                                              AS PA31_VALUE
		, MAX(CASE WHEN FE_MSTR_PARAM_ID = 32 THEN FE_MSTR_PARAM_VALUE END)                                              AS PA32_VALUE
		, MAX(CASE WHEN FE_MSTR_PARAM_ID = 33 THEN FE_MSTR_PARAM_VALUE END)                                              AS PA33_VALUE
		, MAX(CASE WHEN FE_MSTR_PARAM_ID = 34 THEN FE_MSTR_PARAM_VALUE END)                                              AS PA34_VALUE
		, MAX(CASE WHEN FE_MSTR_PARAM_ID = 35 THEN FE_MSTR_PARAM_VALUE END)                                              AS PA35_VALUE
		, MAX(CASE WHEN FE_MSTR_PARAM_ID = 36 THEN FE_MSTR_PARAM_VALUE END)                                              AS PA36_VALUE
		, MAX(CASE WHEN FE_MSTR_PARAM_ID = 37 THEN FE_MSTR_PARAM_VALUE END)                                              AS PA37_VALUE
		, MAX(CASE WHEN FE_MSTR_PARAM_ID = 38 THEN FE_MSTR_PARAM_VALUE END)                                              AS PA38_VALUE
		, MAX(CASE WHEN FE_MSTR_PARAM_ID = 39 THEN FE_MSTR_PARAM_VALUE END)                                              AS PA39_VALUE
		, MAX(CASE WHEN FE_MSTR_PARAM_ID = 40 THEN FE_MSTR_PARAM_VALUE END)                                              AS PA40_VALUE
		, MAX(CASE WHEN FE_MSTR_PARAM_ID = 41 THEN FE_MSTR_PARAM_VALUE END)                                              AS PA41_VALUE
		, MAX(CASE WHEN FE_MSTR_PARAM_ID = 42 THEN FE_MSTR_PARAM_VALUE END)                                              AS PA42_VALUE
		, MAX(CASE WHEN FE_MSTR_PARAM_ID = 43 THEN FE_MSTR_PARAM_VALUE END)                                              AS PA43_VALUE
		, MAX(CASE WHEN FE_MSTR_PARAM_ID = 44 THEN FE_MSTR_PARAM_VALUE END)                                              AS PA44_VALUE
	FROM P_LEW_FE_MSTR_PIT.T_CNTL_FE_MSTR_PARAM
	WHERE TRUE
		AND DELETED_FG 		= 0
		AND	REJECT_FG		= 0
		AND CURRENT_DATE()	BETWEEN VALID_FROM_DT AND VALID_TO_DT
		
  ) AS pa
WHERE TRUE

;


-- SELECT * FROM P_LEW_FE_MSTR_PIT.V_CNTL_FE_MSTR_ADV_WEEK_REPORT_LINKS LIMIT 10;