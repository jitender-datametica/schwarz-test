/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : VIEW fOR V_SOURCE_ITEM_FAMILY_GROUP
#-------------------------------------------------------------------------------
# Describtion: CREATE VIEW fOR V_SOURCE_ITEM_FAMILY_GROUP
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-08-16 Massimo Morelli   Initial version
#  1.1  2021-09-07 Mike Davis        Refinement
#  1.2  2021-09-17 Mike Davis        Formatting
#  1.3  2021-09-29 Dirk Hering       Use example role added, data types added, column order, formatting
#  1.4  2021-10-08 Dirk Hering       try_to_number added for sub_item_grp_sid
#  1.5  2021-10-12 Dirk Hering       Deduplication from source (Qualify Row Number = 1); ifg_hist.dwh_updated
#  1.6  2022-01-18 Andreas Kurz		 Reworked the structure
#  1.7  2022-09-06 Prasanna Ranjan   Added SCD_KEY_MD
#  1.8	2023-04-27 Nikolai Toknov	 Use SUB_ITEM_GRP_SID as AS-IS. WA. The target solution requires changes in architecture and joining at the T_A_*-level
#  1.9	2024-09-23 Nikolai Toknov	 Add schema name for f_CleanValidToDate
#-------------------------------------------------------------------------------
*/

