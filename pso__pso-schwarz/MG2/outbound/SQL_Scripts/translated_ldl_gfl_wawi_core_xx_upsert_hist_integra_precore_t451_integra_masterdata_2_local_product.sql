/* WAWI_HQ country deduplication mapping table */
CREATE TEMPORARY TABLE t_ctrcode_map_${load_id} AS
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
  FROM meta.t_party_key AS pk
  INNER JOIN core_rel.t_internal_organization AS io
    ON pk.party_sid = io.int_org_sid
    AND pk.dwh_valid_fg
    AND io.dwh_valid_fg
    AND pk.party_key_type_cd = 'COUNTRY'
) AS subselect;

/* FV product to (WAWI) local product */
CREATE TEMPORARY TABLE t_fv_prod_to_wawi_item AS
SELECT
  p.prod_sid,
  p.prod_nr,
  iit.ctrcode,
  iit.itemnr
FROM (
  SELECT
    t_product.prod_sid,
    t_product.prod_nr AS prod_nr
  FROM core_rel.t_product
  WHERE
    t_product.prod_sid IN (
      SELECT
        t_product.prod_sid
      FROM meta.t_product_key
      WHERE
        prod_key_type_cd IN ('FV')
    )
    AND t_product.dwh_valid_fg
) AS p
INNER JOIN (
  SELECT
    iit_0.*
  FROM (
    SELECT
      subselect.*
    FROM (
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
      FROM etl.t_wawi_precore_t215_int_itemnr
    ) AS subselect
    QUALIFY
      row_number() OVER (
        PARTITION BY subselect.ctrcode, subselect.c215_int_itemnr
        ORDER BY IF(
          CASE WHEN subselect.c215_int_itemnr = subselect.itemnr THEN 0 ELSE 1 END IS NULL,
          0,
          1
        ) DESC, CASE WHEN subselect.c215_int_itemnr = subselect.itemnr THEN 0 ELSE 1 END, IF(subselect.itemnr IS NULL, 0, 1) DESC, subselect.itemnr
      ) = 1
  ) AS iit_0
  INNER JOIN t_ctrcode_map_${load_id} AS cm
    ON iit_0.ctrcode = cm.ctrcode_src
  QUALIFY
    row_number() OVER (
      PARTITION BY iit_0.c215_int_itemnr, cm.ctrcode_tgt
      ORDER BY IF(cm.ctrcode_rank IS NULL, 0, 1) DESC, cm.ctrcode_rank
    ) = 1
) AS iit
  ON p.prod_nr = iit.c215_int_itemnr;

