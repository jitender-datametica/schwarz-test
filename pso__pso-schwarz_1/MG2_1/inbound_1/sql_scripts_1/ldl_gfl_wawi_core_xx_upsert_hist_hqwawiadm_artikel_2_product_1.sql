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
  LEFT(art.wawi_instanz_kzl, 2) || '|' || LTRIM(artnrvier,'0') prod_nat_key_nr,
  'WAWI' prod_key_type_cd,
  CASE
    WHEN artgrupnr BETWEEN 10 AND 899 THEN 'ITEM_1'
    WHEN artgrupnr = 996 THEN 'ITEM_1'
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
   SELECT
     Cast(artnrvier AS Number) AS itemnr,src.*
   FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.${SRC_INPUT_TABLE} src
   WHERE src.delete_fg IS NULL
   QUALIFY Row_Number() OVER (PARTITION BY src.wawi_instanz_kzl, artnrvier ORDER BY artikelnr) = 1

  ) AS art_1
LEFT OUTER JOIN
  (
    SELECT DISTINCT
        wawi_instanz_kzl
      , Cast(Substring(c215_itemnr, 1, Length(c215_itemnr)-4) AS Number) AS itemnr
      , Cast(c215_int_itemnr AS Number) AS c215_int_itemnr
    FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.t215_int_itemnr_1
    WHERE delete_fg IS NULL
  ) AS ii ON  art.wawi_instanz_kzl = ii.wawi_instanz_kzl AND art.itemnr = ii.itemnr
LEFT OUTER JOIN meta.t_product_key_1 AS ipk ON  Cast(ii.c215_int_itemnr AS String) = ipk.prod_nat_key_nr AND ipk.prod_key_type_cd IN ('CBX', 'FV')
                                               AND ipk.dwh_valid_fg
LEFT OUTER JOIN
  (
    SELECT DISTINCT itemno
    FROM etl.t_tcache_eks_item_wawi_item_1
  ) AS eks ON  ii.c215_int_itemnr = eks.itemno
LEFT OUTER JOIN ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.t271_packagetype_1 AS pt ON  art.wawi_instanz_kzl = pt.wawi_instanz_kzl AND art.packung = pt.c271_packdescript AND pt.delete_fg IS NULL
LEFT OUTER JOIN
  (
    SELECT DISTINCT wawi_instanz_kzl, c664_item
    FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.t664_brokerage_item_1
    WHERE c664_std_flag = 1 AND c664_modset = 0 AND delete_fg IS NULL
  ) AS ign ON  art.wawi_instanz_kzl = ign.wawi_instanz_kzl AND art.itemnr = ign.c664_item
WHERE (ii.itemnr IS NULL /* No link to international item_1 number */
      OR (ipk.prod_sid IS NULL /* International number not found in international keys */  AND eks.itemno IS NULL))
      AND deutschtext IS NOT NULL /* temporary fix due to data masking */
;
