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
  COALESCE(TRY_TO_NUMBER(adsc.desc),TRY_TO_NUMBER(LEFT(adsc.desc,2)))  min_cust_age_meas,
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
      , Split(prod_nat_key_nr, '|')[0] AS ctrcode
      , Cast(Split(prod_nat_key_nr, '|')[1] AS Number) AS itemnr
    FROM META.t_product_key_1
    WHERE prod_key_type_cd = 'WAWI'
    AND dwh_valid_fg
  ) src
INNER JOIN
  (
    SELECT Cast(artnrvier AS Number) AS itemnr,a.*
    FROM ${TEMP_DB}.t_wawi_precore_artikel_1 AS a
    QUALIFY Row_Number() OVER (PARTITION BY ctrcode, artnrvier ORDER BY artikelnr) = 1
  ) AS waw ON  src.ctrcode = waw.ctrcode AND src.itemnr = waw.itemnr
INNER JOIN
  (
    SELECT party_sid,party_nat_key_nr
    FROM meta.t_party_key_1
    WHERE party_key_type_cd = 'COUNTRY_1' AND dwh_valid_fg    
  ) ctr ON ctr.party_nat_key_nr=waw.ctrcode
LEFT OUTER JOIN
  (
    SELECT ctrcode, CAST(Substring(itemno, 1, Length(itemno)-4) AS Number) AS itemnr
    FROM ${TEMP_DB}.t_wawi_precore_t119_status_locked_1
    GROUP BY 1,2
    HAVING Min(locked) = 1
  ) AS lck ON  waw.ctrcode = lck.ctrcode AND waw.itemnr = lck.itemnr
LEFT OUTER JOIN
  (
    SELECT Cast(Substring(artikelnr, 1, Length(artikelnr)-4) AS Number) AS itemnr, a.*
    FROM ${TEMP_DB}.t_wawi_precore_artikelbestell_1 AS a
    QUALIFY Row_Number() OVER (PARTITION BY ctrcode, itemnr ORDER BY artikelnr) = 1
  ) AS itmo ON  waw.ctrcode = itmo.ctrcode AND waw.itemnr = itmo.itemnr
LEFT OUTER JOIN
  (
    SELECT Cast(Substring(itemno, 1, Length(itemno)-4) AS Number) AS itemnr, a.*
    FROM ${TEMP_DB}.t_wawi_precore_t220_dangerous_goods_1 AS a
    QUALIFY Row_Number() OVER (PARTITION BY ctrcode, itemnr ORDER BY itemno) = 1
   ) as dg ON  waw.ctrcode = dg.ctrcode AND waw.itemnr = dg.itemnr
LEFT OUTER JOIN
  (
    SELECT Cast(itemnrshort AS Number) AS itemnr, ctrcode, ageflag
    FROM ${TEMP_DB}.t_wawi_precore_t214_itemaddinfo_1 AS a
    QUALIFY Row_Number() OVER (PARTITION BY ctrcode, Cast(itemnrshort AS Number) ORDER BY extraction_tmsp) = 1
  ) AS itma ON  waw.ctrcode = itma.ctrcode AND waw.itemnr = itma.itemnr
LEFT OUTER JOIN ${TEMP_DB}.t_wawi_precore_t007_descriptions_1 AS adsc ON waw.ctrcode = adsc.ctrcode AND itma.ageflag = adsc.code AND adsc.type_ = 'AgeLimits'
left join     ETL.t_wawi_precore_T270_LISTTYPE_1 brd
on brd.ctrcode = waw.ctrcode
and c270_listnr = listenknznr                
;
