BEGIN TRANSACTION;

DELETE FROM CORE.${TST_PREFIX}t_fact_charge_log_events;

insert into CORE.${TST_PREFIX}t_fact_charge_log_events (charger_provider_system_cd, charge_log_uuid_nr, charge_event_dt, start_tmsp, end_tmsp, charger_resource_item_sid, charger_serial_nr, division_party_sid, division_name, country_location_sid, country_iso_cd, internal_company_name, real_estate_resource_item_sid, real_estate_nr, real_estate_zip, real_estate_city_name, real_estate_street_name, charge_point_resource_item_sid, charger_station_type_cd, charge_point_plugin_type_name, charge_point_nr, charge_point_connector_label_txt, roaming_identification_data_txt, duration_sec, total_charging_power_meas, average_charging_power_meas, turnover_val, turnover_local_val, curr_cd, local_curr_cd, dwh_created_tmsp, dwh_updated_tmsp)
select l.charger_provider_system_cd,
       l.charge_log_uuid_nr,
       to_date(coalesce(l.end_local_tmsp, l.end_tmsp)) as charge_event_dt,
       coalesce(l.start_local_tmsp, l.start_tmsp) as start_tmsp,
       coalesce(l.end_local_tmsp, l.end_tmsp) as end_tmsp,
       coalesce(c.resource_item_sid, -1) as charger_resource_item_sid,
       c.serial_nr as charger_serial_nr,
       coalesce(d.party_sid, -1) as division_party_sid,
       d.division_name,
       coalesce(o.location_sid, -1) as country_location_sid,
       o.iso_country_cd as country_iso_cd,
       so.charging_station_owner_name as internal_company_name,
       coalesce(r.resource_item_sid, -1) as real_estate_resource_item_sid,
       r.real_estate_nr,
       a.zip as real_estate_zip,
       y.city_name as real_estate_city_name,
       trim(s.street_name || ' ' || coalesce(s.house_nr, '')) as real_estate_street_name,
       coalesce(p.resource_item_sid, -1) as charge_point_resource_item_sid,
       nullif(pwt.charger_station_type_cd, '-1') as charger_station_type_cd,
       nullif(p.charge_point_plugin_type_cd, '-1') as charge_point_plugin_type_name,
       p.ocpp_id as charge_point_nr,
       p.connector_label_txt as charge_point_connection_label_txt,
       l.roaming_identification_data_txt,
       case when l.start_local_tmsp is not null and l.end_local_tmsp is not null
            then datediff(second, l.start_local_tmsp, l.end_local_tmsp)
            else datediff(second, l.start_tmsp, l.end_tmsp)
        end as duration_sec,
       coalesce(l.meter_total_meas / 1000, 0) as total_charging_power_meas,
       coalesce(case when l.start_local_tmsp is not null and l.end_local_tmsp is not null
                     then l.meter_total_meas / 1000 / nullif(timestampdiff(second, l.start_local_tmsp, l.end_local_tmsp), 0) * 3600 
                     else l.meter_total_meas / 1000 / nullif(timestampdiff(second, l.start_tmsp, l.end_tmsp), 0) * 3600 
                 end, 0) as average_charging_power_meas,
       case when coalesce(l.invoice_curr_cd, '-1') = 'EUR'
            then coalesce(l.total_cost_val, 0) -- workaround for EUR values because of bad source data quality
            else coalesce(l.total_cost_val / nullif(e.exchange_rate, 0), 0)
        end as turnover_val,
       coalesce(l.total_cost_val, 0) as turnover_local_val,
       'EUR' as curr_cd,
       coalesce(l.invoice_curr_cd, '-1') as local_curr_cd,
       current_timestamp as dwh_created_tmsp,
       current_timestamp as dwh_updated_tmsp
  from core_rel.t_charge_log l
  left
  join core_rel.t_charge_point p
    on l.charge_point_resource_item_sid = p.resource_item_sid
   and coalesce(l.end_local_tmsp, l.end_tmsp) between p.dwh_valid_from_tmsp and p.dwh_valid_to_tmsp
  left
  join core_rel.t_charger c
    on l.charger_resource_item_sid = c.resource_item_sid
   and coalesce(l.end_local_tmsp, l.end_tmsp) between c.dwh_valid_from_tmsp and c.dwh_valid_to_tmsp
  left
  join core_rel.t_charging_station_owner so
    on c.charging_station_owner_party_sid = so.party_sid
   and coalesce(l.end_local_tmsp, l.end_tmsp) between so.dwh_valid_from_tmsp and so.dwh_valid_to_tmsp
  left
  join core_rel.t_real_estate r
    on c.real_estate_resource_item_sid = r.resource_item_sid
   and coalesce(l.end_local_tmsp, l.end_tmsp) between r.dwh_valid_from_tmsp and r.dwh_valid_to_tmsp
  left
  join core_rel.t_division d
    on r.division_party_sid = d.party_sid
   and coalesce(l.end_local_tmsp, l.end_tmsp) between d.dwh_valid_from_tmsp and d.dwh_valid_to_tmsp
  left
  join core_rel.t_country_political o
    on r.country_location_sid = o.location_sid
   and o.lang_cd = 'DE'
   and coalesce(l.end_local_tmsp, l.end_tmsp) between o.dwh_valid_from_tmsp and o.dwh_valid_to_tmsp
  left
  join core_rel.t_street_address s
    on r.street_address_location_sid = s.location_sid
   and coalesce(l.end_local_tmsp, l.end_tmsp) between s.dwh_valid_from_tmsp and s.dwh_valid_to_tmsp
  left
  join core_rel.t_postal_code_area a
    on s.postal_code_area_location_sid = a.location_sid
   and coalesce(l.end_local_tmsp, l.end_tmsp) between a.dwh_valid_from_tmsp and a.dwh_valid_to_tmsp
  left
  join core_rel.t_city y
    on s.city_location_sid = y.location_sid
   and coalesce(l.end_local_tmsp, l.end_tmsp) between y.dwh_valid_from_tmsp and y.dwh_valid_to_tmsp
  left
  join core_rel.t_exchange_rate e
    on l.invoice_curr_cd = e.source_currency_cd
   and e.target_currency_cd = 'EUR'
   and e.exchange_rate_type_cd = 'IOTCHARGER'
   and coalesce(l.end_local_tmsp, l.end_tmsp) between e.dwh_valid_from_tmsp and e.dwh_valid_to_tmsp
  LEFT
  JOIN(SELECT CPO.CHARGER_RESOURCE_ITEM_SID,
              MAX(PCT.POWER_TYPE_CD) AS CHARGER_STATION_TYPE_CD
         FROM CORE_REL.T_CHARGE_POINT CPO
         JOIN CORE_REL.T_CHARGE_POINT_CONNECTOR_TYPE PCT
           ON CPO.CHARGE_POINT_CONNECTOR_TYPE_ID = PCT.CHARGE_POINT_CONNECTOR_TYPE_ID
        WHERE CPO.CHARGER_RESOURCE_ITEM_SID != -1  
        GROUP
           BY ALL
      ) PWT
    ON c.RESOURCE_ITEM_SID = PWT.CHARGER_RESOURCE_ITEM_SID
;

COMMIT;
