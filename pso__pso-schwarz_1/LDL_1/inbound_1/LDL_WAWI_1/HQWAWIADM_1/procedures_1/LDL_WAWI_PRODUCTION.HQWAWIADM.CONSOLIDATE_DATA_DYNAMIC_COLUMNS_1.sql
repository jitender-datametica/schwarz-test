CREATE OR REPLACE PROCEDURE LDL_WAWI_PRODUCTION.HQWAWIADM.CONSOLIDATE_DATA_DYNAMIC_COLUMNS("SNFLK_DATABASE" VARCHAR, "IN_SOURCE_TABLE_NAME" VARCHAR, "IN_TARGET_TABLE_NAME" VARCHAR, "IN_SF_CONSOL_SCHEMA" VARCHAR, "IN_WAWI_SCHEMA" VARCHAR, "IN_SOURCE_TABLE" VARCHAR, "IN_LOAD_MODE" VARCHAR, "PRIMARY_KEYS" VARCHAR)
RETURNS VARCHAR
LANGUAGE JAVASCRIPT
EXECUTE AS CALLER
AS '


    var lcl_snflk_database = arguments[0];
    var country_databases = lcl_snflk_database.split('','');
    var source_table_name = arguments[1];
    var target_table_name = arguments[2];
    var SF_CONSOL_SCHEMA = arguments[3];
    var WAWI_SCHEMA = arguments[4];
    var SOURCE_TABLE = arguments[5];
    var LOAD_MODE = arguments[6];
    var lcl_primary_keys = arguments[7];
    var primary_KeyColumns = lcl_primary_keys.split('','');


// Function to get the maximum SCN
function getMaxScn(schema, table_name, database_name, source_table, country_1) {
    var wh_nr = (source_table === ''WH'' || source_table === ''WH_Move'') ? database_name.substring(database_name.length - 3) : ''000'';
    var query = `
        SELECT max_scn
        FROM LDL_WAWI_PRODUCTION.` + schema + `.wawi_consolidation_extract_log_1
        WHERE wawi_instanz_kzl = ''` + country_1 + `''
        AND table_name = ''` + table_name + `''
        AND wh_nr = ''` + wh_nr + `''
    `;

    console.log(''Executing query:'', query);

    var statement = snowflake.createStatement({sqlText: query});
    var resultSet = statement.execute();

    if (resultSet.next()) {
        var max_scn = resultSet.getColumnValue(1);
        console.log(''max_scn:'', max_scn);
        return max_scn === null ? -1 : max_scn;
    }

    console.log(''No result found'');
    return -1;
}

// Function to get the maximum DFG SCN
function getMaxDfgScn(schema, table_name, database_name, source_table, country_1) {
    var wh_nr = (source_table === ''WH'' || source_table === ''WH_Move'') ? database_name.substring(database_name.length - 3) : ''000'';
    var query = `
        SELECT max_dfg_scn
        FROM LDL_WAWI_PRODUCTION.` + schema + `.wawi_consolidation_extract_log_1
        WHERE wawi_instanz_kzl = ''` + country_1 + `''
        AND table_name = ''` + table_name + `''
        AND wh_nr = ''` + wh_nr + `''
    `;

    console.log(''Executing query:'', query);

    var statement = snowflake.createStatement({sqlText: query});
    var resultSet = statement.execute();

    if (resultSet.next()) {
        var max_dfg_scn = resultSet.getColumnValue(1);
        console.log(''max_dfg_scn:'', max_dfg_scn);
        return max_dfg_scn === null ? -1 : max_dfg_scn;
    }

    console.log(''No result found'');
    return -1;
}

