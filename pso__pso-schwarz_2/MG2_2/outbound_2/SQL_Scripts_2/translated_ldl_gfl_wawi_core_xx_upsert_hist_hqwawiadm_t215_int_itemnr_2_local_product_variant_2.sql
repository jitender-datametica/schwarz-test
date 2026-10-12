/* WAWI_HQ country_2 deduplication mapping table */
CREATE TEMPORARY TABLE t_wawi_instanz_kzl_map AS
SELECT
  left(com.party_nat_key_nr, 2) AS wawi_instanz_kzl_tgt,
  ctr.party_nat_key_nr AS wawi_instanz_kzl_src,
  row_number() OVER (
    PARTITION BY ctr.party_sid
    ORDER BY IF(
      CASE WHEN ctr.party_nat_key_nr = left(com.party_nat_key_nr, 2) THEN 0 ELSE 1 END IS NULL,
      0,
      1
    ) DESC, CASE WHEN ctr.party_nat_key_nr = left(com.party_nat_key_nr, 2) THEN 0 ELSE 1 END, IF(ctr.party_nat_key_nr IS NULL, 0, 1) DESC, ctr.party_nat_key_nr
  ) AS wawi_instanz_kzl_rank
FROM meta.t_party_key_2 AS ctr
INNER JOIN meta.t_party_key_2 AS com
  ON ctr.party_key_type_cd = 'COUNTRY_2'
  AND ctr.party_sid = com.party_sid
  AND com.party_key_type_cd = 'COMPANY';

INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (
  ctrcode,
  prod_key_type_cd,
  int_org_key_type_cd,
  prod_variant_key_type_cd,
  local_prod_variant_nr,
  local_prod_variant_name,
  local_prod_nr,
  prod_nr,
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
SELECT DISTINCT
  iit.wawi_instanz_kzl AS ctrcode, /* Extraction/Filter Logic: */ /* for retrieving the int_org_sid */
  'CBX' AS prod_key_type_cd,
  'COUNTRY_2' AS int_org_key_type_cd,
  pv.prod_variant_key_type_cd AS prod_variant_key_type_cd,
  pv.prod_variant_nr AS local_prod_variant_nr,
  pv.prod_variant_name AS local_prod_variant_name,
  p.prod_nr AS local_prod_nr,
  p.prod_nr AS prod_nr,
  'CBX' AS source_system,
  CURRENT_DATE AS extraction_dt,
  iit.extraction_tmsp AS dwh_mapping_tmsp, /* <--- added in subquery */
  0 AS tf_error_fg,
  0 AS deleted_fg,
  0 AS record_id,
  't_${SRC_INPUT_TABLE}' AS filename,
  pv.p_dwh_node_cd AS dwh_node_cd,
  '${LOAD_ID}' AS dwh_load_id
FROM (
  SELECT
    t_product_variant.*,
    t_product_variant_key.*,
    t_product_variant.dwh_node_cd AS p_dwh_node_cd
  FROM core_rel.t_product_variant_2
  INNER JOIN meta.t_product_variant_key_2
    ON t_product_variant.prod_variant_sid = t_product_variant_key.prod_variant_sid
    AND t_product_variant_key.prod_variant_key_type_cd IN ('CBX_SLS', 'CBX_SLS_UNK', 'CBX_LOG')
  WHERE
    t_product_variant.dwh_valid_fg
) AS pv
INNER JOIN core_rel.t_product_2 AS p
  ON pv.prod_sid = p.prod_sid AND p.dwh_valid_fg
INNER JOIN (
  SELECT
    iit_0.*
  FROM (
    SELECT
      subselect.*
    FROM (
      SELECT DISTINCT
        left(src.wawi_instanz_kzl, 2) AS wawi_instanz_kzl,
        src.extraction_tmsp, /* <--- added */
        round(
          CAST(substr(src.c215_itemnr, 1, CAST(length(src.c215_itemnr) - 4 AS INT64)) AS NUMERIC),
          0
        ) AS itemnr,
        CAST(src.c215_int_itemnr AS NUMERIC) AS c215_int_itemnr
      FROM ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.t215_int_itemnr_2 AS src
      WHERE
        src.delete_fg IS NULL
      QUALIFY
        row_number() OVER (
          PARTITION BY wawi_instanz_kzl, src.c215_int_itemnr
          ORDER BY IF(src.extraction_tmsp IS NULL, 0, 1), src.extraction_tmsp DESC
        ) = 1
    ) AS subselect
    QUALIFY
      row_number() OVER (
        PARTITION BY subselect.wawi_instanz_kzl, subselect.c215_int_itemnr
        ORDER BY IF(
          CASE WHEN subselect.c215_int_itemnr = subselect.itemnr THEN 0 ELSE 1 END IS NULL,
          0,
          1
        ) DESC, CASE WHEN subselect.c215_int_itemnr = subselect.itemnr THEN 0 ELSE 1 END, IF(subselect.itemnr IS NULL, 0, 1) DESC, subselect.itemnr
      ) = 1
  ) AS iit_0
  INNER JOIN t_wawi_instanz_kzl_map AS cm
    ON iit_0.wawi_instanz_kzl = cm.wawi_instanz_kzl_src
  QUALIFY
    row_number() OVER (
      PARTITION BY iit_0.c215_int_itemnr, cm.wawi_instanz_kzl_tgt
      ORDER BY IF(cm.wawi_instanz_kzl_rank IS NULL, 0, 1) DESC, cm.wawi_instanz_kzl_rank
    ) = 1
) AS iit
  ON p.prod_nr = iit.c215_int_itemnr;