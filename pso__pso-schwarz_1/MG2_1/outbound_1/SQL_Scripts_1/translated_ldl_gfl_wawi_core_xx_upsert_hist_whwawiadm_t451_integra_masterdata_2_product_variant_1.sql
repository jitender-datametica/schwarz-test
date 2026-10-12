INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (
  prod_variant_nr,
  gtin,
  prod_nr,
  prod_key_type_cd,
  prod_variant_key_type_cd,
  prod_variant_name,
  prod_variant_type_cd,
  weight_based_fg,
  logistic_variant_type_cd,
  case_size_cnt,
  sales_variant_type_cd,
  sales_variant_content_meas,
  unit_cnt,
  unit_content_meas,
  content_uom_cd,
  non_food_variant_type_cd,
  size_name,
  style_name,
  kind_name,
  fruits_and_vegetables_class_cd,
  min_caliber_meas,
  max_caliber_meas,
  caliber_uom_cd,
  country_of_origin_nr,
  country_of_origin_key_type_cd,
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
WITH t026 AS (
  SELECT
    * /* ------------------------------- */
  FROM ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.t026_wawi_item_1
  WHERE
    t026_wawi_item.delete_fg IS NULL
  QUALIFY
    row_number() OVER (
      PARTITION BY t026_wawi_item.itemno
      ORDER BY IF(t026_wawi_item.seqid IS NULL, 0, 1), t026_wawi_item.seqid DESC
    ) = 1
), t451 AS (
  SELECT
    *
  FROM ${ldl_wawi_common_snflk_cl_db_name}.${src_input_table} AS src
  WHERE
    src.delete_fg IS NULL
    AND NOT CAST(src.c451_itemnr AS NUMERIC) IN (
      SELECT
        CAST(itemno AS NUMERIC)
      FROM t026
      WHERE
        NOT itemgrshortdesc BETWEEN CAST('10' AS NUMERIC) AND CAST('13' AS NUMERIC)
    )
  QUALIFY
    row_number() OVER (
      PARTITION BY left(src.wawi_instanz_kzl, 2), src.c451_itemnr, src.c451_subitemnr
      ORDER BY IF(src.extraction_tmsp IS NULL, 0, 1), src.extraction_tmsp DESC
    ) = 1
)
SELECT
  subselect.prod_variant_nr,
  subselect.gtin,
  subselect.prod_nr,
  subselect.prod_key_type_cd,
  subselect.prod_variant_key_type_cd,
  subselect.prod_variant_name,
  subselect.prod_variant_type_cd,
  subselect.weight_based_fg,
  subselect.logistic_variant_type_cd,
  subselect.case_size_cnt,
  subselect.sales_variant_type_cd,
  subselect.sales_variant_content_meas,
  subselect.unit_cnt,
  subselect.unit_content_meas,
  subselect.content_uom_cd,
  subselect.non_food_variant_type_cd,
  subselect.size_name,
  subselect.style_name,
  subselect.kind_name,
  subselect.fruits_and_vegetables_class_cd,
  subselect.min_caliber_meas,
  subselect.max_caliber_meas,
  subselect.caliber_uom_cd,
  subselect.country_of_origin_nr,
  subselect.country_of_origin_key_type_cd,
  'FV' AS source_system, /* ------------------------------- */
  subselect.extraction_tmsp AS extraction_dt,
  current_timestamp() AS dwh_mapping_tmsp,
  0 AS tf_error_fg,
  0 AS deleted_fg,
  0 AS record_id,
  '${SRC_INPUT_TABLE}' AS filename,
  'WAWI_WH' AS dwh_node_cd,
  '${LOAD_ID}' AS dwh_load_id
/* FV_SLS Data */
FROM (
  SELECT
    'FV_SLS' AS prod_variant_key_type_cd,
    CONCAT(CAST(itm.itemnr AS STRING), '|', substr(CAST(itm.subitemnr AS STRING), 1, 16777216)) AS prod_variant_nr,
    'FV' AS prod_key_type_cd,
    itm.itemnr AS prod_nr,
    NULL AS gtin,
    coalesce(eks.itemdesc, waw.deutschtext, 'Unbekannt') AS prod_variant_name,
    'SALES_1' AS prod_variant_type_cd,
    itmo.weight_based_fg,
    NULL AS logistic_variant_type_cd,
    NULL AS case_size_cnt,
    'FV' AS sales_variant_type_cd,
    CASE
      WHEN coalesce(pt1.c271_int_short /* pack_type_eks */, pt2.c271_int_short) = /* pack_type_wawi */ 'LOSE'
      THEN NULL
      ELSE eks.volume * eks.bundlefact
    END AS sales_variant_content_meas,
    CASE
      WHEN coalesce(pt1.c271_int_short /* pack_type_eks */, pt2.c271_int_short) = /* pack_type_wawi */ 'LOSE'
      THEN NULL
      ELSE eks.bundlefact
    END AS unit_cnt,
    CASE
      WHEN coalesce(pt1.c271_int_short /* pack_type_eks */, pt2.c271_int_short) = /* pack_type_wawi */ 'LOSE'
      THEN NULL
      ELSE eks.volume
    END AS unit_content_meas,
    CASE
      WHEN coalesce(pt1.c271_int_short /* pack_type_eks */, pt2.c271_int_short) = /* pack_type_wawi */ 'LOSE'
      AND itmo.weight_based_fg = (
        1 <> 0
      )
      THEN NULL
      WHEN coalesce(pt1.c271_int_short /* pack_type_eks */, pt2.c271_int_short) = /* pack_type_wawi */ 'LOSE'
      AND itmo.weight_based_fg = (
        0 <> 0
      )
      THEN 'PIECE'
      ELSE unf.c277_intunit
    END AS content_uom_cd,
    NULL AS non_food_variant_type_cd, /* unit_int_desc */ /* Consolidation needed Stück/Piece/Kus */
    NULL AS size_name,
    NULL AS style_name,
    NULL AS kind_name,
    nullif(itm.c451_class, '-') AS fruits_and_vegetables_class_cd,
    itm.c451_caliber_min AS min_caliber_meas,
    itm.c451_caliber_max AS max_caliber_meas,
    nullif(itm.c451_caliber_unit, '-') AS caliber_uom_cd,
    itm.extraction_tmsp,
    CASE
      WHEN itm.c451_origin = '-'
      THEN NULL
      ELSE replace(replace(replace(itm.c451_origin, '. ', ' '), '.', ''), ' ', '')
    END AS country_of_origin_nr,
    'CTRY' AS country_of_origin_key_type_cd
  FROM (
    SELECT
      CAST(t451.c451_itemnr AS NUMERIC) AS itemnr,
      CAST(t451.c451_subitemnr AS NUMERIC) AS subitemnr,
      t451.c451_class,
      t451.c451_caliber_min,
      t451.c451_caliber_max,
      t451.c451_caliber_unit,
      t451.c451_origin,
      t451.extraction_tmsp
    FROM t451
    QUALIFY
      row_number() OVER (
        PARTITION BY itemnr, subitemnr
        ORDER BY IF(
          CASE
            WHEN t451.wawi_instanz_kzl = 'DE'
            THEN 1
            WHEN NOT t451.wawi_instanz_kzl IN ('BG', 'CY', 'GR')
            THEN 2
            WHEN t451.wawi_instanz_kzl = 'GR'
            THEN 3
            WHEN t451.wawi_instanz_kzl IN ('BG', 'CY')
            THEN 4
          END IS NULL,
          0,
          1
        ) DESC, CASE
          WHEN t451.wawi_instanz_kzl = 'DE'
          THEN 1
          WHEN NOT t451.wawi_instanz_kzl IN ('BG', 'CY', 'GR')
          THEN 2
          WHEN t451.wawi_instanz_kzl = 'GR'
          THEN 3
          WHEN t451.wawi_instanz_kzl IN ('BG', 'CY')
          THEN 4
        END, IF(t451.wawi_instanz_kzl IS NULL, 0, 1) DESC, t451.wawi_instanz_kzl, IF(t451.wh_nr IS NULL, 0, 1) DESC, t451.wh_nr
      ) = 1
  ) AS itm
  LEFT OUTER JOIN t026 AS eks
    ON itm.itemnr = eks.itemno
  LEFT OUTER JOIN ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.t271_packagetype_1 AS pt1
    ON eks.wawi_instanz_kzl = pt1.wawi_instanz_kzl
    AND pt1.delete_fg IS NULL
    AND eks.packageid = pt1.c271_packnr
  LEFT OUTER JOIN (
    SELECT
      t277_unitfactors.c277_eks_link,
      t277_unitfactors.c277_intunit,
      substr(TRIM(t277_unitfactors.wawi_instanz_kzl, ' '), 1, 2) AS wawi_instanz_kzl
    FROM ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.t277_unitfactors_1
    WHERE
      NOT t277_unitfactors.c277_eks_link IS NULL
      AND NOT t277_unitfactors.c277_intunit IS NULL
      AND t277_unitfactors.delete_fg IS NULL
    QUALIFY
      row_number() OVER (
        PARTITION BY c277_eks_link
        ORDER BY IF(
          CASE
            WHEN wawi_instanz_kzl = 'DE'
            THEN 1
            WHEN NOT wawi_instanz_kzl IN ('BG', 'CY', 'GR')
            THEN 2
            WHEN wawi_instanz_kzl = 'GR'
            THEN 3
            WHEN wawi_instanz_kzl IN ('BG', 'CY')
            THEN 4
          END IS NULL,
          0,
          1
        ) DESC, CASE
          WHEN wawi_instanz_kzl = 'DE'
          THEN 1
          WHEN NOT wawi_instanz_kzl IN ('BG', 'CY', 'GR')
          THEN 2
          WHEN wawi_instanz_kzl = 'GR'
          THEN 3
          WHEN wawi_instanz_kzl IN ('BG', 'CY')
          THEN 4
        END, IF(wawi_instanz_kzl IS NULL, 0, 1) DESC, wawi_instanz_kzl
      ) = 1
  ) AS unf
    ON eks.wawi_instanz_kzl = unf.wawi_instanz_kzl AND eks.unitid = unf.c277_eks_link
  LEFT OUTER JOIN (
    SELECT
      a.*,
      CAST(a.artnrvier AS NUMERIC) AS itemnr
    FROM ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.artikel_1 AS a
    WHERE
      a.delete_fg IS NULL
    QUALIFY
      row_number() OVER (
        PARTITION BY itemnr
        ORDER BY IF(
          CASE
            WHEN a.wawi_instanz_kzl = 'DE'
            THEN 1
            WHEN NOT a.wawi_instanz_kzl IN ('BG', 'CY', 'GR')
            THEN 2
            WHEN a.wawi_instanz_kzl = 'GR'
            THEN 3
            WHEN a.wawi_instanz_kzl IN ('BG', 'CY')
            THEN 4
          END IS NULL,
          0,
          1
        ) DESC, CASE
          WHEN a.wawi_instanz_kzl = 'DE'
          THEN 1
          WHEN NOT a.wawi_instanz_kzl IN ('BG', 'CY', 'GR')
          THEN 2
          WHEN a.wawi_instanz_kzl = 'GR'
          THEN 3
          WHEN a.wawi_instanz_kzl IN ('BG', 'CY')
          THEN 4
        END, IF(a.wawi_instanz_kzl IS NULL, 0, 1) DESC, a.wawi_instanz_kzl, IF(a.artikelnr IS NULL, 0, 1) DESC, a.artikelnr
      ) = 1
  ) AS waw
    ON itm.itemnr = waw.itemnr
  LEFT OUTER JOIN ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.t271_packagetype_1 AS pt2
    ON waw.wawi_instanz_kzl = pt2.wawi_instanz_kzl
    AND waw.packung = pt2.c271_packdescript
    AND pt2.delete_fg IS NULL
  LEFT OUTER JOIN (
    SELECT
      artikelbestell.wawi_instanz_kzl,
      round(
        CAST(substr(artikelbestell.artikelnr, 1, CAST(length(artikelbestell.artikelnr) - 4 AS INT64)) AS NUMERIC),
        0
      ) AS itemnr,
      logical_or(
        CASE
          WHEN artikelbestell.gewichtsartikel = 1
          THEN TRUE
          ELSE artikelbestell.gewichtsartikel
        END
      ) AS weight_based_fg
    FROM ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.artikelbestell_1
    WHERE
      artikelbestell.delete_fg IS NULL
    /* where wawi_instanz_kzl ilike 'PL' and Cast(Substring(artikelnr, 1, Length(artikelnr)-4) AS Number) =  1579 --Gewichtsflag */
    GROUP BY
      1,
      2
  ) AS itmo
    ON waw.wawi_instanz_kzl = itmo.wawi_instanz_kzl AND waw.itemnr = itmo.itemnr
  UNION ALL
  SELECT
    'FV_SLS_UNK' AS prod_variant_key_type_cd, /* FV_SLS_UNK Data */
    substr(CAST(itm.itemnr AS STRING), 1, 16777216) AS prod_variant_nr,
    'FV' AS prod_key_type_cd,
    itm.itemnr AS prod_nr,
    NULL AS gtin,
    coalesce(eks.itemdesc, waw.deutschtext, 'Unbekannt') AS prod_variant_name,
    'SALES_1' AS prod_variant_type_cd,
    itmo.weight_based_fg,
    NULL AS logistic_variant_type_cd,
    NULL AS case_size_cnt,
    'FV' AS sales_variant_type_cd,
    CASE
      WHEN coalesce(pt1.c271_int_short /* pack_type_eks */, pt2.c271_int_short) = /* pack_type_wawi */ 'LOSE'
      THEN NULL
      ELSE eks.volume * eks.bundlefact
    END AS sales_variant_content_meas,
    CASE
      WHEN coalesce(pt1.c271_int_short /* pack_type_eks */, pt2.c271_int_short) = /* pack_type_wawi */ 'LOSE'
      THEN NULL
      ELSE eks.bundlefact
    END AS unit_cnt,
    CASE
      WHEN coalesce(pt1.c271_int_short /* pack_type_eks */, pt2.c271_int_short) = /* pack_type_wawi */ 'LOSE'
      THEN NULL
      ELSE eks.volume
    END AS unit_content_meas,
    CASE
      WHEN coalesce(pt1.c271_int_short /* pack_type_eks */, pt2.c271_int_short) = /* pack_type_wawi */ 'LOSE'
      AND itmo.weight_based_fg = (
        1 <> 0
      )
      THEN NULL
      WHEN coalesce(pt1.c271_int_short /* pack_type_eks */, pt2.c271_int_short) = /* pack_type_wawi */ 'LOSE'
      AND itmo.weight_based_fg = (
        0 <> 0
      )
      THEN 'PIECE'
      ELSE unf.c277_intunit
    END AS content_uom_cd,
    NULL AS non_food_variant_type_cd, /* unit_int_desc */ /* Consolidation needed Stück/Piece/Kus */
    NULL AS size_name,
    NULL AS style_name,
    NULL AS kind_name,
    NULL AS fruits_and_vegetables_class_cd,
    NULL AS min_caliber_meas,
    NULL AS max_caliber_meas,
    NULL AS caliber_uom_cd,
    itm.extraction_tmsp,
    NULL AS country_of_origin_nr,
    NULL AS country_of_origin_key_type_cd
  FROM (
    SELECT
      subselect_0.itemnr,
      MIN(subselect_0.extraction_tmsp) AS extraction_tmsp
    FROM (
      SELECT
        CAST(t451.c451_itemnr AS NUMERIC) AS itemnr,
        t451.c451_subitemnr,
        MIN(t451.extraction_tmsp) AS extraction_tmsp
      FROM t451
      GROUP BY
        1,
        2
    ) AS subselect_0
    GROUP BY
      1
    HAVING
      count(*) > 1
    UNION ALL
    SELECT
      t026.itemno AS itemnr,
      t026.extraction_tmsp
    FROM t026
    WHERE
      t026.itemgrshortdesc BETWEEN CAST('10' AS NUMERIC) AND CAST('13' AS NUMERIC)
      AND NOT t026.itemno IN (
        SELECT DISTINCT
          CAST(c451_itemnr AS NUMERIC) AS itemnr
        FROM t451
      )
  ) AS itm
  LEFT OUTER JOIN t026 AS eks
    ON itm.itemnr = eks.itemno
  LEFT OUTER JOIN ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.t271_packagetype_1 AS pt1
    ON eks.wawi_instanz_kzl = pt1.wawi_instanz_kzl
    AND eks.packageid = pt1.c271_packnr
    AND pt1.delete_fg IS NULL
  LEFT OUTER JOIN (
    SELECT
      t277_unitfactors.c277_eks_link,
      t277_unitfactors.c277_intunit,
      substr(TRIM(t277_unitfactors.wawi_instanz_kzl, ' '), 1, 2) AS wawi_instanz_kzl
    FROM ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.t277_unitfactors_1
    WHERE
      NOT t277_unitfactors.c277_eks_link IS NULL
      AND NOT t277_unitfactors.c277_intunit IS NULL
      AND t277_unitfactors.delete_fg IS NULL
    QUALIFY
      row_number() OVER (
        PARTITION BY c277_eks_link
        ORDER BY IF(
          CASE
            WHEN wawi_instanz_kzl = 'DE'
            THEN 1
            WHEN NOT wawi_instanz_kzl IN ('BG', 'CY', 'GR')
            THEN 2
            WHEN wawi_instanz_kzl = 'GR'
            THEN 3
            WHEN wawi_instanz_kzl IN ('BG', 'CY')
            THEN 4
          END IS NULL,
          0,
          1
        ) DESC, CASE
          WHEN wawi_instanz_kzl = 'DE'
          THEN 1
          WHEN NOT wawi_instanz_kzl IN ('BG', 'CY', 'GR')
          THEN 2
          WHEN wawi_instanz_kzl = 'GR'
          THEN 3
          WHEN wawi_instanz_kzl IN ('BG', 'CY')
          THEN 4
        END, IF(wawi_instanz_kzl IS NULL, 0, 1) DESC, wawi_instanz_kzl
      ) = 1
  ) AS unf
    ON eks.wawi_instanz_kzl = unf.wawi_instanz_kzl AND eks.unitid = unf.c277_eks_link
  LEFT OUTER JOIN (
    SELECT
      a.*,
      CAST(a.artnrvier AS NUMERIC) AS itemnr
    FROM ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.artikel_1 AS a
    WHERE
      a.delete_fg IS NULL
    QUALIFY
      row_number() OVER (
        PARTITION BY itemnr
        ORDER BY IF(
          CASE
            WHEN wawi_instanz_kzl = 'DE'
            THEN 1
            WHEN NOT wawi_instanz_kzl IN ('BG', 'CY', 'GR')
            THEN 2
            WHEN wawi_instanz_kzl = 'GR'
            THEN 3
            WHEN wawi_instanz_kzl IN ('BG', 'CY')
            THEN 4
          END IS NULL,
          0,
          1
        ) DESC, CASE
          WHEN wawi_instanz_kzl = 'DE'
          THEN 1
          WHEN NOT wawi_instanz_kzl IN ('BG', 'CY', 'GR')
          THEN 2
          WHEN wawi_instanz_kzl = 'GR'
          THEN 3
          WHEN wawi_instanz_kzl IN ('BG', 'CY')
          THEN 4
        END, IF(wawi_instanz_kzl IS NULL, 0, 1) DESC, wawi_instanz_kzl, IF(artikelnr IS NULL, 0, 1) DESC, artikelnr
      ) = 1
  ) AS waw
    ON itm.itemnr = waw.itemnr
  LEFT OUTER JOIN ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.t271_packagetype_1 AS pt2
    ON waw.wawi_instanz_kzl = pt2.wawi_instanz_kzl
    AND pt2.delete_fg IS NULL
    AND waw.packung = pt2.c271_packdescript
  LEFT OUTER JOIN (
    SELECT
      artikelbestell.wawi_instanz_kzl,
      round(
        CAST(substr(artikelbestell.artikelnr, 1, CAST(length(artikelbestell.artikelnr) - 4 AS INT64)) AS NUMERIC),
        0
      ) AS itemnr,
      logical_or(
        CASE
          WHEN artikelbestell.gewichtsartikel = 1
          THEN TRUE
          ELSE artikelbestell.gewichtsartikel
        END
      ) AS weight_based_fg
    FROM ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.artikelbestell_1
    WHERE
      artikelbestell.delete_fg IS NULL
    /* where wawi_instanz_kzl ilike 'PL' and Cast(Substring(artikelnr, 1, Length(artikelnr)-4) AS Number) =  1579 --Gewichtsflag */
    GROUP BY
      1,
      2
  ) AS itmo
    ON waw.wawi_instanz_kzl = itmo.wawi_instanz_kzl AND waw.itemnr = itmo.itemnr
  UNION ALL
  SELECT
    'FV_LOG' AS prod_variant_key_type_cd, /* FV_LOG Data */
    CONCAT(CAST(itm.itemnr AS STRING), '|', substr(CAST(itm.subitemnr AS STRING), 1, 16777216)) AS prod_variant_nr,
    'FV' AS prod_key_type_cd,
    itm.itemnr AS prod_nr,
    NULL AS gtin,
    coalesce(eks.itemdesc, waw.deutschtext, 'Unbekannt') AS prod_variant_name,
    'LOGISTIC' AS prod_variant_type_cd,
    FALSE AS weight_based_fg,
    'SINGLE' AS logistic_variant_type_cd,
    NULL AS case_size_cnt,
    NULL AS sales_variant_type_cd,
    NULL AS sales_variant_content_meas,
    NULL AS unit_cnt,
    NULL AS unit_content_meas,
    NULL AS content_uom_cd,
    NULL AS non_food_variant_type_cd,
    NULL AS size_name,
    NULL AS style_name,
    NULL AS kind_name,
    NULL AS fruits_and_vegetables_class_cd,
    NULL AS min_caliber_meas,
    NULL AS max_caliber_meas,
    NULL AS caliber_uom_cd,
    itm.extraction_tmsp,
    NULL AS country_of_origin_nr,
    NULL AS country_of_origin_key_type_cd
  FROM (
    SELECT
      CAST(t451.c451_itemnr AS NUMERIC) AS itemnr,
      CAST(t451.c451_subitemnr AS NUMERIC) AS subitemnr,
      t451.extraction_tmsp
    FROM t451
    QUALIFY
      row_number() OVER (
        PARTITION BY itemnr, subitemnr
        ORDER BY IF(
          CASE
            WHEN t451.wawi_instanz_kzl = 'DE'
            THEN 1
            WHEN NOT t451.wawi_instanz_kzl IN ('BG', 'CY', 'GR')
            THEN 2
            WHEN t451.wawi_instanz_kzl = 'GR'
            THEN 3
            WHEN t451.wawi_instanz_kzl IN ('BG', 'CY')
            THEN 4
          END IS NULL,
          0,
          1
        ) DESC, CASE
          WHEN t451.wawi_instanz_kzl = 'DE'
          THEN 1
          WHEN NOT t451.wawi_instanz_kzl IN ('BG', 'CY', 'GR')
          THEN 2
          WHEN t451.wawi_instanz_kzl = 'GR'
          THEN 3
          WHEN t451.wawi_instanz_kzl IN ('BG', 'CY')
          THEN 4
        END, IF(t451.wawi_instanz_kzl IS NULL, 0, 1) DESC, t451.wawi_instanz_kzl, IF(t451.wh_nr IS NULL, 0, 1) DESC, t451.wh_nr
      ) = 1
  ) AS itm
  LEFT OUTER JOIN t026 AS eks
    ON itm.itemnr = eks.itemno
  LEFT OUTER JOIN (
    SELECT
      a.*,
      CAST(a.artnrvier AS NUMERIC) AS itemnr
    FROM ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.artikel_1 AS a
    WHERE
      a.delete_fg IS NULL
    QUALIFY
      row_number() OVER (
        PARTITION BY itemnr
        ORDER BY IF(
          CASE
            WHEN wawi_instanz_kzl = 'DE'
            THEN 1
            WHEN NOT wawi_instanz_kzl IN ('BG', 'CY', 'GR')
            THEN 2
            WHEN wawi_instanz_kzl = 'GR'
            THEN 3
            WHEN wawi_instanz_kzl IN ('BG', 'CY')
            THEN 4
          END IS NULL,
          0,
          1
        ) DESC, CASE
          WHEN wawi_instanz_kzl = 'DE'
          THEN 1
          WHEN NOT wawi_instanz_kzl IN ('BG', 'CY', 'GR')
          THEN 2
          WHEN wawi_instanz_kzl = 'GR'
          THEN 3
          WHEN wawi_instanz_kzl IN ('BG', 'CY')
          THEN 4
        END, IF(wawi_instanz_kzl IS NULL, 0, 1) DESC, wawi_instanz_kzl, IF(artikelnr IS NULL, 0, 1) DESC, artikelnr
      ) = 1
  ) AS waw
    ON itm.itemnr = waw.itemnr
  UNION ALL
  SELECT
    'FV_LOG_UNK' AS prod_variant_key_type_cd, /* FV_LOG_UNK Data */
    substr(CAST(itm.itemnr AS STRING), 1, 16777216) AS prod_variant_nr,
    'FV' AS prod_key_type_cd,
    itm.itemnr AS prod_nr,
    NULL AS gtin,
    coalesce(eks.itemdesc, waw.deutschtext, 'Unbekannt') AS prod_variant_name,
    'LOGISTIC' AS prod_variant_type_cd,
    NULL AS weight_based_fg,
    'SINGLE' AS logistic_variant_type_cd,
    1 AS case_size_cnt,
    NULL AS sales_variant_type_cd,
    NULL AS sales_variant_content_meas,
    NULL AS unit_cnt,
    NULL AS unit_content_meas,
    NULL AS content_uom_cd,
    NULL AS non_food_variant_type_cd,
    NULL AS size_name,
    NULL AS style_name,
    NULL AS kind_name,
    NULL AS fruits_and_vegetables_class_cd,
    NULL AS min_caliber_meas,
    NULL AS max_caliber_meas,
    NULL AS caliber_uom_cd,
    itm.extraction_tmsp,
    NULL AS country_of_origin_nr,
    NULL AS country_of_origin_key_type_cd
  FROM (
    SELECT
      subselect_0.itemnr,
      MIN(subselect_0.extraction_tmsp) AS extraction_tmsp
    FROM (
      SELECT
        CAST(t451.c451_itemnr AS NUMERIC) AS itemnr,
        t451.c451_subitemnr,
        MIN(t451.extraction_tmsp) AS extraction_tmsp
      FROM t451
      GROUP BY
        1,
        2
    ) AS subselect_0
    GROUP BY
      1
    HAVING
      count(*) > 1
    UNION ALL
    SELECT
      t026.itemno AS itemnr,
      t026.extraction_tmsp
    FROM t026
    WHERE
      t026.itemgrshortdesc BETWEEN CAST('10' AS NUMERIC) AND CAST('13' AS NUMERIC)
      AND NOT t026.itemno IN (
        SELECT DISTINCT
          CAST(c451_itemnr AS NUMERIC) AS itemnr
        FROM t451
      )
  ) AS itm
  LEFT OUTER JOIN t026 AS eks
    ON itm.itemnr = eks.itemno
  LEFT OUTER JOIN (
    SELECT
      a.*,
      CAST(a.artnrvier AS NUMERIC) AS itemnr
    FROM ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.artikel_1 AS a
    WHERE
      a.delete_fg IS NULL
    QUALIFY
      row_number() OVER (
        PARTITION BY itemnr
        ORDER BY IF(
          CASE
            WHEN wawi_instanz_kzl = 'DE'
            THEN 1
            WHEN NOT wawi_instanz_kzl IN ('BG', 'CY', 'GR')
            THEN 2
            WHEN wawi_instanz_kzl = 'GR'
            THEN 3
            WHEN wawi_instanz_kzl IN ('BG', 'CY')
            THEN 4
          END IS NULL,
          0,
          1
        ) DESC, CASE
          WHEN wawi_instanz_kzl = 'DE'
          THEN 1
          WHEN NOT wawi_instanz_kzl IN ('BG', 'CY', 'GR')
          THEN 2
          WHEN wawi_instanz_kzl = 'GR'
          THEN 3
          WHEN wawi_instanz_kzl IN ('BG', 'CY')
          THEN 4
        END, IF(wawi_instanz_kzl IS NULL, 0, 1) DESC, wawi_instanz_kzl, IF(artikelnr IS NULL, 0, 1) DESC, artikelnr
      ) = 1
  ) AS waw
    ON itm.itemnr = waw.itemnr
) AS subselect;