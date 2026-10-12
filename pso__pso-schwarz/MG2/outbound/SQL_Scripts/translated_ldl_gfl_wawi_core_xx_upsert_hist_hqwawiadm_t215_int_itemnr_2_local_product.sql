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

/* EKS product to (WAWI) local product */
CREATE TEMPORARY TABLE t_eks_prod_to_wawi_item AS
SELECT
  eks.*
FROM (
  SELECT
    t_tcache_eks_item_wawi_item.prod_num,
    t_tcache_eks_item_wawi_item.wawi_instanz_kzl,
    t_tcache_eks_item_wawi_item.itemno_wawi
  FROM etl.t_tcache_eks_item_wawi_item
  QUALIFY
    row_number() OVER (
      PARTITION BY wawi_instanz_kzl, prod_num
      ORDER BY IF(
        CASE WHEN prod_num = t_tcache_eks_item_wawi_item.itemno THEN 0 ELSE 1 END IS NULL,
        0,
        1
      ) DESC, CASE WHEN prod_num = t_tcache_eks_item_wawi_item.itemno THEN 0 ELSE 1 END, IF(itemno_wawi IS NULL, 0, 1) DESC, itemno_wawi
    ) = 1
) AS eks
INNER JOIN t_wawi_instanz_kzl_map AS cm
  ON eks.wawi_instanz_kzl = cm.wawi_instanz_kzl_src
QUALIFY
  row_number() OVER (
    PARTITION BY eks.prod_num, cm.wawi_instanz_kzl_tgt
    ORDER BY IF(cm.wawi_instanz_kzl_rank IS NULL, 0, 1) DESC, cm.wawi_instanz_kzl_rank
  ) = 1;

