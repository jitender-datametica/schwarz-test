/*
#-------------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : DDL for PROCEDURE sp_psnf_UpdateParam
#-------------------------------------------------------------------------------
# Describtion: Create DDL for FE MSTR Reporting Toc Lookup Table
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-07-01 Andreas Kurz    Initial version
#  1.1  2023-08-27 Nikolai Toknov	Change for PSNF-project
#-------------------------------------------------------------------------------
*/

/*
USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;
USE DATABASE 	LDL_CLONE_PIT;
USE SCHEMA 		P_LEW_MART_PIT_2; 

	DROP PROCEDURE IF EXISTS P_LEW_MART_PIT.sp_psnf_UpdateParam(STRING, STRING, STRING, DOUBLE, STRING, BOOLEAN)
	;
	-- DESCRIBE PROCEDURE sp_psnf_UpdateParam(STRING, STRING, STRING, DOUBLE, STRING, BOOLEAN)
	-- SHOW USER PROCEDURES
	-- SELECT get_ddl('PROCEDURE','sp_psnf_UpdateParam')
	-- Check QH: SELECT * FROM TABLE(INFORMATION_SCHEMA.QUERY_HISTORY_BY_USER(RESULT_LIMIT => 100 ));

	Call sp_RunSearchOptimization('P_LEW_MART_PIT_2','PITonCloud','Performance','',100,FALSE);
	SELECT * FROM LDL.P_LEW_MART_PIT.T_CNTL_PSNF_PROCESSING_PARAM_2 WHERE CLIENT_ID = 21 AND PARAM_ID IN (1, 40, 41)
*/

