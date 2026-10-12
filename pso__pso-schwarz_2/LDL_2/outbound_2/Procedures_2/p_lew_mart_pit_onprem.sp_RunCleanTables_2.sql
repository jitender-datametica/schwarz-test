/*
// ---------------------------------------------------------------------
// PROCEDURE	:	sp_RunCleanTables(pSchema STRING, pApplicationName STRING, pModuleName STRING, pRunClusteringDesc STRING )
// Input		:   pTableType				STRING (All, Static, Fact, Log, Empty)
// 				pSchema 				STRING 
// 				pApplicationName 		STRING
// 				pModuleName 			STRING 		
//     			pRunClusteringDesc    	STRING --> [0] running in sequence
//     			pMaxRuns				INTEGER
// Return		:	Error + Error Msg or in success case number of processed Tables
// Convert		:	None    
// Description	: 	Initialize Cleaning all PIT Tables based on Parameters, there is a max Runs (:= 100) to prevent endless loops
// 				PIT Tables are inputted statically, but must exist in the information schema of the corresponding Schema
//                 Logging is also enables  but must be enabled! 
// Example		:	Call sp_RunCleanTables('P_LEW_MART_PIT_ONPREM');
// ------------------------------------------------------------------------
// # History:
// #  1.0  2021-07-01 Andreas Kurz    Initial version
*/