/*
---------------------------------------------------------------------
0.  Merge the coure sources: t_item_familygroup, t_item_familygroup_hist, t_item_familygroup_descr
------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW p_lew_mart_pit.V_SOURCE_ITEM_FAMILY_GROUP
COMMENT = 'Source View Family Group (AF)'
AS
SELECT
    -- keys (also see version)
      ifg.CLIENT_ID::INTEGER                                                                                    AS CLIENT_ID
    , ifg.item_fam_grp_sid::INTEGER                                                                             AS ITEM_FAM_GRP_SID
																												
    -- business ifg keys                                                                                        
    , ifg.src_familygrp_id::INTEGER                                                                             AS ITEM_FAM_GRP_SRC_ID
    , ifg.src_familygrp_cd::VARCHAR                                                                             AS ITEM_FAM_GRP_SRC_CD
																												
    -- ifg information                                                                                          
    , COALESCE(ifg.item_fam_grp_name, id_int.item_fam_grp_descr, id_local.item_fam_grp_descr, 'N/A')::VARCHAR   AS ITEM_FAM_GRP_NAME
    , COALESCE(id_local.item_fam_grp_descr, ifg.item_fam_grp_name, id_int.item_fam_grp_descr, 'N/A')::VARCHAR   AS ITEM_FAM_GRP_DESCR
    , COALESCE(id_int.item_fam_grp_descr, id_local.item_fam_grp_descr, ifg.item_fam_grp_name, 'N/A')::VARCHAR   AS ITEM_FAM_GRP_INT_DESCR
																												
    -- additional item hierarchy join fields                                                                    
    , COALESCE(try_to_number(ifg_hist.sub_item_grp_sid, 38, 0), -1)::INTEGER                                    AS SUB_ITEM_GRP_SID

    , MD5
        (
            COALESCE(TO_CHAR(ITEM_FAM_GRP_SRC_ID                                                                                            ),'')     ||
            COALESCE(TO_CHAR(ITEM_FAM_GRP_SRC_CD      	                                                                                    ),'')     ||
            COALESCE(TO_CHAR(COALESCE(ifg.item_fam_grp_name, id_int.item_fam_grp_descr, id_local.item_fam_grp_descr, 'N/A')::VARCHAR   		),'')     ||
            COALESCE(TO_CHAR(COALESCE(id_local.item_fam_grp_descr, ifg.item_fam_grp_name, id_int.item_fam_grp_descr, 'N/A')::VARCHAR        ),'')     ||
            COALESCE(TO_CHAR(COALESCE(id_int.item_fam_grp_descr, id_local.item_fam_grp_descr, ifg.item_fam_grp_name, 'N/A')::VARCHAR        ),'')     ||
            COALESCE(TO_CHAR(COALESCE(try_to_number(ifg_hist.sub_item_grp_sid, 38, 0), -1)::INTEGER                                         ),'')      

        ) 																				                            AS SCD_KEY_MD
                                                                                                                
    -- technical versioning                                                                                     
    , COALESCE(ifg_hist.dwh_valid_from, '1900-01-01'::DATE)::DATE                                               AS VALID_FROM_DT
    , P_LEW_MART_PIT.f_CleanValidToDate(ifg_hist.dwh_valid_to)                             									AS VALID_TO_DT
																												
    , ifg_hist.deleted_fg::SMALLINT                                                                             AS DELETED_FG    
    , ifg_hist.dwh_updated::TIMESTAMP                                                                           AS DWH_UPDATED_TS

FROM
    (
        SELECT 
            * 
        FROM P_LEW_CORE.T_ITEM_FAMILYGROUP
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
        QUALIFY ROW_NUMBER() OVER (PARTITION BY ITEM_FAM_GRP_SID ORDER BY DWH_UPDATED DESC) = 1
    ) ifg
    
    INNER JOIN
    (
        SELECT  
			-- SUB_ITEM_GRP_SID
			-- NToknov change 1.8 Use SUB_ITEM_GRP_SID as AS-IS (not as-was)
			  LAST_VALUE (SUB_ITEM_GRP_SID) OVER (PARTITION BY CLIENT_ID, ITEM_FAM_GRP_SID ORDER BY DWH_VALID_TO) AS SUB_ITEM_GRP_SID
			, CLIENT_ID
			, ITEM_FAM_GRP_SID
			, DELETED_FG
			, DWH_UPDATED
			, DWH_VALID_FROM
			, DWH_VALID_TO
        FROM P_LEW_CORE.T_ITEM_FAMILYGROUP_HIST
        -- Deduplication on the source PK (Snowflake does not enforce unique constraints. Just as a precaution here.)
        QUALIFY ROW_NUMBER() OVER (PARTITION BY ITEM_FAM_GRP_SID, DWH_VALID_FROM ORDER BY DWH_UPDATED DESC) = 1
    ) ifg_hist
        ON  TRUE 
            AND ifg.CLIENT_ID        = ifg_hist.CLIENT_ID
            AND ifg.ITEM_FAM_GRP_SID = ifg_hist.ITEM_FAM_GRP_SID
    
    INNER JOIN
    (
        SELECT 
            * 
        FROM P_LEW_CORE.t_country
        -- Deduplication on the source PK (Snowflake does not enforce unique constraints. Just as a precaution here.)
        QUALIFY ROW_NUMBER() OVER (PARTITION BY COUNTRY_SID ORDER BY DWH_UPDATED DESC) = 1
    ) c_local
        ON  TRUE 
            AND ifg.CLIENT_ID = c_local.COUNTRY_SID
    
    INNER JOIN
    (
        SELECT 
            * 
        FROM P_LEW_CORE.t_country
        -- Deduplication on the source PK (Snowflake does not enforce unique constraints. Just as a precaution here.)
        QUALIFY ROW_NUMBER() OVER (PARTITION BY COUNTRY_SID ORDER BY DWH_UPDATED DESC) = 1
    ) c_int
        ON  TRUE 
            AND TRIM(c_int.lang_cd) = '@'
    
    LEFT OUTER JOIN
    (
        SELECT 
            * 
        FROM P_LEW_CORE.t_item_familygroup_descr
        -- Deduplication on the source PK (Snowflake does not enforce unique constraints. Just as a precaution here.)
        QUALIFY ROW_NUMBER() OVER (PARTITION BY ITEM_FAM_GRP_SID, LANG_SID ORDER BY DWH_UPDATED DESC) = 1
    ) id_local
        ON  TRUE 
            AND ifg.CLIENT_ID        = id_local.CLIENT_ID
            AND c_local.lang_sid     = id_local.lang_sid
            AND ifg.item_fam_grp_sid = id_local.item_fam_grp_sid
    
    LEFT OUTER JOIN
    (
        SELECT 
            * 
        FROM P_LEW_CORE.t_item_familygroup_descr
        -- Deduplication on the source PK (Snowflake does not enforce unique constraints. Just as a precaution here.)
        QUALIFY ROW_NUMBER() OVER (PARTITION BY ITEM_FAM_GRP_SID, LANG_SID ORDER BY DWH_UPDATED DESC) = 1
    ) id_int
        ON  TRUE 
            AND ifg.CLIENT_ID        = id_int.CLIENT_ID
            AND c_int.lang_sid       = id_int.lang_sid
            AND ifg.item_fam_grp_sid = id_int.item_fam_grp_sid

WHERE TRUE
;