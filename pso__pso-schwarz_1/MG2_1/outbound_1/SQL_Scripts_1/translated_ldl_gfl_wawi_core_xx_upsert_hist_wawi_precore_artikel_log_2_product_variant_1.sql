INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (
  prod_nat_key_nr,
  prod_key_type_cd,
  prod_variant_key_type_cd,
  prod_variant_nat_key_nr,
  prod_variant_nr,
  gtin,
  prod_variant_name,
  prod_variant_type_cd,
  weight_based_fg,
  logistic_variant_type_cd,
  case_size_cnt,
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
  CONCAT(art.ctrcode, '|', LTRIM(CAST(art.itemnr AS STRING), '0')) AS prod_nat_key_nr,
  'WAWI' AS prod_key_type_cd,
  'WAW_LOG' AS prod_variant_key_type_cd,
  CONCAT(art.ctrcode, '|', substr(CAST(art.itemnr AS STRING), 1, 16777216)) AS prod_variant_nat_key_nr,
  CONCAT(art.ctrcode, '|', substr(CAST(art.itemnr AS STRING), 1, 16777216)) AS prod_variant_nr,
  NULL AS gtin,
  art.deutschtext AS prod_variant_name,
  'LOGISTIC' AS prod_variant_type_cd,
  CASE WHEN coalesce(art.gewichtsartikel, 0) = 1 THEN TRUE ELSE FALSE END AS weight_based_fg,
  NULL AS logistic_variant_type_cd,
  NULL AS case_size_cnt,
  'WAWI' AS source_system,
  art.extraction_tmsp AS extraction_dt,
  art.extraction_tmsp AS dwh_mapping_tmsp,
  0 AS tf_error_fg,
  0 AS deleted_fg,
  0 AS record_id,
  't_${SRC_INPUT_TABLE}' AS filename,
  'WAWI_HQ' AS dwh_node_cd,
  '${LOAD_ID}' AS dwh_load_id
FROM (
  SELECT
    art_0.ctrcode,
    art_0.itemnr,
    art_0.case_size,
    art_0.extraction_tmsp,
    art_0.deutschtext,
    itmo.gewichtsartikel, /* WEIGHT_BASED_FG -- */
    art_0.artgrupnr
  FROM (
    SELECT
      *,
      CAST(t_wawi_precore_artikel.artnrvier AS NUMERIC) AS itemnr,
      round(CAST(right(t_wawi_precore_artikel.artikelnr, 4) AS NUMERIC), 0) AS case_size
    FROM ${temp_db}.t_wawi_precore_artikel_1
  ) AS art_0
  LEFT OUTER JOIN (
    SELECT DISTINCT
      t_wawi_precore_t215_int_itemnr.ctrcode,
      round(
        CAST(substr(
          t_wawi_precore_t215_int_itemnr.c215_itemnr,
          1,
          CAST(length(t_wawi_precore_t215_int_itemnr.c215_itemnr) - 4 AS INT64)
        ) AS NUMERIC),
        0
      ) AS itemnr,
      CAST(t_wawi_precore_t215_int_itemnr.c215_int_itemnr AS NUMERIC) AS c215_int_itemnr
    FROM ${temp_db}.t_wawi_precore_t215_int_itemnr_1
  ) AS ii
    ON art_0.ctrcode = ii.ctrcode AND art_0.itemnr = ii.itemnr
  LEFT OUTER JOIN meta.t_product_key_1 AS ipk
    ON substr(CAST(ii.c215_int_itemnr AS STRING), 1, 16777216) = ipk.prod_nat_key_nr
    AND ipk.prod_key_type_cd IN ('CBX', 'FV')
    AND ipk.dwh_valid_fg
  LEFT OUTER JOIN (
    SELECT DISTINCT
      t_wawi_precore_eks_item_wawi_item.itemno
    FROM etl.t_wawi_precore_eks_item_wawi_item_1
  ) AS eks
    ON ii.c215_int_itemnr = eks.itemno
  LEFT OUTER JOIN ${temp_db}.t_wawi_precore_t271_packagetype_1 AS pt
    ON art_0.ctrcode = pt.ctrcode AND art_0.packung = pt.c271_packdescript
  INNER JOIN ${temp_db}.t_wawi_precore_artikelbestell_1 AS itmo
    ON art_0.ctrcode = itmo.ctrcode AND art_0.artikelnr = itmo.artikelnr
  INNER JOIN ${temp_db}.t_wawi_precore_t277_unitfactors_1 AS unit_1
    ON art_0.ctrcode = unit.ctrcode AND art_0.unit_id = unit.c277_id
  WHERE
    ii.itemnr IS NULL
    OR /* NO LINK TO INTERNATIONAL ITEM_1 NUMBER */ ipk.prod_sid IS NULL
    AND /* INTERNATIONAL NUMBER NOT FOUND IN INTERNATIONAL KEYS */ eks.itemno IS NULL
  QUALIFY
    row_number() OVER (PARTITION BY art_0.ctrcode, art_0.itemnr ORDER BY art_0.case_size DESC) = 1
) AS art_1;