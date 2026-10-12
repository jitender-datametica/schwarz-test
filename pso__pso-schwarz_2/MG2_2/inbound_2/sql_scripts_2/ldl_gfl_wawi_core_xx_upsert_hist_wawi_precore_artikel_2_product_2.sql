INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
 (
  prod_nat_key_nr,    
  prod_key_type_cd,    
  prod_type_cd, 
  item_type_cd, 
  prod_nr, 
  prod_name, 
  prod_descr, 
  prod_creation_dt, 
  packing_type_cd, 
  goods_on_consignment_fg, 
  excl_from_vat_calc_fg, 
  country_specific_prod_fg, 
  source_system, 
  extraction_dt, 
  dwh_mapping_tmsp,  
  tf_error_fg, 
  deleted_fg, 
  record_id, 
  filename,
  dwh_node_cd, 
  dwh_load_id)
SELECT	
  art.ctrcode || '|' || LTRIM(artnrvier,'0') prod_nat_key_nr,
  'WAWI' prod_key_type_cd, 
  CASE 
    WHEN artgrupnr BETWEEN 10 AND 899 THEN 'ITEM_2'
    WHEN artgrupnr = 996 THEN 'ITEM_2'
    WHEN artgrupnr = 991 THEN 'VOUCHER'
    WHEN artgrupnr = 997 THEN 'CONSUMABLE'
    ELSE 'OTHER'
  END prod_type_cd,
  CASE 
    WHEN artgrupnr BETWEEN 10 AND 14 THEN 'FV'
    WHEN artgrupnr BETWEEN 20 AND 99 THEN 'FOOD'
    WHEN artgrupnr BETWEEN 100 AND 400 THEN 'NON FOOD'
    WHEN artgrupnr = 996 THEN 'DEPOSIT'
  END item_type_cd,
  LTRIM(artnrvier,'0') prod_nr,
  deutschtext prod_name,
  bez_lang prod_descr,
  gueltig_ab prod_creation_dt,
  pt.c271_int_short packing_type_cd, 
  CASE 
    WHEN artgrupnr = 991 THEN TRUE ELSE FALSE 
  END goods_on_consignment_fg,
  CASE 
    WHEN ign.c664_item IS NOT NULL THEN TRUE 
    ELSE FALSE  
  END excl_from_vat_calc_fg,
  TRUE country_specific_prod_fg,
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
  (
    SELECT a.*
      , Cast(artnrvier AS Number) AS itemnr
    FROM ${TEMP_DB}.t_wawi_precore_artikel_2 AS a
    QUALIFY Row_Number() OVER (PARTITION BY ctrcode, itemnr ORDER BY artikelnr) = 1
  ) AS art_2
LEFT OUTER JOIN
  (
    SELECT DISTINCT
        ctrcode
      , Cast(Substring(c215_itemnr, 1, Length(c215_itemnr)-4) AS Number) AS itemnr
      , Cast(c215_int_itemnr AS Number) AS c215_int_itemnr
    FROM ${TEMP_DB}.t_wawi_precore_t215_int_itemnr_2
  ) AS ii ON  art.ctrcode = ii.ctrcode AND art.itemnr = ii.itemnr
LEFT OUTER JOIN meta.t_product_key_2 AS ipk ON  Cast(ii.c215_int_itemnr AS String) = ipk.prod_nat_key_nr AND ipk.prod_key_type_cd IN ('CBX', 'FV')
                                               AND ipk.dwh_valid_fg
LEFT OUTER JOIN
  (
    SELECT DISTINCT itemno
    FROM ${TEMP_DB}.t_wawi_precore_eks_item_wawi_item_2
  ) AS eks ON  ii.c215_int_itemnr = eks.itemno
LEFT OUTER JOIN ${TEMP_DB}.t_wawi_precore_t271_packagetype_2 AS pt ON  art.ctrcode = pt.ctrcode AND art.packung = pt.c271_packdescript
LEFT OUTER JOIN
  (
    SELECT DISTINCT ctrcode, c664_item
    FROM ${TEMP_DB}.t_wawi_precore_t664_brokerage_item_2
    WHERE c664_std_flag = 1 AND c664_modset = 0
  ) AS ign ON  art.ctrcode = ign.ctrcode AND art.itemnr = ign.c664_item
WHERE (ii.itemnr IS NULL /* No link to international item_2 number */
      OR (ipk.prod_sid IS NULL /* International number not found in international keys */  AND eks.itemno IS NULL))
      AND deutschtext IS NOT NULL /* temporary fix due to data masking */
;
