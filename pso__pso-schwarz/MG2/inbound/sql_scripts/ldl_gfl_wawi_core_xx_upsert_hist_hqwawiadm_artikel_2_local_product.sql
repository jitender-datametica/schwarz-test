INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
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
  dwh_load_id)
SELECT DISTINCT
  commoditycode intrastat_nr,
  FALSE add_nr_exist_fg,
  prod_sid,
  party_sid int_org_sid,
  waw.artnrvier local_prod_nr,
  waw.bez_kurz local_prod_name,
  waw.bez_lang local_prod_descr,
  COALESCE(itemversion, 0) local_prod_version_nr,
  gueltig_ab local_prod_creation_dt,
  CASE 
    WHEN eingelist = TRUE THEN eingel_datum 
    ELSE NULL 
  END local_list_dt,
  CASE 
    WHEN ausgelist = TRUE THEN ausgel_datum
    ELSE NULL 
  END local_delist_dt,
  (lck.itemnr IS NOT NULL) locked_fg,
  UPPER(waw.marke) brand_name,
  waw.plu plu_nr,
  COALESCE(waw.refund, FALSE) vat_refund_fg,
  (dg.itemnr IS NOT NULL) dangerous_goods_fg,
  COALESCE(TRY_TO_NUMBER(adsc.c007_desc),TRY_TO_NUMBER(LEFT(adsc.c007_desc,2)))  min_cust_age_meas,
  waw.ordersatznr sort_seq,
  case when brd.c270_listdescript ilike '% EM' then 'EM'
            when c270_listdescript ilike '% M' then 'M'
            else 'EM/M' end brand_type_cd,
  'WAWI' source_system,
  waw.extraction_tmsp extraction_dt,
  waw.extraction_tmsp dwh_mapping_tmsp,
  0 tf_error_fg,
  0 deleted_fg,
  0 record_id,
  '${SRC_INPUT_TABLE}' filename,
  'WAWI_HQ' dwh_node_cd,
  '${LOAD_ID}' dwh_load_id
FROM  
  (
    SELECT
       prod_sid
      , Split(prod_nat_key_nr, '|')[0] AS wawi_instanz_kzl
      , Cast(Split(prod_nat_key_nr, '|')[1] AS Number) AS itemnr
    FROM META.t_product_key
    WHERE prod_key_type_cd = 'WAWI'
    AND dwh_valid_fg
  ) src
INNER JOIN
  (    
   SELECT 
     Cast(artnrvier AS Number) AS itemnr,src.* 
   FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.${SRC_INPUT_TABLE} src   
   WHERE delete_fg IS NULL
   QUALIFY Row_Number() OVER (PARTITION BY src.wawi_instanz_kzl, artnrvier ORDER BY artikelnr) = 1    

  ) AS waw ON  src.wawi_instanz_kzl = LEFT(waw.wawi_instanz_kzl,2) AND src.itemnr = waw.itemnr
INNER JOIN
  (
    SELECT party_sid,party_nat_key_nr
    FROM meta.t_party_key
    WHERE party_key_type_cd = 'COUNTRY' AND dwh_valid_fg    
  ) ctr ON ctr.party_nat_key_nr=LEFT(waw.wawi_instanz_kzl,2)
LEFT OUTER JOIN
  (
    SELECT wawi_instanz_kzl, CAST(Substring(c119_itemno, 1, Length(c119_itemno)-4) AS Number) AS itemnr
    FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.whwawiadm.t119_status_locked
    WHERE delete_fg IS NULL
    GROUP BY 1,2
    HAVING Min(c119_locked) = 1
  ) AS lck ON  waw.wawi_instanz_kzl = lck.wawi_instanz_kzl AND waw.itemnr = lck.itemnr
LEFT OUTER JOIN
  (
    SELECT Cast(Substring(artikelnr, 1, Length(artikelnr)-4) AS Number) AS itemnr, a.*
    FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.artikelbestell AS a
    WHERE delete_fg IS NULL
    QUALIFY Row_Number() OVER (PARTITION BY wawi_instanz_kzl, itemnr ORDER BY artikelnr) = 1
  ) AS itmo ON  waw.wawi_instanz_kzl = itmo.wawi_instanz_kzl AND waw.itemnr = itmo.itemnr
LEFT OUTER JOIN
  (
    SELECT Cast(Substring(c220_itemno, 1, Length(c220_itemno)-4) AS Number) AS itemnr, a.*
    FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.t220_dangerous_goods AS a
    WHERE delete_fg IS NULL
    QUALIFY Row_Number() OVER (PARTITION BY wawi_instanz_kzl, itemnr ORDER BY c220_itemno) = 1
   ) as dg ON  waw.wawi_instanz_kzl = dg.wawi_instanz_kzl AND waw.itemnr = dg.itemnr
LEFT OUTER JOIN
  (
    SELECT Cast(c214_itemnrshort AS Number) AS itemnr, wawi_instanz_kzl, c214_ageflag AS ageflag
    FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.whwawiadm.t214_itemaddinfo AS a
     WHERE delete_fg IS NULL
    QUALIFY Row_Number() OVER (PARTITION BY wawi_instanz_kzl, Cast(c214_itemnrshort AS Number) ORDER BY extraction_tmsp) = 1
  ) AS itma ON  waw.wawi_instanz_kzl = itma.wawi_instanz_kzl AND waw.itemnr = itma.itemnr
LEFT OUTER JOIN ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.t007_descriptions AS adsc ON waw.wawi_instanz_kzl = adsc.wawi_instanz_kzl AND itma.ageflag = adsc.c007_code AND adsc.c007_type = 'AgeLimits'
left join     ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.T270_LISTTYPE brd
on brd.wawi_instanz_kzl = waw.wawi_instanz_kzl
and c270_listnr = listenknznr
WHERE adsc.delete_fg IS NULL AND  brd.delete_fg IS NULL               
;