/* ---------------------------------------------------------------------
PROCEDURE	:	sp_psnf_UpdateParam(pApplicationName STRING, pPCLIENTIDingDesc STRING)
Input		:   pClientId 			STRING 
				pSchema				STRING
				pParamName			STRING
				pParamValue			DOUBLE
				pParamValueChar		STRING
				pScope				BOOLEAN (True/False) for BEGIN Transaction and Commit. Default is FALSE not BT and COMMIT
Return		:	Error + Error Msg | Success Nbr of rows (modules and or compenents) of this run
Convert		:	None    
Description	: 	Updating various Parameters. 
Example		:	Call P_LEW_MART_PIT.sp_psnf_UpdateParam( '23','P_LEW_MART_PIT_2', 'EXEC_PIT_MANUAL_RUN_FG', 2 , NULL);
				Call P_LEW_MART_PIT.sp_psnf_UpdateParam( '23','P_LEW_MART_PIT_2', 'EXEC_PIT_MANUAL_COUNTRY_LST', NULL , '');
				
				Call sp_psnf_UpdateParam( '23','P_LEW_MART_PIT_2', 'START_DT_REAGG', CAST( to_char('${START_DT_REAGG}'::DATE,'YYYYMMDD') AS INTEGER), null); --START_DT_REAGG
				Call sp_psnf_UpdateParam( '23','P_LEW_MART_PIT_2', 'EXEC_PIT_MANUAL_COUNTRY_LST', null, '${EXEC_PIT_MANUAL_COUNTRY_LST}'); --EXEC_PIT_MANUAL_COUNTRY_LST
				Call P_LEW_MART_PIT.sp_psnf_UpdateParam( '21','P_LEW_MART_PIT_2', 'START_DT_PIT_DATA'                , CAST( to_char('2022-03-23'::DATE,'YYYYMMDD') AS INTEGER) , NULL)				
				Call P_LEW_MART_PIT.sp_psnf_UpdateParam( '21','P_LEW_MART_PIT_2', 'START_DT_PIT_DATA'                , CAST( to_char('2022-03-24'::DATE,'YYYYMMDD') AS INTEGER) , NULL, TRUE)
					, pScope				BOOLEAN
------------------------------------------------------------------------
*/
CREATE OR REPLACE PROCEDURE p_lew_mart_pit.sp_psnf_updateparam(
    IN PCLIENTID STRING, 
    IN PSCHEMA STRING, 
    IN PPARAMNAME STRING, 
    IN PPARAMVALUE FLOAT64, 
    IN PPARAMVALUECHAR STRING, 
    OUT OUT_PARAM STRING
)
BEGIN
    DECLARE _rowcnt INT64 DEFAULT 0;
    DECLARE msg STRING DEFAULT '';
    DECLARE sqlcode FLOAT64 DEFAULT 0;
    DECLARE sqlstate STRING DEFAULT '00000';
    DECLARE strclient STRING DEFAULT '-1';
    DECLARE sqlstmtins STRING DEFAULT '';
    DECLARE sqlstmtupd STRING DEFAULT '';
    DECLARE sqlbegintransaction STRING DEFAULT 'BEGIN TRANSACTION;';
    DECLARE sqlcommit STRING DEFAULT 'COMMIT;';
    DECLARE strschema STRING DEFAULT 'P_LEW_MART_PIT_2';
    DECLARE strparamvaluechar STRING DEFAULT '';
    DECLARE strvalue STRING DEFAULT 'NULL';
    DECLARE p_param_value_str STRING;

    IF PCLIENTID = '' OR PCLIENTID IS NULL THEN
        BEGIN
            SET PCLIENTID = strclient;
        END;
    ELSE
        BEGIN
            SET strclient = UPPER(PCLIENTID);
        END;
    END IF;

    IF PSCHEMA = '' OR PSCHEMA IS NULL THEN
        BEGIN
            SET PSCHEMA = strschema;
        END;
    ELSE
        BEGIN
            SET strschema = UPPER(PSCHEMA);
        END;
    END IF;

    IF PPARAMVALUE IS NULL THEN
        BEGIN
            SET PPARAMVALUE = strvalue;
        END;
    ELSE
        BEGIN
            SET p_param_value_str = CAST(PPARAMVALUE AS STRING);
        END;
    END IF;

    IF PPARAMVALUECHAR = '' OR PPARAMVALUECHAR IS NULL THEN
        BEGIN
            SET strparamvaluechar = '';
        END;
    ELSE
        BEGIN
            SET strparamvaluechar = UPPER(PPARAMVALUECHAR);
        END;
    END IF;

    IF PPARAMNAME = '' OR PPARAMNAME IS NULL THEN
        BEGIN
            SET msg = 'Missing parameter pParamName';
            RAISE USING MESSAGE = msg;
        END;
    END IF;

    SET sqlstmtupd = '';
    SET sqlstmtupd = '''
			-- update param #PPARAMID# for client [ #PCLIENTID# ]
			UPDATE `#PSCHEMA#`.t_cntl_psnf_processing_param_2 trg
			SET 
				  valid_to_dt  		= CURRENT_DATE("Europe/Berlin") - 1
				, dwh_updated_ts   	= CAST(CURRENT_TIMESTAMP() AS DATETIME)
				, current_fg    	= CAST(0 AS INT64)
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
					FROM `#PSCHEMA#`.t_cntl_psnf_processing_param_2					
					WHERE TRUE
						AND client_id 	IN ( #PCLIENTID# )
						AND deleted_fg 	= 0
						AND current_fg 	= 1
						AND reject_fg  	= 0
					/* ALWAYS TAKE MAX VERSION NR IGNORE DATE_FROM DATE_TO IN CASE OF ALREADY CLOSED PERIODS */
					QUALIFY version_nr = MAX(version_nr) OVER (PARTITION BY client_id, param_id)
				) pa 
				
				/* PARAM REF */
				INNER JOIN
				(
					SELECT DISTINCT
						  param_id
						, param_name
						, param_descr
						, param_column_datatype
					FROM `#PSCHEMA#`.t_cntl_dim_processing_param_2
					WHERE TRUE
						AND UPPER(TRIM(param_name))  	=  UPPER(TRIM('#PPARAMNAME#'))
						AND deleted_fg 	= 0
						AND reject_fg  	= 0
					-- Deduplication 
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
    SET sqlstmtupd = REPLACE(sqlstmtupd, '#PSCHEMA#', LOWER(strschema));
    SET sqlstmtupd = REPLACE(sqlstmtupd, '#PPARAMNAME#', UPPER(PPARAMNAME));

    SET sqlstmtins = '';
    SET sqlstmtins = '''
		-- Update param 42 pit_manual_run_fg insert new version
			INSERT INTO `#PSCHEMA#`.t_cntl_psnf_processing_param_2
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
				-- Value 			
				, CASE 
					WHEN TRIM(UPPER(param_column_datatype)) = 'SMALLINT' THEN
						CAST(COALESCE(CAST(#PPARAMVALUE# AS INT64), -1) AS INT64)
					WHEN TRIM(UPPER(param_column_datatype)) = 'INTEGER' THEN	
						CAST(COALESCE(CAST(#PPARAMVALUE# AS INT64), -1) AS INT64)	
					WHEN TRIM(UPPER(param_column_datatype)) = 'NUMBER(29,5)' THEN	
						COALESCE(CAST(#PPARAMVALUE# AS NUMERIC), -1)	
					WHEN TRIM(UPPER(param_column_datatype)) = 'DATE' THEN		
						CAST(COALESCE(CAST(#PPARAMVALUE# AS INT64), 88881231) AS INT64)						
					WHEN TRIM(UPPER(param_column_datatype)) = 'VARCHAR' THEN	
						NULL
					ELSE
						NULL
				  END 									AS param_value
				-- Value Char
				, CASE 
					WHEN TRIM(UPPER(param_column_datatype)) = 'SMALLINT' THEN
						CAST(CAST(COALESCE(CAST(#PPARAMVALUE# AS INT64), -1) AS INT64) AS STRING)
					WHEN TRIM(UPPER(param_column_datatype)) = 'INTEGER' THEN			
						CAST(CAST(COALESCE(CAST(#PPARAMVALUE# AS INT64), -1) AS INT64) AS STRING)	
					WHEN TRIM(UPPER(param_column_datatype)) = 'NUMBER(29,5)' THEN			
						CAST(COALESCE(CAST(#PPARAMVALUE# AS NUMERIC), -1) AS STRING)	
					WHEN TRIM(UPPER(param_column_datatype)) = 'DATE' THEN	
						FORMAT_DATE('%Y-%m-%d', SAFE.PARSE_DATE('%Y%m%d', CAST(CAST(COALESCE(CAST(#PPARAMVALUE# AS INT64), 88881231) AS INT64) AS STRING)))											
					WHEN TRIM(UPPER(param_column_datatype)) = 'VARCHAR' THEN
						IF(LENGTH(TRIM('#PPARAMVALUECHAR#'))=0,NULL,TRIM('#PPARAMVALUECHAR#'))
					ELSE
						NULL
				  END 									AS param_value_char
				
				, CURRENT_DATE("Europe/Berlin")                        AS dwh_valid_from
				, DATE('9999-12-31')                    AS dwh_valid_to
				
				, pa.version_nr + 1                     AS version_nr
				, CAST(1 AS INT64)                      AS current_fg
			FROM
			(
				SELECT 
					  client_id
					, param_id
					, version_nr
				FROM `#PSCHEMA#`.t_cntl_psnf_processing_param_2
				WHERE TRUE
					AND client_id 	IN ( #PCLIENTID# )
					AND deleted_fg 	= 0
					AND reject_fg  	= 0
				-- several updates per day 
				QUALIFY version_nr = MAX(version_nr) OVER (PARTITION BY client_id, param_id)
			) pa
		
			/* PARAM REF */
			INNER JOIN
			(
				SELECT DISTINCT
					  param_id
					, param_name
					, param_descr
					, param_column_datatype
				FROM `#PSCHEMA#`.t_cntl_dim_processing_param_2
				WHERE TRUE
					AND UPPER(TRIM(param_name))  =  UPPER(TRIM('#PPARAMNAME#'))
					AND deleted_fg 	= 0
					AND reject_fg  	= 0
				-- Deduplication 
				QUALIFY ROW_NUMBER() OVER(PARTITION BY param_id ORDER BY dwh_updated_ts DESC) = 1						
			) par
			ON TRUE
				AND pa.param_id = par.param_id
			;
    ''';

    SET sqlstmtins = REPLACE(sqlstmtins, '#PCLIENTID#', strclient);
    SET sqlstmtins = REPLACE(sqlstmtins, '#PSCHEMA#', LOWER(strschema));
    SET sqlstmtins = REPLACE(sqlstmtins, '#PPARAMNAME#', UPPER(PPARAMNAME));
    SET sqlstmtins = REPLACE(sqlstmtins, '#PPARAMVALUE#', p_param_value_str);
    SET sqlstmtins = REPLACE(sqlstmtins, '#PPARAMVALUECHAR#', strparamvaluechar);

    BEGIN
        EXECUTE IMMEDIATE sqlbegintransaction;
        
        EXECUTE IMMEDIATE sqlstmtupd;
        SET _rowcnt = @@row_count;

        EXECUTE IMMEDIATE sqlstmtins;
        SET _rowcnt = _rowcnt + @@row_count;

        EXECUTE IMMEDIATE sqlcommit;
    EXCEPTION WHEN ERROR THEN
        SET msg = CONCAT('UpdateParam: [', sqlstmtupd, sqlstmtins, '] SQLSTATE: FAILED MESSAGE: ', @@error.message);
        RAISE USING MESSAGE = msg;
    END;

    SET OUT_PARAM = CAST(COALESCE(_rowcnt, 0) AS STRING);
END;
-- End of sp_psnf_UpdateParam

