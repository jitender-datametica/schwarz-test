/*
#-------------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface :   TD2SF CDWH Migration Project
#-------------------------------------------------------------------------------
# Describtion: DDL for PROCEDURE f_GetTableTransaction_Codes
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-10-15 Andreas Kurz	   	Initial version
#  1.3  2022-01-24 Andreas Kurz		Reworked the structure after DM review
#  1.4	2022-02-15 Andreas Kurz		Changed to adapted DIM_CLIENT structure
#-------------------------------------------------------------------------------
*/
/*

USE ROLE 		R_LDL_D_PIT_ETL;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT;
USE SCHEMA 		P_LEW_MART_PIT_1;
USE WAREHOUSE 	WH_LDL_D_PIT_ETL_S;

 */
/* 
---------------------------------------------------------------------
FUNCTION	:	f_GetTableAdvWeekStartDayId()
Input		:   None
Return		:	Table (CLIENT_ID INTEGER, COUNTRY_ISO_CD VARCHAR(3), COUNTRY_DESCR VARCHAR, LANG_SID INTEGER, CURR_SID INTEGER, CURR_CD VARCHAR, CTR_ADV_WEEK_START_WEEKDAY_ID SMALLINT)
Convert		:	None    
Description	: 	SQL Table Function - returns all Country_1 specific information of the PIT Clients.  
Example		:	iff (ARRAY_CONTAINS(p_transaction_type_cd::INTEGER, TRANSACTION_TYPE_CD),1::INTEGER,0::INTEGER) AS trans_flag
				SELECT * FROM TABLE(f_GetTableAdvWeekStartDayId())
------------------------------------------------------------------------
*/

CREATE OR REPLACE TABLE FUNCTION ldl_p_lew_mart_pit.f_gettableadvweekstartdayid()
RETURNS TABLE<
    client_id INT64,
    country_iso_cd STRING,
    country_descr STRING,
    lang_sid INT64,
    curr_sid INT64,
    curr_cd STRING,
    ctr_adv_week_start_weekday_id INT64
>
AS (

    SELECT 
          a.client_id
        , a.country_iso_cd
        , a.country_descr
        , a.lang_sid
        , a.curr_sid
        , a.curr_cd
        , a.ctr_adv_week_start_weekday_id
    FROM
    (
        SELECT
              client_id
            , country_iso_cd
            , country_descr
            , lang_sid
            , curr_sid
            , curr_cd
            , ctr_adv_week_start_weekday_id
        FROM ldl_p_lew_mart_pit.t_dim_client_1
        WHERE TRUE
            AND deleted_fg = 0
            AND current_fg = 1
            AND pit_country_fg = 1

        QUALIFY ROW_NUMBER() OVER(
            PARTITION BY client_id, valid_from_dt, deleted_fg
            ORDER BY dwh_updated_ts
        ) = 1
    ) a

);