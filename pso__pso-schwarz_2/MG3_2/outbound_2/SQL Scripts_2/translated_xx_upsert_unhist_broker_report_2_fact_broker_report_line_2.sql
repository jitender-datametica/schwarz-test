
-- WWT Data
 -- Consignor Data
 -- Broker Data
 -- GTS Data
 INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area}
(dwh_src_file_name, tf_error_fg, dwh_src_1_tmsp, deleted_fg, record_id, dwh_mapping_tmsp, filename, importer_party_sid,
 importer_name, importer_nr, dwh_load_id, movement_ref_number, broker_declarant_party_sid, customs_product_sid,
 customs_declaration_type_cd, authority_country_location_sid, origin_country_location_sid, customs_tariff_number_cd,
 trader_reference_nr, broker_tax_cd, consignor_tax_cd, alcoholic_beverage_pct, item_tariff_uom_cd, origin_country_cd,
 net_mass_meas, item_position_seq, gross_mass_meas, excise_payment_amount_val, customs_product_nr, first_deferment,
 alcoholic_beverage_adjusted_pct, broker_dt, excise_tax_rate_val, consignor_specified_qty, broker_declarant_nr,
 cds_acceptance_tmsp, broker_declarant_name, alcoholic_beverage_volume_qty, customs_product_descr, item_tariff_qty,
 item_piece_cnt, acceptance_tmsp, cds_clearance_tmsp)
