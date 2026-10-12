/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : VIEW fOR V_SOURCE_ITEM_WGI_2
#-------------------------------------------------------------------------------
# Description: CREATE VIEW fOR V_SOURCE_ITEM_WGI_2 (item_2 group international)
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-08-16 Massimo Morelli     Initial version
#  1.1  2021-09-09 Mike Davis          Refinement
#  1.2  2021-09-17 Mike Davis          Formatting
#  1.3  2021-09-29 Dirk Hering         Use example role added, data types added, column order, formatting
#  1.4  2021-10-12 Dirk Hering         Deduplication from source (Qualify Row Number = 1); iig.dwh_updated
#  1.5  2022-07-21 Prasanna Ranjan     Added SCD_KEY_MD
#-------------------------------------------------------------------------------
*/
/*
---------------------------------------------------------------------
0.   CREATE VIEW in V_SOURCE_ITEM_WGI_2
     Merge the coure sources: t_itemgroup_international_2, t_itemgroup_international_descr_2
     Note: history table not necessary
------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_PIT.V_SOURCE_ITEM_WGI_2
COMMENT = 'V_SOURCE_ITEM_WGI_2'
AS
SELECT      
    -- keys (also see version)
      iig.CLIENT_ID::INTEGER                                                                                     AS CLIENT_ID
    , iig.item_grp_int_sid::INTEGER                                                                              AS ITEM_GRP_INT_SID

    -- business iig keys
    , iig.src_itemgrp_int_cd::VARCHAR                                                                            AS ITEM_GRP_INT_SRC_CD

    -- iig information
    , COALESCE(iig.item_grp_int_name, id_int.item_grp_int_descr, id_local.item_grp_int_descr, 'N/A')::VARCHAR    AS ITEM_GRP_INT_NAME
    , COALESCE(id_local.item_grp_int_descr, iig.item_grp_int_name, id_int.item_grp_int_descr, 'N/A')::VARCHAR    AS ITEM_GRP_INT_DESCR
    , COALESCE(id_int.item_grp_int_descr, id_local.item_grp_int_descr, iig.item_grp_int_name, 'N/A')::VARCHAR    AS ITEM_GRP_INT_INT_DESCR

    -- additional item_2 hierarchy_2 join fields
    -- none
	
	, MD5(
                COALESCE(TO_CHAR(COALESCE(iig.item_grp_int_name, id_int.item_grp_int_descr, id_local.item_grp_int_descr, 'N/A')::VARCHAR       	),'')     || -- ITEM_GRP_INT_NAME
                COALESCE(TO_CHAR(COALESCE(id_local.item_grp_int_descr, iig.item_grp_int_name, id_int.item_grp_int_descr, 'N/A')::VARCHAR   		),'')     || -- ITEM_GRP_INT_DESCR
				COALESCE(TO_CHAR(ITEM_GRP_INT_INT_DESCR  																						),'') 		 --	ITEM_GRP_INT_INT_DESCR
        )																										AS SCD_KEY_MD

    -- technical versioning
    , '1900-01-01'::DATE                                                                                         AS VALID_FROM_DT
    , '9999-12-31'::DATE                                                                                         AS VALID_TO_DT
    , 0::SMALLINT                                                                                                AS DELETED_FG
    , iig.dwh_updated::TIMESTAMP                                                                                 AS DWH_UPDATED_TS

FROM
    (
        SELECT 
            * 
        FROM P_LEW_CORE.T_ITEMGROUP_INTERNATIONAL_2
		WHERE TRUE
			AND CLIENT_ID IN (
				-- PIT Country_2
				SELECT 
					CLIENT_ID 
				FROM P_LEW_MART_PIT.T_DIM_CLIENT_2 
				WHERE TRUE 
					AND PIT_COUNTRY_FG 	= 1 
					AND DELETED_FG 		= 0 
					AND REJECT_FG 		= 0 
					AND CURRENT_FG 		= 1 
				GROUP BY 1
			)		
		
        -- Deduplication on the source PK (Snowflake does not enforce unique constraints. Just as a precaution here.)
        QUALIFY ROW_NUMBER() OVER (PARTITION BY ITEM_GRP_INT_SID ORDER BY DWH_UPDATED DESC) = 1
    ) iig

    INNER JOIN
    (
        SELECT 
            * 
        FROM P_LEW_CORE.T_COUNTRY_2
        -- Deduplication on the source PK (Snowflake does not enforce unique constraints. Just as a precaution here.)
        QUALIFY ROW_NUMBER() OVER (PARTITION BY COUNTRY_SID ORDER BY DWH_UPDATED DESC) = 1
    ) c_local
        ON  TRUE 
            AND iig.CLIENT_ID = c_local.country_sid

    INNER JOIN
    (
        SELECT 
            * 
        FROM P_LEW_CORE.T_COUNTRY_2
        -- Deduplication on the source PK (Snowflake does not enforce unique constraints. Just as a precaution here.)
        QUALIFY ROW_NUMBER() OVER (PARTITION BY COUNTRY_SID ORDER BY DWH_UPDATED DESC) = 1
    ) c_int
        ON  TRUE 
            AND c_int.lang_cd = '@'

    LEFT OUTER JOIN
    (
        SELECT 
            * 
        FROM p_lew_core.t_itemgroup_international_descr_2
        -- Deduplication on the source PK (Snowflake does not enforce unique constraints. Just as a precaution here.)
        QUALIFY ROW_NUMBER() OVER (PARTITION BY ITEM_GRP_INT_SID, LANG_SID ORDER BY DWH_UPDATED DESC) = 1
    ) id_local
        ON  TRUE 
            AND iig.CLIENT_ID        = id_local.CLIENT_ID
            AND c_local.lang_sid     = id_local.lang_sid
            AND iig.item_grp_int_sid = id_local.item_grp_int_sid

    LEFT OUTER JOIN
    (
        SELECT 
            * 
        FROM p_lew_core.t_itemgroup_international_descr_2
        -- Deduplication on the source PK (Snowflake does not enforce unique constraints. Just as a precaution here.)
        QUALIFY ROW_NUMBER() OVER (PARTITION BY ITEM_GRP_INT_SID, LANG_SID ORDER BY DWH_UPDATED DESC) = 1
    ) id_int
        ON  TRUE 
            AND iig.CLIENT_ID        = id_int.CLIENT_ID
            AND c_int.lang_sid       = id_int.lang_sid
            AND iig.item_grp_int_sid = id_int.item_grp_int_sid

WHERE TRUE
    /*-- DH: Commented out filtering out WGI 0, 00 -> this is filtered out in load_t_p_f_store_day_adv_period_item.sql only for items in promotion
    --  Exclude minus values
    AND iig.src_itemgrp_int_cd NOT LIKE ('%-%'::VARCHAR)
    */
;