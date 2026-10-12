--cross join to get all dates for last 2 business years


--exlude days store is closed (ie. Sundays)


--get real estates with OP status_2 = open stores


--get country_sid to be able to join holidays


CREATE OR REPLACE VIEW ldl_data_production_eval.tmp_open_store4_2 (open_fg, cal_dt, holiday_cd, day_of_week, int_org_sid,
real_estate_sid, dwh_valid_from_tmsp, dwh_valid_to_tmsp, dwh_valid_fg, curr_int_org_nr, init_int_org_nr, int_org_name,
int_org_status_cd, real_estate_status_cd) AS SELECT hol.holiday_cd IS NULL AS open_fg,
 dt.cal_dt,
 hol.holiday_cd,
 dt.day_of_week,
 store.int_org_sid,
 re.real_estate_sid,
 store.dwh_valid_from_tmsp,
 store.dwh_valid_to_tmsp,
 store.dwh_valid_fg,
 store.curr_int_org_nr,
 store.init_int_org_nr,
 store.int_org_name,
 store.int_org_status_cd,
 re.real_estate_status_cd
FROM ldl_data_production_core_dim.t_dim_internal_organization_2 AS store
 INNER JOIN ldl_data_production_core_dim.t_dim_calendar_date_2 AS dt ON dt.cal_dt < CURRENT_DATE AND dt.bus_year_offset >=
   - 2
 INNER JOIN ldl_data_production_core_rel.t_store_opening_hours_2 AS oh ON store.int_org_sid = oh.store_sid AND dt.day_of_week
     = oh.day_of_week AND dt.cal_dt BETWEEN CAST(oh.dwh_valid_from_tmsp AS DATE) AND (CAST(oh.dwh_valid_to_tmsp AS DATE)
    )
 INNER JOIN ldl_data_production_core_dim.t_dim_real_estate_2 AS re_2 ON store.int_org_sid = re.int_org_sid AND dt.cal_dt
    BETWEEN CAST(re.dwh_valid_from_tmsp AS DATE) AND (CAST(re.dwh_valid_to_tmsp AS DATE)) AND re.real_estate_status_cd =
   'OP'
 LEFT JOIN ldl_data_production_core_rel.t_country_2 AS cntr ON store.iso_country_cd = cntr.iso_country_cd AND dt.cal_dt
   BETWEEN CAST(cntr.dwh_valid_from_tmsp AS DATE) AND (CAST(cntr.dwh_valid_to_tmsp AS DATE))
 LEFT JOIN ldl_data_production_core_rel.t_geographical_area_holiday_2 AS hol ON cntr.country_sid = hol.geo_area_sid AND
     hol.geo_area_type_cd = 'CTRY' AND dt.cal_dt = hol.cal_dt AND dt.cal_dt BETWEEN CAST(hol.dwh_valid_from_tmsp AS DATE)
   AND (CAST(hol.dwh_valid_to_tmsp AS DATE))
WHERE dt.cal_dt BETWEEN CAST(store.dwh_valid_from_tmsp AS DATE) AND (CAST(store.dwh_valid_to_tmsp AS DATE))
 AND store.int_org_type_cd = 'STORE'
 AND store.iso_country_cd <> '@';