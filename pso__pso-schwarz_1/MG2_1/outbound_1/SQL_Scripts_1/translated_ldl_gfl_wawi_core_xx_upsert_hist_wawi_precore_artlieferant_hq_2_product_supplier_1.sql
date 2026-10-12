/* Standard processing as per mapping specifications:
*/ /*
0.2 init country_1 table and deduplication mapping
*/
CREATE OR REPLACE TEMPORARY TABLE t_ctrcode_map_1 AS
SELECT
  subselect.int_org_ctr_cd AS ctrcode_tgt,
  subselect.party_nat_key_nr AS ctrcode_src,
  row_number() OVER (
    PARTITION BY subselect.party_sid
    ORDER BY IF(
      CASE WHEN subselect.party_nat_key_nr = subselect.int_org_ctr_cd THEN 0 ELSE 1 END IS NULL,
      0,
      1
    ) DESC, CASE WHEN subselect.party_nat_key_nr = subselect.int_org_ctr_cd THEN 0 ELSE 1 END, IF(subselect.party_nat_key_nr IS NULL, 0, 1) DESC, subselect.party_nat_key_nr
  ) AS ctrcode_rank
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

/*
0.3 CBX product to local items
*/
CREATE OR REPLACE TEMPORARY TABLE t_cbx_prod_to_wawi_items AS
SELECT
  p.prod_sid,
  p.prod_nr,
  iit.ctrcode,
  iit.itemnr
FROM (
  SELECT
    t_product.prod_sid,
    t_product.prod_nr AS prod_nr
  FROM core_rel.t_product_1
  WHERE
    t_product.prod_sid IN (
      SELECT
        t_product.prod_sid
      FROM meta.t_product_key_1
      WHERE
        prod_key_type_cd IN ('CBX')
    )
    AND t_product.dwh_valid_fg
    AND NOT t_product.prod_nr IS NULL
) AS p
INNER JOIN (
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
  FROM etl.t_wawi_precore_t215_int_itemnr_1
) AS iit
  ON p.prod_nr = iit.c215_int_itemnr;

/*
0.3 add FV product to local items
*/
CREATE OR REPLACE TEMPORARY TABLE t_fv_prod_to_wawi_item AS
SELECT
  p.prod_sid,
  p.prod_nr,
  iit.ctrcode,
  iit.itemnr
FROM (
  SELECT
    t_product.prod_sid,
    t_product.prod_nr AS prod_nr
  FROM core_rel.t_product_1
  WHERE
    t_product.prod_sid IN (
      SELECT
        t_product.prod_sid
      FROM meta.t_product_key_1
      WHERE
        prod_key_type_cd IN ('FV')
    )
    AND t_product.dwh_valid_fg
    AND NOT t_product.prod_nr IS NULL
) AS p
INNER JOIN (
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
  FROM etl.t_wawi_precore_t215_int_itemnr_1
) AS iit
  ON p.prod_nr = iit.c215_int_itemnr;

/*
0.4 add WaWi product to local items
*/
CREATE OR REPLACE TEMPORARY TABLE t_wawi_prod_to_wawi_item_1 AS
SELECT
  p.prod_sid,
  split(p.prod_nat_key_nr, '|')[SAFE_ORDINAL(0)] AS ctrcode,
  m.ctrcode_tgt,
  CAST(lax_float64(split(p.prod_nat_key_nr, '|')[SAFE_ORDINAL(1)]) AS NUMERIC) AS itemnr
FROM meta.t_product_key_1 AS p
LEFT OUTER JOIN t_ctrcode_map_1 AS m
  ON split(p.prod_nat_key_nr, '|')[SAFE_ORDINAL(0)] = m.ctrcode_src
WHERE
  p.prod_key_type_cd = 'WAWI' AND p.dwh_valid_fg = 1;

INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (
  prod_sid,
  party_nat_key_nr,
  int_org_key_type_cd,
  sup_nat_key_nr,
  sup_key_type_cd,
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
  src.prod_sid, /* CBX */
  src.ctrcode AS party_nat_key_nr,
  'COUNTRY_1' AS int_org_key_type_cd,
  CONCAT(src.ctrcode, '|', LTRIM(src.krednr, '0')) AS sup_nat_key_nr,
  'SUPPLIER_1' AS sup_key_type_cd,
  'CBX' AS source_system,
  src.extraction_tmsp AS extraction_dt,
  src.extraction_tmsp AS dwh_mapping_tmsp,
  0 AS tf_error_fg,
  0 AS deleted_fg,
  0 AS record_id,
  'wawi_precore_artlieferant_hq' AS filename,
  'CBX' AS dwh_node_cd,
  src.${load_id} AS dwh_load_id
FROM (
  SELECT
    l.prod_sid,
    c.ctrcode_tgt AS ctrcode,
    s.krednr,
    l.prod_nr,
    CONCAT(c.ctrcode_tgt, '|', CAST(round(CAST(s.krednr AS NUMERIC), 0) AS STRING)) AS party_nat_key_nr,
    s.extraction_tmsp
  FROM t_cbx_prod_to_wawi_items AS l
  LEFT OUTER JOIN t_ctrcode_map_1 AS c
    ON l.ctrcode = c.ctrcode_src
  LEFT OUTER JOIN (
    SELECT
      substr(
        substr(
          TRIM(t_wawi_precore_artlieferant_hq.artikelnr, CAST(0 AS STRING)),
          1,
          CAST(length(TRIM(t_wawi_precore_artlieferant_hq.artikelnr, CAST(0 AS STRING))) - 4 AS INT64)
        ),
        1,
        20
      ) AS artikelnr,
      t_wawi_precore_artlieferant_hq.ctrcode,
      LTRIM(t_wawi_precore_artlieferant_hq.krednr, '0') AS krednr,
      t_wawi_precore_artlieferant_hq.extraction_tmsp
    FROM etl.t_wawi_precore_artlieferant_hq_1
  ) AS s
    ON substr(CAST(l.itemnr AS STRING), 1, 20) = s.artikelnr AND l.ctrcode = s.ctrcode
  WHERE
    NOT s.krednr IS NULL AND s.krednr <> ''
  QUALIFY
    row_number() OVER (
      PARTITION BY l.prod_sid, ctrcode
      ORDER BY IF(s.krednr IS NULL, 0, 1) DESC, s.krednr
    ) = 1
) AS src
UNION DISTINCT
SELECT
  src.prod_sid, /* FV */
  src.ctrcode AS party_nat_key_nr,
  'COUNTRY_1' AS int_org_key_type_cd,
  CONCAT(src.ctrcode, '|', LTRIM(src.krednr, '0')) AS sup_nat_key_nr,
  'SUPPLIER_1' AS sup_key_type_cd,
  'FV' AS source_system,
  src.extraction_tmsp AS extraction_dt,
  src.extraction_tmsp AS dwh_mapping_tmsp,
  0 AS tf_error_fg,
  0 AS deleted_fg,
  0 AS record_id,
  'wawi_precore_artlieferant_hq' AS filename,
  'FV' AS dwh_node_cd,
  src.${load_id} AS dwh_load_id
FROM (
  SELECT
    l.prod_sid,
    c.ctrcode_tgt AS ctrcode,
    s.krednr,
    l.prod_nr,
    CONCAT(c.ctrcode_tgt, '|', CAST(round(CAST(s.krednr AS NUMERIC), 0) AS STRING)) AS party_nat_key_nr,
    s.extraction_tmsp
  FROM t_fv_prod_to_wawi_item AS l
  LEFT OUTER JOIN t_ctrcode_map_1 AS c
    ON l.ctrcode = c.ctrcode_src
  LEFT OUTER JOIN (
    SELECT
      substr(
        substr(
          TRIM(t_wawi_precore_artlieferant_hq.artikelnr, CAST(0 AS STRING)),
          1,
          CAST(length(TRIM(t_wawi_precore_artlieferant_hq.artikelnr, CAST(0 AS STRING))) - 4 AS INT64)
        ),
        1,
        20
      ) AS artikelnr,
      t_wawi_precore_artlieferant_hq.ctrcode,
      LTRIM(t_wawi_precore_artlieferant_hq.krednr, '0') AS krednr,
      t_wawi_precore_artlieferant_hq.extraction_tmsp
    FROM etl.t_wawi_precore_artlieferant_hq_1
  ) AS s
    ON substr(CAST(l.itemnr AS STRING), 1, 20) = s.artikelnr AND l.ctrcode = s.ctrcode
  WHERE
    NOT s.krednr IS NULL AND s.krednr <> ''
  QUALIFY
    row_number() OVER (
      PARTITION BY l.prod_sid, ctrcode
      ORDER BY IF(s.krednr IS NULL, 0, 1) DESC, s.krednr
    ) = 1
) AS src
UNION DISTINCT
SELECT
  src.prod_sid, /* EKS */
  src.ctrcode AS party_nat_key_nr,
  'COUNTRY_1' AS int_org_key_type_cd,
  CONCAT(src.ctrcode, '|', LTRIM(src.krednr, '0')) AS sup_nat_key_nr,
  'SUPPLIER_1' AS sup_key_type_cd,
  'EKS' AS source_system,
  src.extraction_tmsp AS extraction_dt,
  src.extraction_tmsp AS dwh_mapping_tmsp,
  0 AS tf_error_fg,
  0 AS deleted_fg,
  0 AS record_id,
  'wawi_precore_artlieferant_hq' AS filename,
  'EKS' AS dwh_node_cd,
  src.${load_id} AS dwh_load_id
FROM (
  SELECT
    pk.prod_sid,
    c.ctrcode_tgt AS ctrcode,
    s.krednr,
    CONCAT(c.ctrcode_tgt, '|', s.krednr) AS party_nat_key_nr,
    s.extraction_tmsp
  FROM etl.t_wawi_precore_eks_item_wawi_item_1 AS eks
  LEFT OUTER JOIN t_ctrcode_map_1 AS c
    ON eks.ctrcode = c.ctrcode_src
  LEFT OUTER JOIN (
    SELECT
      substr(
        substr(
          TRIM(t_wawi_precore_artlieferant_hq.artikelnr, CAST(0 AS STRING)),
          1,
          CAST(length(TRIM(t_wawi_precore_artlieferant_hq.artikelnr, CAST(0 AS STRING))) - 4 AS INT64)
        ),
        1,
        20
      ) AS artikelnr,
      t_wawi_precore_artlieferant_hq.ctrcode,
      LTRIM(t_wawi_precore_artlieferant_hq.krednr, '0') AS krednr,
      t_wawi_precore_artlieferant_hq.extraction_tmsp
    FROM etl.t_wawi_precore_artlieferant_hq_1
  ) AS s
    ON CAST(eks.itemno_wawi AS STRING) = s.artikelnr AND eks.ctrcode = s.ctrcode
  INNER JOIN meta.t_product_key_1 AS pk
    ON CAST(pk.prod_nat_key_nr AS STRING) = CAST(eks.prod_num AS STRING)
    AND pk.prod_key_type_cd = 'EKS'
    AND pk.dwh_valid_fg
  WHERE
    NOT eks.prod_num IS NULL AND s.krednr <> ''
  QUALIFY
    row_number() OVER (
      PARTITION BY ctrcode, eks.prod_num
      ORDER BY IF(s.krednr IS NULL, 0, 1) DESC, s.krednr
    ) = 1
) AS src
UNION DISTINCT
SELECT
  src.prod_sid, /* WAWI */
  src.ctrcode AS party_nat_key_nr,
  'COUNTRY_1' AS int_org_key_type_cd,
  CONCAT(src.ctrcode, '|', LTRIM(src.krednr, '0')) AS sup_nat_key_nr,
  'SUPPLIER_1' AS sup_key_type_cd,
  'WAWI' AS source_system,
  src.extraction_tmsp AS extraction_dt,
  src.extraction_tmsp AS dwh_mapping_tmsp,
  0 AS tf_error_fg,
  0 AS deleted_fg,
  0 AS record_id,
  'wawi_precore_artlieferant_hq' AS filename,
  'WAWI' AS dwh_node_cd,
  src.${load_id} AS dwh_load_id
FROM (
  SELECT
    w.prod_sid,
    c.ctrcode_tgt AS ctrcode,
    s.krednr,
    w.itemnr,
    CONCAT(c.ctrcode_tgt, '|', CAST(round(CAST(s.krednr AS NUMERIC), 0) AS STRING)) AS party_nat_key_nr,
    s.extraction_tmsp
  FROM t_wawi_prod_to_wawi_item_1 AS w
  LEFT OUTER JOIN t_ctrcode_map_1 AS c
    ON w.ctrcode = c.ctrcode_src
  LEFT OUTER JOIN (
    SELECT
      substr(
        substr(
          TRIM(t_wawi_precore_artlieferant_hq.artikelnr, CAST(0 AS STRING)),
          1,
          CAST(length(TRIM(t_wawi_precore_artlieferant_hq.artikelnr, CAST(0 AS STRING))) - 4 AS INT64)
        ),
        1,
        20
      ) AS artikelnr,
      t_wawi_precore_artlieferant_hq.ctrcode,
      LTRIM(t_wawi_precore_artlieferant_hq.krednr, '0') AS krednr,
      t_wawi_precore_artlieferant_hq.extraction_tmsp
    FROM etl.t_wawi_precore_artlieferant_hq_1
  ) AS s
    ON substr(CAST(w.itemnr AS STRING), 1, 20) = s.artikelnr AND w.ctrcode = s.ctrcode
  WHERE
    NOT w.itemnr IS NULL AND NOT s.krednr IS NULL AND s.krednr <> ''
  QUALIFY
    row_number() OVER (
      PARTITION BY s.artikelnr, ctrcode
      ORDER BY IF(s.krednr IS NULL, 0, 1) DESC, s.krednr
    ) = 1
) AS src;