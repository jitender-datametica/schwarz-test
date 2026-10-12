/* WAWI_HQ country_2 deduplication mapping table */
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
  FROM meta.t_party_key_2 AS pk
  INNER JOIN core_rel.t_internal_organization_2 AS io
    ON pk.party_sid = io.int_org_sid
    AND pk.dwh_valid_fg
    AND io.dwh_valid_fg
    AND pk.party_key_type_cd = 'COUNTRY_2'
) AS subselect;

/* EKS product to (WAWI) local product */
CREATE TEMPORARY TABLE t_eks_prod_to_wawi_item AS
SELECT
  eks.*
FROM (
  SELECT
    t_wawi_precore_eks_item_wawi_item.prod_num,
    t_wawi_precore_eks_item_wawi_item.ctrcode,
    t_wawi_precore_eks_item_wawi_item.itemno_wawi
  FROM etl.t_wawi_precore_eks_item_wawi_item_2
  QUALIFY
    row_number() OVER (
      PARTITION BY ctrcode, prod_num
      ORDER BY IF(
        CASE WHEN prod_num = t_wawi_precore_eks_item_wawi_item.itemno THEN 0 ELSE 1 END IS NULL,
        0,
        1
      ) DESC, CASE WHEN prod_num = t_wawi_precore_eks_item_wawi_item.itemno THEN 0 ELSE 1 END, IF(itemno_wawi IS NULL, 0, 1) DESC, itemno_wawi
    ) = 1
) AS eks
INNER JOIN t_ctrcode_map_${load_id} AS cm
  ON eks.ctrcode = cm.ctrcode_src
QUALIFY
  row_number() OVER (
    PARTITION BY eks.prod_num, cm.ctrcode_tgt
    ORDER BY IF(cm.ctrcode_rank IS NULL, 0, 1) DESC, cm.ctrcode_rank
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
  'COUNTRY_2' AS int_org_key_type_cd,
  src.ctrcode AS ctrcode,
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
  adsc.`desc` AS min_cust_age_meas,
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
    t_${src_input_table}.ctrcode,
    t_${src_input_table}.prod_num,
    t_${src_input_table}.itemno_wawi,
    count(*) OVER (
      PARTITION BY t_${src_input_table}.ctrcode, t_${src_input_table}.prod_num
    ) > 1 AS add_nr_exist_fg
  FROM ${temp_db}.t_${src_input_table}
  QUALIFY
    row_number() OVER (
      PARTITION BY ctrcode, prod_num
      ORDER BY IF(itemno_wawi IS NULL, 0, 1) DESC, itemno_wawi
    ) = 1
) AS src
INNER JOIN (
  SELECT
    CAST(a.artnrvier AS NUMERIC) AS itemnr,
    a.*
  FROM etl.t_wawi_precore_artikel_2 AS a
  QUALIFY
    row_number() OVER (
      PARTITION BY a.ctrcode, a.artnrvier
      ORDER BY IF(a.artikelnr IS NULL, 0, 1) DESC, a.artikelnr
    ) = 1
) AS waw
  ON src.ctrcode = waw.ctrcode AND src.itemno_wawi = waw.itemnr
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
    ) AS itemnr
  FROM etl.t_wawi_precore_t119_status_locked_2
  GROUP BY
    1,
    2
  HAVING
    MIN(t_wawi_precore_t119_status_locked.locked) = 1
) AS lck
  ON waw.ctrcode = lck.ctrcode AND waw.itemnr = lck.itemnr
LEFT OUTER JOIN (
  SELECT
    round(CAST(substr(a.artikelnr, 1, CAST(length(a.artikelnr) - 4 AS INT64)) AS NUMERIC), 0) AS itemnr,
    a.*
  FROM etl.t_wawi_precore_artikelbestell_2 AS a
  QUALIFY
    row_number() OVER (
      PARTITION BY a.ctrcode, itemnr
      ORDER BY IF(a.artikelnr IS NULL, 0, 1) DESC, a.artikelnr
    ) = 1
) AS itmo
  ON waw.ctrcode = itmo.ctrcode AND waw.itemnr = itmo.itemnr
LEFT OUTER JOIN (
  SELECT
    round(CAST(substr(a.itemno, 1, CAST(length(a.itemno) - 4 AS INT64)) AS NUMERIC), 0) AS itemnr,
    a.*
  FROM etl.t_wawi_precore_t220_dangerous_goods_2 AS a
  QUALIFY
    row_number() OVER (PARTITION BY a.ctrcode, itemnr ORDER BY IF(a.itemno IS NULL, 0, 1) DESC, a.itemno) = 1
) AS dg
  ON waw.ctrcode = dg.ctrcode AND waw.itemnr = dg.itemnr
LEFT OUTER JOIN (
  SELECT
    CAST(a.itemnrshort AS NUMERIC) AS itemnr_,
    a.*
  FROM etl.t_wawi_precore_t214_itemaddinfo_2 AS a
  QUALIFY
    row_number() OVER (
      PARTITION BY a.ctrcode, a.itemnrshort
      ORDER BY IF(a.itemnr IS NULL, 0, 1) DESC, a.itemnr
    ) = 1
) AS itma
  ON waw.ctrcode = itma.ctrcode AND waw.itemnr = itma.itemnr_
LEFT OUTER JOIN etl.t_wawi_precore_t007_descriptions_2 AS adsc
  ON waw.ctrcode = adsc.ctrcode
  AND itma.ageflag = adsc.code
  AND adsc.type_ = 'AgeLimits'
LEFT OUTER JOIN etl.t_wawi_precore_t270_listtype_2 AS brd
  ON brd.ctrcode = waw.ctrcode AND c270_listnr = listenknznr;