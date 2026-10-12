INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (
  prod_key_type_cd,
  prod_nr,
  prod_grp_key_type_cd,
  prod_grp_type_cd,
  prod_grp_nr,
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
WITH t215 AS (
  SELECT
    *
  FROM ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.t215_int_itemnr_2 AS src
  WHERE
    src.delete_fg IS NULL
  QUALIFY
    row_number() OVER (
      PARTITION BY left(src.wawi_instanz_kzl, 2), src.c215_int_itemnr
      ORDER BY IF(src.extraction_tmsp IS NULL, 0, 1), src.extraction_tmsp DESC
    ) = 1
), t214 AS (
  SELECT
    *
  FROM ${ldl_wawi_common_snflk_cl_db_name}.whwawiadm.t214_itemaddinfo_2 AS src
  WHERE
    src.delete_fg IS NULL
  QUALIFY
    row_number() OVER (
      PARTITION BY left(src.wawi_instanz_kzl, 2), src.c214_itemnr
      ORDER BY IF(src.extraction_tmsp IS NULL, 0, 1), src.extraction_tmsp DESC
    ) = 1
), t038 AS (
  SELECT
    src.* /* NAT_KEY_TYPE */ /* NAT_KEY */ /* NAT_KEY_TYPE */ /* NAT_KEY */ /* FRAMEWORK AND TECHNICAL COLUMNS */
  FROM ldl_wawi_production.hqwawiadm.t038_itemfamily_2 AS src
  INNER JOIN (
    SELECT
      a.wawi_instanz_kzl,
      rank() OVER (
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
        END, IF(a.wawi_instanz_kzl IS NULL, 0, 1) DESC, a.wawi_instanz_kzl
      ) AS eks_rank
    FROM (
      SELECT DISTINCT
        t038_itemfamily.wawi_instanz_kzl
      FROM ldl_wawi_production.hqwawiadm.t038_itemfamily_2
      WHERE
        t038_itemfamily.delete_fg IS NULL
    ) AS a
  ) AS csrc
    ON csrc.wawi_instanz_kzl = csrc.wawi_instanz_kzl
  WHERE
    delete_fg IS NULL
  QUALIFY
    (
      csrc.eks_rank = MIN(csrc.eks_rank) OVER (
        PARTITION BY left(src.wawi_instanz_kzl, 2), src.c038_family_id /* ) */
        ORDER BY IF(src.extraction_tmsp IS NULL, 0, 1), src.extraction_tmsp DESC
      )
    ) = (
      1 <> 0
    )
)
SELECT
  'WAWI' AS prod_key_type_cd, /* AND Row_Number() OVER (PARTITION BY LEFT( src.wawi_instanz_kzl, 2), src.C038_FAMILY_ID */
  CONCAT(upper(left(src.wawi_instanz_kzl, 2)), '|', CAST(src.itemnr AS STRING)) AS prod_nr,
  'IFG' AS prod_grp_key_type_cd,
  'IFG' AS prod_grp_type_cd,
  CONCAT(src.itemgrpnr, '|', src.family_code) AS prod_grp_nr,
  'WAWI_HQ' AS source_system, /* FRAMEWORK AND TECHNICAL COLUMNS */
  src.extraction_tmsp AS extraction_dt,
  src.extraction_tmsp AS dwh_mapping_tmsp,
  0 AS tf_error_fg,
  0 AS deleted_fg,
  0 AS record_id,
  't_${SRC_INPUT_TABLE}' AS filename,
  'WAWI_HQ' AS dwh_node_cd,
  '${LOAD_ID}' AS dwh_load_id
FROM (
  SELECT
    left(art.wawi_instanz_kzl, 2) AS wawi_instanz_kzl,
    art.itemnr,
    fg.c038_itemgrpnr AS itemgrpnr,
    fg.c038_family_code AS family_code,
    itma.extraction_tmsp
  FROM (
    SELECT
      a.*,
      CAST(a.artnrvier AS NUMERIC) AS itemnr
    FROM ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.artikel_2 AS a
    WHERE
      a.delete_fg IS NULL
    QUALIFY
      row_number() OVER (
        PARTITION BY a.wawi_instanz_kzl, itemnr
        ORDER BY IF(a.artikelnr IS NULL, 0, 1) DESC, a.artikelnr
      ) = 1
  ) AS art_2
  LEFT OUTER JOIN (
    SELECT DISTINCT
      t215.wawi_instanz_kzl,
      round(
        CAST(substr(t215.c215_itemnr, 1, CAST(length(t215.c215_itemnr) - 4 AS INT64)) AS NUMERIC),
        0
      ) AS itemnr,
      CAST(t215.c215_int_itemnr AS NUMERIC) AS c215_int_itemnr
    FROM t215
  ) AS ii
    ON art.wawi_instanz_kzl = ii.wawi_instanz_kzl AND art.itemnr = ii.itemnr
  LEFT OUTER JOIN meta.t_product_key_2 AS ipk
    ON substr(CAST(ii.c215_int_itemnr AS STRING), 1, 16777216) = ipk.prod_nat_key_nr
    AND ipk.prod_key_type_cd IN ('CBX', 'FV')
    AND ipk.dwh_valid_fg
  LEFT OUTER JOIN (
    SELECT DISTINCT
      t_tcache_eks_item_wawi_item.itemno
    FROM etl.t_tcache_eks_item_wawi_item_2
  ) AS eks
    ON ii.c215_int_itemnr = eks.itemno
  INNER JOIN t214 AS itma
    ON art.wawi_instanz_kzl = itma.wawi_instanz_kzl AND art.artikelnr = itma.c214_itemnr
  INNER JOIN t038 AS fg
    ON itma.wawi_instanz_kzl = fg.wawi_instanz_kzl
    AND itma.c214_family_id = fg.c038_family_id
    AND (
      ii.itemnr IS NULL
      OR /* No link to international item_2 number */ ipk.prod_sid IS NULL
      AND /* International number not found in international keys */ eks.itemno IS NULL
    )
) AS src;