CREATE OR REPLACE PROCEDURE p_lew_mart_pit_onprem.sp_runcleantables (
    IN PTABLETYPE      		STRING,
	IN PSCHEMA      		STRING, 
	IN PAPPLICATIONNAME 	STRING, 
	IN PMODULENAME 			STRING, 		
	IN PRUNCLUSTERINGDESC   STRING,  
	IN PMAXRUNS				FLOAT64,
	IN PLOGGING				BOOL,
    OUT OUT_PARAM           STRING
)
BEGIN
    DECLARE _rowcnt INT64 DEFAULT 0;
    DECLARE _blogging BOOL DEFAULT FALSE;
    DECLARE imaxruns FLOAT64 DEFAULT 100;
    DECLARE strtabletype STRING DEFAULT 'ALL';
    DECLARE strruncluster STRING DEFAULT '[0]';
    DECLARE sqlcode INT64 DEFAULT 0;
    DECLARE sqlstate STRING DEFAULT '00000';
    DECLARE msg STRING DEFAULT '';
    DECLARE sqlstmtlogstart STRING DEFAULT '';
    DECLARE sqlstmtlogend STRING DEFAULT '';
    DECLARE sqlstmt STRING DEFAULT '';
    
    DECLARE res ARRAY<JSON>;
    DECLARE iterator_res INT64 DEFAULT 0;
    DECLARE icnt FLOAT64 DEFAULT 0;
    DECLARE tablename_schema STRING;
    DECLARE var_out STRING;

    IF PLOGGING IS NULL THEN
        SET _blogging = FALSE;
    ELSE
        SET _blogging = PLOGGING;
    END IF;
    
    IF PMAXRUNS IS NULL THEN 
        SET PMAXRUNS = imaxruns; 
    ELSE
        SET imaxruns = PMAXRUNS;
    END IF;
    
    -- CHECK INPUT runcluster 
    IF PRUNCLUSTERINGDESC = '' OR PRUNCLUSTERINGDESC IS NULL THEN 
        SET PRUNCLUSTERINGDESC = strruncluster; 
    ELSE
        SET strruncluster = UPPER(PRUNCLUSTERINGDESC);
    END IF;	
    
    -- CHECK INPUT pTableType
    IF PTABLETYPE = '' OR PTABLETYPE IS NULL THEN 
        SET PTABLETYPE = strtabletype; 
    ELSE
        SET strtabletype = UPPER(PTABLETYPE);
    END IF;

    SET sqlstmt = format("""
        SELECT
              stat.table_name
            , stat.table_type
            , stat.seq_num				
            , stat.table_type_id
            , stat.tablename_schema AS tablename_schema_5				
        FROM
        (
            SELECT
                  TRIM(LOWER(column1)) 						AS table_name 
                , TRIM(UPPER(column2)) 						AS table_type 
                , column3 									AS seq_num
                , CASE 
                    WHEN TRIM(UPPER(column2)) = 'STATIC' 		THEN  1
                    WHEN TRIM(UPPER(column2)) = 'FACT'		    THEN  2
                    WHEN TRIM(UPPER(column2)) = 'LOG'           THEN  3
                    WHEN TRIM(UPPER(column2)) = 'EMPTY'         THEN -1
                    WHEN TRIM(UPPER(column2)) = 'NOTUSED'       THEN -1
                    WHEN TRIM(UPPER(column2)) = 'CLONED'        THEN -1
                    ELSE -2
                END AS table_type_id
                , CONCAT('%s.', TRIM(LOWER(column1))) 		AS tablename_schema
            FROM UNNEST([
                  STRUCT('t_advert_medium_2' AS column1, 'STATIC' AS column2, 1 AS column3)
                , STRUCT('t_advert_medium_group_2', 'STATIC', 2)
                , STRUCT('t_advert_medium_hist_2', 'STATIC', 3)
                , STRUCT('t_advert_period_2', 'STATIC', 4)
                , STRUCT('t_advert_theme_2', 'STATIC', 5)
                , STRUCT('t_advert_week_2', 'FACT', 6)
                , STRUCT('t_advert_week_action_type_2', 'FACT', 7)
                , STRUCT('t_advert_week_itemgroup_int_2', 'FACT', 8)
                , STRUCT('t_advert_week_item_medium_2', 'FACT', 9)
                , STRUCT('t_advert_week_item_period_2', 'FACT', 10)
                , STRUCT('t_advert_week_item_period_wawi_2', 'FACT', 11)
                , STRUCT('t_advert_week_medium_2', 'FACT', 12)
                , STRUCT('t_advert_week_medium_grp_2', 'FACT', 13)
                , STRUCT('t_advert_week_orig_item_2', 'FACT', 14)
                , STRUCT('t_advert_week_period_2', 'FACT', 15)
                , STRUCT('t_advert_week_period_action_type_2', 'FACT', 16)
                , STRUCT('t_advert_week_related_2', 'STATIC', 17)
                , STRUCT('t_advert_week_related_type_2', 'STATIC', 18)
                , STRUCT('t_advert_week_subitemgroup_2', 'FACT', 19)
                , STRUCT('t_advert_week_theme_2', 'FACT', 20)
                , STRUCT('t_advert_week_theme_total_2', 'FACT', 21)
                , STRUCT('t_advert_week_total_2', 'FACT', 22)
                , STRUCT('t_cntl_etl_logging_2', 'LOG', 23)
                , STRUCT('t_cntl_etl_logging_run_seq_2', 'LOG', 24)
                , STRUCT('t_cntl_etl_performance_2', 'LOG', 25)
                , STRUCT('t_country_advert_week_start_2', 'STATIC', 26)
                , STRUCT('t_dim_calendar_2', 'STATIC', 27)
                , STRUCT('t_itemgroup_int_buy_price_range_2', 'STATIC', 28)
                , STRUCT('t_pit_action_type_2', 'STATIC', 29)
                , STRUCT('t_pit_apt_advert_medium_client_2', 'STATIC', 30)
                , STRUCT('t_pit_apt_advert_theme_client_2', 'STATIC', 31)
                , STRUCT('t_pit_apt_base_client_promotionperiod_item_2', 'FACT', 32)
                , STRUCT('t_pit_apt_item_list_type_2', 'FACT', 33)
                , STRUCT('t_pit_apt_medium_client_promotionperiod_item_2', 'FACT', 34)
                , STRUCT('t_pit_automated_testing_item_2', 'EMPTY', 35)
                , STRUCT('t_pit_automated_testing_rules_2', 'EMPTY', 36)
                , STRUCT('t_pit_clients_2', 'FACT', 37)
                , STRUCT('t_pit_clients_stores_2', 'FACT', 38)
                , STRUCT('t_pit_client_advert_week_2', 'FACT', 39)
                , STRUCT('t_pit_client_advert_week_period_start_2', 'FACT', 40)
                , STRUCT('t_pit_country_2', 'STATIC', 41)
                , STRUCT('t_pit_day_item_store_adv_cnt_2', 'FACT', 42)
                , STRUCT('t_pit_day_item_store_cnt_2', 'FACT', 43)
                , STRUCT('t_pit_etl_logging_2', 'NOTUSED', 44)
                , STRUCT('t_pit_etl_logging_run_2', 'NOTUSED', 45)
                , STRUCT('t_pit_hier_level_2', 'STATIC', 46)
                , STRUCT('t_pit_hier_type_2', 'STATIC', 47)
                , STRUCT('t_pit_item_client_day_2', 'FACT', 48)
                , STRUCT('t_pit_item_client_last_day_2', 'FACT', 49)
                , STRUCT('t_pit_item_eclient_2', 'FACT', 50)
                , STRUCT('t_pit_item_eclient_day_2', 'FACT', 51)
                , STRUCT('t_pit_item_elwis_brand_type_client_day_2', 'FACT', 52)
                , STRUCT('t_pit_item_elwis_brand_type_store_day_2', 'FACT', 53)
                , STRUCT('t_pit_item_elwis_buying_list_type_client_day_2', 'FACT', 54)
                , STRUCT('t_pit_item_elwis_list_type_client_day_2', 'FACT', 55)
                , STRUCT('t_pit_item_elwis_list_type_store_day_2', 'FACT', 56)
                , STRUCT('t_pit_param_2', 'STATIC', 57)
                , STRUCT('t_pit_pv_sales_client_day_item_2', 'FACT', 58)
                , STRUCT('t_pit_ref_till_discount_2', 'NOTUSED', 59)
                , STRUCT('t_pit_reports_toc_2', 'STATIC', 60)
                , STRUCT('t_pit_sales_client_day_item_2', 'FACT', 61)
                , STRUCT('t_pit_sales_store_day_item_2', 'FACT', 62)
                , STRUCT('t_pit_scope_country_init_2', 'NOTUSED', 63)
                , STRUCT('t_pit_scope_country_param_2', 'STATIC', 64)
                , STRUCT('t_pit_scope_country_param_backup_after_2', 'CLONED', 65)
                , STRUCT('t_pit_scope_country_param_backup_before_2', 'CLONED', 66)
                , STRUCT('t_pit_scope_country_param_country_2', 'STATIC', 67)
                , STRUCT('t_pit_scope_country_param_normalized_2', 'STATIC', 68)
                , STRUCT('t_pit_scope_country_param_ref_2', 'STATIC', 69)
                , STRUCT('t_pit_store_day_item_pv_2', 'FACT', 70)
                , STRUCT('t_pit_store_day_item_pv_reagg_2', 'FACT', 71)
                , STRUCT('t_pit_store_day_item_wawi_2', 'FACT', 72)
                , STRUCT('t_pit_upi_client_day_item_2', 'FACT', 73)
                , STRUCT('t_pit_upi_eclient_day_item_2', 'FACT', 74)
                , STRUCT('t_pit_upi_store_day_item_2', 'FACT', 75)
                , STRUCT('t_pit_version_info_2', 'STATIC', 76)
                , STRUCT('t_pit_week_item_period_pv_2', 'FACT', 77)
            ])
            WHERE TRUE	
                AND ('%s' = 'ALL' OR '%s' = TRIM(UPPER(column2)))
        ) stat
        INNER JOIN
        (
            SELECT 
                CONCAT(LOWER(table_schema), '.', LOWER(table_name)) AS tablename_schema
            FROM `%s`.INFORMATION_SCHEMA.TABLES 
            WHERE TRUE 
                AND UPPER(table_name)   LIKE 'T_%%' 
                AND UPPER(table_name)   NOT LIKE 'TT%%' 
                AND UPPER(table_name) 	NOT LIKE '%%_TMP'			
        ) inf
        ON TRUE 
            AND inf.tablename_schema = stat.tablename_schema
    """, LOWER(PSCHEMA), UPPER(PTABLETYPE), UPPER(PTABLETYPE), LOWER(PSCHEMA));

    -- Retrieve from all uses tables
    BEGIN
        EXECUTE IMMEDIATE format("""
            SELECT ARRAY_AGG(JSON_OBJECT('tablename_schema_5', tablename_schema_5))
            FROM (%s)
        """, sqlstmt) INTO res;
    EXCEPTION WHEN ERROR THEN
        SET msg = CONCAT('P_RUNCLEANTABLE: [', sqlstmt, '] SQLSTATE: FAILED MESSAGE: ', @@error.message);
        RAISE USING MESSAGE = msg;           
    END;

    -- Loop all results
    SET _rowcnt = ARRAY_LENGTH(res);
    SET iterator_res = 0;
    SET icnt = 0;

    WHILE (iterator_res < _rowcnt AND icnt < imaxruns) DO
        BEGIN
            SET tablename_schema = JSON_VALUE(res[SAFE_OFFSET(iterator_res)], '$.tablename_schema_5');
            
            SET sqlstmt = '';
            SET sqlstmt = CONCAT('TRUNCATE TABLE ', tablename_schema, ';');
            
            IF _blogging IS TRUE THEN
                BEGIN
                    CALL p_lew_mart_pit_onprem.sp_startcomponentlogging(
                        PAPPLICATIONNAME,
                        PMODULENAME,
                        CONCAT('TRUNCATE TABLE ', tablename_schema), 
                        strruncluster,
                        p_lew_mart_pit_onprem.querytag(PAPPLICATIONNAME, PMODULENAME, NULL),
                        var_out
                    );
                EXCEPTION WHEN ERROR THEN
                    SET msg = CONCAT('P_RUNCLEANTABLE_TRUNCATE: p_lew_mart_pit_onprem.sp_startcomponentlogging FAILED MESSAGE: ', @@error.message);
                    RAISE USING MESSAGE = msg;
                END;
            END IF;

            BEGIN
                EXECUTE IMMEDIATE sqlstmt;
            EXCEPTION WHEN ERROR THEN
                SET msg = CONCAT('P_RUNCLEANTABLE_TRUNCATE: [', sqlstmt, '] SQLSTATE: FAILED MESSAGE: ', @@error.message);
                RAISE USING MESSAGE = msg;
            END;

            IF _blogging IS TRUE THEN
                BEGIN
                    CALL p_lew_mart_pit_onprem.sp_endcomponentlogging(
                       PAPPLICATIONNAME,
    PMODULENAME,
    CONCAT('TRUNCATE TABLE ', tablename_schema), 
    strruncluster, 
    '1',
    var_out
                    );
                EXCEPTION WHEN ERROR THEN
                    SET msg = CONCAT('P_RUNCLEANTABLE_TRUNCATE: p_lew_mart_pit_onprem.sp_endcomponentlogging FAILED MESSAGE: ', @@error.message);
                    RAISE USING MESSAGE = msg;
                END;
            END IF;
            
            SET icnt = icnt + 1;
            SET iterator_res = iterator_res + 1;
        END;
    END WHILE;

    SET OUT_PARAM = CAST(COALESCE(_rowcnt, 0) AS STRING);			
END;