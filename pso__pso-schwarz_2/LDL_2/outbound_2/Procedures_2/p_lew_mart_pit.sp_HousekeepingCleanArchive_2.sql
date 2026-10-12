/*
#-------------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - PITonCloud Application 2024
#-------------------------------------------------------------------------------
# Interface : DDL for PROCEDURE sp_HousekeepingCleanArchive
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
PROCEDURE	:	sp_HousekeepingCleanArchive(pSchema STRING, pTableName STRING )
Input		:   pSchema 				STRING 
				pTableName 				STRING
				pExecute				BOOLEAN
				pScope				BOOLEAN (True/False) for BEGIN Transaction and Commit. Default is FALSE not BT and COMMIT				
Return		:	Error + Error Msg or in success case name of backuped table
Convert		:	None    
Description	: 	Copies / backup important tables 
				Format: #PSCHEMA#.#PTABLENAME#_{Current TS:: YYYYMMDD_H24MISS}_TMP
Example		:	Call P_LEW_MART_PIT.sp_HousekeepingCleanArchive('-1' , 100,'HOUSEKEEPING',3,0);  
------------------------------------------------------------------------
*/
CREATE OR REPLACE PROCEDURE p_lew_mart_pit.sp_housekeepingcleanarchive (
    IN PCLIENTIDS STRING,
    IN PPITMAXARCHIVEHISTORYINDAYS FLOAT64,
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
    DECLARE sqlstmtstartcomponentloggingtmp STRING DEFAULT '';
    DECLARE sqlstmtendcomponentloggingtmp STRING DEFAULT '';
    DECLARE sqlcleanarchive STRING DEFAULT 'DROP TABLE #SF_SCHEMA#.#SF_TABLE_NAME#;';
    
    DECLARE sf_schema STRING;
    DECLARE sf_table_name STRING;
    DECLARE drop_msg STRING;
    DECLARE res ARRAY<JSON>;
    DECLARE iterator_res INT64 DEFAULT 0;
    DECLARE msg STRING;

    -- STEP 1.2 choose correct tamplate (crate or do nothing)
    SET sqlstmthousekeeping = sqlcleanarchive;
    
    IF PPITMAXARCHIVEHISTORYINDAYS != -1 THEN
        BEGIN
            -- STEP 2. Loop: take all rows from config tables
            SET sqlstmt = '';
            SET sqlstmt = '''
                SELECT table_schema AS sf_schema 
                     , table_name AS sf_table_name 
                FROM p_lew_mart_pit_arch.INFORMATION_SCHEMA.TABLES
                WHERE TRUE
                    AND table_type='BASE TABLE'
                    AND SAFE_CAST(REGEXP_EXTRACT(table_name, r'\\d{19}') AS FLOAT64)
                    <= CAST(FORMAT_DATE('%Y%m%d', DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL CAST(#PPITMAXARCHIVEHISTORYINDAYS# AS INT64) DAY)) AS FLOAT64) * POWER(10,(19-8))
                UNION ALL
                SELECT table_schema AS sf_schema 
                     , table_name AS sf_table_name 
                FROM p_lew_fe_mstr_pit_arch.INFORMATION_SCHEMA.TABLES
                WHERE TRUE
                    AND table_type='BASE TABLE'
                    AND SAFE_CAST(REGEXP_EXTRACT(table_name, r'\\d{19}') AS FLOAT64)
                    <= CAST(FORMAT_DATE('%Y%m%d', DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL CAST(#PPITMAXARCHIVEHISTORYINDAYS# AS INT64) DAY)) AS FLOAT64) * POWER(10,(19-8))
            ''';
            
            -- Variable Substitution
            SET sqlstmt = REPLACE(sqlstmt, '#PPITMAXARCHIVEHISTORYINDAYS#', CAST(PPITMAXARCHIVEHISTORYINDAYS AS STRING));
            
            -- Retrieve next Template
            BEGIN
                EXECUTE IMMEDIATE CONCAT('SELECT ARRAY_AGG(JSON_ARRAY(sf_schema, sf_table_name)) FROM (', sqlstmt, ')') INTO res;
            EXCEPTION WHEN ERROR THEN
                SET msg = CONCAT('StartComponentLogging: [', sqlstmt, '] FAILED MESSAGE: ', @@error.message);
                RAISE USING MESSAGE = msg;
            END;

            SET iterator_res = 0;
            WHILE iterator_res < ARRAY_LENGTH(res) DO
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
                    SET drop_msg = CONCAT('DROP ARCH-TABLE ', sf_schema, '.', sf_table_name, ': ', REPLACE(strout, "'", "''"));
                    
                    BEGIN
                        CALL p_lew_mart_pit.sp_startcomponentlogging(
                            CAST(PLOADID AS STRING), 
                            PAPPLICATIONNAME, 
                            'HOUSEKEEPING', 
                            drop_msg, 
                            CONCAT('[', PCLIENTIDS, ']'), 
                            p_lew_mart_pit.f_querytag('HOUSEKEEPING', PAPPLICATIONNAME, CONCAT('[', PCLIENTIDS, ']')), 
                            'p_lew_mart_pit_2', 
                            PPITLOGGINGLEVEL
                        );
                    EXCEPTION WHEN ERROR THEN
                        SET msg = CONCAT('StartComponentLogging: failed message: ', @@error.message);
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
                            drop_msg, 
                            CONCAT('[', PCLIENTIDS, ']'), 
                            'p_lew_mart_pit_2', 
                            0, 
                            PPITLOGGINGLEVEL
                        );
                    EXCEPTION WHEN ERROR THEN
                        SET msg = CONCAT('StartComponentLogging: failed message: ', @@error.message);
                        RAISE USING MESSAGE = msg;
                    END;
                    
                    SET iterator_res = iterator_res + 1;
                END;
            END WHILE;
        END;
    END IF;
  
    SET OUT_PARAM = strout;
END;
