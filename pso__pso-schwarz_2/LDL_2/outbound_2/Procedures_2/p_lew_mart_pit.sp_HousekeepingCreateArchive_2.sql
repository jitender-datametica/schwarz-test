/*
#-------------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - PITonCloud Application 2024
#-------------------------------------------------------------------------------
# Interface : DDL for PROCEDURE sp_HousekeepingCreateArchive
#-------------------------------------------------------------------------------
# Describtion: 
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2024-05-14 Nikolai Toknov    	Initial version
#-------------------------------------------------------------------------------
*/

/* TO DO: update description
---------------------------------------------------------------------
PROCEDURE	:	sp_HousekeepingCreateArchive(pSchema STRING, pTableName STRING )
Input		:   pSchema 				STRING 
				pTableName 				STRING
				pExecute				BOOLEAN
				pScope				BOOLEAN (True/False) for BEGIN Transaction and Commit. Default is FALSE not BT and COMMIT				
Return		:	Error + Error Msg or in success case name of backuped table
Convert		:	None    
Description	: 	Copies / backup important tables 
				Format: #PSCHEMA#.#PTABLENAME#_{Current TS:: YYYYMMDD_H24MISS}_TMP
Example		:	Call P_LEW_MART_PIT.sp_HousekeepingCreateArchive(-1 ,'ALL','HOUSEKEEPING',3,0);
------------------------------------------------------------------------
*/


