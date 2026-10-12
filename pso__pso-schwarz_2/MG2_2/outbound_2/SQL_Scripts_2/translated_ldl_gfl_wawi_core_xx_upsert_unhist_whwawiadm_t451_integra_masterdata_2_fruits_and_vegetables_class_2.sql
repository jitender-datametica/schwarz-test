-- !SET exit_on_error=True;

-- Apply the changes as INSERTs or UPDATES ignoring any unchanged rows.


MERGE INTO ldl_data_production_core_rel.t_fruits_and_vegetables_class_2 AS target
USING (WITH t451 AS (SELECT *
    FROM (SELECT *
      FROM whwawiadm.t451_integra_masterdata_2 AS src
      WHERE delete_fg IS NULL
       AND ROUND(CAST(c451_itemnr AS BIGNUMERIC), 0) NOT IN (SELECT CAST(itemno AS BIGNUMERIC) AS A99158023
         FROM hqwawiadm.t026_wawi_item_2
         WHERE delete_fg IS NULL
          AND NOT CAST(itemgrshortdesc AS INTEGER) BETWEEN 10 AND 13)
      QUALIFY (ROW_NUMBER() OVER (PARTITION BY LEFT(wawi_instanz_kzl, 2), c451_itemnr, c451_subitemnr ORDER BY
            extraction_tmsp IS NULL DESC, extraction_tmsp DESC)) = 1) AS t2
    WHERE c451_class IS NOT NULL) (SELECT *
    FROM (SELECT *
       FROM (SELECT c451_class AS fruits_and_vegetables_class_cd,
           'DE' AS lang_cd,
            CASE
            WHEN c451_class = '-'
            THEN 'unbekannt'
            ELSE c451_class
            END AS fruits_and_vegetables_class_descr
          FROM t451
          GROUP BY fruits_and_vegetables_class_cd
          UNION DISTINCT
          SELECT c451_class AS fruits_and_vegetables_class_cd,
           'EN' AS lang_cd,
            CASE
            WHEN c451_class = '-'
            THEN 'unknown'
            ELSE c451_class
            END AS fruits_and_vegetables_class_descr
          FROM t451
          GROUP BY fruits_and_vegetables_class_cd)
       EXCEPT DISTINCT
       SELECT fruits_and_vegetables_class_cd,
        fruits_and_vegetables_class_descr,
        lang_cd
       FROM ldl_data_production_core_rel.t_fruits_and_vegetables_class_2))) AS source
ON target.fruits_and_vegetables_class_cd = source.fruits_and_vegetables_class_cd AND target.lang_cd = source.lang_cd
WHEN MATCHED THEN UPDATE SET
 fruits_and_vegetables_class_descr = source.fruits_and_vegetables_class_descr,
 dwh_updated_tmsp = CURRENT_TIMESTAMP(),
 dwh_load_id = CAST(${LOAD_ID} AS INTEGER),
 dwh_node_cd = 'INTERGRA'
WHEN NOT MATCHED THEN INSERT VALUES(source.fruits_and_vegetables_class_cd, source.lang_cd, source.fruits_and_vegetables_class_descr
 , CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP(), CAST(${LOAD_ID} AS INTEGER), 'INTEGRA');