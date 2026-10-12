/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : VIEW FOR V_SOURCE_ITEM_UWG
#-------------------------------------------------------------------------------
# Description: CREATE VIEW FOR V_SOURCE_ITEM_UWG (item sub group)
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-08-16 Massimo Morelli     Initial version
#  1.1  2021-09-07 Mike Davis          Refinement
#  1.2  2021-09-17 Mike Davis          Formatting
#  1.3  2021-09-29 Dirk Hering         Use example role added, data types added, column order, formatting
#  1.4  2021-10-12 Dirk Hering         Deduplication from source (Qualify Row Number = 1); isg_hist.dwh_updated
#  1.5	2023-04-27 Nikolai Toknov	   Use ITEM_GRP_INT_SID as AS-IS. WA. The target solution requires changes in architecture and joining at the T_A_*-level
#  1.6  2024-02-01 Andreas Kurz		   Enhance View WGI by additionbal condition used in WaWi-PV Detection
#									   PV_UWG_GROUP_FG
#  1.7	2024-09-23 Nikolai Toknov	   Add schema name for f_CleanValidToDate
#-------------------------------------------------------------------------------
*/
/*
USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R60001;
USE SCHEMA 		P_LEW_MART_PIT;
 */
/*
---------------------------------------------------------------------
0.   CREATE VIEW in V_SOURCE_ITEM_UWG
     Merge the coure sources: t_subitemgroup, t_subitemgroup_hist, t_subitemgroup_descr
------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_PIT.V_SOURCE_ITEM_UWG
COMMENT = 'V_SOURCE_ITEM_UWG'
AS
SELECT      
    -- keys (also see version)
      isg.CLIENT_ID::INTEGER                                                                                    		AS CLIENT_ID
    , isg.SUB_ITEM_GRP_SID::INTEGER                                                                             		AS SUB_ITEM_GRP_SID
		
    -- business isg keys		
    , isg.SRC_SUBITEMGRP_CD::VARCHAR                                                                            		AS SUB_ITEM_GRP_SRC_CD

	-- AKU 2024-02-01 added new flag to exclude from PV
	, iff (
			isg.SRC_SUBITEMGRP_NR IS NOT NULL AND 
			(
				(isg.SRC_SUBITEMGRP_NR BETWEEN 100 AND 399) OR (isg.SRC_SUBITEMGRP_NR IN (75, 76))
			)
			,1::SMALLINT
			,0::SMALLINT) 																								AS PV_UWG_GROUP_FG
    -- isg information
    , COALESCE(isg.sub_item_grp_name, id_int.sub_item_grp_descr, id_local.sub_item_grp_descr, 'N/A')::VARCHAR   		AS SUB_ITEM_GRP_NAME
    , COALESCE(id_local.sub_item_grp_descr, isg.sub_item_grp_name, id_int.sub_item_grp_descr, 'N/A')::VARCHAR   		AS SUB_ITEM_GRP_DESCR
    , COALESCE(id_int.sub_item_grp_descr, id_local.sub_item_grp_descr, isg.sub_item_grp_name, 'N/A')::VARCHAR   		AS SUB_ITEM_GRP_INT_DESCR
		
    -- additional item hierarchy join fields		
    , COALESCE(isg_hist.item_grp_int_sid, -1)::INTEGER                                                          		AS ITEM_GRP_INT_SID
	
	, MD5(
                COALESCE(TO_CHAR(COALESCE(isg.sub_item_grp_name, id_int.sub_item_grp_descr, id_local.sub_item_grp_descr, 'N/A')       	),'')     || -- SUB_ITEM_GRP_NAME
                COALESCE(TO_CHAR(COALESCE(id_local.sub_item_grp_descr, isg.sub_item_grp_name, id_int.sub_item_grp_descr, 'N/A')   		),'')     || -- SUB_ITEM_GRP_DESCR
                COALESCE(TO_CHAR(SUB_ITEM_GRP_INT_DESCR    																				),'')     ||
				COALESCE(TO_CHAR(COALESCE(isg_hist.item_grp_int_sid, -1)  																),'') 		 --	ITEM_GRP_INT_SID
                
        )																												AS SCD_KEY_MD
																															
    -- technical versioning                                                                                     		
    , COALESCE(isg_hist.dwh_valid_from, '1900-01-01'::DATE)::DATE                                               		AS VALID_FROM_DT
    , P_LEW_MART_PIT.f_CleanValidToDate(isg_hist.dwh_valid_to)::DATE                                                       			AS VALID_TO_DT
			
	, isg_hist.deleted_fg::SMALLINT                                                                             		AS DELETED_FG    
    , isg_hist.dwh_updated::TIMESTAMP                                                                           		AS DWH_UPDATED_TS

FROM
    (
        SELECT 
              CLIENT_ID
			, SUB_ITEM_GRP_SID
			, SRC_NODE
			, SRC_SUBITEMGRP_CD
			, TRY_TO_NUMBER(SRC_SUBITEMGRP_CD)	AS SRC_SUBITEMGRP_NR
			, SRC_SUBITEMGRP_ID
			, SUB_ITEM_GRP_NAME
			, DWH_LOAD_ID
			, DWH_CREATED
			, DWH_UPDATED 
        FROM P_LEW_CORE.T_SUBITEMGROUP
		WHERE TRUE
			AND CLIENT_ID IN (
				-- PIT Country
				SELECT 
					CLIENT_ID 
				FROM P_LEW_MART_PIT.T_DIM_CLIENT 
				WHERE TRUE 
					AND PIT_COUNTRY_FG 	= 1 
					AND DELETED_FG 		= 0 
					AND REJECT_FG 		= 0 
					AND CURRENT_FG 		= 1 
				GROUP BY 1
			)		
        -- Deduplication on the source PK (Snowflake does not enforce unique constraints. Just as a precaution here.)
        QUALIFY ROW_NUMBER() OVER(PARTITION BY SUB_ITEM_GRP_SID ORDER BY DWH_UPDATED DESC) = 1
    ) isg

    INNER JOIN
    (
        SELECT 
             CLIENT_ID
			,SUB_ITEM_GRP_SID
			-- ,ITEM_GRP_INT_SID
			-- NToknov change 1.8 Use ITEM_GRP_INT_SID as AS-IS (not as-was)
			,LAST_VALUE (ITEM_GRP_INT_SID) OVER (PARTITION BY CLIENT_ID, SUB_ITEM_GRP_SID ORDER BY DWH_VALID_TO) AS ITEM_GRP_INT_SID
			,DWH_VALID_FROM
			,DWH_VALID_TO
			,DELETED_FG
			,DWH_UPDATED
        FROM P_LEW_CORE.T_SUBITEMGROUP_HIST
        -- Deduplication on the source PK (Snowflake does not enforce unique constraints. Just as a precaution here.)
        QUALIFY ROW_NUMBER() OVER(PARTITION BY SUB_ITEM_GRP_SID, DWH_VALID_FROM ORDER BY DWH_UPDATED DESC) = 1
    ) isg_hist    
    ON  TRUE
        AND isg.CLIENT_ID        = isg_hist.CLIENT_ID
        AND isg.SUB_ITEM_GRP_SID = isg_hist.SUB_ITEM_GRP_SID
    
    INNER JOIN
    (
        SELECT 
              COUNTRY_SID
			, SRC_COUNTRY_LIDL_CD
			, SRC_LANG_ID
			, COUNTRY_NAME
			, COUNTRY_GRP_SID
			, LANG_SID
			, LANG_CD
			, DWH_LOAD_ID
			, DWH_CREATED
			, DWH_UPDATED 
        FROM P_LEW_CORE.T_COUNTRY
        -- Deduplication on the source PK (Snowflake does not enforce unique constraints. Just as a precaution here.)
        QUALIFY ROW_NUMBER() OVER (PARTITION BY COUNTRY_SID ORDER BY DWH_UPDATED DESC) = 1
    ) c_local
    ON  TRUE
        AND isg.CLIENT_ID = c_local.COUNTRY_SID
    
    INNER JOIN
    (
        SELECT 
              COUNTRY_SID
			, SRC_COUNTRY_LIDL_CD
			, SRC_LANG_ID
			, COUNTRY_NAME
			, COUNTRY_GRP_SID
			, LANG_SID
			, LANG_CD
			, DWH_LOAD_ID
			, DWH_CREATED
			, DWH_UPDATED 
        FROM P_LEW_CORE.T_COUNTRY
        -- Deduplication on the source PK (Snowflake does not enforce unique constraints. Just as a precaution here.)
        QUALIFY ROW_NUMBER() OVER (PARTITION BY COUNTRY_SID ORDER BY DWH_UPDATED DESC) = 1
    ) c_int
    ON  TRUE
        AND c_int.lang_cd = '@'
    
    LEFT OUTER JOIN
    (
        SELECT 
			  CLIENT_ID
			, SUB_ITEM_GRP_SID
			, LANG_SID
			, LANG_CD
			, SUB_ITEM_GRP_DESCR
			, SUB_ITEM_GRP_DESCR_LONG
			, SUB_ITEM_GRP_DESCR_CAPS
			, DWH_LOAD_ID
			, DWH_CREATED
			, DWH_UPDATED 
        FROM P_LEW_CORE.T_SUBITEMGROUP_DESCR
        -- Deduplication on the source PK (Snowflake does not enforce unique constraints. Just as a precaution here.)
        QUALIFY ROW_NUMBER() OVER (PARTITION BY SUB_ITEM_GRP_SID, LANG_SID ORDER BY DWH_UPDATED DESC) = 1
    ) id_local
    ON  TRUE
        AND isg.CLIENT_ID        = id_local.CLIENT_ID
        AND c_local.LANG_SID     = id_local.LANG_SID
        AND isg.SUB_ITEM_GRP_SID = id_local.SUB_ITEM_GRP_SID
    
    LEFT OUTER JOIN
        (
        SELECT 
			  CLIENT_ID
			, SUB_ITEM_GRP_SID
			, LANG_SID
			, LANG_CD
			, SUB_ITEM_GRP_DESCR
			, SUB_ITEM_GRP_DESCR_LONG
			, SUB_ITEM_GRP_DESCR_CAPS
			, DWH_LOAD_ID
			, DWH_CREATED
			, DWH_UPDATED  
        FROM P_LEW_CORE.T_SUBITEMGROUP_DESCR
        -- Deduplication on the source PK (Snowflake does not enforce unique constraints. Just as a precaution here.)
        QUALIFY ROW_NUMBER() OVER (PARTITION BY SUB_ITEM_GRP_SID, LANG_SID ORDER BY DWH_UPDATED DESC) = 1
    ) id_int
    ON  TRUE
        AND isg.CLIENT_ID        = id_int.CLIENT_ID
        AND c_int.LANG_SID       = id_int.LANG_SID
        AND isg.SUB_ITEM_GRP_SID = id_int.SUB_ITEM_GRP_SID

WHERE TRUE
    --AND isg.SRC_SUBITEMGRP_CD NOT LIKE ('%-%'::VARCHAR)
	AND isg.SRC_SUBITEMGRP_NR IS NOT NULL
	AND isg.SRC_SUBITEMGRP_NR > 0
;
-- SELECT CLIENT_ID, PV_UWG_GROUP_FG, COUNT(1) AS _RECNBR FROM P_LEW_MART_PIT.V_SOURCE_ITEM_UWG WHERE TRUE GROUP BY 1,2 ORDER BY 1,2