// Function to extract the country_1 code from the database name
function getCountryCode(database_name) {
    // Check for specific database names and return ''NIE''
    if (database_name === ''SH_WAWI_IEHQ002'' || database_name === ''SH_WAWI_IEWH020'') {
        return ''NIE'';
    }
    // Default behavior: extract the country_1 code from the database name
    return database_name.substring(8, 10);
}

    // New function to get column names using SHOW COLUMNS and RESULT_SCAN
    function getColumnNames(database_name, schema, table_name) {
        var showColumnsSQL = ` SHOW COLUMNS IN TABLE ` + database_name + `.` + schema + `.` + table_name;
        var statement = snowflake.createStatement({sqlText: showColumnsSQL});
        statement.execute();

        var getColumnsSQL = `SELECT column_name FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()))`;
        var columnStatement = snowflake.createStatement({sqlText: getColumnsSQL});
        var resultSet = columnStatement.execute();
        var columnNames = [];
        while (resultSet.next()) {
            columnNames.push(resultSet.getColumnValue(1));
        }
        return columnNames;
    }
    // Function to check if a table exists
    function tableExists(database_name, schema, table_name) {
        var query = `
            SELECT COUNT(*)
            FROM ` + database_name + `.INFORMATION_SCHEMA.TABLES
            WHERE TABLE_SCHEMA = ''` + schema + `''
            AND TABLE_NAME = ''` + table_name + `''
        `;
        var statement = snowflake.createStatement({sqlText: query});
        var resultSet = statement.execute();
        var result = resultSet.next() ? resultSet.getColumnValue(1) : 0;
        return result > 0;
    }

    try {
        for (var i = 0; i < country_databases.length; i++) {
            var database_name = country_databases[i];
            var country_1 = getCountryCode(database_name);

            // Check if the source table exists
            if (!tableExists(database_name, WAWI_SCHEMA, source_table_name)) {
                console.log(''Table '' + source_table_name + '' does not exist in database '' + database_name + ''. Skipping...'');
                continue;
            }

            // Get the values of the SCNs to prepare for a delta load.
            var max_scn = getMaxScn(SF_CONSOL_SCHEMA, source_table_name, database_name, SOURCE_TABLE, country_1);
            var max_dfg_scn = getMaxDfgScn(SF_CONSOL_SCHEMA, source_table_name, database_name, SOURCE_TABLE, country_1);

            // Get column names from the source and target tables
            var sourceColumns = getColumnNames(database_name, WAWI_SCHEMA, source_table_name);
            var targetColumns = getColumnNames(''LDL_WAWI_PRODUCTION'', SF_CONSOL_SCHEMA, target_table_name);

            // Exclude specific columns from the target columns
            var filteredTargetColumns = targetColumns.filter(col => ![''WAWI_INSTANZ_KZL'', ''DELETE_FG'', ''EXTRACTION_TMSP''].includes(col));

            // Identify columns that are in the target but not in the source
            var missingColumns = filteredTargetColumns.filter(col => !sourceColumns.includes(col));


            // Identify columns that are in both the source and target
            var commonColumns = sourceColumns.filter(col => filteredTargetColumns.includes(col));

            // Create the column list for the INSERT statement
            var commonColumnsList = commonColumns.join('', '');
            var allColumnsList = commonColumnsList + (missingColumns.length > 0 ? '', '' + missingColumns.join('', '') : '''') + '', WAWI_INSTANZ_KZL, DELETE_FG, EXTRACTION_TMSP'';

            // Create the SELECT list for the INSERT statement, setting missing columns to NULL
            var selectColumnsList = commonColumns.map(col => col).concat(missingColumns.map(col => ''NULL AS '' + col)).join('', '');

            var warehouse_number = database_name.substring(database_name.length - 3);

            // Decide if it is a full or a delta load:
            // Insert data into the temporary table
            if (LOAD_MODE === ''FULL'') {
                var insertSQL = `
                    INSERT INTO LDL_WAWI_PRODUCTION.` + SF_CONSOL_SCHEMA + `.` + target_table_name + ` (` + allColumnsList + `)
                    SELECT
                        ` + selectColumnsList + `,
                        ''` + country_1 + `'' AS WAWI_INSTANZ_KZL,
                        NULL AS DELETE_FG,
                        CURRENT_TIMESTAMP() AS EXTRACTION_TMSP
                    FROM
                        ` + database_name + `.` + WAWI_SCHEMA + `.` + source_table_name + `;
                `;
                console.log(insertSQL); // Log the SQL statement
                snowflake.execute({sqlText: insertSQL});

                var jsonExtractColumns = commonColumns
                .filter(col => ![''WAWI_INSTANZ_KZL'', ''DELETE_FG'', ''EXTRACTION_TMSP'', ''SCN'', ''scn''].includes(col))
                .map(col => `JSON_EXTRACT_PATH_TEXT(json, ''${col}'') AS ${col}`)
                .concat(missingColumns.map(col => ''NULL AS '' + col))
                .join('', '');

                var filteredAllColumnsList = allColumnsList
                .split('', '')
                .filter(col => ![''SCN'', ''scn''].includes(col))
                .concat([''SCN''])
                .join('', '');

                // Construct jsonExtractColumns for the primary key columns
                var jsonExtractColumns_pk = primary_KeyColumns
                .filter(col => ![''wawi_instanz_kzl''].includes(col))
                .map(col => `JSON_EXTRACT_PATH_TEXT(json, ''${col}'') AS ${col}`)
                .join('', '');

                // Construct groupByColumnsList for the GROUP BY clause
                var groupByColumnsList = primary_KeyColumns
                .filter(col => ![''wawi_instanz_kzl''].includes(col))
                .map(col => `JSON_EXTRACT_PATH_TEXT(json, ''${col.toUpperCase()}'')`)
                .concat([''SCN''])
                .join('', '');


                var insertSQL_INGESTION_TABLE = `
                INSERT INTO LDL_WAWI_PRODUCTION.` + SF_CONSOL_SCHEMA + `.` + target_table_name + ` (` + filteredAllColumnsList + `)
                SELECT
                    ` + jsonExtractColumns + `,
                    ''` + country_1 + `'' AS WAWI_INSTANZ_KZL,
                    ''D'' AS DELETE_FG,
                    CURRENT_TIMESTAMP() AS EXTRACTION_TMSP,
                    SCN
                FROM (
                      SELECT *,
                        ROW_NUMBER() OVER (
                            PARTITION BY ${groupByColumnsList}
                            ORDER BY curr_ts DESC
                        ) AS rn
                      FROM
                        ` + database_name + `.etl.ingestion_table
                      WHERE tablename = ''` + WAWI_SCHEMA + `.` + source_table_name + `''
                      AND scn >= ` + max_scn + `
                ) AS ordered_ops
                WHERE rn = 1 AND op_type = ''D'';
            `;
                console.log(insertSQL_INGESTION_TABLE); // Log the SQL statement
                snowflake.execute({sqlText: insertSQL_INGESTION_TABLE});

            } else {
                var insertSQL = `
                    INSERT INTO LDL_WAWI_PRODUCTION.` + SF_CONSOL_SCHEMA + `.` + target_table_name + ` (` + allColumnsList + `)
                    SELECT
                        ` + selectColumnsList + `,
                        ''` + country_1 + `'' AS WAWI_INSTANZ_KZL,
                        NULL AS DELETE_FG,
                        CURRENT_TIMESTAMP() AS EXTRACTION_TMSP
                    FROM
                        ` + database_name + `.` + WAWI_SCHEMA + `.` + source_table_name + `
                    WHERE scn >= ` + max_scn + `;
                `;
                console.log(insertSQL); // Log the SQL statement
                snowflake.execute({sqlText: insertSQL});

                var jsonExtractColumns = commonColumns
                .filter(col => ![''WAWI_INSTANZ_KZL'', ''DELETE_FG'', ''EXTRACTION_TMSP'', ''SCN'', ''scn''].includes(col))
                .map(col => `JSON_EXTRACT_PATH_TEXT(json, ''${col}'') AS ${col}`)
                .concat(missingColumns.map(col => ''NULL AS '' + col))
                .join('', '');

                var filteredAllColumnsList = allColumnsList
                .split('', '')
                .filter(col => ![''SCN'', ''scn''].includes(col))
                .concat([''SCN''])
                .join('', '');

                // Construct jsonExtractColumns for the primary key columns
                var jsonExtractColumns_pk = primary_KeyColumns
                .filter(col => ![''wawi_instanz_kzl''].includes(col))
                .map(col => `JSON_EXTRACT_PATH_TEXT(json, ''${col}'') AS ${col}`)
                .join('', '');

                // Construct groupByColumnsList for the GROUP BY clause
                var groupByColumnsList = primary_KeyColumns
                .filter(col => ![''wawi_instanz_kzl''].includes(col))
                .map(col => `JSON_EXTRACT_PATH_TEXT(json, ''${col.toUpperCase()}'')`)
                .concat([''SCN''])
                .join('', '');


                var insertSQL_INGESTION_TABLE = `
                INSERT INTO LDL_WAWI_PRODUCTION.` + SF_CONSOL_SCHEMA + `.` + target_table_name + ` (` + filteredAllColumnsList + `)
                SELECT
                    ` + jsonExtractColumns + `,
                    ''` + country_1 + `'' AS WAWI_INSTANZ_KZL,
                    ''D'' AS DELETE_FG,
                    CURRENT_TIMESTAMP() AS EXTRACTION_TMSP,
                    SCN
                FROM (
                      SELECT *,
                        ROW_NUMBER() OVER (
                            PARTITION BY ${groupByColumnsList}
                            ORDER BY curr_ts DESC
                        ) AS rn
                      FROM
                        ` + database_name + `.etl.ingestion_table
                      WHERE tablename = ''` + WAWI_SCHEMA + `.` + source_table_name + `''
                      AND scn >= ` + max_scn + `
                ) AS ordered_ops
                WHERE rn = 1 AND op_type = ''D'';
            `;
                console.log(insertSQL_INGESTION_TABLE); // Log the SQL statement
                snowflake.execute({sqlText: insertSQL_INGESTION_TABLE});
            }
        }

        // Commit the transaction
        snowflake.createStatement({sqlText: ''COMMIT''}).execute();

        return ''Data consolidation completed successfully for all countries and warehouses.'';
    } catch (err) {
        // Rollback the transaction in case of an error
        snowflake.createStatement({sqlText: ''ROLLBACK''}).execute();
        throw err;
    }
';