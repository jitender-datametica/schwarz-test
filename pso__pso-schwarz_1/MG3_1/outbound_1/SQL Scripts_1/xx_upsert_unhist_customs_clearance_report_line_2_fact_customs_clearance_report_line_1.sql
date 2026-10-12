INSERT INTO szd_producton.${temp_db}.${src2tgt_temp_table1}_${src_context_area} (
  movement_ref_number,
  item_position,
  clearance_dt,
  cy_month,
  authority_country_location_sid,
  consignor_party_sid,
  importer_party_sid,
  importer_number,
  declarant_party_sid,
  acceptance_dt,
  declarant_number,
  declarant_name,
  declarant_authorized_fg,
  customs_declaration_type_cd,
  customs_procedure_cd,
  customs_preference_cd,
  origin_country_location_sid,
  origin_iso_country_cd,
  customs_product_sid,
  customs_tariff_number_cd,
  customs_product_number,
  article_variant_nr,
  goods_descr,
  trader_reference,
  curr_cd,
  vat_paid_val,
  duty_paid_val,
  net_weight_meas,
  customs_val,
  preference_indicator_txt,
  allocation_cnt,
  package_cnt,
  item_cnt,
  batch_nr_txt,
  dwh_mapping_tmsp,
  dwh_src_file_name,
  dwh_src_1_tmsp,
  tf_error_fg,
  dwh_load_id,
  record_id,
  filename,
  deleted_fg
)
SELECT DISTINCT
  crl.movement_ref_number,
  crl.item_position,
  ccr.clearance_dt,
  cd.cy_month,
  ccr.authority_country_location_sid,
  ccr.consignor_party_sid,
  ccr.importer_party_sid,
  imp.importer_nr,
  coalesce(
    ccr.broker_declarant_party_sid,
    ccr.importer_declarant_party_sid,
    -CAST('1' AS NUMERIC)
  ) AS declarant_party_sid,
  ccr.acceptance_dt,
  dcl.declarant_nr,
  dcl.declarant_name,
  dcl.declarant_authorized_fg,
  ccr.customs_declaration_type_cd,
  crl.customs_procedure_cd,
  crl.customs_preference_cd,
  crl.origin_country_location_sid,
  ocp.iso_country_cd AS origin_iso_country_cd,
  crl.customs_product_sid,
  coalesce(crl.customs_tariff_code_cd, cpr.customs_tariff_number_cd) AS customs_tariff_number_cd, /* case when crl.customs_product_sid = -1
                  then crl.customs_tariff_code_cd
                  else cpr.customs_tariff_number_cd
              end as customs_tariff_number_cd, */
  coalesce(
    CASE
      WHEN length(cpr.customs_additional_cd) > CAST('0' AS NUMERIC)
      THEN CONCAT(cpr.customs_product_nr, '_', cpr.customs_additional_cd)
      ELSE CAST(cpr.customs_product_nr AS STRING)
    END,
    pnr.customs_product_nr,
    'Unknown'
  ) AS customs_product_number, /* coalesce(case when length(cpr.customs_additional_cd) > 0
                           then cpr.customs_product_nr || '_' || cpr.customs_additional_cd
                           else to_char(cpr.customs_product_nr)
                       end, 'Unknown') as customs_product_number, */
  col.article_variant_nr, /* case when crl.customs_product_sid = -1
                  then crl.goods_descr
                  else cpr.customs_product_name
              end as goods_descr, */
  coalesce(crl.goods_descr, cpr.customs_product_name) AS goods_descr,
  ccr.trader_reference,
  'GBP' AS curr_cd,
  coalesce(crl.vat_paid_val, CAST('0' AS NUMERIC)) AS vat_paid_val,
  coalesce(crl.duty_paid_val, CAST('0' AS NUMERIC)) AS duty_paid_val,
  coalesce(crl.net_mass_qty, CAST('0' AS NUMERIC)) AS net_weight_meas,
  coalesce(crl.customs_val, CAST('0' AS NUMERIC)) AS customs_val,
  nullif(col.preference_indicator_txt, '') AS preference_indicator_txt,
  col.allocation_cnt,
  col.packages_cnt,
  col.item_cnt,
  col.batch_nr_txt,
  crl.dwh_src_1_tmsp AS dwh_mapping_tmsp,
  crl.dwh_src_file_name,
  crl.dwh_src_1_tmsp,
  CAST('0' AS NUMERIC) AS tf_error_fg,
  CAST('0' AS NUMERIC) AS dwh_load_id,
  CAST('0' AS NUMERIC) AS record_id,
  crl.dwh_src_file_name AS filename,
  CAST('0' AS NUMERIC) AS deleted_fg
