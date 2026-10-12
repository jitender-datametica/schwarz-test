/*
#-------------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : DDL for PROCEDURE sp_UpdateParam
#-------------------------------------------------------------------------------
# Describtion: Create DDL for FE MSTR Reporting Toc Lookup Table
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-07-01 Andreas Kurz    Initial version
#-------------------------------------------------------------------------------
*/

/*
USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT;
USE SCHEMA 		P_LEW_MART_PIT_1; 

	DROP PROCEDURE IF EXISTS P_LEW_MART_PIT.sp_UpdateParam(STRING, STRING, STRING, DOUBLE, STRING, BOOLEAN)
	;
	-- DESCRIBE PROCEDURE sp_UpdateParam(STRING, STRING, STRING, DOUBLE, STRING, BOOLEAN)
	-- SHOW USER PROCEDURES
	-- SELECT get_ddl('PROCEDURE','SP_UPDATEPARAM')
	-- Check QH: SELECT * FROM TABLE(INFORMATION_SCHEMA.QUERY_HISTORY_BY_USER(RESULT_LIMIT => 100 ));

	Call sp_RunSearchOptimization('P_LEW_MART_PIT_1','PITonCloud','Performance','',100,FALSE);
	SELECT * FROM LDL_PRODUCTION.P_LEW_MART_PIT.T_CNTL_PROCESSING_PARAM_1 WHERE CLIENT_ID = 21 AND PARAM_ID IN (1, 40, 41)
*/

/* 
---------------------------------------------------------------------
PROCEDURE	:	sp_UpdateParam(pApplicationName STRING, pPCLIENTIDingDesc STRING)
Input		:   pClientId 			STRING 
				pSchema				STRING
				pParamName			STRING
				pParamValue			DOUBLE
				pParamValueChar		STRING
				pScope				BOOLEAN (True/False) for BEGIN Transaction and Commit. Default is FALSE not BT and COMMIT
Return		:	Error + Error Msg | Success Nbr of rows (modules and or compenents) of this run
Convert		:	None    
Description	: 	Updating various Parameters. 
Example		:	Call P_LEW_MART_PIT.sp_UpdateParam( '23','P_LEW_MART_PIT_1', 'EXEC_PIT_MANUAL_RUN_FG', 2 , NULL);
				Call P_LEW_MART_PIT.sp_UpdateParam( '23','P_LEW_MART_PIT_1', 'EXEC_PIT_MANUAL_COUNTRY_LST', NULL , '');
				
				Call sp_UpdateParam( '23','P_LEW_MART_PIT_1', 'START_DT_REAGG', CAST( to_char('${START_DT_REAGG}'::DATE,'YYYYMMDD') AS INTEGER), null); --START_DT_REAGG
				Call sp_UpdateParam( '23','P_LEW_MART_PIT_1', 'EXEC_PIT_MANUAL_COUNTRY_LST', null, '${EXEC_PIT_MANUAL_COUNTRY_LST}'); --EXEC_PIT_MANUAL_COUNTRY_LST
				Call P_LEW_MART_PIT.sp_UpdateParam( '21','P_LEW_MART_PIT_1', 'START_DT_PIT_DATA'                , CAST( to_char('2022-03-23'::DATE,'YYYYMMDD') AS INTEGER) , NULL)				
				Call P_LEW_MART_PIT.sp_UpdateParam( '21','P_LEW_MART_PIT_1', 'START_DT_PIT_DATA'                , CAST( to_char('2022-03-24'::DATE,'YYYYMMDD') AS INTEGER) , NULL, TRUE)
					, pScope				BOOLEAN
------------------------------------------------------------------------
*/



