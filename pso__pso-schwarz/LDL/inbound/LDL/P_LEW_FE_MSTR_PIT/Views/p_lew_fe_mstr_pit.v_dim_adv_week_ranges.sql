/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : View V_DIM_ADV_WEEK_RANGES
#-------------------------------------------------------------------------------
# Description: Clusters the advertising weeks into ranges (last 4 / 12 / 24 / 36 / 52 / 104 / max. adv. weeks). For filter bar in Dossiers.
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2022-06-02 Dirk Hering      Initial temporary version, may be replaced by T_DIM_ADV_WEEK_RANGES
#  2.0	2022-07-16 Nikolai Toknov   Changing the script for DevOps
#  2.1  2022-07-18 Dirk Hering      Using new view location P_LEW_FE_MSTR_PIT.V_DIM_ADV_WEEK_PROCESSED
#-------------------------------------------------------------------------------
*/

/*
USE ROLE        R_LDL_D_PIT_ETL;
USE WAREHOUSE   WH_LDL_D_PIT_ETL_2XL;
--USE DATABASE	LDL_PRODUCTION_CLONE_PIT;
USE DATABASE	LDL_PRODUCTION_CLONE_PIT_QS;
--USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R51501;
USE SCHEMA      P_LEW_MART_PIT;

UPDATE P_LEW_MART_PIT.T_DIM_ADV_WEEK trg

SET
	  LAST_ADV_WEEK_ID  		= src.LAST_ADV_WEEK_ID
	, LAST_ADV_WEEK_FG			= src.LAST_ADV_WEEK_FG
	, LAST_CLOSED_ADV_WEEK_ID  	= src.LAST_CLOSED_ADV_WEEK_ID
	, LAST_CLOSED_ADV_WEEK_FG	= src.LAST_CLOSED_ADV_WEEK_FG
	, DWH_UPDATED_TS			= CURRENT_TIMESTAMP()	
FROM 
(
	SELECT DISTINCT
		  a.CLIENT_ID
		, a.ADV_WEEK_ID
		, a.LAST_ADV_WEEK_ID
		, a.LAST_ADV_WEEK_FG
		, a.LAST_CLOSED_ADV_WEEK_ID
		, a.LAST_CLOSED_ADV_WEEK_FG		
	FROM
	(
		SELECT 
      		  ap.CLIENT_ID
			, ap.ADV_WEEK_ID
			, adw.ADV_WEEK_START_DT
			, adw.ADV_WEEK_END_DT
            , ROW_NUMBER() over (PARTITION BY ap.CLIENT_ID ORDER BY ap.ADV_WEEK_ID desc ) RN
            , LEAD(ap.ADV_WEEK_ID, 0) OVER (PARTITION BY ap.CLIENT_ID ORDER BY ap.ADV_WEEK_ID desc )  AS LAST_ADV_WEEK_ID
	        , LEAD(ap.ADV_WEEK_ID, 0) OVER (PARTITION BY ap.CLIENT_ID ORDER BY ap.ADV_WEEK_ID desc ) AS LAST_CLOSED_ADV_WEEK_ID
            , iff( RN=1, 1::SMALLINT,0::SMALLINT)::INTEGER  AS LAST_ADV_WEEK_FG
            , iff( RN=1, 1::SMALLINT,0::SMALLINT)::INTEGER  AS LAST_CLOSED_ADV_WEEK_FG			
		FROM
		(
			SELECT DISTINCT
				  CLIENT_ID
				, ADV_WEEK_ID
			FROM 
		 P_LEW_MART_PIT.T_P_F_STORE_DAY_ADV_PERIOD_ITEM 
			WHERE TRUE
				--AND CLIENT_ID 			IN (${CLIENT_ID})
				AND DELETED_FG 			= 0
				AND REJECT_FG			= 0
				AND ADV_WEEK_ID <= 202319
						
		) ap
		INNER JOIN
		(
			SELECT
				  CLIENT_ID
				, ADV_WEEK_ID
				, ADV_WEEK_START_DT
				, ADV_WEEK_END_DT
			FROM P_LEW_MART_PIT.T_DIM_ADV_WEEK 
			WHERE TRUE
				AND DELETED_FG 	= 0
				AND REJECT_FG	= 0
				--AND CLIENT_ID 		IN (${CLIENT_ID})				-- List of Clients e.g. 2 or 1,2,3,5 so it could run in ps1 framework and also in ABInitio
                AND ADV_WEEK_START_DT<=CURRENT_DATE 
			GROUP BY 1,2,3,4
		) adw
		ON TRUE
			AND adw.CLIENT_ID 	= ap.CLIENT_ID
			AND adw.ADV_WEEK_ID	= ap.ADV_WEEK_ID
		WHERE TRUE 
	) a
	WHERE TRUE
		AND 
			(
			a.LAST_CLOSED_ADV_WEEK_FG = 1::SMALLINT
			OR
			a.LAST_ADV_WEEK_FG = 1::SMALLINT
			)
	GROUP BY 1,2,3,4,5,6
) src
WHERE TRUE
	AND trg.DELETED_FG 	= 0
	AND trg.REJECT_FG 	= 0
	AND trg.CLIENT_ID 	= src.CLIENT_ID
	AND trg.ADV_WEEK_ID = src.ADV_WEEK_ID
;

UPDATE P_LEW_MART_PIT.T_DIM_ADV_WEEK trg

SET
	  MOV_ADV_WEEK_START_FROM_CURRENT	= -1::INTEGER   
	, MOV_ADV_WEEK_ID_FROM_START_NR		= -1::INTEGER 
	, DWH_UPDATED_TS					= CURRENT_TIMESTAMP()	
WHERE TRUE
	AND trg.DELETED_FG 		= 0
	AND trg.REJECT_FG 		= 0;
UPDATE P_LEW_MART_PIT.T_DIM_ADV_WEEK trg

SET
	  MOV_ADV_WEEK_START_FROM_CURRENT	= src.MOV_ADV_WEEK_START_FROM_CURRENT   
	, MOV_ADV_WEEK_ID_FROM_START_NR		= src.MOV_ADV_WEEK_ID_FROM_START_NR 	
FROM 
(
	SELECT DISTINCT
			  a.CLIENT_ID
			, a.ADV_WEEK_ID
			, a.LAST_ADV_WEEK_FG
			, a.MOV_ADV_WEEK_ID_FROM_START_NR
			, MAX(iff(a.LAST_ADV_WEEK_FG=1::SMALLINT,a.MOV_ADV_WEEK_ID_FROM_START_NR,0)) OVER(PARTITION BY CLIENT_ID ORDER BY NULL) 
					AS _MAX_CURRENT_ADV_WEEK_FROM_START_NR
			, a.MOV_ADV_WEEK_ID_FROM_START_NR - _MAX_CURRENT_ADV_WEEK_FROM_START_NR - 1::INTEGER
					AS MOV_ADV_WEEK_START_FROM_CURRENT
		FROM
		(
			SELECT 
				  CLIENT_ID
				, ADV_WEEK_ID
				, LAST_ADV_WEEK_FG
				, ROW_NUMBER() OVER(PARTITION BY CLIENT_ID ORDER BY ADV_WEEK_ID ASC) - 1::INTEGER
								AS MOV_ADV_WEEK_ID_FROM_START_NR

			FROM P_LEW_MART_PIT.T_DIM_ADV_WEEK 
			WHERE TRUE
				--AND CLIENT_ID = 23
				AND DELETED_FG 				= 0
				AND REJECT_FG				= 0
				AND PROCESSED_ADV_WEEK_FG	= 1
				AND ADV_WEEK_ID 			< 888853	


			GROUP BY 1,2,3
		) a
) src
WHERE TRUE
	AND trg.DELETED_FG 	= 0
	AND trg.REJECT_FG 	= 0
	AND trg.CLIENT_ID 	= src.CLIENT_ID
	AND trg.ADV_WEEK_ID = src.ADV_WEEK_ID
;	
SELECT * FROM P_LEW_FE_MSTR_PIT.V_DIM_ADV_WEEK_RANGES WHERE CLIENT_ID IN (12)
;

		SELECT 
		CLIENT_ID
		,ADV_WEEK_ID
		,PROCESSED_ADV_WEEK_FG
		,MOV_ADV_WEEK_START_FROM_CURRENT
		,MOV_ADV_WEEK_ID_FROM_START_NR
		,COUNT(1)
	FROM P_LEW_MART_PIT.T_DIM_ADV_WEEK advw
	WHERE TRUE
		-- only regard processed adv weeks
		AND PROCESSED_ADV_WEEK_FG   = 1
		--AND CLIENT_ID = 32
					AND CLIENT_ID = 23	
	GROUP BY 1,2,3,4,5
	ORDER BY 1,2
;		
*/


