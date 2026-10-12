INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (
  prod_type_cd,
  item_type_cd,
  prod_key_type_cd,
  prod_nr,
  prod_name,
  prod_descr,
  prod_creation_dt,
  packing_type_cd,
  goods_on_consignment_fg,
  excl_from_vat_calc_fg,
  country_specific_prod_fg,
  source_system,
  extraction_dt,
  dwh_mapping_tmsp,
  tf_error_fg,
  deleted_fg,
  record_id,
  filename,
  dwh_node_cd,
  dwh_load_id
)
SELECT
  'ITEM_1' AS prod_type_cd, /* FRAMEWORK AND TECHNICAL COLUMNS */
  'FV' AS item_type_cd,
  'FV' AS prod_key_type_cd,
  itemnr.itemnr AS prod_nr,
  coalesce(eks.itemdesc, waw.deutschtext, 'Unbekannt') AS prod_name,
  coalesce(eks.itemdesc, waw.deutschtext, 'Unbekannt') AS prod_descr,
  waw.min_valid_from AS prod_creation_dt,
  coalesce(pt1.c271_int_short, pt2.c271_int_short) AS packing_type_cd,
  FALSE AS goods_on_consignment_fg,
  FALSE AS excl_from_vat_calc_fg,
  FALSE AS country_specific_prod_fg,
  'WAWI' AS source_system,
  CURRENT_DATE AS extraction_dt,
  itemnr.extraction_tmsp AS dwh_mapping_tmsp,
  0 AS tf_error_fg,
  0 AS deleted_fg,
  0 AS record_id,
  't_${SRC_INPUT_TABLE}' AS filename,
  'WAWI_HQ' AS dwh_node_cd,
  '${LOAD_ID}' AS dwh_load_id
FROM (
  SELECT
    subselect.itemnr,
    MIN(subselect.extraction_tmsp) AS extraction_tmsp
  FROM (
    SELECT
      CAST(t_${src_input_table}.c451_itemnr AS NUMERIC) AS itemnr,
      t_${src_input_table}.extraction_tmsp
    FROM etl.t_${src_input_table}
    UNION ALL
    SELECT
      t_wawi_precore_t026_wawi_item.itemno AS itemnr,
      t_wawi_precore_t026_wawi_item.extraction_tmsp
    FROM etl.t_wawi_precore_t026_wawi_item_1
    WHERE
      t_wawi_precore_t026_wawi_item.itemgrshortdesc BETWEEN CAST('10' AS NUMERIC) AND CAST('13' AS NUMERIC)
  ) AS subselect
  GROUP BY
    1
) AS itemnr
LEFT OUTER JOIN etl.t_wawi_precore_t026_wawi_item_1 AS eks
  ON itemnr.itemnr = eks.itemno
LEFT OUTER JOIN etl.t_wawi_precore_t271_packagetype_1 AS pt1
  ON eks.ctrcode = pt1.ctrcode AND eks.packageid = pt1.c271_packnr
LEFT OUTER JOIN (
  SELECT
    a.*,
    CAST(a.artnrvier AS NUMERIC) AS itemnr,
    MIN(a.gueltig_ab) OVER (PARTITION BY CAST(a.artnrvier AS NUMERIC)) AS min_valid_from
  FROM etl.t_wawi_precore_artikel_1 AS a
  QUALIFY
    row_number() OVER (
      PARTITION BY itemnr
      ORDER BY IF(
        CASE
          WHEN a.ctrcode = 'DE'
          THEN 1
          WHEN NOT a.ctrcode IN ('BG', 'CY', 'GR')
          THEN 2
          WHEN a.ctrcode = 'GR'
          THEN 3
          WHEN a.ctrcode IN ('BG', 'CY')
          THEN 4
        END IS NULL,
        0,
        1
      ) DESC, CASE
        WHEN a.ctrcode = 'DE'
        THEN 1
        WHEN NOT a.ctrcode IN ('BG', 'CY', 'GR')
        THEN 2
        WHEN a.ctrcode = 'GR'
        THEN 3
        WHEN a.ctrcode IN ('BG', 'CY')
        THEN 4
      END, IF(a.ctrcode IS NULL, 0, 1) DESC, a.ctrcode, IF(a.artikelnr IS NULL, 0, 1) DESC, a.artikelnr
    ) = 1
) AS waw
  ON itemnr.itemnr = waw.itemnr
LEFT OUTER JOIN etl.t_wawi_precore_t271_packagetype_1 AS pt2
  ON waw.ctrcode = pt2.ctrcode AND waw.packung = pt2.c271_packdescript;

/* /* TEMPORARY/not is mapping * /WHERE PROD_NAME IS NOT NULL */;