CREATE OR REPLACE PROCEDURE p_lew_mart_pit.sp_updateparam (
    IN PCLIENTID STRING,
    IN PSCHEMA STRING,
    IN PPARAMNAME STRING,
    IN PPARAMVALUE FLOAT64,
    IN PPARAMVALUECHAR STRING,
    OUT OUT_PARAM STRING
)
BEGIN
    DECLARE _rowcnt INT64 DEFAULT 0;
    DECLARE _updcnt INT64 DEFAULT 0;
    DECLARE _inscnt INT64 DEFAULT 0;
    DECLARE msg STRING DEFAULT '';
    DECLARE sqlstmtins STRING DEFAULT '';
    DECLARE sqlstmtupd STRING DEFAULT '';
    DECLARE sqlbegintransaction STRING DEFAULT 'BEGIN TRANSACTION;';
    DECLARE sqlcommit STRING DEFAULT 'COMMIT TRANSACTION;';
    DECLARE strschema STRING DEFAULT 'p_lew_mart_pit_1';
    DECLARE strparamvaluechar STRING DEFAULT '';
    DECLARE strclient STRING DEFAULT '-1';
    DECLARE strparamvalue STRING DEFAULT 'NULL';

    IF PCLIENTID IS NULL OR PCLIENTID = '' THEN
        SET strclient = '-1';
    ELSE
        SET strclient = UPPER(PCLIENTID);
    END IF;

    IF PSCHEMA IS NULL OR PSCHEMA = '' THEN
        SET strschema = 'p_lew_mart_pit_1';
    ELSE
        SET strschema = LOWER(PSCHEMA);
    END IF;

    IF PPARAMVALUE IS NOT NULL THEN
        SET strparamvalue = CAST(PPARAMVALUE AS STRING);
    END IF;

    IF PPARAMVALUECHAR IS NULL OR PPARAMVALUECHAR = '' THEN
        SET strparamvaluechar = '';
    ELSE
        SET strparamvaluechar = UPPER(PPARAMVALUECHAR);
    END IF;

    IF PPARAMNAME IS NULL OR PPARAMNAME = '' THEN
        RAISE USING MESSAGE = 'Missing parameter pParamName';
    END IF;

    SET sqlstmtupd = '''
            UPDATE #PSCHEMA#.t_cntl_processing_param_1 trg
            SET 
                  valid_to_dt       = CURRENT_DATE("Europe/Berlin") - 1
                , dwh_updated_ts    = CAST(CURRENT_TIMESTAMP() AS DATETIME)
                , current_fg        = 0
            FROM    
            (
                SELECT 
                      pa.client_id
                    , pa.param_id
                    , pa.version_nr
                FROM
                    (
                    SELECT 
                          client_id
                        , param_id
                        , version_nr
                    FROM #PSCHEMA#.t_cntl_processing_param_1                  
                    WHERE TRUE
                        AND client_id   IN ( #PCLIENTID# )
                        AND deleted_fg  = 0
                        AND current_fg  = 1
                        AND reject_fg   = 0
                    QUALIFY version_nr = MAX(version_nr) OVER (PARTITION BY client_id, param_id)
                ) pa 
                INNER JOIN
                (
                    SELECT DISTINCT
                          param_id
                        , param_name
                        , param_descr
                        , param_column_datatype
                    FROM #PSCHEMA#.t_cntl_dim_processing_param_1
                    WHERE TRUE
                        AND UPPER(TRIM(param_name))     =  UPPER(TRIM('#PPARAMNAME#'))
                        AND deleted_fg  = 0
                        AND reject_fg   = 0
                    QUALIFY ROW_NUMBER() OVER(PARTITION BY param_id ORDER BY dwh_updated_ts DESC) = 1                       
                ) par
                ON TRUE
                    AND pa.param_id = par.param_id
            ) src
            WHERE TRUE
                AND trg.param_id   = src.param_id
                AND trg.client_id  = src.client_id
                AND trg.version_nr = src.version_nr
                AND trg.deleted_fg = 0
                AND trg.reject_fg  = 0
                AND trg.client_id  IN ( #PCLIENTID# ) 
                ;       
    ''';

    SET sqlstmtupd = REPLACE(sqlstmtupd, '#PCLIENTID#', strclient);
    SET sqlstmtupd = REPLACE(sqlstmtupd, '#PSCHEMA#', strschema);
    SET sqlstmtupd = REPLACE(sqlstmtupd, '#PPARAMNAME#', UPPER(PPARAMNAME));

    SET sqlstmtins = '''
            INSERT INTO #PSCHEMA#.t_cntl_processing_param_1
            (
                  client_id
                , param_id
                , param_value
                , param_value_char
                , valid_from_dt
                , valid_to_dt
                , version_nr
                , current_fg
            )
            SELECT
                  pa.client_id
                , pa.param_id
                , CAST(CASE 
                    WHEN TRIM(UPPER(param_column_datatype)) = 'SMALLINT' THEN
                        COALESCE(CAST(#PPARAMVALUE# AS FLOAT64), -1.0)
                    WHEN TRIM(UPPER(param_column_datatype)) = 'INTEGER' THEN    
                        COALESCE(CAST(#PPARAMVALUE# AS FLOAT64), -1.0)    
                    WHEN TRIM(UPPER(param_column_datatype)) = 'NUMBER(29,5)' THEN   
                        COALESCE(CAST(#PPARAMVALUE# AS FLOAT64), -1.0)  
                    WHEN TRIM(UPPER(param_column_datatype)) = 'DATE' THEN       
                        COALESCE(CAST(#PPARAMVALUE# AS FLOAT64), 88881231.0)                      
                    WHEN TRIM(UPPER(param_column_datatype)) = 'VARCHAR' THEN    
                        NULL
                    ELSE
                        NULL
                  END  AS NUMERIC)                                  AS param_value
                , CASE 
                    WHEN TRIM(UPPER(param_column_datatype)) = 'SMALLINT' THEN
                        CAST(COALESCE(CAST(#PPARAMVALUE# AS INT64), -1) AS STRING)
                    WHEN TRIM(UPPER(param_column_datatype)) = 'INTEGER' THEN            
                        CAST(COALESCE(CAST(#PPARAMVALUE# AS INT64), -1) AS STRING)   
                    WHEN TRIM(UPPER(param_column_datatype)) = 'NUMBER(29,5)' THEN           
                        CAST(COALESCE(CAST(#PPARAMVALUE# AS NUMERIC), CAST(-1 AS NUMERIC)) AS STRING) 
                    WHEN TRIM(UPPER(param_column_datatype)) = 'DATE' THEN   
                        CAST(PARSE_DATE('%Y%m%d', CAST(COALESCE(CAST(#PPARAMVALUE# AS INT64), 88881231) AS STRING)) AS STRING)                                           
                    WHEN TRIM(UPPER(param_column_datatype)) = 'VARCHAR' THEN
                        IF(LENGTH(TRIM('#PPARAMVALUECHAR#'))=0, NULL, TRIM('#PPARAMVALUECHAR#'))
                    ELSE
                        NULL
                  END                                   AS param_value_char
                , CURRENT_DATE("Europe/Berlin")                        AS dwh_valid_from
                , DATE('9999-12-31')                    AS dwh_valid_to
                , pa.version_nr + 1                     AS version_nr
                , 1                                     AS current_fg
            FROM
            (
                SELECT 
                      client_id
                    , param_id
                    , version_nr
                FROM #PSCHEMA#.t_cntl_processing_param_1
                WHERE TRUE
                    AND client_id   IN ( #PCLIENTID# )
                    AND deleted_fg  = 0
                    AND reject_fg   = 0
                QUALIFY version_nr = MAX(version_nr) OVER (PARTITION BY client_id, param_id)
            ) pa
            INNER JOIN
            (
                SELECT DISTINCT
                      param_id
                    , param_name
                    , param_descr
                    , param_column_datatype
                FROM #PSCHEMA#.t_cntl_dim_processing_param_1
                WHERE TRUE
                    AND UPPER(TRIM(param_name))  =  UPPER(TRIM('#PPARAMNAME#'))
                    AND deleted_fg  = 0
                    AND reject_fg   = 0
                QUALIFY ROW_NUMBER() OVER(PARTITION BY param_id ORDER BY dwh_updated_ts DESC) = 1                       
            ) par
            ON TRUE
                AND pa.param_id = par.param_id
            ;
    ''';

    SET sqlstmtins = REPLACE(sqlstmtins, '#PCLIENTID#', strclient);
    SET sqlstmtins = REPLACE(sqlstmtins, '#PSCHEMA#', strschema);
    SET sqlstmtins = REPLACE(sqlstmtins, '#PPARAMNAME#', UPPER(PPARAMNAME));
    SET sqlstmtins = REPLACE(sqlstmtins, '#PPARAMVALUE#', strparamvalue);
    SET sqlstmtins = REPLACE(sqlstmtins, '#PPARAMVALUECHAR#', strparamvaluechar);

    BEGIN
        EXECUTE IMMEDIATE sqlbegintransaction;
        
        EXECUTE IMMEDIATE sqlstmtupd;
        SET _updcnt = @@row_count;
        
        EXECUTE IMMEDIATE sqlstmtins;
        SET _inscnt = @@row_count;
        
        EXECUTE IMMEDIATE sqlcommit;
    EXCEPTION WHEN ERROR THEN
        SET msg = CONCAT('UpdateParam: [', sqlstmtupd, sqlstmtins, '] SQLSTATE: FAILED MESSAGE: ', @@error.message);
        RAISE USING MESSAGE = msg;
    END;

    SET _rowcnt = _updcnt + _inscnt;
    SET OUT_PARAM = CAST(_rowcnt AS STRING);
END;
