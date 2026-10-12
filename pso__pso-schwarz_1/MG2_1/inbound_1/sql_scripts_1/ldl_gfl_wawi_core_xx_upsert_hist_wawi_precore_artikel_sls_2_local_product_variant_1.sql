INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
 (
  prod_nat_key_nr,    
  prod_key_type_cd,  
  prod_variant_key_type_cd,  
  prod_variant_nr,
  int_org_key_type_cd,	
  party_nat_key_nr,

  prod_variant_nat_key_nr,
  local_prod_variant_nr,
  local_prod_variant_name,

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
  art.ctrcode || '|' || LTRIM(art.itemnr,'0') prod_nat_key_nr,
  'WAWI' prod_key_type_cd, 
  'WAW_SLS' prod_variant_key_type_cd, 
  art.ctrcode || '|' || Cast(art.itemnr AS String) prod_variant_nr,
  'COUNTRY_1' party_key_type_cd,	
  art.ctrcode party_nat_key_nr,

  art.ctrcode || '|' || Cast(art.itemnr AS String) prod_variant_nat_key_nr,
  art.itemnr local_prod_variant_nr,
  COALESCE(bez_lang, deutschtext) local_prod_variant_name,

  'WAWI' source_system,
  art.extraction_tmsp extraction_dt,
  art.extraction_tmsp dwh_mapping_tmsp,
  0 tf_error_fg,
  0 deleted_fg,
  0 record_id,
  '${SRC_INPUT_TABLE}' filename,
  'WAWI_HQ' dwh_node_cd,
  '${LOAD_ID}' dwh_load_id 
FROM
(    SELECT
        ctrcode
      , CAST(artnrvier AS NUMBER) AS itemnr
      , bez_lang
      , deutschtext
      , extraction_tmsp
    FROM ${TEMP_DB}.t_wawi_precore_artikel_1
    QUALIFY Row_Number() OVER (PARTITION BY ctrcode, itemnr ORDER BY artikelnr) = 1
) AS art_1
LEFT OUTER JOIN
(
    SELECT DISTINCT
        ctrcode
      , Cast(Substring(c215_itemnr, 1, Length(c215_itemnr)-4) AS Number) AS itemnr
      , Cast(c215_int_itemnr AS Number) AS int_itemnr
    FROM ${TEMP_DB}.t_wawi_precore_t215_int_itemnr_1
) AS ii ON  art.ctrcode = ii.ctrcode
AND art.itemnr = ii.itemnr
LEFT OUTER JOIN meta.t_product_key_1 AS ipk ON  Cast(ii.int_itemnr AS String) = ipk.prod_nat_key_nr AND ipk.prod_key_type_cd IN ('CBX', 'FV') AND ipk.dwh_valid_fg
LEFT OUTER JOIN
(
    SELECT DISTINCT
        itemno
    FROM ${TEMP_DB}.t_wawi_precore_eks_item_wawi_item_1
) AS eks ON  ii.int_itemnr = eks.itemno
WHERE
  (
    ii.itemnr IS NULL /* No link to international item_1 number */
    OR (ipk.prod_sid IS NULL /* International number not found in international keys */   AND eks.itemno IS NULL )
  )
;
