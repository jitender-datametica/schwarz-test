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
  art.wawi_instanz_kzl || '|' || LTRIM(artnrvier,'0') prod_nat_key_nr,
  'WAWI' prod_key_type_cd, 
  'WAW_SLS' prod_variant_key_type_cd, 
  LEFT(art.wawi_instanz_kzl,2) || '|' || Cast(art.itemnr AS String) prod_variant_nat_key_nr,
  LEFT(art.wawi_instanz_kzl,2) || '|' || Cast(art.itemnr AS String) prod_variant_nr,
  NULL gtin,
  art.deutschtext prod_variant_name,
 'SALES' prod_variant_type_cd,
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
    SELECT wawi_instanz_kzl ,artikelnr ,artgrupnr ,deutschtext ,artnrvier ,CAST(artnrvier AS NUMBER) AS itemnr ,extraction_tmsp ,packung ,unit_id
    FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.artikel
    WHERE delete_fg IS NULL         
    QUALIFY Row_Number() OVER (PARTITION BY wawi_instanz_kzl, itemnr ORDER BY artikelnr) = 1
  ) AS art
LEFT OUTER JOIN
  (
    SELECT DISTINCT  wawi_instanz_kzl, Cast(Substring(c215_itemnr, 1, Length(c215_itemnr)-4) AS Number) AS itemnr
           ,Cast(c215_int_itemnr AS Number) AS c215_int_itemnr
    FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.t215_int_itemnr
    WHERE delete_fg IS NULL           
  ) AS ii ON  art.wawi_instanz_kzl = ii.wawi_instanz_kzl AND art.itemnr = ii.itemnr
LEFT OUTER JOIN meta.t_product_key AS ipk ON  Cast(ii.c215_int_itemnr AS String) = ipk.prod_nat_key_nr AND ipk.prod_key_type_cd IN ('CBX', 'FV') AND ipk.dwh_valid_fg
LEFT OUTER JOIN
 (
  SELECT DISTINCT itemno
  FROM etl.t_tcache_eks_item_wawi_item
  ) AS eks ON  ii.c215_int_itemnr = eks.itemno
LEFT OUTER JOIN ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.t271_packagetype AS pt ON  art.wawi_instanz_kzl = pt.wawi_instanz_kzl AND art.packung = pt.c271_packdescript
                                                                                         AND pt.delete_fg IS NULL           
LEFT OUTER JOIN
  (
    SELECT c664_item,wawi_instanz_kzl
    FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.t664_brokerage_item
    WHERE c664_std_flag = 1 AND c664_modset = 0 AND delete_fg IS NULL         
  ) AS ign
ON  art.itemnr = ign.c664_item  AND art.wawi_instanz_kzl = ign.wawi_instanz_kzl 
INNER JOIN (
            select
            wawi_instanz_kzl 
            ,Cast(Substring(artikelnr, 1, Length(artikelnr)-4) AS Number) as artikelnr 
            ,max (CASE WHEN gewichtsartikel = 1 THEN True ELSE gewichtsartikel END) as weight_based_fg 
            FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.artikelbestell 
            WHERE delete_fg IS NULL             
            group by wawi_instanz_kzl, Cast(Substring(artikelnr, 1, Length(artikelnr)-4) AS Number)
           ) AS itmo 
        -- ON  art.wawi_instanz_kzl = itmo.wawi_instanz_kzl AND art.artikelnr = itmo.artikelnr
          ON art.wawi_instanz_kzl = itmo.wawi_instanz_kzl AND art.itemnr= itmo.artikelnr
INNER JOIN ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.t277_unitfactors AS unit 
           ON  art.wawi_instanz_kzl = unit.wawi_instanz_kzl AND art.unit_id = unit.c277_id AND unit.delete_fg IS NULL
WHERE
  (
    ii.itemnr IS NULL /* No link to international item number */
    OR
    (
            ipk.prod_sid IS NULL /* International number not found in international keys */
        AND eks.itemno IS NULL
    )
  )
;
