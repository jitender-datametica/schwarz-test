CREATE OR REPLACE PROCEDURE LDL_WAWI_PRODUCTION.EVAL.COMPARE_SCHEMAS_WITH_KEYS("SCHEMA1" VARCHAR, "DATABASE1" VARCHAR, "SCHEMA2" VARCHAR, "DATABASE2" VARCHAR, "TABLE_NAME" VARCHAR, "KEYSARRAY" VARCHAR)
RETURNS VARCHAR
LANGUAGE JAVASCRIPT
EXECUTE AS CALLER
AS '
{

         // Assign parameter values to local variables for simplicity
        var schema1 = ''WAWIADM'';
        var database1 = ''COMP_SH_WAWI_HQRS001_DEV'';
        var schema2 = ''WAWIADM'';
        var database2 = ''SH_WAWI_RSHQ001'';
        var table_name = ''ARTEANCODES_2'';
        var keysArray = ''ARTIKELNR, EANCODE'';

    try {
        // Debug Step 1: Parse keysArray into an array
        var keys = keysArray.split('','').map(key => key.trim());
        if (keys.length === 0) {
            throw "Primary keys array is empty. Please provide valid keys.";
        }
        var debugStep1 = `Parsed keysArray: ${JSON.stringify(keys)}`;

        // Debug Step 2: Build the ON condition for the JOIN
        var onCondition = keys.map(key => `t1.${key} = t2.${key}`).join(" AND ");
        var debugStep2 = `ON condition:\\n${onCondition}`;

        // Debug Step 3: Get the column list from the table
        var columnQuery = `
            SELECT COLUMN_NAME
            FROM ${database1}.INFORMATION_SCHEMA.COLUMNS
            WHERE TABLE_SCHEMA = ?
            AND TABLE_NAME = ?
        `;
        var columnResults = snowflake.execute({
            sqlText: columnQuery,
            binds: [schema1, table_name]
        });

        var columns = [];
        while (columnResults.next()) {
            columns.push(columnResults.getColumnValue(0)); // Index fixed to 0
        }
        if (columns.length === 0) {
            throw `No columns found for table ${table_name} in schema ${schema1}.`;
        }
        var debugStep3 = `Columns found: ${JSON.stringify(columns)}`;

        // Debug Step 4: Build comparison conditions for all columns
        var compareConditions = columns.map(col =>
            `(t1.${col} <> t2.${col} OR t1.${col} IS NULL OR t2.${col} IS NULL)`
        ).join(" OR ");
        var debugStep4 = `Comparison conditions:\\n${compareConditions}`;

        // Debug Step 5: Build select clause for all columns
        var selectClause = keys.map((key, index) =>
            `COALESCE(t1.${key}, t2.${key}) AS key${index + 1}`
        ).join(",\\n            ");
        selectClause += ",\\n            " + columns.map(col =>
            `t1.${col} AS ${col}_schema1, t2.${col} AS ${col}_schema2`
        ).join(",\\n            ");
        var debugStep5 = `SELECT clause:\\n${selectClause}`;

        // Debug Step 6: Define the comparison query
        var comparisonQuery = `
            SELECT
                ${selectClause}
            FROM ${database1}.${schema1}.${table_name} AS t1_2
            FULL OUTER JOIN ${database2}.${schema2}.${table_name} AS t2
            ON ${onCondition}
            WHERE ${compareConditions}
        `;
        var debugStep6 = `Comparison Query:\\n${comparisonQuery}`;

        // Execute comparison and collect results
        var comparisonResults = snowflake.execute({ sqlText: comparisonQuery });

        // Debug Step 7: Check result set column count and names
        var columnNames = [];
        for (var i = 0; i < comparisonResults.getColumnCount(); i++) {
            columnNames.push(comparisonResults.getColumnName(i));
        }
        var debugStep7 = `Result set columns:\\n${JSON.stringify(columnNames)}`;
        if (comparisonResults.getColumnCount() === 0) {
            return `No differences found for table ${table_name}.`;
        }

        // Collect and format unmatched data
        var unmatchedData = [];
        do {
            var row = {};
            for (var i = 0; i < comparisonResults.getColumnCount(); i++) {
                row[columnNames[i]] = comparisonResults.getColumnValue(i);
            }
            unmatchedData.push(row);
        } while (comparisonResults.next());

        // Return debugging steps for analysis (Remove in production)
        return JSON.stringify({
            Step1: debugStep1,
            Step2: debugStep2,
            Step3: debugStep3,
            Step4: debugStep4,
            Step5: debugStep5,
            Step6: debugStep6,
            Step7: debugStep7,
            UnmatchedData: unmatchedData
        });

    } catch (err) {
        throw `Error in compare_schemas_with_keys procedure: ${err}`;
    }
}
';