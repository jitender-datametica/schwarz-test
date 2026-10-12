CREATE OR REPLACE PROCEDURE LDL_WAWI_PRODUCTION.EVAL.CALCULATE_CHECKSUMS_VAT()
RETURNS VARCHAR
LANGUAGE JAVASCRIPT
EXECUTE AS CALLER
AS '
{
    try {
        // Fixed database, schema, tables, and SCN
        const database = ''COMP_SH_WAWI_HQRS001_DEV'';
        const schema = ''WAWIADM'';
        const tables = [''T228_PURCHASE_VAT_2'']; // List of tables
        const scn = 5663004820008; // SCN value

        // Function to get column names for a table
        function getColumnNames(database, schema, table) {
            const columnQuery = `
                SELECT COLUMN_NAME, DATA_TYPE
                FROM ${database}.INFORMATION_SCHEMA.COLUMNS
                WHERE TABLE_SCHEMA = ''${schema}''
                  AND TABLE_NAME = ''${table}''
                  AND COLUMN_NAME <> ''SCN''
                ORDER BY ORDINAL_POSITION
            `;
            const columnResults = snowflake.execute({ sqlText: columnQuery });

            const columns = [];
            while (columnResults.next()) {
                columns.push({
                    name: columnResults.getColumnValue(1),
                    type: columnResults.getColumnValue(2)
                });
            }

            if (columns.length === 0) {
                throw `No columns found for table ${schema}.${table}. Ensure the table exists and has columns.`;
            }

            return columns;
        }

        // Initialize results array
        let results = ''Table Name | Checksum | Row Count\\n'';
        results += ''-----------------------------------\\n'';

        // Loop through each table and calculate checksum
        for (const table of tables) {
            // Get column names and types for the table
            const columns = getColumnNames(database, schema, table);

            // Build the column concatenation logic for checksum calculation
            const columnConcat = columns.map(col => {
                if (col.type === ''NUMBER'') {
                    return `NVL(TRIM(CAST(${col.name} AS STRING)), '''')`;
                } else if (col.type === ''TIMESTAMP_NTZ'' || col.type === ''TIMESTAMP_TZ'' || col.type === ''TIMESTAMP_LTZ'') {
                    return `NVL(TRIM(TO_CHAR(${col.name}, ''YYYY-MM_2-DD HH24:MI:SS'')), '''')`;
                } else {
                    return `NVL(TRIM(${col.name}), '''')`;
                }
            }).join(" || ''|'' || ");

            // Build the checksum query
            const checksumQuery = `
                SELECT
                    COALESCE(SUM(TO_NUMBER(SUBSTR(MD5(${columnConcat}), 1, 22), ''XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'')), 0) AS SF_CHECKSUM,
                    COUNT(1) AS SF_ROWCOUNT
                FROM ${database}.${schema}.${table}
                WHERE SCN <= ${scn}
            `;

            // Execute the checksum query
            const checksumResults = snowflake.execute({ sqlText: checksumQuery });

            // Fetch the results
            if (checksumResults.next()) {
                const checksum = checksumResults.getColumnValue(''SF_CHECKSUM'');
                const rowCount = checksumResults.getColumnValue(''SF_ROWCOUNT'');

                // Append the result to the output
                results += `${schema}.${table} | ${checksum} | ${rowCount}\\n`;
            } else {
                results += `${schema}.${table} | NULL | 0\\n`;
            }
        }

        // Return the results as a string
        return results;
    } catch (err) {
        throw `Error in calculate_checksums procedure: ${err}`;
    }
}
';