(SELECT bd.dwh_src_file_name,
  0 AS tf_error_fg,
  bd.dwh_src_1_tmsp,
  CAST(0 AS BOOL) AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  bd.dwh_src_1_tmsp AS dwh_mapping_tmsp,
  bd.dwh_src_file_name AS filename,
  imp.party_sid AS importer_party_sid,
  imp.importer_name,
  imp.importer_number AS importer_nr,
  0 AS dwh_load_id,
  bd.movement_ref_number,
  COALESCE(brk.party_sid, - 1) AS broker_declarant_party_sid,
  bd.customs_product_sid,
  bd.customs_declaration_type_cd,
  bd.authority_country_location_sid,
  p.origin_country_location_sid,
  p.customs_tariff_code_cd AS customs_tariff_number_cd,
  bd.trader_reference_nr,
  COALESCE(bd.alcoholic_beverage_tax_rate_cd, '-1') AS broker_tax_cd,
  COALESCE(cd.alcoholic_beverage_tax_rate_cd, '-1') AS consignor_tax_cd,
  p.alcoholic_beverage_pct,
  COALESCE(UPPER(u.unit_cd), '-1') AS item_tariff_uom_cd,
  ocp.iso_country_cd AS origin_country_cd,
  bd.net_mass_meas,
  bd.item_position AS item_position_seq,
  bd.gross_mass_meas,
  bd.excise_payment_amount_val,
   CASE
   WHEN p.additional_cd <> ''
   THEN p.customs_product_nr || '_' || p.additional_cd
   ELSE p.customs_product_nr
   END AS customs_product_nr,
  bd.first_deferment,
  p.alcoholic_beverage_adjusted_pct,
  CAST(COALESCE(bd.cds_acceptance_tmsp, bd.acceptance_tmsp, bd.cds_clearance_tmsp) AS STRING) AS broker_dt,
  COALESCE(p.special_excise_rate_val, txr.excise_tax_rate_val) AS excise_tax_rate_val,
  CAST(cd.spec_meas AS STRING) AS consignor_specified_qty,
  brk.broker_number AS broker_declarant_nr,
  bd.cds_acceptance_tmsp,
  brk.broker_name AS broker_declarant_name,
  p.alcoholic_beverage_volume_qty,
  p.customs_product_name AS customs_product_descr,
  bd.item_tariff_qty,
  bd.item_piece_cnt,
  bd.acceptance_tmsp,
  bd.cds_clearance_tmsp
 FROM (SELECT CASE
     WHEN br.trader_reference LIKE '%-SDI'
     THEN SUBSTR(br.trader_reference, 1, LENGTH(br.trader_reference) - 4)
     ELSE br.trader_reference
     END AS trader_reference_nr,
    brl.customs_product_sid,
      (COUNT(*) OVER (PARTITION BY br.trader_reference, brl.customs_product_sid RANGE BETWEEN UNBOUNDED PRECEDING AND
       UNBOUNDED FOLLOWING)) = 1 AS unique_product_fg,
    brl.item_position,
    br.customs_declaration_type_cd,
    br.authority_country_location_sid,
    br.movement_ref_number,
    br.cds_acceptance_tmsp,
    br.acceptance_tmsp,
    br.cds_clearance_tmsp,
    br.importer_party_sid,
    br.broker_declarant_party_sid,
    br.first_deferment,
    brl.gross_mass_meas,
    brl.net_mass_meas,
    brl.item_piece_cnt,
    brl.item_tariff_qty,
    brl.item_tariff_qty_uom_id,
    brl.excise_payment_amount_val,
    brl.alcoholic_beverage_tax_rate_cd,
    br.dwh_src_1_tmsp,
    br.dwh_src_file_name
   FROM szd_production_core_rel.t_broker_report_2 AS br
    INNER JOIN szd_production_core_rel.t_broker_report_line_2 AS brl ON br.movement_ref_number = brl.movement_ref_number
     AND br.trader_reference = brl.trader_reference) AS bd
  INNER JOIN szd_production_core_rel.t_importer_2 AS imp ON bd.importer_party_sid = imp.party_sid
  INNER JOIN szd_production_core_rel.t_broker_2 AS brk ON bd.broker_declarant_party_sid = brk.party_sid
  INNER JOIN szd_production_core_rel.t_customs_product_2 AS p ON bd.customs_product_sid = p.product_sid AND COALESCE(bd.cds_acceptance_tmsp
     , bd.acceptance_tmsp, bd.cds_clearance_tmsp) BETWEEN p.dwh_valid_from_tmsp AND p.dwh_valid_to_tmsp
  INNER JOIN szd_production_core_rel.t_country_political_2 AS ocp ON p.origin_country_location_sid = ocp.location_sid AND
    ocp.lang_cd = 'DE'
  LEFT JOIN szd_production_core_rel.t_unit_2 AS u ON bd.item_tariff_qty_uom_id = u.unit_id
  LEFT JOIN szd_production_core_rel.t_alcoholic_beverage_tax_rate_2 AS txr ON bd.alcoholic_beverage_tax_rate_cd = txr.alcoholic_beverage_tax_rate_cd
   
  LEFT JOIN (SELECT coll.trader_reference_nr,
     coll.customs_product_sid,
     coll.item_position_seq,
     ROW_NUMBER() OVER (PARTITION BY coll.trader_reference_nr ORDER BY coll.inbound_item_nr IS NULL, coll.inbound_item_nr
        ) AS item_position_ibd_seq,
     coll.alcoholic_beverage_tax_rate_cd,
     spc.spec_meas
    FROM szd_production_core_rel.t_consignor_order_list_line_2 AS coll
     LEFT JOIN szd_production_core_rel.t_consignor_order_list_line_specification_2 AS spc ON coll.trader_reference_nr =
         spc.trader_reference_nr AND coll.order_dt = spc.order_dt AND coll.item_position_seq = spc.item_position_seq AND
       spc.specification_seq = 1
    WHERE coll.customs_product_sid <> - 1
    UNION DISTINCT
    SELECT coll.trader_reference_nr,
     p.product_sid AS customs_product_sid,
     - 1 AS item_position_seq,
     - 1 AS item_position_ibd_seq,
     MAX(p.alcoholic_beverage_tax_rate_cd) AS alcoholic_beverage_tax_rate_cd,
     SUM(p.volume_unit_qty * coll.item_cnt) AS spec_meas
    FROM szd_production_core_rel.t_consignor_order_list_line_2 AS coll
     INNER JOIN szd_production_core_rel.t_customs_product_2 AS p ON coll.product_nr = p.customs_product_nr AND coll.additional_cd
          = p.additional_cd AND coll.origin_country_location_sid = p.origin_country_location_sid AND coll.order_dt
       BETWEEN CAST(p.dwh_valid_from_tmsp AS DATE) AND (CAST(p.dwh_valid_to_tmsp AS DATE))
    WHERE coll.product_sid <> - 1
    GROUP BY coll.trader_reference_nr,
     customs_product_sid) AS cd ON bd.trader_reference_nr = cd.trader_reference_nr AND bd.customs_product_sid = cd.customs_product_sid
      AND (bd.unique_product_fg OR cd.item_position_seq = - 1 OR bd.item_position = cd.item_position_seq OR bd.item_position
       = cd.item_position_ibd_seq)
 QUALIFY (ROW_NUMBER() OVER (PARTITION BY bd.trader_reference_nr, bd.movement_ref_number, bd.item_position ORDER BY CASE
        WHEN bd.item_position = cd.item_position_seq
        THEN 1
        WHEN bd.item_position = cd.item_position_ibd_seq
        THEN 2
        ELSE NULL
        END IS NULL, CASE
        WHEN bd.item_position = cd.item_position_seq
        THEN 1
        WHEN bd.item_position = cd.item_position_ibd_seq
        THEN 2
        ELSE NULL
        END)) = 1);