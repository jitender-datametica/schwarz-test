create or replace view LDL_PRODUCTION.P_LEW_CORE_AC.V_ADDRESS_DEMOGRAPHICS_HIST_1(
	CLIENT_ID,
	ADDR_SID,
	INHABITANTS_10MIN_BY_CAR_CNT,
	INHABITANTS_5MIN_BY_CAR_CNT,
	INHABITANTS_500M_CNT,
	INHABITANTS_1000M_CNT,
	INHABITANTS_CITY_CNT,
	INHABITANTS_CATCHMENT_AREA_CNT,
	DELETED_FG,
	DWH_VALID_FROM,
	DWH_VALID_TO,
	DWH_LOAD_ID,
	DWH_CREATED,
	DWH_UPDATED
) as
   SELECT
       client_id,
   addr_sid,
   inhabitants_10min_by_car_cnt,
   inhabitants_5min_by_car_cnt,
   inhabitants_500m_cnt,
   inhabitants_1000m_cnt,
   inhabitants_city_cnt,
   inhabitants_catchment_area_cnt,
   deleted_fg,
   dwh_valid_from,
   dwh_valid_to,
   dwh_load_id,
   dwh_created,
   dwh_updated
  FROM p_lew_core.t_address_demographics_hist_1
;