/* INSERT INTO  etl.t_tf_integra_precore_t451_integra_masterdata_2_local_product__ */
INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (
  ctrcode,
  int_org_key_type_cd,
  prod_key_type_cd,
  prod_nr,
  local_prod_nr,
  add_nr_exist_fg,
  local_prod_name,
  local_prod_descr,
  local_prod_version_nr,
  local_prod_creation_dt,
  local_list_dt,
  local_delist_dt,
  locked_fg,
  brand_name,
  intrastat_nr,
  plu_nr,
  vat_refund_fg,
  dangerous_goods_fg,
  min_cust_age_meas,
  sort_seq,
  brand_type_cd,
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
  src.ctrcode AS ctrcode, /* FRAMEWORK AND TECHNICAL COLUMNS */
  'COUNTRY' AS int_org_key_type_cd,
  'FV' AS prod_key_type_cd,
  src.prod_nr AS prod_nr,
  src.src_itemnr AS local_prod_nr,
  FALSE AS add_nr_exist_fg,
  src.bez_kurz AS local_prod_name,
  src.bez_lang AS local_prod_descr,
  coalesce(src.itemversion, 0) AS local_prod_version_nr,
  src.gueltig_ab AS local_prod_creation_dt,
  CASE WHEN src.eingelist = TRUE THEN src.eingel_datum ELSE NULL END AS local_list_dt,
  CASE WHEN src.ausgelist = TRUE THEN src.ausgel_datum ELSE NULL END AS local_delist_dt,
  src.locked_fg AS locked_fg,
  upper(src.marke) AS brand_name,
  src.commoditycode AS intrastat_nr,
  src.plu AS plu_nr,
  coalesce(src.refund, FALSE) AS vat_refund_fg,
  src.dang_fg AS dangerous_goods_fg,
  src.desc_007 AS min_cust_age_meas,
  src.ordersatznr AS sort_seq,
  src.brand_type_cd,
  'WAWI' AS source_system,
  CURRENT_DATE AS extraction_dt,
  src.extraction_tmsp AS dwh_mapping_tmsp,
  0 AS tf_error_fg,
  0 AS deleted_fg,
  0 AS record_id,
  't_${SRC_INPUT_TABLE}' AS filename,
  'WAWI_HQ' AS dwh_node_cd,
  '${LOAD_ID}' AS dwh_load_id
/* Extraction/Filter Logic: */
FROM (
  SELECT
    src_0.prod_nr,
    src_0.ctrcode,
    src_0.itemnr AS src_itemnr,
    waw.extraction_tmsp,
    waw.bez_kurz,
    waw.bez_lang,
    waw.itemversion,
    waw.gueltig_ab,
    waw.eingelist,
    waw.eingel_datum,
    waw.ausgelist,
    waw.ausgel_datum,
    NOT lck.lck_itemnr IS NULL AS locked_fg,
    waw.marke,
    itmo.commoditycode,
    waw.plu,
    waw.refund,
    NOT dg.dg_itemnr IS NULL AS dang_fg,
    adsc.desc_007,
    waw.ordersatznr,
    CASE
      WHEN upper(c270_listdescript) LIKE '% EM'
      THEN 'EM'
      WHEN upper(c270_listdescript) LIKE '% M'
      THEN 'M'
      ELSE 'EM/M'
    END AS brand_type_cd
  FROM t_fv_prod_to_wawi_item AS src_0
  INNER JOIN (
    SELECT
      CAST(a.artnrvier AS NUMERIC) AS waw_itemnr,
      a.*
    FROM etl.t_wawi_precore_artikel AS a
    QUALIFY
      row_number() OVER (
        PARTITION BY a.ctrcode, a.artnrvier
        ORDER BY IF(a.artikelnr IS NULL, 0, 1) DESC, a.artikelnr
      ) = 1
  ) AS waw
    ON src_0.ctrcode = waw.ctrcode AND src_0.itemnr = waw.waw_itemnr
  LEFT OUTER JOIN etl.t_wawi_precore_t270_listtype AS brd
    ON brd.ctrcode = waw.ctrcode AND c270_listnr = listenknznr
  LEFT OUTER JOIN (
    SELECT
      t_wawi_precore_t119_status_locked.ctrcode,
      round(
        CAST(substr(
          t_wawi_precore_t119_status_locked.itemno,
          1,
          CAST(length(t_wawi_precore_t119_status_locked.itemno) - 4 AS INT64)
        ) AS NUMERIC),
        0
      ) AS lck_itemnr
    FROM etl.t_wawi_precore_t119_status_locked
    GROUP BY
      1,
      2
    HAVING
      MIN(t_wawi_precore_t119_status_locked.locked) = 1
  ) AS lck
    ON waw.ctrcode = lck.ctrcode AND waw.waw_itemnr = lck.lck_itemnr
  LEFT OUTER JOIN (
    SELECT
      round(CAST(substr(a.artikelnr, 1, CAST(length(a.artikelnr) - 4 AS INT64)) AS NUMERIC), 0) AS itmo_itemnr,
      a.*
    FROM etl.t_wawi_precore_artikelbestell AS a
    QUALIFY
      row_number() OVER (
        PARTITION BY a.ctrcode, itmo_itemnr
        ORDER BY IF(a.artikelnr IS NULL, 0, 1) DESC, a.artikelnr
      ) = 1
  ) AS itmo
    ON waw.ctrcode = itmo.ctrcode AND waw.waw_itemnr = itmo.itmo_itemnr
  LEFT OUTER JOIN (
    SELECT
      round(CAST(substr(a.itemno, 1, CAST(length(a.itemno) - 4 AS INT64)) AS NUMERIC), 0) AS dg_itemnr,
      a.*
    FROM etl.t_wawi_precore_t220_dangerous_goods AS a
    QUALIFY
      row_number() OVER (
        PARTITION BY a.ctrcode, dg_itemnr
        ORDER BY IF(dg_itemnr IS NULL, 0, 1) DESC, dg_itemnr
      ) = 1
  ) AS dg
    ON waw.ctrcode = dg.ctrcode AND waw.waw_itemnr = dg.dg_itemnr
  LEFT OUTER JOIN (
    SELECT
      CAST(a.itemnrshort AS NUMERIC) AS itma_itemnr,
      a.*
    FROM etl.t_wawi_precore_t214_itemaddinfo AS a
    QUALIFY
      row_number() OVER (
        PARTITION BY a.ctrcode, itma_itemnr
        ORDER BY IF(a.itemnr IS NULL, 0, 1) DESC, a.itemnr
      ) = 1
  ) AS itma
    ON waw.ctrcode = itma.ctrcode AND waw.waw_itemnr = itma.itma_itemnr
  LEFT OUTER JOIN (
    SELECT
      t_wawi_precore_t007_descriptions.*,
      t_wawi_precore_t007_descriptions.`desc` AS desc_007
    FROM etl.t_wawi_precore_t007_descriptions
  ) AS adsc
    ON waw.ctrcode = adsc.ctrcode
    AND itma.ageflag = adsc.code
    AND adsc.type_ = 'AgeLimits'
) AS src;