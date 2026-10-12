
-- coalesce(bei.PGEMAT_TYPE = 'X', false) as roll_on_roll_off_fg,
 -- Insert from WWT Report
 -- container_nr_txt,

INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_src_file_name
 , tf_error_fg, dwh_src_1_tmsp, deleted_fg, record_id, dwh_mapping_tmsp, filename, consignor_party_sid,
 authority_country_location_sid, original_consignor_party_sid, trader_reference_nr, invoice_finance_sid, order_dt,
 ferry_country_location_sid, carrier_party_sid, shipment_nr, consignee_party_sid, packaging_list_nr, train_name,
 bill_of_leding_nr, loading_reference_nr, trailer_name, customs_office_party_sid, truck_country_location_sid, dispo_week
 , vessel_country_location_sid, truck_name, transport_route_type_cd, estimated_departure_dt,
 export_warehouse_resource_item_sid, ferry_name, trailer_country_location_sid, vessel_name, roll_on_roll_off_fg,
 inbound_delivery_nr, container_nr_txt, inbound_delivery_dt, departure_country_location_sid, train_country_location_sid
 , port_of_arrival_txt, transport_type_cd, transport_reference_nr, estimated_arrival_dt, purchase_order_nr)
(SELECT MAX(dwh_src_file_name),
  0 AS tf_error_fg,
  MAX(dwh_src_1_tmsp),
  CAST(0 AS BOOL) AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  CURRENT_TIMESTAMP() AS dwh_mapping_tmsp,
  MAX(dwh_src_file_name) AS filename,
  consignor_party_sid,
  authority_country_location_sid,
  original_consignor_party_sid,
  trader_reference_nr,
  invoice_finance_sid,
  order_dt,
  ferry_country_location_sid,
  carrier_party_sid,
  shipment_nr,
  consignee_party_sid,
  packaging_list_nr,
  train_name,
  bill_of_leding_nr,
  loading_reference_nr,
  trailer_name,
  customs_office_party_sid,
  truck_country_location_sid,
  dispo_week,
  vessel_country_location_sid,
  truck_name,
  transport_route_type_cd,
  estimated_departure_dt,
  export_warehouse_resource_item_sid,
  ferry_name,
  trailer_country_location_sid,
  vessel_name,
  roll_on_roll_off_fg,
  inbound_delivery_nr,
  MAX(CASE
    WHEN container_nr_txt = 'NULL'
    THEN NULL
    ELSE container_nr_txt
    END),
  inbound_delivery_dt,
  departure_country_location_sid,
  train_country_location_sid,
  port_of_arrival_txt,
  transport_type_cd,
  transport_reference_nr,
  estimated_arrival_dt,
  purchase_order_nr
 FROM (SELECT CAST(bei.corder AS STRING) AS trader_reference_nr,
     COALESCE(bei.etd, bei.etats) AS order_dt,
     ack.location_sid AS authority_country_location_sid,
     cpk.party_sid AS consignor_party_sid,
     COALESCE(opk.party_sid, - 1) AS original_consignor_party_sid,
     COALESCE(hpk.party_sid, - 1) AS carrier_party_sid,
     COALESCE(cek.party_sid, - 1) AS consignee_party_sid,
     - 1 AS export_warehouse_resource_item_sid,
     COALESCE(dlk.location_sid, - 1) AS departure_country_location_sid,
     COALESCE(cok.party_sid, - 1) AS customs_office_party_sid,
     - 1 AS invoice_finance_sid,
     COALESCE(tt.transport_type_cd, 'UNKNOWN') AS transport_type_cd,
     COALESCE(tt.transport_route_type_cd, 'BEFORE_EXPORT') AS transport_route_type_cd,
      CASE
      WHEN bei.vidar = 'NULL'
      THEN NULL
      ELSE bei.vidar
      END AS transport_reference_nr,
     CAST(NULL AS BIGNUMERIC) AS dispo_week,
     COALESCE(TRIM(bei.pgemat_type) = 'X', FALSE) AS roll_on_roll_off_fg,
     LTRIM(bei.refno_po_no, '0') AS purchase_order_nr,
      CASE
      WHEN bei.tknum = 'NULL'
      THEN NULL
      ELSE bei.tknum
      END AS shipment_nr,
     bei.nodfa AS port_of_arrival_txt,
     bei.etats AS estimated_arrival_dt,
     bei.etd AS estimated_departure_dt,
      CASE
      WHEN bei.y902_ext_id2 = 'NULL'
      THEN NULL
      ELSE bei.y902_ext_id2
      END AS bill_of_leding_nr,
      CASE
      WHEN bei.packing_list = 'NULL'
      THEN NULL
      ELSE bei.packing_list
      END AS packaging_list_nr,
      CASE
      WHEN STRPOS(bei.ext_id2, ';') > 0
      THEN SUBSTR(bei.ext_id2, 1, STRPOS(bei.ext_id2, ';') - 1)
      ELSE bei.ext_id2
      END AS container_nr_txt,
     COALESCE(vek.location_sid, - 1) AS vessel_country_location_sid,
      CASE
      WHEN bei.y030_ext_id2 = 'NULL'
      THEN NULL
      ELSE bei.y030_ext_id2
      END AS vessel_name,
     COALESCE(fek.location_sid, - 1) AS ferry_country_location_sid,
      CASE
      WHEN bei.y035_ext_id2 = 'NULL'
      THEN NULL
      ELSE bei.y035_ext_id2
      END AS ferry_name,
     COALESCE(trk.location_sid, - 1) AS truck_country_location_sid,
      CASE
      WHEN bei.y040_ext_id2 = 'NULL'
      THEN NULL
      ELSE bei.y040_ext_id2
      END AS truck_name,
     COALESCE(tek.location_sid, - 1) AS trailer_country_location_sid,
      CASE
      WHEN bei.yror_ext_id2 = 'NULL'
      THEN NULL
      ELSE bei.yror_ext_id2
      END AS trailer_name,
     COALESCE(tnk.location_sid, - 1) AS train_country_location_sid,
      CASE
      WHEN bei.y055_ext_id2 = 'NULL'
      THEN NULL
      ELSE bei.y055_ext_id2
      END AS train_name,
     bei.lifex AS loading_reference_nr,
     LTRIM(bei.refno_id_no, '0') AS inbound_delivery_nr,
     bei.refdt_id AS inbound_delivery_dt,
     bei.dwh_src_1_tmsp,
     bei.dwh_src_file_name -- select * from SZD_PRODUCTION.etl.t_cache_zgts_brimport

    FROM szd_production_etl.t_cache_zgts_brimport AS bei
     INNER JOIN szd_production_meta.t_location_key AS ack ON ack.location_key_type_cd = 'COUNTRY' AND ack.location_nat_key_nr
        = 'GB'
     INNER JOIN szd_production_meta.t_party_key AS cpk ON cpk.party_key_type_cd = 'CONSIGNOR' AND cpk.party_nat_key_nr =
       'LIDL EXPORT INTERNATIONAL GMBH & CO'
     LEFT JOIN szd_production_meta.t_party_key AS opk ON opk.party_key_type_cd = 'CONSIGNOR' AND opk.party_nat_key_nr =
       TRIM(UPPER(bei.parno_consignor_name1))
     LEFT JOIN szd_production_meta.t_party_key AS hpk ON hpk.party_key_type_cd = 'HAULER'
       -- and hpk.party_nat_key_nr = trim(upper(bei.PARNO_CAR_NAME1))
 AND TRIM(hpk.party_nat_key_nr) = TRIM(UPPER(bei.parno_car_name1
         ))
     LEFT JOIN szd_production_meta.t_party_key AS cek ON cek.party_key_type_cd = 'CONSIGNEE' AND cek.party_nat_key_nr =
       TRIM(UPPER(bei.parno_cons_name1))
     LEFT JOIN szd_production_meta.t_location_key AS dlk ON dlk.location_key_type_cd = 'COUNTRY' AND dlk.location_nat_key_nr
        = TRIM(bei.ctydp)
     LEFT JOIN szd_production_meta.t_party_key AS cok ON cok.party_key_type_cd = 'CUSTOMS_OFFICE'
       -- and cok.party_nat_key_nr = trim(bei.CUOFF)
 AND TRIM(cok.party_nat_key_nr) = 'GB|' || TRIM(bei.cuoff)
     LEFT JOIN szd_production_core_rel.t_transport_type AS tt ON tt.transport_route_type_cd = 'BEFORE_EXPORT' AND tt.foreigntrade_id
        = TRIM(bei.mtbrc)
     LEFT JOIN szd_production_meta.t_location_key AS vek ON vek.location_key_type_cd = 'COUNTRY' AND vek.location_nat_key_nr
        = TRIM(CASE
         WHEN bei.y030_pge_descr = 'NULL'
         THEN '-1'
         ELSE bei.y030_pge_descr
         END)
     LEFT JOIN szd_production_meta.t_location_key AS fek ON fek.location_key_type_cd = 'COUNTRY' AND fek.location_nat_key_nr
        = TRIM(CASE
         WHEN bei.y035_pge_descr = 'NULL'
         THEN '-1'
         ELSE bei.y035_pge_descr
         END)
     LEFT JOIN szd_production_meta.t_location_key AS trk ON trk.location_key_type_cd = 'COUNTRY' AND trk.location_nat_key_nr
        = TRIM(CASE
         WHEN bei.y040_pge_descr = 'NULL'
         THEN '-1'
         ELSE bei.y040_pge_descr
         END)
     LEFT JOIN szd_production_meta.t_location_key AS tek ON tek.location_key_type_cd = 'COUNTRY' AND tek.location_nat_key_nr
        = TRIM(NULLIF(bei.yror_pge_descr, 'NULL'))
     LEFT JOIN szd_production_meta.t_location_key AS tnk ON tnk.location_key_type_cd = 'COUNTRY' AND tnk.location_nat_key_nr
        = TRIM(NULLIF(bei.y055_pge_descr, 'NULL'))
    WHERE COALESCE(bei.etd, bei.etats) IS NOT NULL
    UNION DISTINCT
    SELECT c.consignee_additional_name || '-' || i.invoice_reference_nr AS trader_reference_nr,
     p.loading_dt AS order_dt,
     co.location_sid AS authority_country_location_sid,
     ck.party_sid AS consignor_party_sid,
     - 1 AS original_consignor_party_sid,
     MAX(p.carrier_party_sid) AS carrier_party_sid,
     i.consignee_party_sid,
     MAX(p.export_warehouse_resource_item_sid) AS export_warehouse_resource_item_sid,
     - 1 AS departure_country_location_sid,
     - 1 AS customs_office_party_sid,
     i.finance_sid AS invoice_finance_sid,
     'UNKNOWN' AS transport_type_cd,
     'BEFORE_EXPORT' AS transport_route_type_cd,
     CAST(NULL AS STRING) AS transport_reference_nr,
     ROUND(CAST(SUBSTR(i.invoice_reference_nr, 1, 4) AS BIGNUMERIC), 0) AS dispo_week,
     CAST(NULL AS BOOL) AS roll_on_roll_off_fg,
     CAST(NULL AS STRING) AS purchase_order_nr,
     CAST(NULL AS STRING) AS shipment_nr,
     CAST(NULL AS STRING) AS port_of_arrival_txt,
     CAST(NULL AS DATE) AS estimated_arrival_dt,
     CAST(NULL AS DATE) AS estimated_departure_dt,
     CAST(NULL AS STRING) AS bill_of_leding_nr,
     CAST(NULL AS STRING) AS packaging_list_nr,
     CAST(NULL AS STRING) AS container_nr_txt,
     - 1 AS vessel_country_location_sid,
     CAST(NULL AS STRING) AS vessel_name,
     - 1 AS ferry_country_location_sid,
     CAST(NULL AS STRING) AS ferry_name,
     - 1 AS truck_country_location_sid,
     CAST(NULL AS STRING) AS truck_name,
     - 1 AS trailer_country_location_sid,
     CAST(NULL AS STRING) AS trailer_name,
     - 1 AS train_country_location_sid,
     CAST(NULL AS STRING) AS train_name,
     CAST(NULL AS STRING) AS loading_reference_nr,
     CAST(NULL AS STRING) AS inbound_delivery_nr,
     CAST(NULL AS DATE) AS inbound_delivery_dt,
     i.dwh_src_1_tmsp,
     i.dwh_src_file_name
    FROM szd_production_core_rel.t_invoice AS i
     INNER JOIN szd_production_core_rel.t_invoice_position AS p ON i.finance_sid = p.invoice_finance_sid
     INNER JOIN szd_production_core_rel.t_consignee AS c ON i.consignee_party_sid = c.party_sid AND c.dwh_valid_fg
     INNER JOIN szd_production_core_rel.t_country_political AS co ON c.country_location_sid = co.location_sid AND co.lang_cd
        = 'DE'
     INNER JOIN szd_production_meta.t_party_key AS ck ON ck.party_key_type_cd = 'CONSIGNOR' AND ck.party_nat_key_nr =
        CASE
        WHEN i.consignor_stream_cd = 'LST'
        THEN 'LIDL STIFTUNG & CO KG'
        WHEN i.consignor_stream_cd = 'OWIM'
        THEN 'OWIM GMBH & CO KG'
        ELSE NULL
        END
    WHERE p.business_transaction_type_cd = '1-LAGER'
     AND co.iso_country_cd = 'GB'
     AND i.consignor_stream_cd IN ('LST', 'OWIM')
     AND p.loading_dt >= DATE '2021-12-01'
    GROUP BY trader_reference_nr,
     order_dt,
     authority_country_location_sid,
     consignor_party_sid,
     i.consignee_party_sid,
     invoice_finance_sid,
     dispo_week,
     i.dwh_src_1_tmsp,
     i.dwh_src_file_name) AS a
 GROUP BY trader_reference_nr,
  order_dt,
  authority_country_location_sid,
  consignor_party_sid,
  original_consignor_party_sid,
  carrier_party_sid,
  consignee_party_sid,
  export_warehouse_resource_item_sid,
  departure_country_location_sid,
  customs_office_party_sid,
  invoice_finance_sid,
  transport_type_cd,
  transport_route_type_cd,
  transport_reference_nr,
  dispo_week,
  roll_on_roll_off_fg,
  purchase_order_nr,
  shipment_nr,
  port_of_arrival_txt,
  estimated_arrival_dt,
  estimated_departure_dt,
  bill_of_leding_nr,
  packaging_list_nr,
  vessel_country_location_sid,
  vessel_name,
  ferry_country_location_sid,
  ferry_name,
  truck_country_location_sid,
  truck_name,
  trailer_country_location_sid,
  trailer_name,
  train_country_location_sid,
  train_name,
  loading_reference_nr,
  inbound_delivery_nr,
  inbound_delivery_dt);