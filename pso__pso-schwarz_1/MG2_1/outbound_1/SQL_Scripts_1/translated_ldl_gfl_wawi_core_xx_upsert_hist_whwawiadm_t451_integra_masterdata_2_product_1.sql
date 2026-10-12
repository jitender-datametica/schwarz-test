
-- FRAMEWORK AND TECHNICAL COLUMNS


-- /* TEMPORARY/not is mapping */WHERE PROD_NAME IS NOT NULL


INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_node_cd, tf_error_fg, dwh_load_id,
 source_system, extraction_dt, prod_nr, deleted_fg, record_id, dwh_mapping_tmsp, filename, prod_key_type_cd,
 packing_type_cd, prod_type_cd, goods_on_consignment_fg, prod_descr, prod_name, prod_creation_dt, item_type_cd,
 country_specific_prod_fg, excl_from_vat_calc_fg)
WITH t451 AS (SELECT *
   FROM ${ldl_wawi_common_snflk_cl_db_name}.${src_input_table} AS src
   WHERE delete_fg IS NULL
    AND ROUND(CAST(c451_itemnr AS BIGNUMERIC), 0) NOT IN (SELECT CAST(itemno AS BIGNUMERIC) AS A99158023
      FROM (SELECT *
        FROM hqwawiadm.t026_wawi_item_1
        WHERE delete_fg IS NULL
        QUALIFY (ROW_NUMBER() OVER (PARTITION BY itemno ORDER BY seqid IS NULL DESC, seqid DESC)) = 1) AS t0
      WHERE NOT CAST(itemgrshortdesc AS INTEGER) BETWEEN 10 AND 13)
   QUALIFY (ROW_NUMBER() OVER (PARTITION BY LEFT(wawi_instanz_kzl, 2), c451_itemnr, c451_subitemnr ORDER BY
         extraction_tmsp IS NULL DESC, extraction_tmsp DESC)) = 1) (SELECT 'WAWI_HQ' AS dwh_node_cd,
    0 AS tf_error_fg,
    '${LOAD_ID}' AS dwh_load_id,
    'WAWI' AS source_system,
    CURRENT_DATE AS extraction_dt,
    CAST(t18.itemnr AS STRING) AS prod_nr,
    CAST(0 AS BOOL) AS deleted_fg,
    CAST(0 AS STRING) AS record_id,
    CAST(t18.extraction_tmsp AS TIMESTAMP) AS dwh_mapping_tmsp,
    '${t_SRC_INPUT_TABLE}' AS filename,
    'FV' AS prod_key_type_cd,
    COALESCE(pt1.c271_int_short, pt2.c271_int_short) AS packing_type_cd,
    'ITEM_1' AS prod_type_cd,
    FALSE AS goods_on_consignment_fg,
    COALESCE(eks.itemdesc, waw.deutschtext, 'Unbekannt') AS prod_descr,
    COALESCE(eks.itemdesc, waw.deutschtext, 'Unbekannt') AS prod_name,
    CAST(waw.min_valid_from AS DATE) AS prod_creation_dt,
    'FV' AS item_type_cd,
    FALSE AS country_specific_prod_fg,
    FALSE AS excl_from_vat_calc_fg
   FROM (SELECT itemnr,
      MIN(extraction_tmsp) AS extraction_tmsp
     FROM (SELECT ROUND(CAST(c451_itemnr AS BIGNUMERIC), 0) AS itemnr,
         extraction_tmsp
        FROM t451
        UNION ALL
        SELECT itemno,
         extraction_tmsp
        FROM (SELECT itemno,
           extraction_tmsp,
           itemgrshortdesc
          FROM hqwawiadm.t026_wawi_item_1
          WHERE delete_fg IS NULL
          QUALIFY (ROW_NUMBER() OVER (PARTITION BY itemno ORDER BY seqid IS NULL DESC, seqid DESC)) = 1) AS t13
        WHERE CAST(itemgrshortdesc AS INTEGER) BETWEEN 10 AND 13) AS t16
     GROUP BY itemnr) AS t18
    LEFT JOIN (SELECT seqid,
      delete_fg,
      itemno,
      itemdesc,
      extraction_tmsp,
      packageid,
      wawi_instanz_kzl,
      insertdate,
      itemgrshortdesc,
      bitflag
     FROM hqwawiadm.t026_wawi_item_1
     WHERE delete_fg IS NULL
     QUALIFY (ROW_NUMBER() OVER (PARTITION BY itemno ORDER BY seqid IS NULL DESC, seqid DESC)) = 1) AS eks ON t18.itemnr
      = eks.itemno
    LEFT JOIN hqwawiadm.t271_packagetype_1 AS pt1 ON eks.wawi_instanz_kzl = pt1.wawi_instanz_kzl AND eks.packageid = pt1.c271_packnr
        AND pt1.delete_fg IS NULL
    LEFT JOIN (SELECT extraction_tmsp,
      gueltig_ab,
      artikelnr,
      wawi_instanz_kzl,
      inhalt_karton,
      delete_fg,
      artnrvier,
      bez_lang,
      deutschtext,
      packung,
      artgrupnr,
      unit_id,
      ROUND(CAST(artnrvier AS BIGNUMERIC), 0) AS itemnr,
      MIN(gueltig_ab) OVER (PARTITION BY CAST(ROUND(ROUND(CAST(artnrvier AS BIGNUMERIC), 0), 0) AS STRING) RANGE BETWEEN
       UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS min_valid_from
     FROM hqwawiadm.artikel_1 AS a
     WHERE delete_fg IS NULL
     QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(itemnr AS STRING) ORDER BY CASE
            WHEN wawi_instanz_kzl = 'DE'
            THEN 1
            WHEN wawi_instanz_kzl NOT IN ('BG', 'CY', 'GR')
            THEN 2
            WHEN wawi_instanz_kzl = 'GR'
            THEN 3
            WHEN wawi_instanz_kzl IN ('BG', 'CY')
            THEN 4
            ELSE NULL
            END IS NULL, CASE
            WHEN wawi_instanz_kzl = 'DE'
            THEN 1
            WHEN wawi_instanz_kzl NOT IN ('BG', 'CY', 'GR')
            THEN 2
            WHEN wawi_instanz_kzl = 'GR'
            THEN 3
            WHEN wawi_instanz_kzl IN ('BG', 'CY')
            THEN 4
            ELSE NULL
            END, wawi_instanz_kzl IS NULL, wawi_instanz_kzl, artikelnr IS NULL, artikelnr)) = 1) AS waw ON t18.itemnr =
     waw.itemnr
    LEFT JOIN hqwawiadm.t271_packagetype_1 AS pt2 ON waw.wawi_instanz_kzl = pt2.wawi_instanz_kzl AND waw.packung = pt2.c271_packdescript
        AND pt2.delete_fg IS NULL);