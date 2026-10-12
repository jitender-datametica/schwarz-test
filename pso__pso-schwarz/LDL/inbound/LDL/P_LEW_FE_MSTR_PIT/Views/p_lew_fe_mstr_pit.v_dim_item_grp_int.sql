/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : VIEW fOR V_DIM_ITEM_GRP_INT
#-------------------------------------------------------------------------------
# Describtion: CREATE VIEW fOR V_DIM_ITEM_GRP_INT
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2022-05-18 Massimo Morelli  Initial version
#  2.0	2022-07-16 Nikolai Toknov  	Changing the script for DevOps
#  2.1	2022-07-18 Andreas Kurz		Reworked structure 
#  2.2	2022-07-26 Dirk Hering		Filtered out WGI 0 (Artikel pauschal), 00 (Administration), negative WGI codes (already filtered out in source view)
#  2.3	2022-08-05 Dirk Hering		Commented out filtering out WGI 0, 00 -> this is filtered out in load_t_p_f_store_day_adv_period_item.sql
#  4.0  2023-11-06 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC.
#-------------------------------------------------------------------------------
*/
/*
VC: 
ITEM_GRP_INT_MSTR_SID
ITEM_GRP_INT_MSTR_GID
*/
/*
USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT;
USE SCHEMA 		P_LEW_FE_MSTR_PIT; 


SELECT get_ddl('table','P_LEW_MART_PIT.T_DIM_ITEM_GRP_INT');

DESC TABLE P_LEW_MART_PIT.T_DIM_ITEM_GRP_INT;

DROP VIEW P_LEW_MART_PIT.V_DIM_ITEM_GRP_INT

*/


CREATE OR REPLACE VIEW P_LEW_FE_MSTR_PIT.V_DIM_ITEM_GRP_INT
COMMENT = 'Source View Dimension WGI (Warengruppe International)'
AS
SELECT
      CLIENT_ID
    , COUNTRY_ISO_CD
    , COUNTRY_DESCR
    , ITEM_GRP_INT_SID
    , IFF(ITEM_GRP_INT_SID < 0
			,(ITEM_GRP_INT_SID * 100) - CLIENT_ID
			,(ITEM_GRP_INT_SID * 100) + CLIENT_ID
		) AS ITEM_GRP_INT_MSTR_SID
    , ITEM_GRP_INT_GID
    , IFF(ITEM_GRP_INT_GID < 0							
			, (ITEM_GRP_INT_GID * 100::INTEGER) - CLIENT_ID							
			, (ITEM_GRP_INT_GID * 100::INTEGER) + CLIENT_ID							
		) AS ITEM_GRP_INT_MSTR_GID
    , ITEM_GRP_INT_NAME
    , ITEM_GRP_INT_SRC_CD
    , ITEM_GRP_INT_DESCR
    , ITEM_GRP_INT_INT_DESCR
    , VALID_FROM_DT
    , VALID_TO_DT
    , VERSION_NR
    , CURRENT_FG
    , SCD_KEY_MD
    , REJECT_FG
    , REJECT_REASON_ID
    , SOURCE_SYSTEM_ID
    , DELETED_FG
    , DWH_CREATED_TS
    , DWH_UPDATED_TS
    , LOAD_ID 
FROM
    P_LEW_MART_PIT.T_DIM_ITEM_GRP_INT
WHERE TRUE
    AND DELETED_FG  = 0
    AND REJECT_FG   = 0
    /* -- DH: Commented out filtering out WGI 0, 00 -> this is filtered out in load_t_p_f_store_day_adv_period_item.sql
    AND 
    (
        TRY_TO_NUMBER(ITEM_GRP_INT_SRC_CD) > 0      -- filter out WGI 0 (Artikel pauschal), 00 (Administration), negative WGI codes (already filtered out in source view)
        OR
        ITEM_GRP_INT_SID IN (-1000, -2000)          -- keep defaults
    )
    */
;

-- SELECT * FROM P_LEW_FE_MSTR_PIT.V_DIM_ITEM_GRP_INT LIMIT 10;