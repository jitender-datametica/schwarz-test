/* Standard processing as per mapping specifications:
*/ /* WAWI_HQ country_1 deduplication mapping table (used by CBX, FV, EKS) XXXX */
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

/* CBX product to (WAWI) local items */
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

/* FV product to (WAWI) local items XXXX */
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

/* WAWI product to (WAWI) local product - XXX_1 */
CREATE OR REPLACE TEMPORARY TABLE t_wawi_prod_to_wawi_item_1 AS
SELECT
  t_product_key.prod_sid,
  bqutil.fn.cw_split_part_delimstr_idx(t_product_key.prod_nat_key_nr, '|', 1) AS ctrcode,
  CAST(lax_float64(split(t_product_key.prod_nat_key_nr, '|')[SAFE_ORDINAL(1)]) AS NUMERIC) AS itemnr
FROM meta.t_product_key_1
WHERE
  t_product_key.prod_key_type_cd = 'WAWI' AND t_product_key.dwh_valid_fg;

/* CBX product to (WAWI) local items */
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

/* ------------------------------------------------------------- */
INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (
  prod_sid,
  party_nat_key_nr,
  int_org_key_type_cd,
  list_type_cd,
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
  src.prod_sid,
  src.ctrcode AS party_nat_key_nr,
  'COUNTRY_1' AS int_org_key_type_cd,
  CASE
    WHEN src.listenknznr IN (1, 2)
    THEN 1 /* Normal Assortment */
    WHEN src.listenknznr IN (5, 6)
    THEN 3 /* Test_1 Assortment */
    WHEN src.listenknznr IN (7, 8)
    THEN 2 /* Promotion */
    WHEN src.listenknznr IN (9, CAST('10' AS NUMERIC))
    THEN 4 /* New Listing */
    WHEN src.listenknznr IN (CAST('11' AS NUMERIC), CAST('12' AS NUMERIC))
    THEN 5 /* Delisted */
    ELSE 0
  END AS list_type_cd,
  'WAWI' AS source_system,
  src.extraction_tmsp AS extraction_dt,
  src.extraction_tmsp AS dwh_mapping_tmsp,
  0 AS tf_error_fg,
  0 AS deleted_fg,
  0 AS record_id,
  '${SRC_INPUT_TABLE}' AS filename,
  'WAWI_HQ' AS dwh_node_cd,
  '${LOAD_ID}' AS dwh_load_id
FROM (
  SELECT
    src_0.prod_sid, /* WAWI */
    src_0.ctrcode,
    waw.listenknznr,
    waw.extraction_tmsp
  FROM t_wawi_prod_to_wawi_item_1 AS src_0
  INNER JOIN etl.t_wawi_precore_artikel_1 AS waw
    ON src_0.ctrcode = waw.ctrcode AND src_0.itemnr = CAST(waw.artnrvier AS NUMERIC)
  QUALIFY
    row_number() OVER (
      PARTITION BY src_0.prod_sid, src_0.ctrcode
      ORDER BY IF(waw.listenknznr IS NULL, 0, 1) DESC, waw.listenknznr
    ) = 1
  UNION DISTINCT
  SELECT
    iit.prod_sid, /* FV */
    iit.ctrcode,
    waw.listenknznr,
    waw.extraction_tmsp
  FROM t_fv_prod_to_wawi_item AS iit
  INNER JOIN (
    SELECT
      CAST(a.artnrvier AS NUMERIC) AS itemnr,
      a.*
    FROM etl.t_wawi_precore_artikel_1 AS a
    WHERE
      NOT a.listenknznr IS NULL
    QUALIFY
      row_number() OVER (
        PARTITION BY a.ctrcode, a.artnrvier
        ORDER BY IF(a.listenknznr IS NULL, 0, 1) DESC, a.listenknznr
      ) = 1
  ) AS waw
    ON iit.ctrcode = waw.ctrcode AND iit.itemnr = waw.itemnr
  INNER JOIN t_ctrcode_map_1 AS cm
    ON waw.ctrcode = cm.ctrcode_src
  QUALIFY
    row_number() OVER (
      PARTITION BY iit.prod_sid, cm.ctrcode_tgt
      ORDER BY IF(waw.listenknznr IS NULL, 0, 1) DESC, waw.listenknznr
    ) = 1
  UNION DISTINCT
  SELECT
    pk.prod_sid, /* EKS */
    pr.ctrcode,
    artkl.listenknznr,
    artkl.extraction_tmsp
  FROM (
    SELECT
      a.listenknznr,
      CAST(a.artnrvier AS NUMERIC) AS itemnr,
      a.ctrcode,
      a.extraction_tmsp
    FROM etl.t_wawi_precore_artikel_1 AS a
    WHERE
      NOT a.listenknznr IS NULL
    QUALIFY
      row_number() OVER (
        PARTITION BY ctrcode, itemnr
        ORDER BY IF(a.artikelnr IS NULL, 0, 1) DESC, a.artikelnr
      ) = 1
  ) AS artkl
  INNER JOIN etl.t_wawi_precore_eks_item_wawi_item_1 AS pr
    ON pr.ctrcode = artkl.ctrcode AND pr.itemno_wawi = artkl.itemnr
  INNER JOIN meta.t_product_key_1 AS pk
    ON CAST(pr.prod_num AS STRING) = pk.prod_nat_key_nr
    AND pk.prod_key_type_cd = 'EKS'
    AND pk.dwh_valid_fg
  INNER JOIN t_ctrcode_map_1 AS cm
    ON artkl.ctrcode = cm.ctrcode_src
  QUALIFY
    row_number() OVER (
      PARTITION BY cm.ctrcode_tgt, pk.prod_sid
      ORDER BY IF(artkl.listenknznr IS NULL, 0, 1) DESC, artkl.listenknznr
    ) = 1
  UNION DISTINCT
  SELECT
    subselect.prod_sid, /* CBX */
    subselect.ctrcode,
    subselect.listenknznr,
    subselect.extraction_tmsp
  FROM (
    SELECT
      src_0.prod_sid,
      src_0.prod_nr,
      src_0.ctrcode,
      waw.extraction_tmsp,
      waw.listenknznr
    FROM t_cbx_prod_to_wawi_items AS src_0
    INNER JOIN etl.t_wawi_precore_artikel_1 AS waw
      ON src_0.ctrcode = waw.ctrcode
      AND src_0.itemnr = CAST(waw.artnrvier AS NUMERIC)
      AND NOT waw.listenknznr IS NULL
    INNER JOIN t_ctrcode_map_1 AS cm
      ON waw.ctrcode = cm.ctrcode_src
    QUALIFY
      row_number() OVER (
        PARTITION BY cm.ctrcode_tgt, src_0.prod_nr
        ORDER BY IF(waw.listenknznr IS NULL, 0, 1) DESC, waw.listenknznr
      ) = 1
  ) AS subselect
) AS src;