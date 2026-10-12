/* WAWI_HQ country deduplication mapping table */
CREATE TEMPORARY TABLE t_wawi_instanz_kzl_map AS
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
  iit.wawi_instanz_kzl,
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
        left(t215_int_itemnr.wawi_instanz_kzl, 2) AS wawi_instanz_kzl,
        round(
          CAST(substr(
            t215_int_itemnr.c215_itemnr,
            1,
            CAST(length(t215_int_itemnr.c215_itemnr) - 4 AS INT64)
          ) AS NUMERIC),
          0
        ) AS itemnr,
        CAST(t215_int_itemnr.c215_int_itemnr AS NUMERIC) AS c215_int_itemnr
      FROM ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.t215_int_itemnr
      WHERE
        t215_int_itemnr.delete_fg IS NULL
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

/* INSERT INTO  ETL.t_tf_integra_precore_t451_integra_masterdata_2_local_product__ */
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
  src.wawi_instanz_kzl AS ctrcode, /* FRAMEWORK AND TECHNICAL COLUMNS */
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
  '{SRC_INPUT_TABLE}' AS filename,
  'WAWI_HQ' AS dwh_node_cd,
  '${LOAD_ID}' AS dwh_load_id
/* Extraction/Filter Logic: */
FROM (
  SELECT
    src_0.prod_nr,
    src_0.wawi_instanz_kzl,
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
    FROM ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.artikel AS a
    WHERE
      a.delete_fg IS NULL
    QUALIFY
      row_number() OVER (
        PARTITION BY a.wawi_instanz_kzl, a.artnrvier
        ORDER BY IF(a.artikelnr IS NULL, 0, 1) DESC, a.artikelnr
      ) = 1
  ) AS waw
    ON src_0.wawi_instanz_kzl = left(waw.wawi_instanz_kzl, 2)
    AND src_0.itemnr = waw.waw_itemnr
  LEFT OUTER JOIN ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.t270_listtype AS brd
    ON brd.wawi_instanz_kzl = waw.wawi_instanz_kzl AND c270_listnr = listenknznr
  LEFT OUTER JOIN (
    SELECT
      t119_status_locked.wawi_instanz_kzl,
      round(
        CAST(substr(
          t119_status_locked.c119_itemno,
          1,
          CAST(length(t119_status_locked.c119_itemno) - 4 AS INT64)
        ) AS NUMERIC),
        0
      ) AS lck_itemnr
    FROM ${ldl_wawi_common_snflk_cl_db_name}.whwawiadm.t119_status_locked
    WHERE
      t119_status_locked.delete_fg IS NULL
    GROUP BY
      1,
      2
    HAVING
      MIN(t119_status_locked.c119_locked) = 1
  ) AS lck
    ON waw.wawi_instanz_kzl = lck.wawi_instanz_kzl AND waw.waw_itemnr = lck.lck_itemnr
  LEFT OUTER JOIN (
    SELECT
      round(CAST(substr(a.artikelnr, 1, CAST(length(a.artikelnr) - 4 AS INT64)) AS NUMERIC), 0) AS itmo_itemnr,
      a.*
    FROM ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.artikelbestell AS a
    WHERE
      a.delete_fg IS NULL
    QUALIFY
      row_number() OVER (
        PARTITION BY a.wawi_instanz_kzl, itmo_itemnr
        ORDER BY IF(a.artikelnr IS NULL, 0, 1) DESC, a.artikelnr
      ) = 1
  ) AS itmo
    ON waw.wawi_instanz_kzl = itmo.wawi_instanz_kzl
    AND waw.waw_itemnr = itmo.itmo_itemnr
  LEFT OUTER JOIN (
    SELECT
      round(
        CAST(substr(a.c220_itemno, 1, CAST(length(a.c220_itemno) - 4 AS INT64)) AS NUMERIC),
        0
      ) AS dg_itemnr,
      a.*
    FROM ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.t220_dangerous_goods AS a
    WHERE
      a.delete_fg IS NULL
    QUALIFY
      row_number() OVER (
        PARTITION BY a.wawi_instanz_kzl, dg_itemnr
        ORDER BY IF(dg_itemnr IS NULL, 0, 1) DESC, dg_itemnr
      ) = 1
  ) AS dg
    ON waw.wawi_instanz_kzl = dg.wawi_instanz_kzl AND waw.waw_itemnr = dg.dg_itemnr
  LEFT OUTER JOIN (
    SELECT
      CAST(a.c214_itemnrshort AS NUMERIC) AS itma_itemnr,
      a.*
    FROM ${ldl_wawi_common_snflk_cl_db_name}.whwawiadm.t214_itemaddinfo AS a
    WHERE
      a.delete_fg IS NULL
    QUALIFY
      row_number() OVER (
        PARTITION BY a.wawi_instanz_kzl, itma_itemnr
        ORDER BY IF(a.c214_itemnr IS NULL, 0, 1) DESC, a.c214_itemnr
      ) = 1
  ) AS itma
    ON waw.wawi_instanz_kzl = itma.wawi_instanz_kzl
    AND waw.waw_itemnr = itma.itma_itemnr
  LEFT OUTER JOIN (
    SELECT
      a.*,
      a.c007_desc AS desc_007
    FROM ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.t007_descriptions AS a
    WHERE
      a.delete_fg IS NULL
  ) AS adsc
    ON waw.wawi_instanz_kzl = adsc.wawi_instanz_kzl
    AND adsc.delete_fg IS NULL
    AND itma.c214_ageflag = adsc.c007_code
    AND adsc.c007_type = 'AgeLimits'
) AS src;