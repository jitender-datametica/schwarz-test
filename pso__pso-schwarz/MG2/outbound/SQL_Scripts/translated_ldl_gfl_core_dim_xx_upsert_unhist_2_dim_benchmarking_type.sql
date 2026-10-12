/*
 ################################################################################
 --------------------------------------------------------------------------------
 Executing the Script for t_dim_benchmarking_type
 --------------------------------------------------------------------------------
 ################################################################################
 */
/*
 ##########################################################################
 # STEP 1: Create and load temporary table                                #
 ##########################################################################
 */
CREATE
OR REPLACE TEMPORARY TABLE t_dim_benchmarking_type;

INSERT INTO
    t_dim_benchmarking_type (
        benchmarking_type_id,
        benchmarking_type_descr,
        benchmarking_type_descr_de,
        benchmarking_type_descr_en,
        dwh_created_tmsp,
        dwh_updated_tmsp,
        dwh_load_id,
        dwh_node_cd
    )
SELECT
    src.benchmarking_type_id,
    src.benchmarking_type_descr,
    src.benchmarking_type_descr_de,
    src.benchmarking_type_descr_en,
    CURRENT_TIMESTAMP() AS dwh_created_tmsp,
    CURRENT_TIMESTAMP() AS dwh_updated_tmsp,
    ${load_id} AS dwh_load_id,
    'MANUAL' AS dwh_node_cd
FROM
    (
        SELECT
            ROUND(NUMERIC '1', 0) AS benchmarking_type_id,
            'Standard' AS benchmarking_type_descr,
            'Standard' AS benchmarking_type_descr_de,
            'Standard' AS benchmarking_type_descr_en
        UNION
        ALL
        SELECT
            ROUND(NUMERIC '2', 0) AS benchmarking_type_id,
            'Verkaufsleiter Ebene' AS benchmarking_type_descr,
            'Verkaufsleiter Ebene' AS benchmarking_type_descr_de,
            'Sales Manager Level' AS benchmarking_type_descr_en
        UNION
        ALL
        SELECT
            ROUND(NUMERIC '3', 0) AS benchmarking_type_id,
            'Vertriebsleiter Ebene' AS benchmarking_type_descr,
            'Vertriebsleiter Ebene' AS benchmarking_type_descr_de,
            'Account Manager Level' AS benchmarking_type_descr_en
        UNION
        ALL
        SELECT
            ROUND(NUMERIC '4', 0) AS benchmarking_type_id,
            'Vertriebsgesellschaft Ebene' AS benchmarking_type_descr,
            'Vertriebsgesellschaft Ebene' AS benchmarking_type_descr_de,
            'Sales Company Level' AS benchmarking_type_descr_en
        UNION
        ALL
        SELECT
            ROUND(NUMERIC '5', 0) AS benchmarking_type_id,
            'Region Ebene' AS benchmarking_type_descr,
            'Region Ebene' AS benchmarking_type_descr_de,
            'Region Level' AS benchmarking_type_descr_en
        UNION
        ALL
        SELECT
            ROUND(NUMERIC '6', 0) AS benchmarking_type_id,
            'Land Ebene' AS benchmarking_type_descr,
            'Land Ebene' AS benchmarking_type_descr_de,
            'Country Level' AS benchmarking_type_descr_en
    ) AS src;

-- SELECT COUNT(*) FROM etl.t_dim_benchmarking_type;
-- SELECT * FROM etl.t_dim_benchmarking_type LIMIT 100;
/*
 ##########################################################################
 # STEP 2: Delete data from target                                        #
 ##########################################################################
 */
BEGIN TRANSACTION;

DELETE FROM
    core_dim.t_dim_benchmarking_type AS tgt
WHERE
    NOT EXISTS (
        
            -- Non Key columns will be checked for null values.
        SELECT 1
        FROM
            t_dim_benchmarking_type AS exi
        WHERE
            exi.benchmarking_type_id = tgt.benchmarking_type_id
            AND (
                exi.benchmarking_type_descr = tgt.benchmarking_type_descr
                OR (exi.benchmarking_type_descr IS NULL AND tgt.benchmarking_type_descr IS NULL)
                )
            AND (exi.benchmarking_type_descr_de = tgt.benchmarking_type_descr_de
                OR (exi.benchmarking_type_descr_de IS NULL AND tgt.benchmarking_type_descr_de IS NULL)
                )
            AND (exi.benchmarking_type_descr_en = tgt.benchmarking_type_descr_en
                OR (exi.benchmarking_type_descr_en IS NULL AND tgt.benchmarking_type_descr_en IS NULL)
                )
    )
    AND EXISTS (SELECT 1
                FROM t_dim_benchmarking_type AS src
                WHERE src.benchmarking_type_id = tgt.benchmarking_type_id
    );

/*
 ##########################################################################
 # STEP 3: Load target table                                              #
 ##########################################################################
 */
MERGE INTO core_dim.t_dim_benchmarking_type AS tgt 
USING t_dim_benchmarking_type AS src 
ON tgt.benchmarking_type_id = src.benchmarking_type_id
WHEN NOT MATCHED BY TARGET THEN
INSERT
    (
        benchmarking_type_id,
        benchmarking_type_descr,
        benchmarking_type_descr_de,
        benchmarking_type_descr_en,
        dwh_created_tmsp,
        dwh_updated_tmsp,
        dwh_load_id,
        dwh_node_cd
    )
VALUES
    (
        src.benchmarking_type_id,
        src.benchmarking_type_descr,
        src.benchmarking_type_descr_de,
        src.benchmarking_type_descr_en,
        src.dwh_created_tmsp,
        src.dwh_updated_tmsp,
        src.dwh_load_id,
        src.dwh_node_cd
    );

/*
 ##########################################################################
 # END STEP: DONE                                                         #
 ##########################################################################
 */
COMMIT TRANSACTION;