FROM szd_production.core_rel.t_customs_clearance_report_line_1 AS crl
INNER JOIN szd_production.core_rel.t_customs_clearance_report_1 AS ccr
  ON crl.movement_ref_number = ccr.movement_ref_number
  AND crl.clearance_dt = ccr.clearance_dt
INNER JOIN szd_production.core.t_dim_cal_day_1 AS cd
  ON ccr.clearance_dt = cd.cal_dt
INNER JOIN szd_production.core.t_dim_declarant_1 AS dcl
  ON coalesce(
    ccr.broker_declarant_party_sid,
    ccr.importer_declarant_party_sid,
    -CAST('1' AS NUMERIC)
  ) = dcl.party_sid
  AND ccr.clearance_dt BETWEEN dcl.dwh_valid_from_tmsp AND dcl.dwh_valid_to_tmsp
INNER JOIN szd_production.core.t_dim_importer_1 AS imp
  ON ccr.importer_party_sid = imp.party_sid
  AND ccr.clearance_dt BETWEEN imp.dwh_valid_from_tmsp AND imp.dwh_valid_to_tmsp
INNER JOIN szd_production.core.t_dim_country_political_1 AS ocp
  ON crl.origin_country_location_sid = ocp.location_sid
LEFT OUTER JOIN szd_production.core.t_dim_customs_product_1 AS cpr
  ON crl.customs_product_sid = cpr.product_sid
  AND ccr.clearance_dt BETWEEN cpr.dwh_valid_from_tmsp AND cpr.dwh_valid_to_tmsp
LEFT OUTER JOIN (
  SELECT DISTINCT
    pnr_0.product_sid,
    CASE
      WHEN pnr_0.additional_cd = ''
      THEN pnr_0.customs_product_nr
      ELSE CONCAT(pnr_0.customs_product_nr, '_', pnr_0.additional_cd)
    END AS customs_product_nr,
    pnr_0.dwh_valid_from_tmsp,
    pnr_0.dwh_valid_to_tmsp
  FROM szd_production.core_rel.t_customs_product_1 AS pnr_0
) AS pnr
  ON crl.customs_product_sid = pnr.product_sid
  AND ccr.clearance_dt BETWEEN pnr.dwh_valid_from_tmsp AND pnr.dwh_valid_to_tmsp
