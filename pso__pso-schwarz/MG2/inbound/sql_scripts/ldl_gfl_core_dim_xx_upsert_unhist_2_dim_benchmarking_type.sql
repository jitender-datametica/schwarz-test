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

CREATE OR REPLACE TEMPORARY TABLE ETL.T_DIM_BENCHMARKING_TYPE LIKE CORE_DIM.T_DIM_BENCHMARKING_TYPE;

INSERT INTO
      ETL.T_DIM_BENCHMARKING_TYPE
    ( benchmarking_type_id
    , benchmarking_type_descr
    , benchmarking_type_descr_de
    , benchmarking_type_descr_en
    , dwh_created_tmsp
    , dwh_updated_tmsp
    , dwh_load_id
    , dwh_node_cd
    )
SELECT
      src.benchmarking_type_id
    , src.benchmarking_type_descr
    , src.benchmarking_type_descr_de
    , src.benchmarking_type_descr_en
    , CURRENT_TIMESTAMP AS dwh_created_tmsp
    , CURRENT_TIMESTAMP AS dwh_updated_tmsp
    , ${LOAD_ID}        AS dwh_load_id
    , 'MANUAL'          AS dwh_node_cd
FROM
    ( SELECT
            1::NUMBER(38,0) AS benchmarking_type_id
          , 'Standard'::VARCHAR(100) AS benchmarking_type_descr
          , 'Standard'::VARCHAR(100) AS benchmarking_type_descr_de
          , 'Standard'::VARCHAR(100) AS benchmarking_type_descr_en
      UNION ALL
      SELECT
            2::NUMBER(38,0)  AS benchmarking_type_id
          , 'Verkaufsleiter Ebene'::VARCHAR(100) AS benchmarking_type_descr
          , 'Verkaufsleiter Ebene'::VARCHAR(100) AS benchmarking_type_descr_de
          , 'Sales Manager Level'::VARCHAR(100)  AS benchmarking_type_descr_en
      UNION ALL
      SELECT
            3::NUMBER(38,0) AS benchmarking_type_id
          , 'Vertriebsleiter Ebene'::VARCHAR(100) AS benchmarking_type_descr
          , 'Vertriebsleiter Ebene'::VARCHAR(100) AS benchmarking_type_descr_de
          , 'Account Manager Level'::VARCHAR(100) AS benchmarking_type_descr_en
      UNION ALL
      SELECT
            4::NUMBER(38,0) AS benchmarking_type_id
          , 'Vertriebsgesellschaft Ebene'::VARCHAR(100) AS benchmarking_type_descr
          , 'Vertriebsgesellschaft Ebene'::VARCHAR(100) AS benchmarking_type_descr_de
          , 'Sales Company Level'::VARCHAR(100)         AS benchmarking_type_descr_en
      UNION ALL
      SELECT
            5::NUMBER(38,0) AS benchmarking_type_id
          , 'Region Ebene'::VARCHAR(100) AS benchmarking_type_descr
          , 'Region Ebene'::VARCHAR(100) AS benchmarking_type_descr_de
          , 'Region Level'::VARCHAR(100) AS benchmarking_type_descr_en
      UNION ALL
      SELECT
            6::NUMBER(38,0) AS benchmarking_type_id
          , 'Land Ebene'::VARCHAR(100)    AS benchmarking_type_descr
          , 'Land Ebene'::VARCHAR(100)    AS benchmarking_type_descr_de
          , 'Country Level'::VARCHAR(100) AS benchmarking_type_descr_en
    ) AS src
;

--SELECT COUNT(*) FROM ETL.T_DIM_BENCHMARKING_TYPE;
--SELECT * FROM ETL.T_DIM_BENCHMARKING_TYPE LIMIT 100;

/*
##########################################################################
# STEP 2: Delete data from target                                        #
##########################################################################
*/

BEGIN TRANSACTION;

DELETE FROM
      CORE_DIM.T_DIM_BENCHMARKING_TYPE AS tgt
USING ETL.T_DIM_BENCHMARKING_TYPE AS src
WHERE src.benchmarking_type_id  = tgt.benchmarking_type_id
  AND NOT EXISTS
  -- Non Key columns will be checked for null values.
      ( SELECT 1
        FROM  ETL.T_DIM_BENCHMARKING_TYPE AS exi
        WHERE exi.benchmarking_type_id = tgt.benchmarking_type_id
          AND (   exi.benchmarking_type_descr = tgt.benchmarking_type_descr
                OR (exi.benchmarking_type_descr IS NULL AND tgt.benchmarking_type_descr IS NULL)
              )
          AND (   exi.benchmarking_type_descr_de = tgt.benchmarking_type_descr_de
                OR (exi.benchmarking_type_descr_de IS NULL AND tgt.benchmarking_type_descr_de IS NULL)
              )
          AND (   exi.benchmarking_type_descr_en = tgt.benchmarking_type_descr_en
                OR (exi.benchmarking_type_descr_en IS NULL AND tgt.benchmarking_type_descr_en IS NULL)
              )
      )
;

/*
##########################################################################
# STEP 3: Load target table                                              #
##########################################################################
*/

MERGE INTO
      CORE_DIM.T_DIM_BENCHMARKING_TYPE AS tgt
USING ETL.T_DIM_BENCHMARKING_TYPE AS src
  ON  tgt.benchmarking_type_id = src.benchmarking_type_id
WHEN NOT MATCHED THEN INSERT
    ( benchmarking_type_id
    , benchmarking_type_descr
    , benchmarking_type_descr_de
    , benchmarking_type_descr_en
    , dwh_created_tmsp
    , dwh_updated_tmsp
    , dwh_load_id
    , dwh_node_cd
    )
VALUES
    ( src.benchmarking_type_id
    , src.benchmarking_type_descr
    , src.benchmarking_type_descr_de
    , src.benchmarking_type_descr_en
    , src.dwh_created_tmsp
    , src.dwh_updated_tmsp
    , src.dwh_load_id
    , src.dwh_node_cd
    )
;

/*
##########################################################################
# END STEP: DONE                                                         #
##########################################################################
*/

COMMIT;