CREATE OR REPLACE VIEW P_LEW_FE_MSTR_PIT.V_DIM_ADV_WEEK_RANGES
COMMENT = 'Advertising week ranges. Clusters closed and processed advertising weeks into ranges (last 4 / 12 / 24 / 36 / 52 / 104 / max. adv. weeks). For filter bar in Dossiers.'
AS

(
	-- ############### Last max. advertising weeks, if > 104 weeks ###############	
	SELECT
		  adw.CLIENT_ID
		, adw.COUNTRY_ISO_CD
		, adw.COUNTRY_DESCR
		, adw.ADV_WEEK_ID
		, adw.ADV_WEEK_MSTR_ID
		, adw.ADV_WEEK_RANGE_ID
		, adw.ADV_WEEK_RANGE_MSTR_ID
		, adw.ADV_WEEK_RANGE_CNT
		, adw.ADV_WEEK_RANGE_DIFF
		, adw.ADV_WEEK_RANGE_DESCR
		, adw.MOV_ADV_WEEK_START_FROM_CURRENT
		, adw.MAX_MOV_NR                      
	FROM
	(
		SELECT
			adw.CLIENT_ID                                                             AS CLIENT_ID
			, COUNTRY_ISO_CD                                                            AS COUNTRY_ISO_CD
			, COUNTRY_DESCR                                                             AS COUNTRY_DESCR
			, ADV_WEEK_ID                                                               AS ADV_WEEK_ID
			, ADV_WEEK_MSTR_ID                                                          AS ADV_WEEK_MSTR_ID
			, 1::INTEGER                                                                AS ADV_WEEK_RANGE_ID
			, (ADV_WEEK_RANGE_ID * 100::INTEGER ) +  adw.CLIENT_ID            			AS ADV_WEEK_RANGE_MSTR_ID
		
			, -1::INTEGER * adw_cnt.ADV_WEEK_RANGE_CNT                                  AS ADV_WEEK_RANGE_DIFF
			, 'Letzte ' || TO_CHAR(adw_cnt.ADV_WEEK_RANGE_CNT) || ' Werbewochen'        AS ADV_WEEK_RANGE_DESCR
			, MOV_ADV_WEEK_START_FROM_CURRENT                                           AS MOV_ADV_WEEK_START_FROM_CURRENT
			, adw_cnt.ADV_WEEK_RANGE_CNT												AS ADV_WEEK_RANGE_CNT
			, adw_cnt.MAX_MOV_NR        												AS MAX_MOV_NR                           -- moving adv week number of the last closed adv week, counted from current week
		-- processed, closed adv weeks
		FROM P_LEW_FE_MSTR_PIT.V_DIM_ADV_WEEK_PROCESSED adw
		
		INNER JOIN
		(
			SELECT
				CLIENT_ID
				, COUNT(DISTINCT ADV_WEEK_ID) 			AS ADV_WEEK_RANGE_CNT
				, MAX(MOV_ADV_WEEK_START_FROM_CURRENT) 	AS MAX_MOV_NR
			FROM P_LEW_FE_MSTR_PIT.V_DIM_ADV_WEEK_PROCESSED
			WHERE TRUE
			GROUP BY 1
		) adw_cnt
		ON TRUE 
			AND adw.CLIENT_ID 				= adw_cnt.CLIENT_ID
			AND adw_cnt.ADV_WEEK_RANGE_CNT 	> 104::INTEGER	
	) adw
	WHERE TRUE

) 

