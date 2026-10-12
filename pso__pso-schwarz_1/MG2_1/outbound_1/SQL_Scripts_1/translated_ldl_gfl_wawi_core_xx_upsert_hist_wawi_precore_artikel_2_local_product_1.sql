INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (
  intrastat_nr,
  add_nr_exist_fg,
  prod_sid,
  int_org_sid,
  local_prod_nr,
  local_prod_name,
  local_prod_descr,
  local_prod_version_nr,
  local_prod_creation_dt,
  local_list_dt,
  local_delist_dt,
  locked_fg,
  brand_name,
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
SELECT DISTINCT
  commoditycode AS intrastat_nr,
  FALSE AS add_nr_exist_fg,
  src.prod_sid,
  ctr.party_sid AS int_org_sid,
  waw.artnrvier AS local_prod_nr,
  waw.bez_kurz AS local_prod_name,
  waw.bez_lang AS local_prod_descr,
  coalesce(itemversion, 0) AS local_prod_version_nr,
  gueltig_ab AS local_prod_creation_dt,
  CASE WHEN eingelist = TRUE THEN eingel_datum ELSE NULL END AS local_list_dt,
  CASE WHEN ausgelist = TRUE THEN ausgel_datum ELSE NULL END AS local_delist_dt,
  NOT lck.itemnr IS NULL AS locked_fg,
  upper(waw.marke) AS brand_name,
  waw.plu AS plu_nr,
  coalesce(waw.refund, FALSE) AS vat_refund_fg,
  NOT dg.itemnr IS NULL AS dangerous_goods_fg,
  coalesce(
    round(SAFE_CAST(adsc.`desc` AS NUMERIC), 0),
    round(SAFE_CAST(left(adsc.`desc`, 2) AS NUMERIC), 0)
  ) AS min_cust_age_meas,
  waw.ordersatznr AS sort_seq,
  CASE
    WHEN upper(brd.c270_listdescript) LIKE '% EM'
    THEN 'EM'
    WHEN upper(c270_listdescript) LIKE '% M'
    THEN 'M'
    ELSE 'EM/M'
  END AS brand_type_cd,
  'WAWI' AS source_system,
  waw.extraction_tmsp AS extraction_dt,
  waw.extraction_tmsp AS dwh_mapping_tmsp,
  0 AS tf_error_fg,
  0 AS deleted_fg,
  0 AS record_id,
  '${SRC_INPUT_TABLE}' AS filename,
  'WAWI_HQ' AS dwh_node_cd,
  '${LOAD_ID}' AS dwh_load_id
FROM (
  SELECT
    t_product_key.prod_sid,
    split(t_product_key.prod_nat_key_nr, '|')[SAFE_ORDINAL(0)] AS ctrcode,
    CAST(lax_float64(split(t_product_key.prod_nat_key_nr, '|')[SAFE_ORDINAL(1)]) AS NUMERIC) AS itemnr
  FROM meta.t_product_key_1
  WHERE
    t_product_key.prod_key_type_cd = 'WAWI' AND t_product_key.dwh_valid_fg
) AS src
INNER JOIN (
  SELECT
    CAST(a.artnrvier AS NUMERIC) AS itemnr,
    a.*
  FROM ${temp_db}.t_wawi_precore_artikel_1 AS a
  QUALIFY
    row_number() OVER (
      PARTITION BY a.ctrcode, a.artnrvier
      ORDER BY IF(a.artikelnr IS NULL, 0, 1) DESC, a.artikelnr
    ) = 1
) AS waw
  ON src.ctrcode = waw.ctrcode AND src.itemnr = waw.itemnr
INNER JOIN (
  SELECT
    t_party_key.party_sid,
    t_party_key.party_nat_key_nr
  FROM meta.t_party_key_1
  WHERE
    t_party_key.party_key_type_cd = 'COUNTRY_1' AND t_party_key.dwh_valid_fg
) AS ctr
  ON ctr.party_nat_key_nr = waw.ctrcode
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
  FROM ${temp_db}.t_wawi_precore_t119_status_locked_1
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
  FROM ${temp_db}.t_wawi_precore_artikelbestell_1 AS a
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
  FROM ${temp_db}.t_wawi_precore_t220_dangerous_goods_1 AS a
  QUALIFY
    row_number() OVER (PARTITION BY a.ctrcode, itemnr ORDER BY IF(a.itemno IS NULL, 0, 1) DESC, a.itemno) = 1
) AS dg
  ON waw.ctrcode = dg.ctrcode AND waw.itemnr = dg.itemnr
LEFT OUTER JOIN (
  SELECT
    CAST(a.itemnrshort AS NUMERIC) AS itemnr,
    a.ctrcode,
    a.ageflag
  FROM ${temp_db}.t_wawi_precore_t214_itemaddinfo_1 AS a
  QUALIFY
    row_number() OVER (
      PARTITION BY ctrcode, itemnr
      ORDER BY IF(a.extraction_tmsp IS NULL, 0, 1) DESC, a.extraction_tmsp
    ) = 1
) AS itma
  ON waw.ctrcode = itma.ctrcode AND waw.itemnr = itma.itemnr
LEFT OUTER JOIN ${temp_db}.t_wawi_precore_t007_descriptions_1 AS adsc
  ON waw.ctrcode = adsc.ctrcode
  AND itma.ageflag = adsc.code
  AND adsc.type_ = 'AgeLimits'
LEFT OUTER JOIN etl.t_wawi_precore_t270_listtype_1 AS brd
  ON brd.ctrcode = waw.ctrcode AND c270_listnr = listenknznr;