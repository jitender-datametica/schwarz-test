create or replace view LDL_PRODUCTION.P_LEW_CORE_AC.V_REF_SDL_BUILDING_HIST_1(
	CLIENT_ID,
	BUILDING_SID,
	SDL_IGNORE_FG,
	SDL_COUNTRY_CODE,
	SDL_BUILDING_STATUS,
	SDL_BUILDING_STATUS_CO_OVERRIDE,
	SDL_BUILDING_NAME,
	SDL_BUILDING_NAME_CO_OVERRIDE,
	SDL_BUILDING_TYPE,
	SDL_BUILDING_TYPE_CO_OVERRIDE,
	SDL_OPENING_DT,
	SDL_OPENING_DT_CO_OVERRIDE,
	SDL_CLOSING_DT,
	SDL_CLOSING_DT_CO_OVERRIDE,
	SDL_CLOSING_REASON,
	SDL_CLOSING_REASON_CO_OVERRIDE,
	SDL_REBUILD_FG,
	SDL_REBUILD_FG_CO_OVERRIDE,
	SDL_REPLACEMENT_TO_DT,
	SDL_REPLACEMENT_TO_DT_CO_OVERRIDE,
	SDL_REPLACEMENT_FROM_DT,
	SDL_REPLACEMENT_FROM_DT_CO_OVERRIDE,
	SDL_SALES_AREA_IN_MEAS,
	SDL_SALES_AREA_IN_MEAS_CO_OVERRIDE,
	SDL_PARKING_PLACE_CNT,
	SDL_PARKING_PLACE_CNT_CO_OVERRIDE,
	SDL_OWNED_PARKING_PLACE_CNT,
	SDL_OWNED_PARKING_PLACE_CNT_CO_OVERRIDE,
	SDL_LONGITUDE,
	SDL_LONGITUDE_CO_OVERRIDE,
	SDL_LATITUDE,
	SDL_LATITUDE_CO_OVERRIDE,
	SDL_CITY_GROUP_NAME,
	SDL_CITY_GROUP_NAME_CO_OVERRIDE,
	SDL_CITY_NAME,
	SDL_CITY_NAME_CO_OVERRIDE,
	SDL_ZIP,
	SDL_ZIP_CO_OVERRIDE,
	SDL_STREET_NAME,
	SDL_STREET_NAME_CO_OVERRIDE,
	SDL_HOUSE_NR,
	SDL_HOUSE_NR_CO_OVERRIDE,
	SDL_INHABITANTS_500M_CNT,
	SDL_INHABITANTS_500M_CNT_CO_OVERRIDE,
	SDL_INHABITANTS_1000M_CNT,
	SDL_INHABITANTS_1000M_CNT_CO_OVERRIDE,
	SDL_INHABITANTS_CATCHMENT_AREA_CNT,
	SDL_INHABITANTS_CATCHMENT_AREA_CNT_CO_OVERRIDE,
	SDL_COUNTRY_WH_NR,
	SDL_COUNTRY_WH_NR_CO_OVERRIDE,
	SDL_EXPANSION_WH_NR,
	SDL_EXPANSION_WH_NR_CO_OVERRIDE,
	SDL_BALANCE_SHEET_WH_NR,
	SDL_BALANCE_SHEET_WH_NR_CO_OVERRIDE,
	SDL_DELIVERY_WH_NR,
	SDL_DELIVERY_WH_NR_CO_OVERRIDE,
	SDL_SALES_WH_NR,
	SDL_SALES_WH_NR_CO_OVERRIDE,
	SDL_OWNER_WH_NR,
	SDL_OWNER_WH_NR_CO_OVERRIDE,
	DELETED_FG,
	DWH_VALID_FROM,
	DWH_VALID_TO,
	DWH_LOAD_ID,
	DWH_CREATED,
	DWH_UPDATED
) as
SELECT client_id
     , building_sid
     , sdl_ignore_fg
     , sdl_country_code
     , sdl_building_status
     , sdl_building_status_co_override
     , sdl_building_name
     , sdl_building_name_co_override
     , sdl_building_type
     , sdl_building_type_co_override
     , sdl_opening_dt
     , sdl_opening_dt_co_override
     , sdl_closing_dt
     , sdl_closing_dt_co_override
     , sdl_closing_reason
     , sdl_closing_reason_co_override
     , sdl_rebuild_fg
     , sdl_rebuild_fg_co_override
     , sdl_replacement_to_dt
     , sdl_replacement_to_dt_co_override
     , sdl_replacement_from_dt
     , sdl_replacement_from_dt_co_override
     , sdl_sales_area_in_meas
     , sdl_sales_area_in_meas_co_override
     , sdl_parking_place_cnt
     , sdl_parking_place_cnt_co_override
     , sdl_owned_parking_place_cnt
     , sdl_owned_parking_place_cnt_co_override
     , sdl_longitude
     , sdl_longitude_co_override
     , sdl_latitude
     , sdl_latitude_co_override
     , sdl_city_group_name
     , sdl_city_group_name_co_override
     , sdl_city_name
     , sdl_city_name_co_override
     , sdl_zip
     , sdl_zip_co_override
     , sdl_street_name
     , sdl_street_name_co_override
     , sdl_house_nr
     , sdl_house_nr_co_override
     , sdl_inhabitants_500m_cnt
     , sdl_inhabitants_500m_cnt_co_override
     , sdl_inhabitants_1000m_cnt
     , sdl_inhabitants_1000m_cnt_co_override
     , sdl_inhabitants_catchment_area_cnt
     , sdl_inhabitants_catchment_area_cnt_co_override
     , sdl_country_wh_nr
     , sdl_country_wh_nr_co_override
     , sdl_expansion_wh_nr
     , sdl_expansion_wh_nr_co_override
     , sdl_balance_sheet_wh_nr
     , sdl_balance_sheet_wh_nr_co_override
     , sdl_delivery_wh_nr
     , sdl_delivery_wh_nr_co_override
     , sdl_sales_wh_nr
     , sdl_sales_wh_nr_co_override
     , sdl_owner_wh_nr
     , sdl_owner_wh_nr_co_override
     , deleted_fg
     , dwh_valid_from
     , dwh_valid_to
     , dwh_load_id
     , dwh_created
     , dwh_updated
FROM P_LEW_CORE.t_ref_sdl_building_hist_1
;
