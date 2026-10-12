INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (
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
  dwh_load_id
)
SELECT
  CONCAT(art.ctrcode, '|', LTRIM(artnrvier, '0')) AS prod_nat_key_nr,
  'WAWI' AS prod_key_type_cd,
  CASE
    WHEN artgrupnr BETWEEN CAST('10' AS NUMERIC) AND CAST('899' AS NUMERIC)
    THEN 'ITEM'
    WHEN artgrupnr = CAST('996' AS NUMERIC)
    THEN 'ITEM'
    WHEN artgrupnr = CAST('991' AS NUMERIC)
    THEN 'VOUCHER'
    WHEN artgrupnr = CAST('997' AS NUMERIC)
    THEN 'CONSUMABLE'
    ELSE 'OTHER'
  END AS prod_type_cd,
  CASE
    WHEN artgrupnr BETWEEN CAST('10' AS NUMERIC) AND CAST('14' AS NUMERIC)
    THEN 'FV'
    WHEN artgrupnr BETWEEN CAST('20' AS NUMERIC) AND CAST('99' AS NUMERIC)
    THEN 'FOOD'
    WHEN artgrupnr BETWEEN CAST('100' AS NUMERIC) AND CAST('400' AS NUMERIC)
    THEN 'NON FOOD'
    WHEN artgrupnr = CAST('996' AS NUMERIC)
    THEN 'DEPOSIT'
  END AS item_type_cd,
  LTRIM(artnrvier, '0') AS prod_nr,
  deutschtext AS prod_name,
  bez_lang AS prod_descr,
  gueltig_ab AS prod_creation_dt,
  pt.c271_int_short AS packing_type_cd,
  CASE WHEN artgrupnr = CAST('991' AS NUMERIC) THEN TRUE ELSE FALSE END AS goods_on_consignment_fg,
  CASE WHEN NOT ign.c664_item IS NULL THEN TRUE ELSE FALSE END AS excl_from_vat_calc_fg,
  TRUE AS country_specific_prod_fg,
  'WAWI' AS source_system,
  art.extraction_tmsp AS extraction_dt,
  art.extraction_tmsp AS dwh_mapping_tmsp,
  0 AS tf_error_fg,
  0 AS deleted_fg,
  0 AS record_id,
  '${SRC_INPUT_TABLE}' AS filename,
  'WAWI_HQ' AS dwh_node_cd,
  '${LOAD_ID}' AS dwh_load_id
FROM (
  SELECT
    a.*,
    CAST(a.artnrvier AS NUMERIC) AS itemnr
  FROM ${temp_db}.t_wawi_precore_artikel AS a
  QUALIFY
    row_number() OVER (
      PARTITION BY a.ctrcode, itemnr
      ORDER BY IF(a.artikelnr IS NULL, 0, 1) DESC, a.artikelnr
    ) = 1
) AS art
LEFT OUTER JOIN (
  SELECT DISTINCT
    t_wawi_precore_t215_int_itemnr.ctrcode,
    round(
      CAST(substr(
        t_wawi_precore_t215_int_itemnr.c215_itemnr,
        1,
        CAST(length(t_wawi_precore_t215_int_itemnr.c215_itemnr) - 4 AS INT64)
      ) AS NUMERIC),
      0
    ) AS itemnr,
    CAST(t_wawi_precore_t215_int_itemnr.c215_int_itemnr AS NUMERIC) AS c215_int_itemnr
  FROM ${temp_db}.t_wawi_precore_t215_int_itemnr
) AS ii
  ON art.ctrcode = ii.ctrcode AND art.itemnr = ii.itemnr
LEFT OUTER JOIN meta.t_product_key AS ipk
  ON substr(CAST(ii.c215_int_itemnr AS STRING), 1, 16777216) = ipk.prod_nat_key_nr
  AND ipk.prod_key_type_cd IN ('CBX', 'FV')
  AND ipk.dwh_valid_fg
LEFT OUTER JOIN (
  SELECT DISTINCT
    t_wawi_precore_eks_item_wawi_item.itemno
  FROM ${temp_db}.t_wawi_precore_eks_item_wawi_item
) AS eks
  ON ii.c215_int_itemnr = eks.itemno
LEFT OUTER JOIN ${temp_db}.t_wawi_precore_t271_packagetype AS pt
  ON art.ctrcode = pt.ctrcode AND art.packung = pt.c271_packdescript
LEFT OUTER JOIN (
  SELECT DISTINCT
    t_wawi_precore_t664_brokerage_item.ctrcode,
    t_wawi_precore_t664_brokerage_item.c664_item
  FROM ${temp_db}.t_wawi_precore_t664_brokerage_item
  WHERE
    t_wawi_precore_t664_brokerage_item.c664_std_flag = 1
    AND t_wawi_precore_t664_brokerage_item.c664_modset = 0
) AS ign
  ON art.ctrcode = ign.ctrcode AND art.itemnr = ign.c664_item
WHERE
  (
    ii.itemnr IS NULL
    OR /* No link to international item number */ ipk.prod_sid IS NULL
    AND /* International number not found in international keys */ eks.itemno IS NULL
  )
  AND NOT deutschtext IS NULL;

/* temporary fix due to data masking */;