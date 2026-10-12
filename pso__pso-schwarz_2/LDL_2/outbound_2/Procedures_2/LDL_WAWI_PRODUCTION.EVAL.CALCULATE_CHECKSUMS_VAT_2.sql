CREATE OR REPLACE PROCEDURE eval.calculate_checksums_vat(OUT out_param STRING)
BEGIN
    BEGIN
        -- Fixed database, schema, tables, and SCN
        DECLARE database STRING DEFAULT 'comp_sh_wawi_hqrs001_dev';
        DECLARE schema STRING DEFAULT 'wawiadm';
        DECLARE tables ARRAY<STRING> DEFAULT ['t228_purchase_vat_2'];
        DECLARE scn INT64 DEFAULT 5663004820008;

        -- Function to get column names for a table
        
        -- Initialize results array
        DECLARE results ARRAY<STRING> DEFAULT [];
        SET results = ARRAY_CONCAT(results, ['Table Name | Checksum | Row Count\n']);
        SET results = ARRAY_CONCAT(results, ['-----------------------------------\n']);

        -- Loop through each table and calculate checksum
        FOR table_record IN (SELECT table_name FROM UNNEST(tables) AS table_name)
        DO
            BEGIN
                DECLARE column_query STRUCT<sql STRING>;
                DECLARE res ARRAY<JSON>;
                DECLARE iterator_res INT64 DEFAULT 0;
                DECLARE current_col JSON;
                DECLARE col_name STRING;
                DECLARE col_type STRING;

                DECLARE columnconcat STRING DEFAULT '';
                DECLARE checksumquery STRING;
                DECLARE checksum INT64;
                DECLARE rowcount INT64;

                -- Get column names and types for the table
                SET column_query = STRUCT(FORMAT(
        'SELECT column_name, data_type FROM `%s.INFORMATION_SCHEMA.COLUMNS` WHERE table_name = "%s" AND column_name <> "scn" ORDER BY ordinal_position', 
        schema,table_record.table_name
    ) AS sql);

                EXECUTE IMMEDIATE FORMAT("""
                SELECT ARRAY_AGG(JSON_ARRAY(%s))
                FROM (%s)
                """, 'column_name, data_type', column_query.sql)
                INTO res USING schema AS schema_param, table_record.table_name AS table_param;

                IF ARRAY_LENGTH(res) = 0 OR res IS NULL THEN
                    RAISE USING MESSAGE = CONCAT('No columns found for table ', schema, '.', table_record.table_name, '. Ensure the table exists and has columns.');
                END IF;

                -- Build the column concatenation logic for checksum calculation
                WHILE (iterator_res < ARRAY_LENGTH(res)) DO
                    SET current_col = res[OFFSET(iterator_res)];
                    SET col_name = STRING(current_col[0]);
                    SET col_type = STRING(current_col[1]);

                    IF iterator_res > 0 THEN
                        SET columnconcat = CONCAT(columnconcat, ' || "|" || ');
                    END IF;

                    IF col_type IN ('INT64', 'NUMERIC', 'BIGNUMERIC', 'FLOAT64', 'INT', 'SMALLINT', 'BIGINT') THEN
                        SET columnconcat = CONCAT(columnconcat, 'IFNULL(TRIM(CAST(', col_name, ' AS STRING)), "")');
                    ELSEIF col_type IN ('TIMESTAMP', 'DATETIME') THEN
                        SET columnconcat = CONCAT(columnconcat, 'IFNULL(TRIM(CAST(FORMAT_TIMESTAMP("%Y-%m-%d %H:%M:%S", ', col_name, ') AS STRING)), "")');
                    ELSE
                        SET columnconcat = CONCAT(columnconcat, 'IFNULL(TRIM(CAST(', col_name, ' AS STRING)), "")');
                    END IF;

                    SET iterator_res = iterator_res + 1;
                END WHILE;

                -- Build the checksum query
                SET checksumquery = CONCAT(
                    'SELECT COALESCE(SUM(CAST(CONCAT("0x", SUBSTR(TO_HEX(MD5(', columnconcat, ')), 1, 15)) AS INT64)), 0) AS sf_checksum, ',
                    'COUNT(1) AS sf_rowcount ',
                    'FROM ', schema, '.', table_record.table_name, ' ',
                    'WHERE scn <= @scn'
                );

                -- Execute the checksum query
                -- Fetch the results
                EXECUTE IMMEDIATE checksumquery INTO checksum, rowcount USING scn AS scn;

                -- Append the result to the output
                IF checksum IS NOT NULL THEN
                    SET results = ARRAY_CONCAT(results, [CONCAT(schema, '.', table_record.table_name, ' | ', CAST(checksum AS STRING), ' | ', CAST(rowcount AS STRING), '\n')]);
                ELSE
                    SET results = ARRAY_CONCAT(results, [CONCAT(schema, '.', table_record.table_name, ' | NULL | 0\n')]);
                END IF;
            END;
        END FOR;

        -- Return the results as a string
        SET out_param = ARRAY_TO_STRING(results, '');

    EXCEPTION WHEN ERROR THEN
        RAISE USING MESSAGE = CONCAT('Error in calculate_checksums procedure: ', @@error.message);
    END;
END;