/* Extraction/Filter Logic: */
INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (
  prod_key_type_cd,
  prod_nr,
  int_org_key_type_cd,
  ctrcode,
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
  'EKS' AS prod_key_type_cd, /* FRAMEWORK AND TECHNICAL COLUMNS */
  src.prod_num AS prod_nr,
  'COUNTRY' AS int_org_key_type_cd,
  src.wawi_instanz_kzl AS ctrcode,
  waw.artnrvier AS local_prod_nr,
  src.add_nr_exist_fg AS add_nr_exist_fg,
  waw.bez_kurz AS local_prod_name,
  waw.bez_lang AS local_prod_descr,
  coalesce(waw.itemversion, 0) AS local_prod_version_nr,
  waw.gueltig_ab AS local_prod_creation_dt,
  CASE WHEN waw.eingelist = TRUE THEN waw.eingel_datum ELSE NULL END AS local_list_dt,
  CASE WHEN waw.ausgelist = TRUE THEN waw.ausgel_datum ELSE NULL END AS local_delist_dt,
  NOT lck.itemnr IS NULL /* lck.locked_fg */ AS locked_fg,
  upper(waw.marke) AS brand_name,
  itmo.commoditycode AS intrastat_nr,
  waw.plu AS plu_nr,
  coalesce(waw.refund, FALSE) AS vat_refund_fg,
  NOT dg.itemnr IS NULL /* dg.dang_fg */ AS dangerous_goods_fg,
  adsc.c007_desc AS min_cust_age_meas,
  waw.ordersatznr AS sort_seq,
  CASE
    WHEN upper(c270_listdescript) LIKE '% EM'
    THEN 'EM'
    WHEN upper(c270_listdescript) LIKE '% M'
    THEN 'M'
    ELSE 'EM/M'
  END AS brand_type_cd,
  'WAWI' AS source_system, /* FRAMEWORK AND TECHNICAL COLUMNS */
  CURRENT_DATE AS extraction_dt,
  waw.extraction_tmsp AS dwh_mapping_tmsp,
  0 AS tf_error_fg,
  0 AS deleted_fg,
  0 AS record_id,
  '${SRC_INPUT_TABLE}' AS filename,
  'WAWI_HQ' AS dwh_node_cd,
  '${LOAD_ID}' AS dwh_load_id
FROM (
  SELECT
    t_tcache_eks_item_wawi_item.wawi_instanz_kzl,
    t_tcache_eks_item_wawi_item.prod_num,
    t_tcache_eks_item_wawi_item.itemno_wawi,
    count(*) OVER (
      PARTITION BY t_tcache_eks_item_wawi_item.wawi_instanz_kzl, t_tcache_eks_item_wawi_item.prod_num
    ) > 1 AS add_nr_exist_fg
  FROM etl.t_tcache_eks_item_wawi_item
  QUALIFY
    row_number() OVER (
      PARTITION BY wawi_instanz_kzl, prod_num
      ORDER BY IF(itemno_wawi IS NULL, 0, 1) DESC, itemno_wawi
    ) = 1
) AS src
INNER JOIN (
  SELECT
    CAST(a.artnrvier AS NUMERIC) AS itemnr,
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
  ON src.wawi_instanz_kzl = left(waw.wawi_instanz_kzl, 2)
  AND src.itemno_wawi = waw.itemnr
LEFT OUTER JOIN (
  SELECT
    left(t119_status_locked.wawi_instanz_kzl, 2) AS wawi_instanz_kzl,
    round(
      CAST(substr(
        t119_status_locked.c119_itemno,
        1,
        CAST(length(t119_status_locked.c119_itemno) - 4 AS INT64)
      ) AS NUMERIC),
      0
    ) AS itemnr
  FROM ${ldl_wawi_common_snflk_cl_db_name}.whwawiadm.t119_status_locked
  WHERE
    t119_status_locked.delete_fg IS NULL
  GROUP BY
    1,
    2
  HAVING
    MIN(t119_status_locked.c119_locked) = 1
) AS lck
  ON left(waw.wawi_instanz_kzl, 2) = lck.wawi_instanz_kzl AND waw.itemnr = lck.itemnr
LEFT OUTER JOIN (
  SELECT
    round(CAST(substr(a.artikelnr, 1, CAST(length(a.artikelnr) - 4 AS INT64)) AS NUMERIC), 0) AS itemnr,
    a.*
  FROM ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.artikelbestell AS a
  WHERE
    a.delete_fg IS NULL
  QUALIFY
    row_number() OVER (
      PARTITION BY a.wawi_instanz_kzl, itemnr
      ORDER BY IF(a.artikelnr IS NULL, 0, 1) DESC, a.artikelnr
    ) = 1
) AS itmo
  ON waw.wawi_instanz_kzl = itmo.wawi_instanz_kzl AND waw.itemnr = itmo.itemnr
LEFT OUTER JOIN (
  SELECT
    round(
      CAST(substr(a.c220_itemno, 1, CAST(length(a.c220_itemno) - 4 AS INT64)) AS NUMERIC),
      0
    ) AS itemnr,
    a.*
  FROM ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.t220_dangerous_goods AS a
  WHERE
    a.delete_fg IS NULL
  QUALIFY
    row_number() OVER (
      PARTITION BY a.wawi_instanz_kzl, itemnr
      ORDER BY IF(a.c220_itemno IS NULL, 0, 1) DESC, a.c220_itemno
    ) = 1
) AS dg
  ON waw.wawi_instanz_kzl = dg.wawi_instanz_kzl AND waw.itemnr = dg.itemnr
LEFT OUTER JOIN (
  SELECT
    CAST(a.c214_itemnrshort AS NUMERIC) AS itemnr_,
    a.*
  FROM ${ldl_wawi_common_snflk_cl_db_name}.whwawiadm.t214_itemaddinfo AS a
  WHERE
    a.delete_fg IS NULL
  QUALIFY
    row_number() OVER (
      PARTITION BY a.wawi_instanz_kzl, a.c214_itemnrshort
      ORDER BY IF(a.c214_itemnr IS NULL, 0, 1) DESC, a.c214_itemnr
    ) = 1
) AS itma
  ON waw.wawi_instanz_kzl = itma.wawi_instanz_kzl AND waw.itemnr = itma.itemnr_
LEFT OUTER JOIN ldl_wawi_production.hqwawiadm.t007_descriptions AS adsc
  ON waw.wawi_instanz_kzl = adsc.wawi_instanz_kzl
  AND itma.c214_ageflag = adsc.c007_code
  AND adsc.c007_type = 'AgeLimits'
  AND adsc.delete_fg IS NULL
LEFT OUTER JOIN ldl_wawi_production.hqwawiadm.t270_listtype AS brd
  ON brd.wawi_instanz_kzl = waw.wawi_instanz_kzl
  AND c270_listnr = listenknznr
  AND brd.delete_fg IS NULL;