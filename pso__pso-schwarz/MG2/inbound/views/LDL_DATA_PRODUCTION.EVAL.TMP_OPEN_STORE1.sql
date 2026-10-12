create or replace view LDL_DATA_PRODUCTION.EVAL.TMP_OPEN_STORE1(
	OPEN_FG,
	CAL_DT,
	HOLIDAY_CD,
	DAY_OF_WEEK,
	INT_ORG_SID,
	REAL_ESTATE_SID,
	DWH_VALID_FROM_TMSP,
	DWH_VALID_TO_TMSP,
	DWH_VALID_FG,
	CURR_INT_ORG_NR,
	INIT_INT_ORG_NR,
	INT_ORG_NAME,
	INT_ORG_STATUS_CD,
	REAL_ESTATE_STATUS_CD
) as
SELECT (CASE WHEN hol.holiday_cd IS NULL 
             THEN TRUE
			 ELSE FALSE
		END) AS OPEN_FG,
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
  FROM core_dim.t_dim_internal_organization AS store

 INNER JOIN core_dim.t_dim_calendar_date dt 
    ON dt.cal_dt < CURRENT_DATE()
   AND dt.bus_year_offset >= -2 --cross join to get all dates for last 2 business years

 INNER JOIN core_rel.t_store_opening_hours AS oh
    ON oh.store_sid = store.int_org_sid
   AND oh.day_of_week = dt.day_of_week
   AND dt.cal_dt BETWEEN oh.dwh_valid_from_tmsp AND oh.dwh_valid_to_tmsp --exlude days store is closed (ie. Sundays)

 INNER JOIN core_dim.t_dim_real_estate AS re 
    ON re.int_org_sid = store.int_org_sid 
   AND dt.cal_dt BETWEEN re.dwh_valid_from_tmsp AND re.dwh_valid_to_tmsp
   AND re.real_estate_status_cd = 'OP' --get real estates with OP status = open stores

 INNER JOIN core_rel.t_country AS cntr 
    ON cntr.iso_country_cd = store.iso_country_cd
   AND dt.cal_dt BETWEEN cntr.dwh_valid_from_tmsp AND cntr.dwh_valid_to_tmsp --get country_sid to be able to join holidays

  LEFT OUTER JOIN core_rel.t_geographical_area_holiday AS hol 
    ON hol.geo_area_sid = cntr.country_sid
   AND hol.geo_area_type_cd = 'CTRY'
   AND hol.cal_dt = dt.cal_dt
   AND dt.cal_dt BETWEEN hol.dwh_valid_from_tmsp AND hol.dwh_valid_to_tmsp

 WHERE dt.cal_dt BETWEEN store.dwh_valid_from_tmsp AND store.dwh_valid_to_tmsp
   AND store.int_org_type_cd = 'STORE';