UNION ALL

(
	-- ############### Last 104 advertising weeks ###############
	SELECT
		  adw.CLIENT_ID
		, adw.COUNTRY_ISO_CD
		, adw.COUNTRY_DESCR
		, adw.ADV_WEEK_ID
		, adw.ADV_WEEK_MSTR_ID
		, adw.ADV_WEEK_RANGE_ID
		, adw.ADV_WEEK_RANGE_MSTR_ID
		, adw.ADV_WEEK_RANGE_CNT
		, adw.ADV_WEEK_RANGE_DIFF
		, adw.ADV_WEEK_RANGE_DESCR
		, adw.MOV_ADV_WEEK_START_FROM_CURRENT
		, adw.MAX_MOV_NR                      
	FROM
	(
		SELECT
			  adw.CLIENT_ID                                                             AS CLIENT_ID
			, COUNTRY_ISO_CD                                                            AS COUNTRY_ISO_CD
			, COUNTRY_DESCR                                                             AS COUNTRY_DESCR
			, ADV_WEEK_ID                                                               AS ADV_WEEK_ID
			, ADV_WEEK_MSTR_ID                                                          AS ADV_WEEK_MSTR_ID
			, 2::INTEGER                                                                AS ADV_WEEK_RANGE_ID
			, (ADV_WEEK_RANGE_ID * 100::INTEGER ) +  adw.CLIENT_ID            			AS ADV_WEEK_RANGE_MSTR_ID
		    , 104::INTEGER																AS ADV_WEEK_RANGE_CNT
			, -1::INTEGER * ADV_WEEK_RANGE_CNT                                  AS ADV_WEEK_RANGE_DIFF
			, 'Letzte ' || TO_CHAR(ADV_WEEK_RANGE_CNT) || ' Werbewochen'        AS ADV_WEEK_RANGE_DESCR
			, MOV_ADV_WEEK_START_FROM_CURRENT                                           AS MOV_ADV_WEEK_START_FROM_CURRENT
			, -1::INTEGER        														AS MAX_MOV_NR                           -- moving adv week number of the last closed adv week, counted from current week		-- processed, closed adv weeks
		FROM P_LEW_FE_MSTR_PIT.V_DIM_ADV_WEEK_PROCESSED adw
		
		WHERE TRUE	
			AND MOV_ADV_WEEK_START_FROM_CURRENT BETWEEN -104 AND -1
	) adw
	WHERE TRUE
	
) 
	
