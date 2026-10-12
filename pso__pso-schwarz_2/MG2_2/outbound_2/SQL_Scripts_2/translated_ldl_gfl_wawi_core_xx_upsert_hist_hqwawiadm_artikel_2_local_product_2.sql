INSERT INTO ldl_data_production_$_2{temp_db}.${src2tgt_temp_table1}_${src_context_area}
(
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
  src.commoditycode AS intrastat_nr,
  FALSE AS add_nr_exist_fg,
  src.prod_sid,
  ctr.party_sid AS int_org_sid,
  waw.artnrvier AS local_prod_nr,
  waw.bez_kurz AS local_prod_name,
  waw.bez_lang AS local_prod_descr,
  COALESCE(waw.itemversion, 0) AS local_prod_version_nr,
  waw.gueltig_ab AS local_prod_creation_dt,
  CASE 
    WHEN waw.eingelist = TRUE THEN waw.eingel_datum
    ELSE NULL
  END AS local_list_dt,
  CASE
    WHEN waw.ausgelist = TRUE THEN waw.ausgel_datum
    ELSE NULL
  END AS local_delist_dt,
  IF(lck.itemnr IS NOT NULL, TRUE, FALSE) AS locked_fg,
  UPPER(waw.marke) AS brand_name,
  waw.plu AS plu_nr,
  COALESCE(waw.refund, FALSE) AS vat_refund_fg,
  IF(dg.itemnr IS NOT NULL, TRUE, FALSE) AS dangerous_goods_fg,
  SAFE_CAST(
    COALESCE(
      SAFE_CAST(adsc.c007_desc AS INT64),
      SAFE_CAST(SUBSTR(adsc.c007_desc, 1, 2) AS INT64)
    ) AS INT64
  ) AS min_cust_age_meas,
  waw.ordersatznr AS sort_seq,
  CASE
    WHEN brd.c270_listdescript ILIKE '% EM' THEN 'EM'
    WHEN brd.c270_listdescript ILIKE '% M' THEN 'M'
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
FROM  
(
    SELECT
       prod_sid,
       SPLIT(prod_nat_key_nr, '|')[SAFE_OFFSET(0)] AS wawi_instanz_kzl,
       SAFE_CAST(SPLIT(prod_nat_key_nr, '|')[SAFE_OFFSET(1)] AS INT64) AS itemnr
    FROM ldl_data_production_meta.t_product_key_2
    WHERE prod_key_type_cd = 'WAWI'
      AND dwh_valid_fg
) AS src
INNER JOIN
(
   SELECT 
     SAFE_CAST(waw_instanz_kzl AS STRING) AS wawi_instanz_kzl,
     SAFE_CAST(artnrvier AS INT64) AS itemnr,
     src.*
   FROM ${ldl_wawi_common_snflk_cl_db_name}.${src_input_table} AS src
   WHERE delete_fg IS NULL
) AS waw
  ON src.wawi_instanz_kzl = LEFT(waw.wawi_instanz_kzl, 2)
 AND src.itemnr = waw.itemnr
INNER JOIN
(
    SELECT party_sid, party_nat_key_nr
    FROM ldl_data_production_meta.t_party_key_2
    WHERE party_key_type_cd = 'COUNTRY_2'
      AND dwh_valid_fg
) AS ctr
  ON ctr.party_nat_key_nr = LEFT(waw.wawi_instanz_kzl, 2)
LEFT JOIN
(
    SELECT 
      wawi_instanz_kzl, 
      SAFE_CAST(SUBSTR(c119_itemno, 1, LENGTH(c119_itemno) - 4) AS INT64) AS itemnr
    FROM ${ldl_wawi_common_snflk_cl_db_name}.whwawiadm.t119_status_locked_2
    WHERE delete_fg IS NULL
    GROUP BY 1, 2
    HAVING MIN(c119_locked) = 1
) AS lck
  ON waw.wawi_instanz_kzl = lck.wawi_instanz_kzl
 AND waw.itemnr = lck.itemnr
LEFT JOIN
(
    SELECT 
      SAFE_CAST(SUBSTR(artikelnr, 1, LENGTH(artikelnr) - 4) AS INT64) AS itemnr,
      a.wawi_instanz_kzl
    FROM ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.artikelbestell_2 AS a
    WHERE delete_fg IS NULL
) AS itmo
  ON waw.wawi_instanz_kzl = itmo.wawi_instanz_kzl
 AND waw.itemnr = itmo.itemnr
LEFT JOIN
(
    SELECT 
      SAFE_CAST(SUBSTR(c220_itemno, 1, LENGTH(c220_itemno) - 4) AS INT64) AS itemnr,
      a.wawi_instanz_kzl
    FROM ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.t220_dangerous_goods_2 AS a
    WHERE delete_fg IS NOT NULL
) AS dg
  ON waw.wawi_instanz_kzl = dg.wawi_instanz_kzl
 AND waw.itemnr = dg.itemnr
LEFT JOIN
(
    SELECT 
      SAFE_CAST(c214_itemnrshort AS INT64) AS itemnr,
      wawi_instanz_kzl,
      c214_ageflag AS ageflag
    FROM ${ldl_wawi_common_snflk_cl_db_name}.whwawiadm.t214_itemaddinfo_2
    WHERE delete_fg IS NULL
) AS itma
  ON waw.wawi_instanz_kzl = itma.wawi_instanz_kzl
 AND waw.itemnr = itma.itemnr
LEFT JOIN ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.t007_descriptions_2 AS adsc
  ON waw.wawi_instanz_kzl = adsc.wawi_instanz_kzl
 AND itma.ageflag = adsc.c007_code
LEFT JOIN ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.t270_listtype_2 AS brd
  ON brd.wawi_instanz_kzl = waw.wawi_instanz_kzl
 AND brd.c270_listnr = brd.listenknznr
WHERE adsc.delete_fg IS NULL
  AND brd.delete_fg IS NULL
;