CREATE OR REPLACE PROCEDURE p_lew_mart_pit.sp_housekeepingcreatearchive (
    IN PCLIENTIDS STRING,
    IN PHOUSKEEPINGARCHIVEMODE STRING,
    IN PAPPLICATIONNAME STRING,
    IN PPITLOGGINGLEVEL FLOAT64,
    IN PLOADID FLOAT64,
    OUT OUT_PARAM STRING
)
BEGIN
    DECLARE strclient STRING DEFAULT '-1';
    DECLARE sqlstmt STRING DEFAULT '';
    DECLARE sqlstmthousekeeping STRING DEFAULT '';
    DECLARE strout STRING DEFAULT '';
    DECLARE sqlcreatearchive STRING DEFAULT 'CREATE OR REPLACE TABLE #SF_SCHEMA#_arch.#SF_TABLE_NAME#_#TS# CLONE #SF_SCHEMA#.#SF_TABLE_NAME#;';
    DECLARE res ARRAY<JSON>;
    DECLARE msg STRING;
    DECLARE iterator_res INT64 DEFAULT 0;
    DECLARE sf_schema STRING;
    DECLARE sf_table_name STRING;
    DECLARE var_out STRING;

    -- STEP 1.2 choose correct tamplate
    IF (PHOUSKEEPINGARCHIVEMODE = 'ALL') OR (PHOUSKEEPINGARCHIVEMODE = 'HK') THEN
        BEGIN
            SET sqlstmthousekeeping = REPLACE(sqlcreatearchive, '#TS#', CAST(PLOADID AS STRING));

            -- STEP 2. Loop: take all rows from config tables
            SET sqlstmt = '';
            SET sqlstmt = ''' 
                    WITH all_tables AS (
          SELECT table_schema, table_name, table_type
          FROM `p_lew_mart_pit.INFORMATION_SCHEMA.TABLES`
          UNION ALL
          SELECT table_schema, table_name, table_type
          FROM `p_lew_fe_mstr_pit.INFORMATION_SCHEMA.TABLES` 
        )
                    SELECT table_schema AS sf_schema 
                          ,table_name AS sf_table_name
                    FROM all_tables
                        WHERE TRUE
                            AND table_type='BASE TABLE'
                            AND NOT ENDS_WITH(table_name, '_arch')
                            AND 
                                ('#HOUSKEEPINGARCHIVEMODE#'='ALL'
                                OR
                                (table_schema,table_name) IN (
                                         SELECT 
                                            (LOWER(TRIM(sf_schema)),
                                            LOWER(TRIM(sf_table_name)))
                                            FROM p_lew_mart_pit.t_cntl_housekeeping_param_2
                                                WHERE CURRENT_DATE("Europe/Berlin") BETWEEN valid_from_dt AND valid_to_dt
                                                AND reject_fg=0
                                                AND deleted_fg=0
                                            UNION ALL
                                         SELECT ('p_lew_mart_pit_2', 't_cntl_processing_param_2')
                                            UNION ALL 
                                         SELECT ('p_lew_mart_pit_2','t_cntl_processing_param_normalized_2')
                                        )
                    ) 
            ''';

            -- Variable Substitution
            SET sqlstmt = REPLACE(sqlstmt, '#HOUSKEEPINGARCHIVEMODE#', PHOUSKEEPINGARCHIVEMODE);

            -- Retrieve next Template
            BEGIN
                EXECUTE IMMEDIATE format("""
                    SELECT ARRAY_AGG(JSON_ARRAY(%s, %s))
                    FROM (%s)
                """, 'sf_schema', 'sf_table_name', sqlstmt) INTO res;
            EXCEPTION WHEN ERROR THEN
                SET msg = CONCAT('StartComponentLogging: [', sqlstmt, '] SQLSTATE: FAILED MESSAGE: ', @@error.message);
                RAISE USING MESSAGE = msg;
            END;

            SET iterator_res = 0;

            WHILE (iterator_res < ARRAY_LENGTH(res)) DO
                BEGIN
                    -- STEP 2.1 replace parameters    

                    SET strout = sqlstmthousekeeping;

                    SET sf_schema = JSON_EXTRACT_SCALAR(res[SAFE_OFFSET(iterator_res)], '$[0]');
                    SET sf_table_name = JSON_EXTRACT_SCALAR(res[SAFE_OFFSET(iterator_res)], '$[1]');
                    
                    SET strout = REPLACE(strout, '#SF_SCHEMA#', sf_schema);
                    SET strout = REPLACE(strout, '#SF_TABLE_NAME#', sf_table_name);
                    
                    -- replace parameters

                    -- STEP 2.2 execute script            
                
                    -- Logging
                    BEGIN
                        CALL p_lew_mart_pit.sp_startcomponentlogging(
                            CAST(PLOADID AS STRING),
                            PAPPLICATIONNAME,
                            'PITONCLOUD',
                            CONCAT('CLONE TABLE ', sf_schema, '.', sf_table_name, ': ', REPLACE(strout, "'", "''''")),
                            CONCAT('[', PCLIENTIDS, ']'),
                            p_lew_mart_pit.f_querytag('HOUSEKEEPING', PAPPLICATIONNAME, CONCAT('[', PCLIENTIDS, ']')),
                            'p_lew_mart_pit_2',
                            PPITLOGGINGLEVEL,
                            var_out
                        );

                        Select var_out;
                    EXCEPTION WHEN ERROR THEN
                        SET msg = CONCAT('StartComponentLogging: sp_startcomponentlogging FAILED MESSAGE: ', @@error.message);
                        RAISE USING MESSAGE = msg;
                    END;
                    
                    BEGIN
                        EXECUTE IMMEDIATE strout;
                    EXCEPTION WHEN ERROR THEN
                        SET msg = CONCAT('StartComponentLogging: [', strout, '] SQLSTATE: FAILED MESSAGE: ', @@error.message);
                        RAISE USING MESSAGE = msg;
                    END;

                    -- Logging
                    BEGIN
                        CALL p_lew_mart_pit.sp_endcomponentlogging(
                            PAPPLICATIONNAME,
                            'HOUSEKEEPING',
                            CONCAT('CLONE TABLE ', sf_schema, '.', sf_table_name, ': ', REPLACE(strout, "'", "''''")),
                            CONCAT('[', PCLIENTIDS, ']'),
                            'p_lew_mart_pit_2',
                            '0',
                            PPITLOGGINGLEVEL,
                            var_out
                        );

                        Select var_out;
                    EXCEPTION WHEN ERROR THEN
                        SET msg = CONCAT('StartComponentLogging: sp_endcomponentlogging FAILED MESSAGE: ', @@error.message);
                        RAISE USING MESSAGE = msg;
                    END;

                    SET iterator_res = iterator_res + 1;
                END;
            END WHILE;
        END;
    END IF;

    SET OUT_PARAM = strout;
END;