UNION ALL

(
	-- ############### Last 52 advertising weeks ###############
	SELECT
		  adw.CLIENT_ID
		, adw.COUNTRY_ISO_CD
		, adw.COUNTRY_DESCR
		, adw.ADV_WEEK_ID
		, adw.ADV_WEEK_MSTR_ID
		, adw.ADV_WEEK_RANGE_ID
		, adw.ADV_WEEK_RANGE_MSTR_ID
		, adw.ADV_WEEK_RANGE_CNT
		, adw.ADV_WEEK_RANGE_DIFF
		, adw.ADV_WEEK_RANGE_DESCR
		, adw.MOV_ADV_WEEK_START_FROM_CURRENT
		, adw.MAX_MOV_NR                      
	FROM
	(
		SELECT
			adw.CLIENT_ID                                                             AS CLIENT_ID
			, COUNTRY_ISO_CD                                                            AS COUNTRY_ISO_CD
			, COUNTRY_DESCR                                                             AS COUNTRY_DESCR
			, ADV_WEEK_ID                                                               AS ADV_WEEK_ID
			, ADV_WEEK_MSTR_ID                                                          AS ADV_WEEK_MSTR_ID
			, 3::INTEGER                                                                AS ADV_WEEK_RANGE_ID
			, (ADV_WEEK_RANGE_ID * 100::INTEGER ) +  adw.CLIENT_ID            			AS ADV_WEEK_RANGE_MSTR_ID
			, 52::INTEGER																AS ADV_WEEK_RANGE_CNT
			, -1::INTEGER * ADV_WEEK_RANGE_CNT                                  AS ADV_WEEK_RANGE_DIFF
			, 'Letzte ' || TO_CHAR(ADV_WEEK_RANGE_CNT) || ' Werbewochen'        AS ADV_WEEK_RANGE_DESCR
			, MOV_ADV_WEEK_START_FROM_CURRENT                                           AS MOV_ADV_WEEK_START_FROM_CURRENT
			, -1::INTEGER        														AS MAX_MOV_NR                           -- moving adv week number of the last closed adv week, counted from current week		-- processed, closed adv weeks
		FROM P_LEW_FE_MSTR_PIT.V_DIM_ADV_WEEK_PROCESSED adw
		
		WHERE TRUE
			AND MOV_ADV_WEEK_START_FROM_CURRENT BETWEEN -52 AND -1
	) adw
	WHERE TRUE
	
)

UNION ALL

