INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
 (
  prod_nat_key_nr,    
  prod_key_type_cd,  
  prod_variant_key_type_cd,  
  prod_variant_nat_key_nr,
  prod_variant_nr,
  gtin,
  prod_variant_name,
  prod_variant_type_cd,
  weight_based_fg,
  logistic_variant_type_cd,
  case_size_cnt,
  sales_variant_type_cd,
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
  'WAW_SLS' prod_variant_key_type_cd, 
  art.ctrcode || '|' || Cast(art.itemnr AS String) prod_variant_nat_key_nr,
  art.ctrcode || '|' || Cast(art.itemnr AS String) prod_variant_nr,
  NULL gtin,
  art.deutschtext prod_variant_name,
 'SALES_1' prod_variant_type_cd,
  itmo.weight_based_fg,
  NULL logistic_variant_type_cd,
  NULL case_size_cnt,
  CASE WHEN artgrupnr BETWEEN 10 AND 14 THEN 'FV'
          WHEN artgrupnr BETWEEN 20 AND 99 THEN 'FOOD'
          WHEN artgrupnr BETWEEN 100 AND 400 THEN 'NON FOOD'
          ELSE 'OTHER' 
  END sales_variant_type_cd,

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
    SELECT ctrcode ,artikelnr ,artgrupnr ,deutschtext ,artnrvier ,CAST(artnrvier AS NUMBER) AS itemnr ,extraction_tmsp ,packung ,unit_id
    FROM ${TEMP_DB}.t_wawi_precore_artikel_1
    QUALIFY Row_Number() OVER (PARTITION BY ctrcode, itemnr ORDER BY artikelnr) = 1
  ) AS art_1
LEFT OUTER JOIN
  (
    SELECT DISTINCT  ctrcode, Cast(Substring(c215_itemnr, 1, Length(c215_itemnr)-4) AS Number) AS itemnr
           ,Cast(c215_int_itemnr AS Number) AS c215_int_itemnr
   FROM ${TEMP_DB}.t_wawi_precore_t215_int_itemnr_1
  ) AS ii ON  art.ctrcode = ii.ctrcode AND art.itemnr = ii.itemnr
LEFT OUTER JOIN meta.t_product_key_1 AS ipk ON  Cast(ii.c215_int_itemnr AS String) = ipk.prod_nat_key_nr AND ipk.prod_key_type_cd IN ('CBX', 'FV') AND ipk.dwh_valid_fg
LEFT OUTER JOIN
 (
  SELECT DISTINCT itemno
  FROM ${TEMP_DB}.t_wawi_precore_eks_item_wawi_item_1
  ) AS eks ON  ii.c215_int_itemnr = eks.itemno
LEFT OUTER JOIN ${TEMP_DB}.t_wawi_precore_t271_packagetype_1 AS pt ON  art.ctrcode = pt.ctrcode AND art.packung = pt.c271_packdescript
LEFT OUTER JOIN
  (
    SELECT c664_item,ctrcode
    FROM ${TEMP_DB}.t_wawi_precore_t664_brokerage_item_1
    WHERE c664_std_flag = 1 AND c664_modset = 0
  ) AS ign
ON  art.itemnr = ign.c664_item  AND art.ctrcode = ign.ctrcode 
INNER JOIN (
            select
            ctrcode 
            ,Cast(Substring(artikelnr, 1, Length(artikelnr)-4) AS Number) as artikelnr 
            ,max (CASE WHEN gewichtsartikel = 1 THEN True ELSE gewichtsartikel END) as weight_based_fg 
            from ${TEMP_DB}.t_wawi_precore_artikelbestell_1 
            group by ctrcode, Cast(Substring(artikelnr, 1, Length(artikelnr)-4) AS Number)
           ) AS itmo 
        -- ON  art.ctrcode = itmo.ctrcode AND art.artikelnr = itmo.artikelnr
          ON art.ctrcode = itmo.ctrcode AND art.itemnr= itmo.artikelnr
INNER JOIN ${TEMP_DB}.t_wawi_precore_t277_unitfactors_1 AS unit_1 ON  art.ctrcode = unit.ctrcode AND art.unit_id = unit.c277_id
WHERE
  (
    ii.itemnr IS NULL /* No link to international item_1 number */
    OR
    (
            ipk.prod_sid IS NULL /* International number not found in international keys */
        AND eks.itemno IS NULL
    )
  )
;
