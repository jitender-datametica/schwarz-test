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

UPDATE LDL.P_LEW_MART_PIT.T_DIM_ADV_WEEK trg

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
            , iff( RN=1, 1::INTEGER ,0::INTEGER )::INTEGER  AS LAST_ADV_WEEK_FG
            , iff( RN=1, 1::INTEGER ,0::INTEGER )::INTEGER  AS LAST_CLOSED_ADV_WEEK_FG			
		FROM
		(
			SELECT DISTINCT
				  CLIENT_ID
				, ADV_WEEK_ID
			FROM LDL.P_LEW_MART_PIT.T_P_F_STORE_DAY_ADV_PERIOD_ITEM 
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
			FROM LDL.P_LEW_MART_PIT.T_DIM_ADV_WEEK 
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
			a.LAST_CLOSED_ADV_WEEK_FG = 1::INTEGER OR
			a.LAST_ADV_WEEK_FG = 1::INTEGER 
			)
	GROUP BY 1,2,3,4,5,6
) src
WHERE TRUE
	AND trg.DELETED_FG 	= 0
	AND trg.REJECT_FG 	= 0
	AND trg.CLIENT_ID 	= src.CLIENT_ID
	AND trg.ADV_WEEK_ID = src.ADV_WEEK_ID


UPDATE LDL.P_LEW_MART_PIT.T_DIM_ADV_WEEK trg

SET
	  MOV_ADV_WEEK_START_FROM_CURRENT	= -1::INTEGER   
	, MOV_ADV_WEEK_ID_FROM_START_NR		= -1::INTEGER 
	, DWH_UPDATED_TS					= CURRENT_TIMESTAMP()	
WHERE TRUE
	AND trg.DELETED_FG 		= 0
	AND trg.REJECT_FG 		= 0;
UPDATE LDL.P_LEW_MART_PIT.T_DIM_ADV_WEEK trg

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
			, MAX(iff(a.LAST_ADV_WEEK_FG=1::INTEGER ,a.MOV_ADV_WEEK_ID_FROM_START_NR,0)) OVER(PARTITION BY CLIENT_ID ORDER BY NULL) 
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

			FROM LDL.P_LEW_MART_PIT.T_DIM_ADV_WEEK 
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
	
SELECT * FROM LDL.P_LEW_FE_MSTR_PIT.V_DIM_ADV_WEEK_RANGES WHERE CLIENT_ID IN (12)


		SELECT 
		CLIENT_ID
		,ADV_WEEK_ID
		,PROCESSED_ADV_WEEK_FG
		,MOV_ADV_WEEK_START_FROM_CURRENT
		,MOV_ADV_WEEK_ID_FROM_START_NR
		,COUNT(1)
	FROM LDL.P_LEW_MART_PIT.T_DIM_ADV_WEEK advw
	WHERE TRUE
		-- only regard processed adv weeks
		AND PROCESSED_ADV_WEEK_FG   = 1
		--AND CLIENT_ID = 32
					AND CLIENT_ID = 23	
	GROUP BY 1,2,3,4,5
	ORDER BY 1,2
		
*/


-- processed, closed adv weeks
 -- ############### Last max. advertising weeks, if > 104 weeks ###############

-- moving adv week number of the last closed adv week, counted from current week		-- processed, closed adv weeks

-- processed, closed adv weeks
 -- AND CLIENT_ID = 23
 -- ############### Last 12 advertising weeks ###############

-- ############### Last 104 advertising weeks ###############

-- ############### Last 24 advertising weeks ###############

-- ############### Last 4 advertising weeks ###############

-- moving adv week number of the last closed adv week, counted from current week		-- processed, closed adv weeks

-- moving adv week number of the last closed adv week, counted from current week		-- processed, closed adv weeks

-- ############### Last 36 advertising weeks ###############

-- moving adv week number of the last closed adv week, counted from current week

-- moving adv week number of the last closed adv week, counted from current week		-- processed, closed adv weeks

-- ############### Last 52 advertising weeks ###############

-- moving adv week number of the last closed adv week, counted from current week		-- processed, closed adv weeks

-- moving adv week number of the last closed adv week, counted from current week

CREATE OR REPLACE VIEW ldl_p_lew_fe_mstr_pit.v_dim_adv_week_ranges
OPTIONS(DESCRIPTION = `ADVERTISING WEEK RANGES. CLUSTERS CLOSED AND PROCESSED ADVERTISING WEEKS INTO RANGES (LAST 4 / 12 / 24 / 36 / 52 / 104 / MAX. ADV. WEEKS). FOR FILTER BAR IN DOSSIERS.`)
AS SELECT ADW.client_id,
 ADW.country_iso_cd,
 ADW.country_descr,
 ADW.adv_week_id,
 ADW.adv_week_mstr_id,
 1 AS adv_week_range_id,
  100 + ADW.client_id AS adv_week_range_mstr_id,
 adw_cnt.adv_week_range_cnt,
  - 1 * adw_cnt.adv_week_range_cnt AS adv_week_range_diff,
   'Letzte ' || CAST(adw_cnt.adv_week_range_cnt AS STRING) || ' Werbewochen' AS adv_week_range_descr,
 ADW.mov_adv_week_start_from_current,
 adw_cnt.max_mov_nr
