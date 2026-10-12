/* WAWI_HQ country_1 deduplication mapping table (used by CBX, FV, EKS) */
CREATE OR REPLACE TEMPORARY TABLE t_wawi_instanz_kzl_map_${load_id} AS
SELECT
  subselect.int_org_ctr_cd AS wawi_instanz_kzl_tgt,
  subselect.party_nat_key_nr AS wawi_instanz_kzl_src,
  row_number() OVER (
    PARTITION BY subselect.party_sid
    ORDER BY IF(
      CASE WHEN subselect.party_nat_key_nr = subselect.int_org_ctr_cd THEN 0 ELSE 1 END IS NULL,
      0,
      1
    ) DESC, CASE WHEN subselect.party_nat_key_nr = subselect.int_org_ctr_cd THEN 0 ELSE 1 END, IF(subselect.party_nat_key_nr IS NULL, 0, 1) DESC, subselect.party_nat_key_nr
  ) AS wawi_instanz_kzl_rank
FROM (
  SELECT DISTINCT
    pk.party_sid,
    pk.party_nat_key_nr,
    left(io.int_org_nr, 2) AS int_org_ctr_cd
  FROM meta.t_party_key_1 AS pk
  INNER JOIN core_rel.t_internal_organization_1 AS io
    ON pk.party_sid = io.int_org_sid
    AND pk.dwh_valid_fg
    AND io.dwh_valid_fg
    AND pk.party_key_type_cd = 'COUNTRY_1'
) AS subselect;

INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (
  prod_variant_sid,
  int_org_sid,
  local_prod_variant_nr,
  local_prod_variant_name,
  prod_sid,
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
WITH eks_log_sel AS (
  SELECT
    cm.wawi_instanz_kzl_tgt AS wawi_instanz_kzl, /* FRAMEWORK AND TECHNICAL COLUMNS */ /* EKS_LOG */
    k.prod_variant_sid,
    pk2.party_sid,
    pv.prod_sid,
    k.wawi_itemnr,
    art.bez_lang,
    art.deutschtext,
    art.extraction_tmsp
  FROM (
    SELECT DISTINCT
      t_product_variant_key.prod_variant_sid,
      substr(
        split(t_product_variant_key.prod_variant_nat_key_nr, '|')[SAFE_ORDINAL(0)],
        1,
        16777216
      ) AS wawi_instanz_kzl,
      round(
        SAFE_CAST(substr(
          split(t_product_variant_key.prod_variant_nat_key_nr, '|')[SAFE_ORDINAL(1)],
          1,
          16777216
        ) AS NUMERIC),
        0
      ) AS wawi_itemnr
    FROM meta.t_product_variant_key_1
    WHERE
      t_product_variant_key.prod_variant_key_type_cd = 'LOG'
      AND t_product_variant_key.dwh_valid_fg
      AND t_product_variant_key.prod_variant_sid IN (
        SELECT
          t_product_variant_key.prod_variant_sid
        FROM meta.t_product_variant_key_1 AS pvk
        WHERE
          prod_variant_key_type_cd IN ('EKS_LOG', 'EKS_LOG_UNK') AND dwh_valid_fg
      )
  ) AS k
  INNER JOIN core_rel.t_product_variant_1 AS pv
    ON k.prod_variant_sid = pv.prod_variant_sid AND pv.dwh_valid_fg
  INNER JOIN ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.artikel_1 AS art_1
    ON k.wawi_instanz_kzl = art.wawi_instanz_kzl AND k.wawi_itemnr = art.artnrvier
  INNER JOIN t_wawi_instanz_kzl_map_${load_id} AS cm
    ON k.wawi_instanz_kzl = cm.wawi_instanz_kzl_src
  INNER JOIN meta.t_party_key_1 AS pk2
    ON k.wawi_instanz_kzl = pk2.party_nat_key_nr
    AND pk2.party_key_type_cd = 'COUNTRY_1'
    AND pk2.dwh_valid_fg = 'TRUE'
  WHERE
    art.delete_fg IS NULL
  QUALIFY
    row_number() OVER (
      PARTITION BY k.prod_variant_sid, wawi_instanz_kzl
      ORDER BY IF(cm.wawi_instanz_kzl_rank IS NULL, 0, 1) DESC, cm.wawi_instanz_kzl_rank, art.gueltig_ab DESC, IF(art.artikelnr IS NULL, 0, 1) DESC, art.artikelnr
    ) = 1
)
SELECT DISTINCT
  src.prod_variant_sid AS prod_variant_sid,
  src.party_sid AS int_org_sid,
  src.wawi_itemnr AS local_prod_variant_nr,
  coalesce(src.bez_lang, src.deutschtext) AS local_prod_variant_name,
  src.prod_sid AS prod_sid,
  'WAWI' AS source_system, /* FRAMEWORK AND TECHNICAL COLUMNS */
  CURRENT_DATE AS extraction_dt,
  current_timestamp() AS dwh_mapping_tmsp,
  0 AS tf_error_fg,
  0 AS deleted_fg,
  0 AS record_id,
  't_${SRC_INPUT_TABLE}' AS filename,
  'WAWI_HQ' AS dwh_node_cd,
  '${LOAD_ID}' AS dwh_load_id
FROM eks_log_sel AS src
UNION ALL
SELECT DISTINCT
  src.prod_variant_sid AS prod_variant_sid, /* EKS_SLS */
  lp.int_org_sid AS int_org_sid,
  src.prod_variant_nr AS local_prod_variant_nr,
  src.prod_variant_name AS local_prod_variant_name,
  src.prod_sid AS prod_sid,
  'WAWI' AS source_system, /* FRAMEWORK AND TECHNICAL COLUMNS */
  CURRENT_DATE AS extraction_dt,
  current_timestamp() AS dwh_mapping_tmsp,
  0 AS tf_error_fg,
  0 AS deleted_fg,
  0 AS record_id,
  't_${SRC_INPUT_TABLE}' AS filename,
  'WAWI_HQ' AS dwh_node_cd,
  '${LOAD_ID}' AS dwh_load_id
FROM ${target_db}.t_${src_input_table} AS src
INNER JOIN core_rel.t_local_product_1 AS lp
  ON lp.prod_sid = src.prod_sid
WHERE
  src.prod_variant_sid IN (
    SELECT
      src.prod_variant_sid
    FROM meta.t_product_variant_key_1
    WHERE
      prod_variant_key_type_cd IN ('EKS_SLS', 'EKS_SLS_UNK')
  )
  AND src.dwh_valid_fg = TRUE
  AND lp.dwh_valid_fg = TRUE;