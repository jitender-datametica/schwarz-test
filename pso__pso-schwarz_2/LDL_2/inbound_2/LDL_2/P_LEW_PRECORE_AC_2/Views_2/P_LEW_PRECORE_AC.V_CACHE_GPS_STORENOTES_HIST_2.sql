CREATE OR REPLACE VIEW P_LEW_PRECORE_AC.V_CACHE_GPS_STORENOTES_HIST_2
(
client_id
, country_2
, store
, loc_sid_store
, warehouse
, opened
, closed
, sundayopen
, holidayopen
, fromholiday
, toholiday
, fromsunday
, tosunday
, mondayfrom
, mondayto
, mondaybreakfrom
, mondaybreakto
, tuesdayfrom
, tuesdayto
, tuesdaybreakfrom
, tuesdaybreakto
, wednesdayfrom
, wednesdayto
, wednesdaybreakfrom
, wednesdaybreakto
, thursdayfrom
, thursdayto
, thursdaybreakfrom
, thursdaybreakto
, fridayfrom
, fridayto
, fridaybreakfrom
, fridaybreakto
, saturdayfrom
, saturdayto
, saturdaybreakfrom
, saturdaybreakto
, sundayfrom
, sundayto
, sundaybreakfrom
, sundaybreakto
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
   country_2,
   store,
   loc_sid_store,
   warehouse,
   opened,
   closed,
   sundayopen,
   holidayopen,
   fromholiday,
   toholiday,
   fromsunday,
   tosunday,
   mondayfrom,
   mondayto,
   mondaybreakfrom,
   mondaybreakto,
   tuesdayfrom,
   tuesdayto,
   tuesdaybreakfrom,
   tuesdaybreakto,
   wednesdayfrom,
   wednesdayto,
   wednesdaybreakfrom,
   wednesdaybreakto,
   thursdayfrom,
   thursdayto,
   thursdaybreakfrom,
   thursdaybreakto,
   fridayfrom,
   fridayto,
   fridaybreakfrom,
   fridaybreakto,
   saturdayfrom,
   saturdayto,
   saturdaybreakfrom,
   saturdaybreakto,
   sundayfrom,
   sundayto,
   sundaybreakfrom,
   sundaybreakto,
   deleted_fg,
   dwh_valid_from,
   dwh_valid_to,
   dwh_load_id,
   dwh_created,
   dwh_updated
  FROM p_lew_precore.t_cache_gps_storenotes_hist_2
;