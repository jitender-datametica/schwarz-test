-- max(coll.net_val_curr_cd) as consignor_invoice_curr_cd,
 -- WWT Documents
 -- Trader Reference Missing

-- Consignor Documents
 -- Consignor Documents
 -- Broker Document List
 -- WWT Data
 -- Consignor Data
 -- WWT Data

-- Missing Documents
 -- GTS Data
 -- Consignor Document List
 -- GTS Data
 -- Consignor Data

-- max(coll.net_val_curr_cd) as consignor_invoice_curr_cd,
 -- GTS Documents
 -- GTS Documents
 -- Broker Data

-- Broker Documents
 -- WWT Documents
 INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area}
(dwh_src_file_name, tf_error_fg, dwh_src_1_tmsp, deleted_fg, record_id, dwh_mapping_tmsp, filename, dwh_load_id,
 broker_declarant_party_sid, customs_product_sid, customs_declaration_type_cd, consignor_party_sid,
 authority_country_location_sid, broker_line_cnt, original_consignor_party_sid, trader_reference_nr, report_dt,
 movement_ref_number_txt, article_variant_nr_txt, consignor_line_cnt, item_position_txt, customs_product_nr,
 customs_product_descr, consignor_commodity_code_nr, cds_document_codes_txt, consignor_invoice_amount_val,
 cds_invoice_curr_cd, cds_net_mass_meas, consignor_product_missing_cnt, consignor_trader_reference_missing_cnt,
 different_invoice_curr_cnt, incoterm_cd, different_country_of_origin_cnt, broker_product_missing_cnt,
 invalid_consignor_cnt, different_invoice_amount_cnt, consignor_net_mass_meas, broker_commodity_code_nr,
 broker_country_of_origin_cd, different_net_mass_cnt, missing_document_codes_txt, consignor_country_of_origin_cd,
 broker_trader_reference_missing_cnt, consignor_invoice_curr_cd, invalid_importer_cnt, correct_line_cnt,
 missing_document_codes_cnt, consignor_origin_country_location_sid, invalid_incoterm_cnt,
 broker_origin_country_location_sid, consignor_document_codes_txt, different_commodity_code_cnt, cds_invoice_amount_val
 )
