INSERT INTO ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
  trader_reference_nr, 
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
  container_nr_txt, 
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
  inbound_delivery_dt,
  dwh_src_1_tmsp,  
  dwh_src_file_name,
  dwh_mapping_tmsp,
  tf_error_fg,
  deleted_fg,
  record_id,
  filename
)
select 
  trader_reference_nr, 
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
  MAX(case WHEN container_nr_txt='NULL' then NULL else container_nr_txt end), 
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
  inbound_delivery_dt,
  MAX(dwh_src_1_tmsp),  
  MAX(dwh_src_file_name),
  current_timestamp dwh_mapping_tmsp,
  0 tf_error_fg,
  0 deleted_fg,
  0 record_id,
  MAX(dwh_src_file_name) filename
from (select 
       to_char(bei.corder) as trader_reference_nr,
       coalesce(bei.etd, bei.etats) as order_dt,
       ack.location_sid as authority_country_location_sid,
       cpk.party_sid as consignor_party_sid,
       coalesce(opk.party_sid, -1) as original_consignor_party_sid,
       coalesce(hpk.party_sid, -1) as carrier_party_sid,
       coalesce(cek.party_sid, -1) as consignee_party_sid,
       -1 as export_warehouse_resource_item_sid,
       coalesce(dlk.location_sid, -1) as departure_country_location_sid,
       coalesce(cok.party_sid, -1) as customs_office_party_sid,
       -1 as invoice_finance_sid ,
       coalesce(tt.transport_type_cd, 'UNKNOWN') as transport_type_cd,
       coalesce(tt.transport_route_type_cd, 'BEFORE_EXPORT') as transport_route_type_cd,
       case when bei.vidar='NULL' then null else bei.vidar end as transport_reference_nr,
       null as dispo_week,
       --coalesce(bei.PGEMAT_TYPE = 'X', false) as roll_on_roll_off_fg,
       coalesce(trim(bei.PGEMAT_TYPE) = 'X', false) as roll_on_roll_off_fg,
       ltrim(bei.REFNO_PO_NO,'0')  as purchase_order_nr,
       case when bei.tknum='NULL' then null else bei.tknum end as shipment_nr,
       bei.nodfa as port_of_arrival_txt,
       bei.etats as estimated_arrival_dt,
       bei.etd as estimated_departure_dt,
       case when bei.Y902_EXT_ID2='NULL' then null else bei.Y902_EXT_ID2 end as bill_of_leding_nr,
       case when bei.PACKING_LIST='NULL' then null else bei.PACKING_LIST end as packaging_list_nr,
      CASE WHEN CHARINDEX(';', EXT_ID2) > 0
          THEN SUBSTR(EXT_ID2, 1, CHARINDEX(';', EXT_ID2) - 1)
          ELSE EXT_ID2
       END as container_nr_txt,
       coalesce(vek.location_sid, -1) as vessel_country_location_sid,
       case when bei.Y030_EXT_ID2='NULL' then null else bei.Y030_EXT_ID2 end vessel_name,
       coalesce(fek.location_sid, -1) as ferry_country_location_sid,
       case when bei.Y035_EXT_ID2='NULL' then null else bei.Y035_EXT_ID2 end ferry_name,
       coalesce(trk.location_sid, -1) as truck_country_location_sid,
       case when bei.Y040_EXT_ID2='NULL' then null else  bei.Y040_EXT_ID2 end truck_name,
       coalesce(tek.location_sid, -1) as trailer_country_location_sid,
       case when bei.YROR_EXT_ID2='NULL' then null else bei.YROR_EXT_ID2 end trailer_name,
       coalesce(tnk.location_sid, -1) as train_country_location_sid,
       case when bei.Y055_EXT_ID2='NULL' then  null else bei.Y055_EXT_ID2 end train_name,
       bei.lifex as loading_reference_nr,
       ltrim(bei.REFNO_ID_NO,'0') as inbound_delivery_nr,
       bei.REFDT_ID as inbound_delivery_dt,
       bei.dwh_src_1_tmsp,  
       bei.dwh_src_file_name
--  select * from etl.t_cache_zgts_brimport
  from etl.t_cache_zgts_brimport bei
  join meta.t_location_key ack
    on ack.location_key_type_cd = 'COUNTRY'
   and ack.location_nat_key_nr = 'GB' 
  join meta.t_party_key cpk
    on cpk.party_key_type_cd = 'CONSIGNOR'
   and cpk.party_nat_key_nr = 'LIDL EXPORT INTERNATIONAL GMBH & CO'
  left
  join meta.t_party_key opk
    on opk.party_key_type_cd = 'CONSIGNOR'
   and opk.party_nat_key_nr = trim(upper(bei.PARNO_CONSIGNOR_NAME1)) 
  left
  join meta.t_party_key hpk
    on hpk.party_key_type_cd = 'HAULER'
   --and hpk.party_nat_key_nr = trim(upper(bei.PARNO_CAR_NAME1)) 
    and trim(hpk.party_nat_key_nr) = trim(upper(bei.PARNO_CAR_NAME1))
  left
  join meta.t_party_key cek
    on cek.party_key_type_cd = 'CONSIGNEE'
   and cek.party_nat_key_nr = trim(upper(bei.PARNO_CONS_NAME1))
  left
  join meta.t_location_key dlk
    on dlk.location_key_type_cd = 'COUNTRY'
   and dlk.location_nat_key_nr = trim(bei.CTYDP)
  left
  join meta.t_party_key cok
    on cok.party_key_type_cd = 'CUSTOMS_OFFICE'
   --and cok.party_nat_key_nr = trim(bei.CUOFF)
    and trim(cok.party_nat_key_nr) = 'GB|'||trim(bei.CUOFF)
  left
  join core_rel.t_transport_type tt
    on tt.transport_route_type_cd = 'BEFORE_EXPORT'
   and tt.foreigntrade_id = trim(bei.MTBRC)
  left
  join meta.t_location_key vek
    on vek.location_key_type_cd = 'COUNTRY'
   and vek.location_nat_key_nr = trim(case when bei.Y030_PGE_DESCR ='NULL' then '-1' else bei.Y030_PGE_DESCR end)
  left
  join meta.t_location_key fek
    on fek.location_key_type_cd = 'COUNTRY'
   and fek.location_nat_key_nr = trim(case when bei.Y035_PGE_DESCR ='NULL' then '-1' else bei.Y035_PGE_DESCR end)
  left
  join meta.t_location_key trk
    on trk.location_key_type_cd = 'COUNTRY'
   and trk.location_nat_key_nr = trim(case when bei.Y040_PGE_DESCR  ='NULL' then '-1' else bei.Y040_PGE_DESCR  end)
  left
  join meta.t_location_key tek
    on tek.location_key_type_cd = 'COUNTRY'
   and tek.location_nat_key_nr = trim( NULLIF(bei.YROR_PGE_DESCR,'NULL')) 
  left
  join meta.t_location_key tnk
    on tnk.location_key_type_cd = 'COUNTRY'
   and tnk.location_nat_key_nr = trim(NULLIF(bei.Y055_PGE_DESCR,'NULL')) 
 where coalesce(bei.etd, bei.etats) is not null
 union
-- Insert from WWT Report
select c.consignee_additional_name || '-' || i.invoice_reference_nr as trader_reference_nr,
       p.loading_dt as order_dt,
       co.location_sid as authority_country_location_sid,
       ck.party_sid as consignor_party_sid,
       -1 as original_consignor_party_sid,
       max(p.carrier_party_sid) as carrier_party_sid,
       i.consignee_party_sid,
       max(p.export_warehouse_resource_item_sid) as export_warehouse_resource_item_sid,
       -1 as departure_country_location_sid,
       -1 as customs_office_party_sid,
       i.finance_sid as invoice_finance_sid,
       'UNKNOWN' as transport_type_cd,
       'BEFORE_EXPORT' as transport_route_type_cd,
       null as transport_reference_nr,
       to_number(substr(i.invoice_reference_nr, 1, 4)) as dispo_week,
       null as roll_on_roll_off_fg,
       null as purchase_order_nr,
       null as shipment_nr,
       null as port_of_arrival_txt,
       null as estimated_arrival_dt,
       null as estimated_departure_dt,
       null as bill_of_leding_nr,
       null as packaging_list_nr,
       null as container_nr_txt,
       -1 as vessel_country_location_sid,
       null as vessel_name,
       -1 as ferry_country_location_sid,
       null as ferry_name,
       -1 as truck_country_location_sid,
       null as truck_name,
       -1 as trailer_country_location_sid,
       null as trailer_name,
       -1 as train_country_location_sid,
       null as train_name,
       null as loading_reference_nr,
       null as inbound_delivery_nr,
       null as inbound_delivery_dt,
       i.dwh_src_1_tmsp,  
       i.dwh_src_file_name
  from core_rel.t_invoice i
  join core_rel.t_invoice_position p
    on i.finance_sid = p.invoice_finance_sid 
  join core_rel.t_consignee c
    on i.consignee_party_sid = c.party_sid 
       and c.dwh_valid_fg='TRUE' 
  join core_rel.t_country_political co
    on c.country_location_sid = co.location_sid 
   and co.lang_cd = 'DE' 
  join meta.t_party_key ck
    on ck.party_key_type_cd = 'CONSIGNOR'
   and ck.party_nat_key_nr = case when i.consignor_stream_cd = 'LST' then 'LIDL STIFTUNG & CO KG'
                                  when i.consignor_stream_cd = 'OWIM' then 'OWIM GMBH & CO KG'
                              end 
 where p.business_transaction_type_cd = '1-LAGER'   
   and co.iso_country_cd = 'GB'
   and i.consignor_stream_cd in ('LST', 'OWIM')
   and p.loading_dt >= '2021-12-01'
 group
    by 1, 2, 3, 4, 7, 11, 15,38,39) a
group by   
  trader_reference_nr, 
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
 -- container_nr_txt, 
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
  inbound_delivery_dt

