CREATE OR REPLACE VIEW P_LEW_PRECORE_AC.V_CACHE_GPS_STOREDETAILS_HIST
(
client_id
, country
, warehouse
, loc_sid_store
, store
, storename
, street
, town
, zipcode
, predecessor_id
, predecessor_name
, successor_id
, successor_name
, region_key
, region_name
, salesarea_key
, salesarea_name
, storetype
, storesize
, phone
, currency
, foreigncurrency
, weatherid
, deleted_fg
, dwh_valid_from
, dwh_valid_to
, dwh_load_id
, dwh_created
, dwh_updated
)
AS
   SELECT
   client_id,
   country,
   warehouse,
   loc_sid_store,
   store,
   storename,
   street,
   town,
   zipcode,
   predecessor_id,
   predecessor_name,
   successor_id,
   successor_name,
   region_key,
   region_name,
   salesarea_key,
   salesarea_name,
   storetype,
   storesize,
   phone,
   currency,
   foreigncurrency,
   weatherid,
   deleted_fg,
   dwh_valid_from,
   dwh_valid_to,
   dwh_load_id,
   dwh_created,
   dwh_updated
  FROM p_lew_precore.t_cache_gps_storedetails_hist
;