(
	-- ############### Last 36 advertising weeks ###############
	SELECT
		  adw.CLIENT_ID
		, adw.COUNTRY_ISO_CD
		, adw.COUNTRY_DESCR
		, adw.ADV_WEEK_ID
		, adw.ADV_WEEK_MSTR_ID
		, adw.ADV_WEEK_RANGE_ID
		, adw.ADV_WEEK_RANGE_MSTR_ID
		, adw.ADV_WEEK_RANGE_CNT
		, adw.ADV_WEEK_RANGE_DIFF
		, adw.ADV_WEEK_RANGE_DESCR
		, adw.MOV_ADV_WEEK_START_FROM_CURRENT
		, adw.MAX_MOV_NR                      
	FROM
	(
		SELECT
			adw.CLIENT_ID                                                             AS CLIENT_ID
			, COUNTRY_ISO_CD                                                            AS COUNTRY_ISO_CD
			, COUNTRY_DESCR                                                             AS COUNTRY_DESCR
			, ADV_WEEK_ID                                                               AS ADV_WEEK_ID
			, ADV_WEEK_MSTR_ID                                                          AS ADV_WEEK_MSTR_ID
			, 4::INTEGER                                                                AS ADV_WEEK_RANGE_ID
			, (ADV_WEEK_RANGE_ID * 100::INTEGER ) +  adw.CLIENT_ID            			AS ADV_WEEK_RANGE_MSTR_ID
			, 36::INTEGER																AS ADV_WEEK_RANGE_CNT
			, -1::INTEGER * ADV_WEEK_RANGE_CNT                                  AS ADV_WEEK_RANGE_DIFF
			, 'Letzte ' || TO_CHAR(ADV_WEEK_RANGE_CNT) || ' Werbewochen'        AS ADV_WEEK_RANGE_DESCR
			, MOV_ADV_WEEK_START_FROM_CURRENT                                           AS MOV_ADV_WEEK_START_FROM_CURRENT
			, -1::INTEGER        														AS MAX_MOV_NR                           -- moving adv week number of the last closed adv week, counted from current week		-- processed, closed adv weeks
		FROM P_LEW_FE_MSTR_PIT.V_DIM_ADV_WEEK_PROCESSED adw
		
		WHERE TRUE
			AND MOV_ADV_WEEK_START_FROM_CURRENT BETWEEN -36 AND -1
	) adw
	WHERE TRUE
)

UNION ALL

(
	-- ############### Last 24 advertising weeks ###############
	SELECT
		  adw.CLIENT_ID
		, adw.COUNTRY_ISO_CD
		, adw.COUNTRY_DESCR
		, adw.ADV_WEEK_ID
		, adw.ADV_WEEK_MSTR_ID
		, adw.ADV_WEEK_RANGE_ID
		, adw.ADV_WEEK_RANGE_MSTR_ID
		, adw.ADV_WEEK_RANGE_CNT
		, adw.ADV_WEEK_RANGE_DIFF
		, adw.ADV_WEEK_RANGE_DESCR
		, adw.MOV_ADV_WEEK_START_FROM_CURRENT
		, adw.MAX_MOV_NR                      
	FROM
	(
		SELECT
			adw.CLIENT_ID                                                             AS CLIENT_ID
			, COUNTRY_ISO_CD                                                            AS COUNTRY_ISO_CD
			, COUNTRY_DESCR                                                             AS COUNTRY_DESCR
			, ADV_WEEK_ID                                                               AS ADV_WEEK_ID
			, ADV_WEEK_MSTR_ID                                                          AS ADV_WEEK_MSTR_ID
			, 5::INTEGER                                                                AS ADV_WEEK_RANGE_ID
			, (ADV_WEEK_RANGE_ID * 100::INTEGER ) +  adw.CLIENT_ID            			AS ADV_WEEK_RANGE_MSTR_ID
			, 24::INTEGER																AS ADV_WEEK_RANGE_CNT
			, -1::INTEGER * ADV_WEEK_RANGE_CNT                                  AS ADV_WEEK_RANGE_DIFF
			, 'Letzte ' || TO_CHAR(ADV_WEEK_RANGE_CNT) || ' Werbewochen'        AS ADV_WEEK_RANGE_DESCR
			, MOV_ADV_WEEK_START_FROM_CURRENT                                           AS MOV_ADV_WEEK_START_FROM_CURRENT
			, -1::INTEGER        														AS MAX_MOV_NR                           -- moving adv week number of the last closed adv week, counted from current week		-- processed, closed adv weeks
		FROM P_LEW_FE_MSTR_PIT.V_DIM_ADV_WEEK_PROCESSED adw
		
		WHERE TRUE
			--AND CLIENT_ID = 23
			AND MOV_ADV_WEEK_START_FROM_CURRENT BETWEEN -24 AND -1
	) adw
	WHERE TRUE
)

UNION ALL