(SELECT DISTINCT t54.dwh_src_file_name,
  t54.tf_error_fg,
  t54.dwh_src_1_tmsp,
   t54.deleted_fg <> 0 AS deleted_fg,
  CAST(t54.record_id AS STRING) AS record_id,
  t54.dwh_mapping_tmsp,
  t54.filename,
  t54.dwh_load_id,
  t54.broker_declarant_party_sid,
  t54.customs_product_sid,
  t54.customs_declaration_type_cd,
  t54.consignor_party_sid,
  t54.authority_country_location_sid,
  t54.broker_line_cnt,
  t54.original_consignor_party_sid,
  t54.trader_reference_nr0 AS trader_reference_nr,
  CAST(t54.report_dt AS DATE) AS report_dt,
  t54.movement_ref_number_txt,
  t54.article_variant_nr_txt,
  t54.consignor_line_cnt,
  t54.item_position_txt,
  t54.customs_product_nr0 AS customs_product_nr,
  t54.customs_product_descr,
  t54.consignor_commodity_code_nr,
  t54.cds_document_codes_txt,
  CAST(t54.consignor_invoice_amount_val AS STRING) AS consignor_invoice_amount_val,
  t54.cds_invoice_curr_cd,
  CAST(t54.cds_net_mass_meas AS STRING) AS cds_net_mass_meas,
  CAST(t54.consignor_product_missing_cnt AS STRING) AS consignor_product_missing_cnt,
  CAST(t54.consignor_trader_reference_missing_cnt AS STRING) AS consignor_trader_reference_missing_cnt,
  CAST(t54.different_invoice_curr_cnt AS STRING) AS different_invoice_curr_cnt,
  t54.incoterm_cd,
  CAST(t54.different_country_of_origin_cnt AS STRING) AS different_country_of_origin_cnt,
  CAST(t54.broker_product_missing_cnt AS STRING) AS broker_product_missing_cnt,
  CAST(t54.invalid_consignor_cnt AS STRING) AS invalid_consignor_cnt,
  CAST(t54.different_invoice_amount_cnt AS STRING) AS different_invoice_amount_cnt,
  CAST(t54.consignor_net_mass_meas AS STRING) AS consignor_net_mass_meas,
  t54.broker_commodity_code_nr,
  t54.broker_country_of_origin_cd,
  CAST(t54.different_net_mass_cnt AS STRING) AS different_net_mass_cnt,
  t54.missing_document_codes_txt,
  t54.consignor_country_of_origin_cd,
  CAST(t54.broker_trader_reference_missing_cnt AS STRING) AS broker_trader_reference_missing_cnt,
  t54.consignor_invoice_curr_cd,
  CAST(t54.invalid_importer_cnt AS STRING) AS invalid_importer_cnt,
  CAST(t54.correct_line_cnt AS STRING) AS correct_line_cnt,
  CAST(t54.missing_document_codes_cnt AS STRING) AS missing_document_codes_cnt,
  CAST(t54.consignor_origin_country_location_sid AS STRING) AS consignor_origin_country_location_sid,
  CAST(t54.invalid_incoterm_cnt AS STRING) AS invalid_incoterm_cnt,
  CAST(t54.broker_origin_country_location_sid AS STRING) AS broker_origin_country_location_sid,
  t54.consignor_document_codes_txt,
  CAST(t54.different_commodity_code_cnt AS STRING) AS different_commodity_code_cnt,
  CAST(t54.cds_invoice_amount_val AS STRING) AS cds_invoice_amount_val
 FROM (SELECT DISTINCT COALESCE(bd.authority_country_location_sid, cd.authority_country_location_sid) AS
    authority_country_location_sid,
    COALESCE(bd.report_dt, CAST(cd.report_dt AS DATETIME)) AS report_dt,
    COALESCE(cd.original_consignor_party_sid, - 1) AS original_consignor_party_sid,
    COALESCE(bd.broker_declarant_party_sid, - 1) AS broker_declarant_party_sid,
    COALESCE(bd.consignor_party_sid, cd.consignor_party_sid) AS consignor_party_sid,
    COALESCE(bd.customs_declaration_type_cd, '-1') AS customs_declaration_type_cd,
    COALESCE(bd.trader_reference_nr, cd.trader_reference_nr) AS trader_reference_nr0,
    COALESCE(bd.customs_product_sid, cd.customs_product_sid) AS customs_product_sid,
    COALESCE(bd.customs_product_nr, cd.customs_product_nr) AS customs_product_nr0,
    COALESCE(bd.customs_product_name, cd.customs_product_name) AS customs_product_descr,
    COALESCE(cd.article_variant_nr_txt, 'Unknown') AS article_variant_nr_txt,
    COALESCE(bd.movement_ref_number_txt, trm.movement_ref_number_txt, 'Unknown') AS movement_ref_number_txt,
    COALESCE(bd.item_position_txt, cd.item_position_txt, 'Unknown') AS item_position_txt,
    COALESCE(bd.broker_line_cnt, 0) AS broker_line_cnt,
    COALESCE(cd.consignor_line_cnt, 0) AS consignor_line_cnt,
     CASE
     WHEN bd.customs_product_nr = cd.customs_product_nr AND bd.commodity_code_nr = cd.commodity_code_nr AND bd.country_of_origin_cd
            = cd.country_of_origin_cd AND bd.cds_net_mass_meas = cd.consignor_net_mass_meas AND bd.cds_invoice_amount_val
          = cd.consignor_invoice_amount_val AND NOT trm.broker_missing_fg AND NOT trm.consignor_missing_fg
     THEN CAST(bd.broker_line_cnt AS INTEGER)
     ELSE 0
     END AS correct_line_cnt,
     CASE
     WHEN bd.consignor_stream_cd = 'EXTERNAL'
     THEN 1
     ELSE 0
     END AS invalid_consignor_cnt,
     CASE
     WHEN bd.importer_party_sid = - 1
     THEN 1
     ELSE 0
     END AS invalid_importer_cnt,
     CASE
     WHEN trm.broker_missing_fg
     THEN CAST(cd.consignor_line_cnt AS INTEGER)
     ELSE 0
     END AS broker_trader_reference_missing_cnt,
     CASE
     WHEN trm.consignor_missing_fg
     THEN CAST(bd.broker_line_cnt AS INTEGER)
     ELSE 0
     END AS consignor_trader_reference_missing_cnt,
     CASE
     WHEN bd.customs_product_nr IS NULL AND NOT trm.broker_missing_fg AND NOT trm.consignor_missing_fg
     THEN CAST(cd.consignor_line_cnt AS INTEGER)
     ELSE 0
     END AS broker_product_missing_cnt,
     CASE
     WHEN cd.customs_product_nr IS NULL AND NOT trm.broker_missing_fg AND NOT trm.consignor_missing_fg
     THEN CAST(bd.broker_line_cnt AS INTEGER)
     ELSE 0
     END AS consignor_product_missing_cnt,
     CASE
     WHEN bd.customs_product_nr = cd.customs_product_nr AND bd.commodity_code_nr <> cd.commodity_code_nr AND NOT trm.broker_missing_fg
        AND NOT trm.consignor_missing_fg
     THEN CAST(bd.broker_line_cnt AS INTEGER)
     ELSE 0
     END AS different_commodity_code_cnt,
    COALESCE(bd.commodity_code_nr, 'Unknown') AS broker_commodity_code_nr,
    COALESCE(cd.commodity_code_nr, 'Unknown') AS consignor_commodity_code_nr,
     CASE
     WHEN bd.customs_product_nr = cd.customs_product_nr AND bd.country_of_origin_cd <> cd.country_of_origin_cd AND NOT
       trm.broker_missing_fg AND NOT trm.consignor_missing_fg
     THEN CAST(bd.broker_line_cnt AS INTEGER)
     ELSE 0
     END AS different_country_of_origin_cnt,
    COALESCE(bd.origin_country_location_sid, - 1) AS broker_origin_country_location_sid,
    COALESCE(bd.country_of_origin_cd, 'Unknown') AS broker_country_of_origin_cd,
    COALESCE(cd.origin_country_location_sid, - 1) AS consignor_origin_country_location_sid,
    COALESCE(cd.country_of_origin_cd, 'Unknown') AS consignor_country_of_origin_cd,
     CASE
     WHEN bd.customs_product_nr = cd.customs_product_nr AND bd.cds_net_mass_meas <> cd.consignor_net_mass_meas AND NOT
       trm.broker_missing_fg AND NOT trm.consignor_missing_fg
     THEN CAST(bd.broker_line_cnt AS INTEGER)
     ELSE 0
     END AS different_net_mass_cnt,
    bd.cds_net_mass_meas,
    cd.consignor_net_mass_meas,
     CASE
     WHEN bd.customs_product_nr = cd.customs_product_nr AND bd.cds_invoice_amount_val <> cd.consignor_invoice_amount_val
          AND NOT trm.broker_missing_fg AND NOT trm.consignor_missing_fg
     THEN CAST(bd.broker_line_cnt AS INTEGER)
     ELSE 0
     END AS different_invoice_amount_cnt,
    bd.cds_invoice_amount_val,
    cd.consignor_invoice_amount_val,
     CASE
     WHEN bd.customs_product_nr = cd.customs_product_nr AND bd.cds_invoice_curr_cd <> cd.consignor_invoice_curr_cd AND
       NOT trm.broker_missing_fg AND NOT trm.consignor_missing_fg
     THEN CAST(bd.broker_line_cnt AS INTEGER)
     ELSE 0
     END AS different_invoice_curr_cnt,
    bd.cds_invoice_curr_cd,
    cd.consignor_invoice_curr_cd,
    COALESCE(md.missing_document_codes_cnt, 0) AS missing_document_codes_cnt,
    bdl.broker_document_codes_txt AS cds_document_codes_txt,
    cdl.conisgnor_document_codes_txt AS consignor_document_codes_txt,
    md.missing_document_codes_txt,
     CASE
     WHEN bd.trade_terms <> 'DAP'
     THEN 1
     ELSE 0
     END AS invalid_incoterm_cnt,
    bd.trade_terms AS incoterm_cd,
    COALESCE(bd.dwh_src_1_tmsp, cd.dwh_src_1_tmsp) AS dwh_mapping_tmsp,
    COALESCE(bd.dwh_src_file_name, cd.dwh_src_file_name) AS dwh_src_file_name,
    COALESCE(bd.dwh_src_1_tmsp, cd.dwh_src_1_tmsp) AS dwh_src_1_tmsp,
    0 AS tf_error_fg,
    0 AS dwh_load_id,
    0 AS record_id,
    COALESCE(bd.dwh_src_file_name, cd.dwh_src_file_name) AS filename,
    0 AS deleted_fg,
    bd.trader_reference_nr,
    cd.trader_reference_nr AS trader_reference_nr1,
    bd.customs_product_nr,
    cd.customs_product_nr AS customs_product_nr1,
    bd.commodity_code_nr,
    cd.commodity_code_nr AS commodity_code_nr0
   FROM (SELECT br.authority_country_location_sid,
      br.broker_declarant_party_sid,
      COALESCE(cr.consignor_party_sid, br.consignor_party_sid) AS consignor_party_sid,
      COALESCE(cr.customs_declaration_type_cd, br.customs_declaration_type_cd) AS customs_declaration_type_cd,
       CASE
       WHEN br.trader_reference LIKE '%-SDI'
       THEN SUBSTR(br.trader_reference, 1, LENGTH(br.trader_reference) - 4)
       ELSE br.trader_reference
       END AS trader_reference_nr,
      DATETIME_TRUNC(COALESCE(CAST(NULLIF(br.cds_acceptance_dt, DATE '1900-01-01') AS DATETIME), br.acceptance_tmsp, CAST(br.cds_clearance_dt AS DATETIME)
        ), dd) AS report_dt,
      p.product_sid AS customs_product_sid,
       CASE
       WHEN p.additional_cd <> ''
       THEN p.customs_product_nr || '_' || p.additional_cd
       ELSE p.customs_product_nr
       END AS customs_product_nr,
      p.customs_tariff_code_cd AS commodity_code_nr,
      p.origin_country_location_sid,
      c.iso_country_cd AS country_of_origin_cd,
      MAX(cg.consignor_stream_cd) AS consignor_stream_cd,
      MAX(COALESCE(cr.importer_party_sid, br.importer_party_sid)) AS importer_party_sid,
      MAX(p.customs_product_name) AS customs_product_name,
      STRING_AGG(DISTINCT br.movement_ref_number, ', ' ORDER BY br.movement_ref_number IS NULL, br.movement_ref_number)
      AS movement_ref_number_txt,
      STRING_AGG(DISTINCT CAST(brl.item_position AS STRING), ', ' ORDER BY brl.item_position IS NULL, brl.item_position
       ) AS item_position_txt,
      ROUND(SUM(brl.net_mass_meas), 2) AS broker_net_mass_meas,
      ROUND(SUM(crl.net_mass_qty), 2) AS cds_net_mass_meas,
      CAST(ROUND(SUM(brl.charge_amount_val), 0) AS INTEGER) AS broker_invoice_amount_val,
      CAST(ROUND(SUM(crl.item_price), 0) AS INTEGER) AS cds_invoice_amount_val,
      MAX(brl.charge_amount_curr_cd) AS broker_invoice_curr_cd,
      MAX(cr.invoice_trust_curr_cd) AS cds_invoice_curr_cd,
      MAX(br.trade_terms) AS trade_terms,
      COUNT(*) AS broker_line_cnt,
      br.dwh_src_file_name,
      br.dwh_src_1_tmsp
     FROM szd_production_core_rel.t_broker_report AS br
      INNER JOIN szd_production_core_rel.t_broker_report_line AS brl ON br.movement_ref_number = brl.movement_ref_number
         AND br.trader_reference = brl.trader_reference
      INNER JOIN szd_production_core_rel.t_customs_product AS p ON brl.customs_product_sid = p.product_sid AND COALESCE(br
         .cds_acceptance_tmsp, br.acceptance_tmsp, br.cds_clearance_tmsp) BETWEEN p.dwh_valid_from_tmsp AND p.dwh_valid_to_tmsp
        
      INNER JOIN szd_production_core_rel.t_country_political AS c ON p.origin_country_location_sid = c.location_sid AND
         COALESCE(br.cds_acceptance_tmsp, br.acceptance_tmsp, br.cds_clearance_tmsp) BETWEEN c.dwh_valid_from_tmsp AND c
         .dwh_valid_to_tmsp AND c.lang_cd = 'DE'
      LEFT JOIN szd_production_core_rel.t_customs_clearance_report AS cr ON br.movement_ref_number = cr.movement_ref_number
         AND (br.trader_reference = cr.trader_reference OR brl.invoice_number = cr.trader_reference OR br.declaration_ucr
          LIKE '%' || cr.trader_reference || '%')
      LEFT JOIN szd_production_core_rel.t_customs_clearance_report_line AS crl ON cr.movement_ref_number = crl.movement_ref_number
          AND cr.clearance_dt = crl.clearance_dt AND brl.item_position = crl.item_position
      INNER JOIN szd_production_core_rel.t_consignor AS cg ON COALESCE(cr.consignor_party_sid, br.consignor_party_sid) =
        cg.party_sid AND COALESCE(br.cds_acceptance_tmsp, br.acceptance_tmsp, br.cds_clearance_tmsp) BETWEEN cg.dwh_valid_from_tmsp
        AND cg.dwh_valid_to_tmsp
     GROUP BY br.authority_country_location_sid,
      br.broker_declarant_party_sid,
      consignor_party_sid,
      customs_declaration_type_cd,
      trader_reference_nr,
      report_dt,
      customs_product_sid,
      customs_product_nr,
      commodity_code_nr,
      p.origin_country_location_sid,
      country_of_origin_cd,
      br.dwh_src_file_name,
      br.dwh_src_1_tmsp) AS bd
    FULL JOIN (SELECT 'GTS' AS customs_product_type_cd,
       col.original_consignor_party_sid,
       col.authority_country_location_sid,
       col.consignor_party_sid,
       col.trader_reference_nr,
       col.order_dt AS report_dt,
       p.product_sid AS customs_product_sid,
        CASE
        WHEN p.additional_cd <> ''
        THEN p.customs_product_nr || '_' || p.additional_cd
        ELSE p.customs_product_nr
        END AS customs_product_nr,
       p.customs_tariff_code_cd AS commodity_code_nr,
       p.origin_country_location_sid,
       c.iso_country_cd AS country_of_origin_cd,
       STRING_AGG(CAST(coll.item_position_seq AS STRING), ', ' ORDER BY coll.item_position_seq IS NULL, coll.item_position_seq
         ) AS item_position_txt,
       MAX(p.customs_product_name) AS customs_product_name,
       STRING_AGG(coll.article_variant_nr, ', ' ORDER BY coll.article_variant_nr IS NULL, coll.article_variant_nr) AS
       article_variant_nr_txt,
       ROUND(SUM(coll.net_weight_meas), 2) AS consignor_net_mass_meas,
       CAST(ROUND(SUM(coll.original_amount_val), 0) AS INTEGER) AS consignor_invoice_amount_val,
       MAX(coll.original_amount_curr_cd) AS consignor_invoice_curr_cd,
       COUNT(*) AS consignor_line_cnt,
       col.dwh_src_1_tmsp,
       col.dwh_src_file_name
      FROM szd_production_core_rel.t_consignor_order_list AS col
       INNER JOIN szd_production_core_rel.t_consignor_order_list_line AS coll ON col.trader_reference_nr = coll.trader_reference_nr
          AND col.order_dt = coll.order_dt
       INNER JOIN szd_production_core_rel.t_customs_product AS p ON coll.customs_product_sid = p.product_sid AND coll.order_dt
         BETWEEN CAST(p.dwh_valid_from_tmsp AS DATE) AND (CAST(p.dwh_valid_to_tmsp AS DATE))
       INNER JOIN szd_production_core_rel.t_country_political AS c ON coll.origin_country_location_sid = c.location_sid
         AND coll.order_dt BETWEEN CAST(c.dwh_valid_from_tmsp AS DATE) AND (CAST(c.dwh_valid_to_tmsp AS DATE)) AND c.lang_cd
          = 'DE'
      WHERE coll.customs_product_sid <> - 1
      GROUP BY col.original_consignor_party_sid,
       col.authority_country_location_sid,
       col.consignor_party_sid,
       col.trader_reference_nr,
       report_dt,
       customs_product_sid,
       customs_product_nr,
       commodity_code_nr,
       p.origin_country_location_sid,
       country_of_origin_cd,
       col.dwh_src_1_tmsp,
       col.dwh_src_file_name
      UNION DISTINCT
      SELECT 'WWT' AS customs_product_type_cd,
       col.original_consignor_party_sid,
       col.authority_country_location_sid,
       col.consignor_party_sid,
       col.trader_reference_nr,
       col.order_dt AS report_dt,
       cp.product_sid AS customs_product_sid,
        CASE
        WHEN cp.additional_cd <> ''
        THEN cp.customs_product_nr || '_' || cp.additional_cd
        ELSE cp.customs_product_nr
        END AS customs_product_nr,
       cp.customs_tariff_code_cd AS commodity_code_nr,
       cp.origin_country_location_sid,
       c.iso_country_cd AS country_of_origin_cd,
       CAST(NULL AS STRING) AS item_position_txt,
       MAX(cp.customs_product_name) AS customs_product_name,
       CAST(NULL AS STRING) AS article_variant_nr_txt,
       ROUND(SUM(coll.net_weight_meas), 2) AS consignor_net_mass_meas,
       CAST(ROUND(SUM(coll.net_val), 0) AS INTEGER) AS consignor_invoice_amount_val,
       MAX(coll.net_curr_cd) AS consignor_invoice_curr_cd,
       COUNT(*) AS consignor_line_cnt,
       col.dwh_src_1_tmsp,
       col.dwh_src_file_name
      FROM szd_production_core_rel.t_consignor_order_list AS col
       INNER JOIN szd_production_core_rel.t_consignor_order_list_line AS coll ON col.trader_reference_nr = coll.trader_reference_nr
           AND col.order_dt = coll.order_dt AND col.invoice_finance_sid = coll.invoice_finance_sid
       INNER JOIN szd_production_core_rel.t_country_political AS c ON coll.origin_country_location_sid = c.location_sid
         AND col.order_dt BETWEEN CAST(c.dwh_valid_from_tmsp AS DATE) AND (CAST(c.dwh_valid_to_tmsp AS DATE)) AND c.lang_cd
          = 'DE'
       INNER JOIN szd_production_core_rel.t_customs_product AS cp ON coll.product_nr = cp.customs_product_nr AND coll.additional_cd
             = cp.additional_cd AND cp.customs_product_type_cd = 'WWT' AND coll.origin_country_location_sid = cp.origin_country_location_sid
           AND col.order_dt BETWEEN CAST(cp.dwh_valid_from_tmsp AS DATE) AND (CAST(cp.dwh_valid_to_tmsp AS DATE))
       INNER JOIN szd_production_core_rel.t_invoice_status AS ist ON col.invoice_finance_sid = ist.invoice_finance_sid
        AND col.order_dt BETWEEN CAST(ist.dwh_valid_from_tmsp AS DATE) AND (CAST(ist.dwh_valid_to_tmsp AS DATE))
       INNER JOIN szd_production_core_rel.t_invoice_position AS inp ON coll.invoice_position_finance_sid = inp.finance_sid
          AND col.order_dt BETWEEN CAST(inp.dwh_valid_from_tmsp AS DATE) AND (CAST(inp.dwh_valid_to_tmsp AS DATE))
      WHERE coll.product_sid <> - 1
       AND ist.invoice_status_type_cd IN ('CHARGED', 'UNCHARGED')
       AND inp.reference_invoice_position_finance_sid = - 1
      GROUP BY col.original_consignor_party_sid,
       col.authority_country_location_sid,
       col.consignor_party_sid,
       col.trader_reference_nr,
       report_dt,
       customs_product_sid,
       customs_product_nr,
       commodity_code_nr,
       cp.origin_country_location_sid,
       country_of_origin_cd,
       col.dwh_src_1_tmsp,
       col.dwh_src_file_name) AS cd ON bd.trader_reference_nr = cd.trader_reference_nr AND bd.customs_product_nr = cd.customs_product_nr
      -- 11.10.2024--and bd.commodity_code_nr = cd.commodity_code_nr

    LEFT JOIN (SELECT COALESCE(bd.trader_reference_nr, cd.trader_reference_nr) AS trader_reference_nr,
      bd.movement_ref_number_txt,
      bd.trader_reference_nr IS NULL AS broker_missing_fg,
      cd.trader_reference_nr IS NULL AS consignor_missing_fg
     FROM (SELECT DISTINCT t12.trader_reference_nr,
        t12.movement_ref_number_txt
       FROM (SELECT br0.authority_country_location_sid,
          br0.broker_declarant_party_sid,
          COALESCE(cr0.consignor_party_sid, br0.consignor_party_sid) AS consignor_party_sid,
          COALESCE(cr0.customs_declaration_type_cd, br0.customs_declaration_type_cd) AS customs_declaration_type_cd,
           CASE
           WHEN br0.trader_reference LIKE '%-SDI'
           THEN SUBSTR(br0.trader_reference, 1, LENGTH(br0.trader_reference) - 4)
           ELSE br0.trader_reference
           END AS trader_reference_nr,
          DATETIME_TRUNC(COALESCE(CAST(NULLIF(br0.cds_acceptance_dt, DATE '1900-01-01') AS DATETIME), br0.acceptance_tmsp
            , CAST(br0.cds_clearance_dt AS DATETIME)), dd) AS report_dt,
          p.product_sid AS custom_product_sid,
           CASE
           WHEN p.additional_cd <> ''
           THEN p.customs_product_nr || '_' || p.additional_cd
           ELSE p.customs_product_nr
           END AS customs_product_nr,
          p.customs_tariff_code_cd AS commodity_code_nr,
          p.origin_country_location_sid,
          c0.iso_country_cd AS country_of_origin_cd,
          MAX(cg0.consignor_stream_cd) AS consignor_stream_cd,
          MAX(COALESCE(cr0.importer_party_sid, br0.importer_party_sid)) AS importer_party_sid,
          MAX(p.customs_product_name) AS customs_product_name,
          STRING_AGG(DISTINCT br0.movement_ref_number, ', ' ORDER BY br0.movement_ref_number IS NULL, br0.movement_ref_number
            ) AS movement_ref_number_txt,
          STRING_AGG(DISTINCT CAST(brl0.item_position AS STRING), ', ' ORDER BY brl0.item_position IS NULL, brl0.item_position
            ) AS item_position_txt,
          SUM(brl0.net_mass_meas),
          SUM(crl0.net_mass_qty),
          SUM(brl0.charge_amount_val),
          SUM(crl0.item_price),
          MAX(brl0.charge_amount_curr_cd) AS broker_invoice_curr_cd,
          MAX(cr0.invoice_trust_curr_cd) AS cds_invoice_curr_cd,
          MAX(br0.trade_terms) AS trade_terms,
          COUNT(*) AS broker_line_cnt
         FROM szd_production_core_rel.t_broker_report AS br0
          INNER JOIN szd_production_core_rel.t_broker_report_line AS brl0 ON br0.movement_ref_number = brl0.movement_ref_number
             AND br0.trader_reference = brl0.trader_reference
          INNER JOIN szd_production_core_rel.t_customs_product AS p ON brl0.customs_product_sid = p.product_sid AND
            COALESCE(br0.cds_acceptance_tmsp, br0.acceptance_tmsp, br0.cds_clearance_tmsp) BETWEEN p.dwh_valid_from_tmsp
            AND p.dwh_valid_to_tmsp
          INNER JOIN szd_production_core_rel.t_country_political AS c0 ON p.origin_country_location_sid = c0.location_sid
              AND COALESCE(br0.cds_acceptance_tmsp, br0.acceptance_tmsp, br0.cds_clearance_tmsp) BETWEEN c0.dwh_valid_from_tmsp
             AND c0.dwh_valid_to_tmsp AND c0.lang_cd = 'DE'
          LEFT JOIN szd_production_core_rel.t_customs_clearance_report AS cr0 ON br0.movement_ref_number = cr0.movement_ref_number
             AND (br0.trader_reference = cr0.trader_reference OR brl0.invoice_number = cr0.trader_reference OR br0.declaration_ucr
              LIKE '%' || cr0.trader_reference || '%')
          LEFT JOIN szd_production_core_rel.t_customs_clearance_report_line AS crl0 ON cr0.movement_ref_number = crl0.movement_ref_number
              AND cr0.clearance_dt = crl0.clearance_dt AND brl0.item_position = crl0.item_position
          INNER JOIN szd_production_core_rel.t_consignor AS cg0 ON COALESCE(cr0.consignor_party_sid, br0.consignor_party_sid
            ) = cg0.party_sid
         GROUP BY br0.authority_country_location_sid,
          br0.broker_declarant_party_sid,
          consignor_party_sid,
          customs_declaration_type_cd,
          trader_reference_nr,
          report_dt,
          custom_product_sid,
          customs_product_nr,
          commodity_code_nr,
          p.origin_country_location_sid,
          country_of_origin_cd) AS t12
       GROUP BY t12.trader_reference_nr,
        t12.movement_ref_number_txt) AS bd
      FULL JOIN (SELECT DISTINCT trader_reference_nr
       FROM (SELECT 'GTS' AS customs_product_type_cd,
           col.authority_country_location_sid,
           col.consignor_party_sid,
           col.trader_reference_nr,
           col.order_dt AS report_dt,
           p.product_sid AS customs_product_sid,
            CASE
            WHEN p.additional_cd <> ''
            THEN p.customs_product_nr || '_' || p.additional_cd
            ELSE p.customs_product_nr
            END AS customs_product_nr,
           p.customs_tariff_code_cd AS commodity_code_nr,
           p.origin_country_location_sid,
           c.iso_country_cd AS country_of_origin_cd,
           STRING_AGG(CAST(coll.item_position_seq AS STRING), ', ' ORDER BY coll.item_position_seq IS NULL, coll.item_position_seq
             ) AS item_position_txt,
           MAX(p.customs_product_name) AS customs_product_name,
           STRING_AGG(coll.article_variant_nr, ', ' ORDER BY coll.article_variant_nr IS NULL, coll.article_variant_nr)
           AS article_variant_nr_txt,
           ROUND(SUM(coll.net_weight_meas), 2) AS consignor_net_mass_meas,
           CAST(ROUND(SUM(coll.original_amount_val), 0) AS INTEGER) AS consignor_invoice_amount_val,
           MAX(coll.original_amount_curr_cd) AS consignor_invoice_curr_cd,
           COUNT(*) AS consignor_line_cnt
          FROM szd_production_core_rel.t_consignor_order_list AS col
           INNER JOIN szd_production_core_rel.t_consignor_order_list_line AS coll ON col.trader_reference_nr = coll.trader_reference_nr
              AND col.order_dt = coll.order_dt
           INNER JOIN szd_production_core_rel.t_customs_product AS p ON coll.customs_product_sid = p.product_sid AND p.customs_product_type_cd
               = 'GTS' AND coll.order_dt BETWEEN CAST(p.dwh_valid_from_tmsp AS DATE) AND (CAST(p.dwh_valid_to_tmsp AS DATE)
              )
           INNER JOIN szd_production_core_rel.t_country_political AS c ON coll.origin_country_location_sid = c.location_sid
               AND coll.order_dt BETWEEN CAST(c.dwh_valid_from_tmsp AS DATE) AND (CAST(c.dwh_valid_to_tmsp AS DATE)) AND
             c.lang_cd = 'DE'
          WHERE coll.customs_product_sid <> - 1
          GROUP BY col.authority_country_location_sid,
           col.consignor_party_sid,
           col.trader_reference_nr,
           report_dt,
           customs_product_sid,
           customs_product_nr,
           commodity_code_nr,
           p.origin_country_location_sid,
           country_of_origin_cd
          UNION DISTINCT
          SELECT 'WWT' AS customs_product_type_cd,
           col.authority_country_location_sid,
           col.consignor_party_sid,
           col.trader_reference_nr,
           col.order_dt AS report_dt,
           cp.product_sid AS customs_product_sid,
            CASE
            WHEN cp.additional_cd <> ''
            THEN cp.customs_product_nr || '_' || cp.additional_cd
            ELSE cp.customs_product_nr
            END AS customs_product_nr,
           cp.customs_tariff_code_cd AS commodity_code_nr,
           cp.origin_country_location_sid,
           c.iso_country_cd AS country_of_origin_cd,
           CAST(NULL AS STRING) AS item_position_txt,
           MAX(cp.customs_product_name) AS customs_product_name,
           CAST(NULL AS STRING) AS article_variant_nr_txt,
           ROUND(SUM(coll.net_weight_meas), 2) AS consignor_net_mass_meas,
           CAST(ROUND(SUM(coll.net_val), 0) AS INTEGER) AS consignor_invoice_amount_val,
           MAX(coll.net_curr_cd) AS consignor_invoice_curr_cd,
           COUNT(*) AS consignor_line_cnt
          FROM szd_production_core_rel.t_consignor_order_list AS col
           INNER JOIN szd_production_core_rel.t_consignor_order_list_line AS coll ON col.trader_reference_nr = coll.trader_reference_nr
               AND col.order_dt = coll.order_dt AND col.invoice_finance_sid = coll.invoice_finance_sid
           INNER JOIN szd_production_core_rel.t_country_political AS c ON coll.origin_country_location_sid = c.location_sid
               AND col.order_dt BETWEEN CAST(c.dwh_valid_from_tmsp AS DATE) AND (CAST(c.dwh_valid_to_tmsp AS DATE)) AND
             c.lang_cd = 'DE'
           INNER JOIN szd_production_core_rel.t_customs_product AS cp ON coll.product_nr = cp.customs_product_nr AND
                coll.additional_cd = cp.additional_cd AND cp.customs_product_type_cd = 'WWT' AND coll.origin_country_location_sid
               = cp.origin_country_location_sid AND col.order_dt BETWEEN CAST(cp.dwh_valid_from_tmsp AS DATE) AND (CAST(cp.dwh_valid_to_tmsp AS DATE)
              )
           INNER JOIN szd_production_core_rel.t_invoice_status AS ist ON col.invoice_finance_sid = ist.invoice_finance_sid
              AND col.order_dt BETWEEN CAST(ist.dwh_valid_from_tmsp AS DATE) AND (CAST(ist.dwh_valid_to_tmsp AS DATE))
           INNER JOIN szd_production_core_rel.t_invoice_position AS inp ON coll.invoice_position_finance_sid = inp.finance_sid
              AND col.order_dt BETWEEN CAST(inp.dwh_valid_from_tmsp AS DATE) AND (CAST(inp.dwh_valid_to_tmsp AS DATE))
          WHERE coll.product_sid <> - 1
           AND ist.invoice_status_type_cd IN ('CHARGED', 'UNCHARGED')
           AND inp.reference_invoice_position_finance_sid = - 1
          GROUP BY col.authority_country_location_sid,
           col.consignor_party_sid,
           col.trader_reference_nr,
           report_dt,
           customs_product_sid,
           customs_product_nr,
           commodity_code_nr,
           cp.origin_country_location_sid,
           country_of_origin_cd) AS t23) AS cd ON bd.trader_reference_nr = cd.trader_reference_nr) AS trm ON COALESCE(bd
      .trader_reference_nr, cd.trader_reference_nr) = trm.trader_reference_nr
    LEFT JOIN (SELECT cd.trader_reference_nr,
      cd.customs_product_sid,
      STRING_AGG(DISTINCT dc.customs_document_cd, ', ' ORDER BY dc.customs_document_cd IS NULL, dc.customs_document_cd)
      AS missing_document_codes_txt,
      COUNT(*) AS missing_document_codes_cnt
     FROM (SELECT coll.trader_reference_nr,
         coll.customs_product_sid,
         rel.resource_item_sid
        FROM szd_production_core_rel.t_consignor_order_list_line_document_rel AS rel
         INNER JOIN szd_production_core_rel.t_consignor_order_list_line AS coll ON rel.trader_reference_nr = coll.trader_reference_nr
             AND rel.order_dt = coll.order_dt AND rel.item_position_seq = coll.item_position_seq
        WHERE coll.customs_product_sid <> - 1
        UNION DISTINCT
        SELECT coll.trader_reference_nr,
         cpr.product_sid,
         0 AS resource_item_sid
        FROM szd_production_core_rel.t_consignor_order_list_line AS coll
         INNER JOIN szd_production_core_rel.t_customs_product AS cpr ON coll.product_nr = cpr.customs_product_nr AND
            coll.additional_cd = cpr.additional_cd AND coll.order_dt BETWEEN CAST(cpr.dwh_valid_from_tmsp AS DATE) AND (CAST(cpr.dwh_valid_to_tmsp AS DATE)
            )
         INNER JOIN szd_production_core_rel.t_customs_product_document_rel AS cpdr ON cpr.product_sid = cpdr.product_sid
            AND coll.order_dt BETWEEN CAST(cpdr.dwh_valid_from_tmsp AS DATE) AND (CAST(cpdr.dwh_valid_to_tmsp AS DATE))
        WHERE coll.customs_product_sid = - 1) AS cd
      INNER JOIN szd_production_core_rel.t_customs_document AS dc ON cd.resource_item_sid = dc.resource_item_sid
      LEFT JOIN (SELECT DISTINCT CASE
         WHEN br1.trader_reference LIKE '%-SDI'
         THEN SUBSTR(br1.trader_reference, 1, LENGTH(br1.trader_reference) - 4)
         ELSE CAST(br1.trader_reference AS STRING)
         END AS trader_reference_nr,
        brl1.customs_product_sid,
        drl.resource_item_sid
       FROM szd_production_core_rel.t_broker_report AS br1
        INNER JOIN szd_production_core_rel.t_broker_report_line AS brl1 ON br1.movement_ref_number = brl1.movement_ref_number
           AND br1.trader_reference = brl1.trader_reference
        INNER JOIN szd_production_core_rel.t_customs_clearance_report AS cr1 ON br1.movement_ref_number = cr1.movement_ref_number
           AND (br1.trader_reference = cr1.trader_reference OR brl1.invoice_number = cr1.trader_reference OR br1.declaration_ucr
            LIKE '%' || cr1.trader_reference || '%')
        INNER JOIN szd_production_core_rel.t_customs_clearance_report_line AS crl1 ON cr1.movement_ref_number = crl1.movement_ref_number
            AND cr1.clearance_dt = crl1.clearance_dt AND brl1.item_position = crl1.item_position
        INNER JOIN szd_production_core_rel.t_customs_clearance_report_line_document_rel AS drl ON crl1.movement_ref_number
           = drl.movement_ref_number AND crl1.item_position = drl.item_position) AS bd ON cd.trader_reference_nr = bd.trader_reference_nr
          AND cd.customs_product_sid = bd.customs_product_sid AND cd.resource_item_sid = bd.resource_item_sid
      LEFT JOIN szd_production_core_rel.t_customs_document AS bc ON bd.resource_item_sid = bc.resource_item_sid
     WHERE bd.resource_item_sid IS NULL
     GROUP BY cd.trader_reference_nr,
      cd.customs_product_sid) AS md ON COALESCE(bd.trader_reference_nr, cd.trader_reference_nr) = md.trader_reference_nr
       AND COALESCE(bd.customs_product_sid, cd.customs_product_sid) = md.customs_product_sid
    LEFT JOIN (SELECT bd.trader_reference_nr,
      bd.customs_product_sid,
      STRING_AGG(DISTINCT dc0.customs_document_cd, ', ' ORDER BY dc0.customs_document_cd IS NULL, dc0.customs_document_cd
        ) AS broker_document_codes_txt
     FROM (SELECT DISTINCT CASE
         WHEN br2.trader_reference LIKE '%-SDI'
         THEN SUBSTR(br2.trader_reference, 1, LENGTH(br2.trader_reference) - 4)
         ELSE CAST(br2.trader_reference AS STRING)
         END AS trader_reference_nr,
        brl2.customs_product_sid,
        drl0.resource_item_sid
       FROM szd_production_core_rel.t_broker_report AS br2
        INNER JOIN szd_production_core_rel.t_broker_report_line AS brl2 ON br2.movement_ref_number = brl2.movement_ref_number
           AND br2.trader_reference = brl2.trader_reference
        INNER JOIN szd_production_core_rel.t_customs_clearance_report AS cr2 ON br2.movement_ref_number = cr2.movement_ref_number
           AND (br2.trader_reference = cr2.trader_reference OR brl2.invoice_number = cr2.trader_reference OR br2.declaration_ucr
            LIKE '%' || cr2.trader_reference || '%')
        INNER JOIN szd_production_core_rel.t_customs_clearance_report_line AS crl2 ON cr2.movement_ref_number = crl2.movement_ref_number
            AND cr2.clearance_dt = crl2.clearance_dt AND brl2.item_position = crl2.item_position
        INNER JOIN szd_production_core_rel.t_customs_clearance_report_line_document_rel AS drl0 ON crl2.movement_ref_number
           = drl0.movement_ref_number AND crl2.item_position = drl0.item_position) AS bd
      INNER JOIN szd_production_core_rel.t_customs_document AS dc0 ON bd.resource_item_sid = dc0.resource_item_sid
     GROUP BY bd.trader_reference_nr,
      bd.customs_product_sid) AS bdl ON COALESCE(bd.trader_reference_nr, cd.trader_reference_nr) = bdl.trader_reference_nr
       AND COALESCE(bd.customs_product_sid, cd.customs_product_sid) = bdl.customs_product_sid
    LEFT JOIN (SELECT bd.trader_reference_nr,
      bd.customs_product_sid,
      STRING_AGG(DISTINCT dc1.customs_document_cd, ', ' ORDER BY dc1.customs_document_cd IS NULL, dc1.customs_document_cd
        ) AS conisgnor_document_codes_txt
     FROM (SELECT coll.trader_reference_nr,
         coll.customs_product_sid,
         rel.resource_item_sid
        FROM szd_production_core_rel.t_consignor_order_list_line_document_rel AS rel
         INNER JOIN szd_production_core_rel.t_consignor_order_list_line AS coll ON rel.trader_reference_nr = coll.trader_reference_nr
             AND rel.order_dt = coll.order_dt AND rel.item_position_seq = coll.item_position_seq
        WHERE coll.customs_product_sid <> - 1
        UNION DISTINCT
        SELECT coll.trader_reference_nr,
         cpr.product_sid,
         0 AS resource_item_sid
        FROM szd_production_core_rel.t_consignor_order_list_line AS coll
         INNER JOIN szd_production_core_rel.t_customs_product AS cpr ON coll.product_nr = cpr.customs_product_nr AND
            coll.additional_cd = cpr.additional_cd AND coll.order_dt BETWEEN CAST(cpr.dwh_valid_from_tmsp AS DATE) AND (CAST(cpr.dwh_valid_to_tmsp AS DATE)
            )
         INNER JOIN szd_production_core_rel.t_customs_product_document_rel AS cpdr ON cpr.product_sid = cpdr.product_sid
            AND coll.order_dt BETWEEN CAST(cpdr.dwh_valid_from_tmsp AS DATE) AND (CAST(cpdr.dwh_valid_to_tmsp AS DATE))
        WHERE coll.customs_product_sid = - 1) AS bd
      INNER JOIN szd_production_core_rel.t_customs_document AS dc1 ON bd.resource_item_sid = dc1.resource_item_sid
     GROUP BY bd.trader_reference_nr,
      bd.customs_product_sid) AS cdl ON COALESCE(bd.trader_reference_nr, cd.trader_reference_nr) = cdl.trader_reference_nr
       AND COALESCE(bd.customs_product_sid, cd.customs_product_sid) = cdl.customs_product_sid
   QUALIFY (ROW_NUMBER() OVER (PARTITION BY trader_reference_nr0, customs_product_nr0 ORDER BY CASE
          WHEN bd.commodity_code_nr = commodity_code_nr0
          THEN 0
          ELSE 1
          END IS NULL, CASE
          WHEN bd.commodity_code_nr = commodity_code_nr0
          THEN 0
          ELSE 1
          END)) = 1) AS t54);