FROM ldl_p_lew_fe_mstr_pit.v_dim_adv_week_processed AS ADW
 INNER JOIN (SELECT client_id,
   COUNT(DISTINCT adv_week_id) AS adv_week_range_cnt,
   MAX(mov_adv_week_start_from_current) AS max_mov_nr
  FROM ldl_p_lew_fe_mstr_pit.v_dim_adv_week_processed
  GROUP BY client_id) AS adw_cnt ON ADW.client_id = adw_cnt.client_id AND adw_cnt.adv_week_range_cnt > 104
UNION ALL
SELECT client_id,
 country_iso_cd,
 country_descr,
 adv_week_id,
 adv_week_mstr_id,
 2 AS adv_week_range_id,
   2 * 100 + client_id AS adv_week_range_mstr_id,
 104 AS adv_week_range_cnt,
  - 1 * 104 AS adv_week_range_diff,
   'Letzte ' || '104' || ' Werbewochen' AS adv_week_range_descr,
 mov_adv_week_start_from_current,
 - 1 AS max_mov_nr
FROM ldl_p_lew_fe_mstr_pit.v_dim_adv_week_processed AS ADW
WHERE mov_adv_week_start_from_current BETWEEN - 104 AND (- 1)
UNION ALL
SELECT client_id,
 country_iso_cd,
 country_descr,
 adv_week_id,
 adv_week_mstr_id,
 3 AS adv_week_range_id,
   3 * 100 + client_id AS adv_week_range_mstr_id,
 52 AS adv_week_range_cnt,
  - 1 * 52 AS adv_week_range_diff,
   'Letzte ' || '52' || ' Werbewochen' AS adv_week_range_descr,
 mov_adv_week_start_from_current,
 - 1 AS max_mov_nr
FROM ldl_p_lew_fe_mstr_pit.v_dim_adv_week_processed AS ADW
WHERE mov_adv_week_start_from_current BETWEEN - 52 AND (- 1)
UNION ALL
SELECT client_id,
 country_iso_cd,
 country_descr,
 adv_week_id,
 adv_week_mstr_id,
 4 AS adv_week_range_id,
   4 * 100 + client_id AS adv_week_range_mstr_id,
 36 AS adv_week_range_cnt,
  - 1 * 36 AS adv_week_range_diff,
   'Letzte ' || '36' || ' Werbewochen' AS adv_week_range_descr,
 mov_adv_week_start_from_current,
 - 1 AS max_mov_nr
FROM ldl_p_lew_fe_mstr_pit.v_dim_adv_week_processed AS ADW
WHERE mov_adv_week_start_from_current BETWEEN - 36 AND (- 1)
UNION ALL
SELECT client_id,
 country_iso_cd,
 country_descr,
 adv_week_id,
 adv_week_mstr_id,
 5 AS adv_week_range_id,
   5 * 100 + client_id AS adv_week_range_mstr_id,
 24 AS adv_week_range_cnt,
  - 1 * 24 AS adv_week_range_diff,
   'Letzte ' || '24' || ' Werbewochen' AS adv_week_range_descr,
 mov_adv_week_start_from_current,
 - 1 AS max_mov_nr
FROM ldl_p_lew_fe_mstr_pit.v_dim_adv_week_processed AS ADW
WHERE mov_adv_week_start_from_current BETWEEN - 24 AND (- 1)
UNION ALL
SELECT client_id,
 country_iso_cd,
 country_descr,
 adv_week_id,
 adv_week_mstr_id,
 6 AS adv_week_range_id,
   6 * 100 + client_id AS adv_week_range_mstr_id,
 12 AS adv_week_range_cnt,
  - 1 * 12 AS adv_week_range_diff,
   'Letzte ' || '12' || ' Werbewochen' AS adv_week_range_descr,
 mov_adv_week_start_from_current,
 - 1 AS max_mov_nr
FROM ldl_p_lew_fe_mstr_pit.v_dim_adv_week_processed AS ADW
WHERE mov_adv_week_start_from_current BETWEEN - 12 AND (- 1)
UNION ALL
SELECT client_id,
 country_iso_cd,
 country_descr,
 adv_week_id,
 adv_week_mstr_id,
 7 AS adv_week_range_id,
   7 * 100 + client_id AS adv_week_range_mstr_id,
 4 AS adv_week_range_cnt,
  - 1 * 4 AS adv_week_range_diff,
   'Letzte ' || '4' || ' Werbewochen' AS adv_week_range_descr,
 mov_adv_week_start_from_current,
 - 1 AS max_mov_nr
FROM ldl_p_lew_fe_mstr_pit.v_dim_adv_week_processed AS ADW
WHERE mov_adv_week_start_from_current BETWEEN - 4 AND (- 1);