LEFT OUTER JOIN (
  SELECT
    coll.trader_reference_nr,
    coll.item_position_seq,
    cpr_0.customs_product_type_cd,
    coll.customs_product_sid,
    CASE
      WHEN coll.additional_cd <> ''
      THEN CONCAT(coll.product_nr, '_', coll.additional_cd)
      ELSE coll.product_nr
    END AS customs_product_nr,
    coll.article_variant_nr,
    array_to_string(
      bqutil.fn.cw_array_stable_distinct(
        array_agg(
          cudo.customs_document_cd IGNORE NULLS ORDER BY IF(cudo.customs_document_cd IS NULL, 0, 1) DESC, cudo.customs_document_cd
        )
      ),
      '; '
    ) AS preference_indicator_txt,
    sum(coll.allocation_cnt) AS allocation_cnt,
    sum(coll.packages_cnt) AS packages_cnt,
    sum(coll.allocation_cnt * coll.packages_cnt) AS item_cnt,
    array_to_string(
      bqutil.fn.cw_array_stable_distinct(
        array_agg(
          coll.batch_nr IGNORE NULLS ORDER BY IF(coll.batch_nr IS NULL, 0, 1) DESC, coll.batch_nr
        )
      ),
      ', '
    ) AS batch_nr_txt
  FROM szd_production.core_rel.t_consignor_order_list_line_1 AS coll
  INNER JOIN szd_production.core_rel.t_customs_product_1 AS cpr_0
    ON coll.customs_product_sid = cpr_0.product_sid
    AND coll.order_dt BETWEEN cpr_0.dwh_valid_from_tmsp AND cpr_0.dwh_valid_to_tmsp
  LEFT OUTER JOIN szd_production.core_rel.t_consignor_order_list_line_document_rel_1 AS codr
    ON coll.trader_reference_nr = codr.trader_reference_nr
    AND coll.order_dt = codr.order_dt
    AND coll.item_position_seq = codr.item_position_seq
    AND codr.preference_indicator_fg = TRUE
  LEFT OUTER JOIN szd_production.core_rel.t_customs_document_1 AS cudo
    ON codr.resource_item_sid = cudo.resource_item_sid
  WHERE
    cpr_0.customs_product_type_cd = 'GTS'
  GROUP BY ALL
  UNION DISTINCT
  SELECT
    coll.trader_reference_nr,
    -CAST('1' AS NUMERIC) AS item_position_seq,
    cpr_0.customs_product_type_cd,
    coll.customs_product_sid,
    CASE
      WHEN coll.additional_cd <> ''
      THEN CONCAT(coll.product_nr, '_', coll.additional_cd)
      ELSE coll.product_nr
    END AS customs_product_nr,
    coll.article_variant_nr,
    array_to_string(
      bqutil.fn.cw_array_stable_distinct(
        array_agg(
          cudo.customs_document_cd IGNORE NULLS ORDER BY IF(cudo.customs_document_cd IS NULL, 0, 1) DESC, cudo.customs_document_cd
        )
      ),
      '; '
    ) AS preference_indicator_txt,
    sum(coll.allocation_cnt) / count(*) AS allocation_cnt,
    sum(coll.packages_cnt) / count(*) AS packages_cnt,
    sum(coll.allocation_cnt * coll.packages_cnt) / count(*) AS item_cnt,
    array_to_string(
      bqutil.fn.cw_array_stable_distinct(
        array_agg(
          coll.batch_nr IGNORE NULLS ORDER BY IF(coll.batch_nr IS NULL, 0, 1) DESC, coll.batch_nr
        )
      ),
      ', '
    ) AS batch_nr_txt
  FROM szd_production.core_rel.t_consignor_order_list_line_1 AS coll
  INNER JOIN szd_production.core_rel.t_customs_product_1 AS cpr_0
    ON coll.product_nr = cpr_0.customs_product_nr
    AND coll.additional_cd = cpr_0.additional_cd
    AND coll.origin_country_location_sid = cpr_0.origin_country_location_sid
    AND coll.order_dt BETWEEN cpr_0.dwh_valid_from_tmsp AND cpr_0.dwh_valid_to_tmsp
  LEFT OUTER JOIN szd_production.core_rel.t_consignor_order_list_line_document_rel_1 AS codr
    ON coll.trader_reference_nr = codr.trader_reference_nr
    AND coll.order_dt = codr.order_dt
    AND coll.item_position_seq = codr.item_position_seq
    AND codr.preference_indicator_fg = TRUE
  LEFT OUTER JOIN szd_production.core_rel.t_customs_document_1 AS cudo
    ON codr.resource_item_sid = cudo.resource_item_sid
  WHERE
    cpr_0.customs_product_type_cd = 'WWT'
  GROUP BY ALL
) AS col
  ON CASE
    WHEN ccr.trader_reference LIKE '%-SDI'
    THEN substr(
      ccr.trader_reference,
      1,
      CAST(length(ccr.trader_reference) - CAST('4' AS NUMERIC) AS INT64)
    )
    ELSE ccr.trader_reference
  END = col.trader_reference_nr
  AND CASE
    WHEN length(cpr.customs_additional_cd) > CAST('0' AS NUMERIC)
    THEN CONCAT(cpr.customs_product_nr, '_', cpr.customs_additional_cd)
    ELSE CAST(cpr.customs_product_nr AS STRING)
  END = col.customs_product_nr
  AND (
    crl.item_position = col.item_position_seq OR col.customs_product_type_cd = 'WWT'
  )
/* dcl.dwh_valid_fg and imp.dwh_valid_fg and ocp.dwh_valid_fg
    and coalesce(cpr.dwh_valid_fg,1) */
WHERE
  NOT ccr.trader_reference IS NULL;