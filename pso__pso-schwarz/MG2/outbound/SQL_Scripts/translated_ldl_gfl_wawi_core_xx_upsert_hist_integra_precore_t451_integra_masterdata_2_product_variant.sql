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
SELECT
  subselect.prod_variant_nr, /* ------------------------------- */
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
  't_${SRC_INPUT_TABLE}' AS filename,
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
    'SALES' AS prod_variant_type_cd,
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
      CAST(t_integra_precore_t451_integra_masterdata.c451_itemnr AS NUMERIC) AS itemnr,
      CAST(t_integra_precore_t451_integra_masterdata.c451_subitemnr AS NUMERIC) AS subitemnr,
      t_integra_precore_t451_integra_masterdata.c451_class,
      t_integra_precore_t451_integra_masterdata.c451_caliber_min,
      t_integra_precore_t451_integra_masterdata.c451_caliber_max,
      t_integra_precore_t451_integra_masterdata.c451_caliber_unit,
      t_integra_precore_t451_integra_masterdata.c451_origin,
      t_integra_precore_t451_integra_masterdata.extraction_tmsp
    FROM etl.t_integra_precore_t451_integra_masterdata
    QUALIFY
      row_number() OVER (
        PARTITION BY itemnr, subitemnr
        ORDER BY IF(
          CASE
            WHEN t_integra_precore_t451_integra_masterdata.ctrcode = 'DE'
            THEN 1
            WHEN NOT t_integra_precore_t451_integra_masterdata.ctrcode IN ('BG', 'CY', 'GR')
            THEN 2
            WHEN t_integra_precore_t451_integra_masterdata.ctrcode = 'GR'
            THEN 3
            WHEN t_integra_precore_t451_integra_masterdata.ctrcode IN ('BG', 'CY')
            THEN 4
          END IS NULL,
          0,
          1
        ) DESC, CASE
          WHEN t_integra_precore_t451_integra_masterdata.ctrcode = 'DE'
          THEN 1
          WHEN NOT t_integra_precore_t451_integra_masterdata.ctrcode IN ('BG', 'CY', 'GR')
          THEN 2
          WHEN t_integra_precore_t451_integra_masterdata.ctrcode = 'GR'
          THEN 3
          WHEN t_integra_precore_t451_integra_masterdata.ctrcode IN ('BG', 'CY')
          THEN 4
        END, IF(t_integra_precore_t451_integra_masterdata.ctrcode IS NULL, 0, 1) DESC, t_integra_precore_t451_integra_masterdata.ctrcode, IF(t_integra_precore_t451_integra_masterdata.wh_nr IS NULL, 0, 1) DESC, t_integra_precore_t451_integra_masterdata.wh_nr
      ) = 1
  ) AS itm
  LEFT OUTER JOIN etl.t_wawi_precore_t026_wawi_item AS eks
    ON itm.itemnr = eks.itemno
  LEFT OUTER JOIN etl.t_wawi_precore_t271_packagetype AS pt1
    ON eks.ctrcode = pt1.ctrcode AND eks.packageid = pt1.c271_packnr
  LEFT OUTER JOIN (
    SELECT
      t_wawi_precore_t277_unitfactors.c277_eks_link,
      t_wawi_precore_t277_unitfactors.c277_intunit,
      substr(TRIM(t_wawi_precore_t277_unitfactors.ctrcode, ' '), 1, 2) AS ctrcode
    FROM etl.t_wawi_precore_t277_unitfactors
    WHERE
      NOT t_wawi_precore_t277_unitfactors.c277_eks_link IS NULL
      AND NOT t_wawi_precore_t277_unitfactors.c277_intunit IS NULL
    QUALIFY
      row_number() OVER (
        PARTITION BY c277_eks_link
        ORDER BY IF(
          CASE
            WHEN ctrcode = 'DE'
            THEN 1
            WHEN NOT ctrcode IN ('BG', 'CY', 'GR')
            THEN 2
            WHEN ctrcode = 'GR'
            THEN 3
            WHEN ctrcode IN ('BG', 'CY')
            THEN 4
          END IS NULL,
          0,
          1
        ) DESC, CASE
          WHEN ctrcode = 'DE'
          THEN 1
          WHEN NOT ctrcode IN ('BG', 'CY', 'GR')
          THEN 2
          WHEN ctrcode = 'GR'
          THEN 3
          WHEN ctrcode IN ('BG', 'CY')
          THEN 4
        END, IF(ctrcode IS NULL, 0, 1) DESC, ctrcode
      ) = 1
  ) AS unf
    ON eks.ctrcode = unf.ctrcode AND eks.unitid = unf.c277_eks_link
  LEFT OUTER JOIN (
    SELECT
      a.*,
      CAST(a.artnrvier AS NUMERIC) AS itemnr
    FROM etl.t_wawi_precore_artikel AS a
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
    ON itm.itemnr = waw.itemnr
  LEFT OUTER JOIN etl.t_wawi_precore_t271_packagetype AS pt2
    ON waw.ctrcode = pt2.ctrcode AND waw.packung = pt2.c271_packdescript
  LEFT OUTER JOIN (
    SELECT
      t_wawi_precore_artikelbestell.ctrcode,
      round(
        CAST(substr(
          t_wawi_precore_artikelbestell.artikelnr,
          1,
          CAST(length(t_wawi_precore_artikelbestell.artikelnr) - 4 AS INT64)
        ) AS NUMERIC),
        0
      ) AS itemnr,
      logical_or(
        CASE
          WHEN t_wawi_precore_artikelbestell.gewichtsartikel = 1
          THEN TRUE
          ELSE t_wawi_precore_artikelbestell.gewichtsartikel
        END
      ) AS weight_based_fg
    FROM etl.t_wawi_precore_artikelbestell
    /* where ctrcode ilike 'PL' and Cast(Substring(artikelnr, 1, Length(artikelnr)-4) AS Number) =  1579 --Gewichtsflag */
    GROUP BY
      1,
      2
  ) AS itmo
    ON waw.ctrcode = itmo.ctrcode AND waw.itemnr = itmo.itemnr
  UNION ALL
  SELECT
    'FV_SLS_UNK' AS prod_variant_key_type_cd, /* FV_SLS_UNK Data */
    substr(CAST(itm.itemnr AS STRING), 1, 16777216) AS prod_variant_nr,
    'FV' AS prod_key_type_cd,
    itm.itemnr AS prod_nr,
    NULL AS gtin,
    coalesce(eks.itemdesc, waw.deutschtext, 'Unbekannt') AS prod_variant_name,
    'SALES' AS prod_variant_type_cd,
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
        CAST(t_integra_precore_t451_integra_masterdata.c451_itemnr AS NUMERIC) AS itemnr,
        t_integra_precore_t451_integra_masterdata.c451_subitemnr,
        MIN(t_integra_precore_t451_integra_masterdata.extraction_tmsp) AS extraction_tmsp
      FROM etl.t_integra_precore_t451_integra_masterdata
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
      t_wawi_precore_t026_wawi_item.itemno AS itemnr,
      t_wawi_precore_t026_wawi_item.extraction_tmsp
    FROM etl.t_wawi_precore_t026_wawi_item
    WHERE
      t_wawi_precore_t026_wawi_item.itemgrshortdesc BETWEEN CAST('10' AS NUMERIC) AND CAST('13' AS NUMERIC)
      AND NOT t_wawi_precore_t026_wawi_item.itemno IN (
        SELECT DISTINCT
          CAST(c451_itemnr AS NUMERIC) AS itemnr
        FROM etl.t_integra_precore_t451_integra_masterdata
      )
  ) AS itm
  LEFT OUTER JOIN etl.t_wawi_precore_t026_wawi_item AS eks
    ON itm.itemnr = eks.itemno
  LEFT OUTER JOIN etl.t_wawi_precore_t271_packagetype AS pt1
    ON eks.ctrcode = pt1.ctrcode AND eks.packageid = pt1.c271_packnr
  LEFT OUTER JOIN (
    SELECT
      t277_unitfactors.c277_eks_link,
      t277_unitfactors.c277_intunit,
      substr(TRIM(t277_unitfactors.ctrcode, ' '), 1, 2) AS ctrcode
    FROM etl.t277_unitfactors
    WHERE
      NOT t277_unitfactors.c277_eks_link IS NULL
      AND NOT t277_unitfactors.c277_intunit IS NULL
    QUALIFY
      row_number() OVER (
        PARTITION BY c277_eks_link
        ORDER BY IF(
          CASE
            WHEN ctrcode = 'DE'
            THEN 1
            WHEN NOT ctrcode IN ('BG', 'CY', 'GR')
            THEN 2
            WHEN ctrcode = 'GR'
            THEN 3
            WHEN ctrcode IN ('BG', 'CY')
            THEN 4
          END IS NULL,
          0,
          1
        ) DESC, CASE
          WHEN ctrcode = 'DE'
          THEN 1
          WHEN NOT ctrcode IN ('BG', 'CY', 'GR')
          THEN 2
          WHEN ctrcode = 'GR'
          THEN 3
          WHEN ctrcode IN ('BG', 'CY')
          THEN 4
        END, IF(ctrcode IS NULL, 0, 1) DESC, ctrcode
      ) = 1
  ) AS unf
    ON eks.ctrcode = unf.ctrcode AND eks.unitid = unf.c277_eks_link
  LEFT OUTER JOIN (
    SELECT
      a.*,
      CAST(a.artnrvier AS NUMERIC) AS itemnr
    FROM etl.t_wawi_precore_artikel AS a
    QUALIFY
      row_number() OVER (
        PARTITION BY itemnr
        ORDER BY IF(
          CASE
            WHEN ctrcode = 'DE'
            THEN 1
            WHEN NOT ctrcode IN ('BG', 'CY', 'GR')
            THEN 2
            WHEN ctrcode = 'GR'
            THEN 3
            WHEN ctrcode IN ('BG', 'CY')
            THEN 4
          END IS NULL,
          0,
          1
        ) DESC, CASE
          WHEN ctrcode = 'DE'
          THEN 1
          WHEN NOT ctrcode IN ('BG', 'CY', 'GR')
          THEN 2
          WHEN ctrcode = 'GR'
          THEN 3
          WHEN ctrcode IN ('BG', 'CY')
          THEN 4
        END, IF(ctrcode IS NULL, 0, 1) DESC, ctrcode, IF(artikelnr IS NULL, 0, 1) DESC, artikelnr
      ) = 1
  ) AS waw
    ON itm.itemnr = waw.itemnr
  LEFT OUTER JOIN etl.t_wawi_precore_t271_packagetype AS pt2
    ON waw.ctrcode = pt2.ctrcode AND waw.packung = pt2.c271_packdescript
  LEFT OUTER JOIN (
    SELECT
      t_wawi_precore_artikelbestell.ctrcode,
      round(
        CAST(substr(
          t_wawi_precore_artikelbestell.artikelnr,
          1,
          CAST(length(t_wawi_precore_artikelbestell.artikelnr) - 4 AS INT64)
        ) AS NUMERIC),
        0
      ) AS itemnr,
      logical_or(
        CASE
          WHEN t_wawi_precore_artikelbestell.gewichtsartikel = 1
          THEN TRUE
          ELSE t_wawi_precore_artikelbestell.gewichtsartikel
        END
      ) AS weight_based_fg
    FROM etl.t_wawi_precore_artikelbestell
    /* where ctrcode ilike 'PL' and Cast(Substring(artikelnr, 1, Length(artikelnr)-4) AS Number) =  1579 --Gewichtsflag */
    GROUP BY
      1,
      2
  ) AS itmo
    ON waw.ctrcode = itmo.ctrcode AND waw.itemnr = itmo.itemnr
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
      CAST(t_integra_precore_t451_integra_masterdata.c451_itemnr AS NUMERIC) AS itemnr,
      CAST(t_integra_precore_t451_integra_masterdata.c451_subitemnr AS NUMERIC) AS subitemnr,
      t_integra_precore_t451_integra_masterdata.extraction_tmsp
    FROM etl.t_integra_precore_t451_integra_masterdata
    QUALIFY
      row_number() OVER (
        PARTITION BY itemnr, subitemnr
        ORDER BY IF(
          CASE
            WHEN t_integra_precore_t451_integra_masterdata.ctrcode = 'DE'
            THEN 1
            WHEN NOT t_integra_precore_t451_integra_masterdata.ctrcode IN ('BG', 'CY', 'GR')
            THEN 2
            WHEN t_integra_precore_t451_integra_masterdata.ctrcode = 'GR'
            THEN 3
            WHEN t_integra_precore_t451_integra_masterdata.ctrcode IN ('BG', 'CY')
            THEN 4
          END IS NULL,
          0,
          1
        ) DESC, CASE
          WHEN t_integra_precore_t451_integra_masterdata.ctrcode = 'DE'
          THEN 1
          WHEN NOT t_integra_precore_t451_integra_masterdata.ctrcode IN ('BG', 'CY', 'GR')
          THEN 2
          WHEN t_integra_precore_t451_integra_masterdata.ctrcode = 'GR'
          THEN 3
          WHEN t_integra_precore_t451_integra_masterdata.ctrcode IN ('BG', 'CY')
          THEN 4
        END, IF(t_integra_precore_t451_integra_masterdata.ctrcode IS NULL, 0, 1) DESC, t_integra_precore_t451_integra_masterdata.ctrcode, IF(t_integra_precore_t451_integra_masterdata.wh_nr IS NULL, 0, 1) DESC, t_integra_precore_t451_integra_masterdata.wh_nr
      ) = 1
  ) AS itm
  LEFT OUTER JOIN etl.t_wawi_precore_t026_wawi_item AS eks
    ON itm.itemnr = eks.itemno
  LEFT OUTER JOIN (
    SELECT
      a.*,
      CAST(a.artnrvier AS NUMERIC) AS itemnr
    FROM etl.t_wawi_precore_artikel AS a
    QUALIFY
      row_number() OVER (
        PARTITION BY itemnr
        ORDER BY IF(
          CASE
            WHEN ctrcode = 'DE'
            THEN 1
            WHEN NOT ctrcode IN ('BG', 'CY', 'GR')
            THEN 2
            WHEN ctrcode = 'GR'
            THEN 3
            WHEN ctrcode IN ('BG', 'CY')
            THEN 4
          END IS NULL,
          0,
          1
        ) DESC, CASE
          WHEN ctrcode = 'DE'
          THEN 1
          WHEN NOT ctrcode IN ('BG', 'CY', 'GR')
          THEN 2
          WHEN ctrcode = 'GR'
          THEN 3
          WHEN ctrcode IN ('BG', 'CY')
          THEN 4
        END, IF(ctrcode IS NULL, 0, 1) DESC, ctrcode, IF(artikelnr IS NULL, 0, 1) DESC, artikelnr
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
        CAST(t_integra_precore_t451_integra_masterdata.c451_itemnr AS NUMERIC) AS itemnr,
        t_integra_precore_t451_integra_masterdata.c451_subitemnr,
        MIN(t_integra_precore_t451_integra_masterdata.extraction_tmsp) AS extraction_tmsp
      FROM etl.t_integra_precore_t451_integra_masterdata
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
      t_wawi_precore_t026_wawi_item.itemno AS itemnr,
      t_wawi_precore_t026_wawi_item.extraction_tmsp
    FROM etl.t_wawi_precore_t026_wawi_item
    WHERE
      t_wawi_precore_t026_wawi_item.itemgrshortdesc BETWEEN CAST('10' AS NUMERIC) AND CAST('13' AS NUMERIC)
      AND NOT t_wawi_precore_t026_wawi_item.itemno IN (
        SELECT DISTINCT
          CAST(c451_itemnr AS NUMERIC) AS itemnr
        FROM etl.t_integra_precore_t451_integra_masterdata
      )
  ) AS itm
  LEFT OUTER JOIN etl.t_wawi_precore_t026_wawi_item AS eks
    ON itm.itemnr = eks.itemno
  LEFT OUTER JOIN (
    SELECT
      a.*,
      CAST(a.artnrvier AS NUMERIC) AS itemnr
    FROM etl.t_wawi_precore_artikel AS a
    QUALIFY
      row_number() OVER (
        PARTITION BY itemnr
        ORDER BY IF(
          CASE
            WHEN ctrcode = 'DE'
            THEN 1
            WHEN NOT ctrcode IN ('BG', 'CY', 'GR')
            THEN 2
            WHEN ctrcode = 'GR'
            THEN 3
            WHEN ctrcode IN ('BG', 'CY')
            THEN 4
          END IS NULL,
          0,
          1
        ) DESC, CASE
          WHEN ctrcode = 'DE'
          THEN 1
          WHEN NOT ctrcode IN ('BG', 'CY', 'GR')
          THEN 2
          WHEN ctrcode = 'GR'
          THEN 3
          WHEN ctrcode IN ('BG', 'CY')
          THEN 4
        END, IF(ctrcode IS NULL, 0, 1) DESC, ctrcode, IF(artikelnr IS NULL, 0, 1) DESC, artikelnr
      ) = 1
  ) AS waw
    ON itm.itemnr = waw.itemnr
) AS subselect;