(
	-- ############### Last 12 advertising weeks ###############
	SELECT
		  adw.CLIENT_ID
		, adw.COUNTRY_ISO_CD
		, adw.COUNTRY_DESCR
		, adw.ADV_WEEK_ID
		, adw.ADV_WEEK_MSTR_ID
		, adw.ADV_WEEK_RANGE_ID
		, adw.ADV_WEEK_RANGE_MSTR_ID
		, adw.ADV_WEEK_RANGE_CNT
		, adw.ADV_WEEK_RANGE_DIFF
		, adw.ADV_WEEK_RANGE_DESCR
		, adw.MOV_ADV_WEEK_START_FROM_CURRENT
		, adw.MAX_MOV_NR                      
	FROM
	(
		SELECT
			adw.CLIENT_ID                                                             AS CLIENT_ID
			, COUNTRY_ISO_CD                                                            AS COUNTRY_ISO_CD
			, COUNTRY_DESCR                                                             AS COUNTRY_DESCR
			, ADV_WEEK_ID                                                               AS ADV_WEEK_ID
			, ADV_WEEK_MSTR_ID                                                          AS ADV_WEEK_MSTR_ID
			, 6::INTEGER                                                                AS ADV_WEEK_RANGE_ID
			, (ADV_WEEK_RANGE_ID * 100::INTEGER ) +  adw.CLIENT_ID            			AS ADV_WEEK_RANGE_MSTR_ID
			, 12::INTEGER																AS ADV_WEEK_RANGE_CNT
			, -1::INTEGER * ADV_WEEK_RANGE_CNT                                  AS ADV_WEEK_RANGE_DIFF
			, 'Letzte ' || TO_CHAR(ADV_WEEK_RANGE_CNT) || ' Werbewochen'        AS ADV_WEEK_RANGE_DESCR
			, MOV_ADV_WEEK_START_FROM_CURRENT                                           AS MOV_ADV_WEEK_START_FROM_CURRENT
			, -1::INTEGER        														AS MAX_MOV_NR                           -- moving adv week number of the last closed adv week, counted from current week		-- processed, closed adv weeks
		FROM P_LEW_FE_MSTR_PIT.V_DIM_ADV_WEEK_PROCESSED adw
		
		WHERE TRUE
			AND MOV_ADV_WEEK_START_FROM_CURRENT BETWEEN -12 AND -1
	) adw
	WHERE TRUE
)


UNION ALL

(
	-- ############### Last 4 advertising weeks ###############
	SELECT
		  adw.CLIENT_ID
		, adw.COUNTRY_ISO_CD
		, adw.COUNTRY_DESCR
		, adw.ADV_WEEK_ID
		, adw.ADV_WEEK_MSTR_ID
		, adw.ADV_WEEK_RANGE_ID
		, adw.ADV_WEEK_RANGE_MSTR_ID
		, adw.ADV_WEEK_RANGE_CNT
		, adw.ADV_WEEK_RANGE_DIFF
		, adw.ADV_WEEK_RANGE_DESCR
		, adw.MOV_ADV_WEEK_START_FROM_CURRENT
		, adw.MAX_MOV_NR                      
	FROM
	(
		SELECT
			adw.CLIENT_ID                                                               AS CLIENT_ID
			, COUNTRY_ISO_CD                                                            AS COUNTRY_ISO_CD
			, COUNTRY_DESCR                                                             AS COUNTRY_DESCR
			, ADV_WEEK_ID                                                               AS ADV_WEEK_ID
			, ADV_WEEK_MSTR_ID                                                          AS ADV_WEEK_MSTR_ID
			, 7::INTEGER                                                                AS ADV_WEEK_RANGE_ID
			, (ADV_WEEK_RANGE_ID * 100::INTEGER ) +  adw.CLIENT_ID            			AS ADV_WEEK_RANGE_MSTR_ID
			, 4::INTEGER																AS ADV_WEEK_RANGE_CNT
			, -1::INTEGER * ADV_WEEK_RANGE_CNT                                  AS ADV_WEEK_RANGE_DIFF
			, 'Letzte ' || TO_CHAR(ADV_WEEK_RANGE_CNT) || ' Werbewochen'        AS ADV_WEEK_RANGE_DESCR
			, MOV_ADV_WEEK_START_FROM_CURRENT                                           AS MOV_ADV_WEEK_START_FROM_CURRENT
			, -1::INTEGER        														AS MAX_MOV_NR                           -- moving adv week number of the last closed adv week, counted from current week
		-- processed, closed adv weeks
		FROM P_LEW_FE_MSTR_PIT.V_DIM_ADV_WEEK_PROCESSED adw
		
		WHERE TRUE
			AND MOV_ADV_WEEK_START_FROM_CURRENT BETWEEN -4 AND -1	
	) adw
	WHERE TRUE
)
;