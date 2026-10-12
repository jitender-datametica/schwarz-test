CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_sdl_building_hist_1 (
client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Unique identifier of the DWH client / slice. FK to \"lew_core_ac.v_client_1\".'),
building_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='FK Surrogate DWH Key to CORE building \"lew_core_ac.v_building_1\".'),
sdl_ignore_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='As defined and set by \"lew_mart_sdl_ac.v_sdl_building_exception_list.laenderkuerzel\". Not modified by Controlling.'),
sdl_country_code STRING(20) COLLATE 'und:ci'
OPTIONS(description='As defined and set by \"lew_mart_sdl_ac.v_sdl_building_exception_list.status_1\". Not modified by Controlling.'),
sdl_building_status STRING(100) COLLATE 'und:ci'
OPTIONS(description='As defined and set by \"lew_mart_sdl_ac.v_sdl_building_exception_list.status_1\" and possibly modified by Controlling.'),
sdl_building_status_co_override STRING(100) COLLATE 'und:ci'
OPTIONS(description='As defined and set by \"lew_mart_sdl_ac.v_sdl_building_exception_list.status_1\" and possibly modified by Controlling.'),
sdl_building_name STRING(100) COLLATE 'und:ci'
OPTIONS(description='As defined and set by \"lew_mart_sdl_ac.v_sdl_building_exception_list.objektbezeichnung\". Not modified by Controlling.'),
sdl_building_name_co_override STRING(100) COLLATE 'und:ci'
OPTIONS(description='As defined and set by \"lew_mart_sdl_ac.v_sdl_building_exception_list.objektbezeichnung_co_override\" and possibly modified by Controlling.'),
sdl_building_type STRING(100) COLLATE 'und:ci'
OPTIONS(description='As defined and set by \"lew_mart_sdl_ac.v_sdl_building_exception_list.objekttyp\". Not modified by Controlling.'),
sdl_building_type_co_override STRING(100) COLLATE 'und:ci'
OPTIONS(description='As defined and set by \"lew_mart_sdl_ac.v_sdl_building_exception_list.objekttyp_co_override\" and possibly modified by Controlling.'),
sdl_opening_dt DATE
OPTIONS(description='As defined and set by \"lew_mart_sdl_ac.v_sdl_building_exception_list.oeffnungsdatum\". Not modified by Controlling.'),
sdl_opening_dt_co_override DATE
OPTIONS(description='As defined and set by \"lew_mart_sdl_ac.v_sdl_building_exception_list.oeffnungsdatum_co_override\" and possibly modified by Controlling.'),
sdl_closing_dt DATE
OPTIONS(description='As defined and set by \"lew_mart_sdl_ac.v_sdl_building_exception_list.schliessungsdatum\". Not modified by Controlling.'),
sdl_closing_dt_co_override DATE
OPTIONS(description='As defined and set by \"lew_mart_sdl_ac.v_sdl_building_exception_list.schliessungsdatum_co_override\" and possibly modified by Controlling.'),
sdl_closing_reason STRING(100) COLLATE 'und:ci'
OPTIONS(description='As defined and set by \"lew_mart_sdl_ac.v_sdl_building_exception_list.schliessungsgrund\". Not modified by Controlling.'),
sdl_closing_reason_co_override STRING(100) COLLATE 'und:ci'
OPTIONS(description='As defined and set by \"lew_mart_sdl_ac.v_sdl_building_exception_list.schliessungsgrund_co_override\" and possibly modified by Controlling.'),
sdl_rebuild_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='As defined and set by \"lew_mart_sdl_ac.v_sdl_building_exception_list.abriss_neubau\". Not modified by Controlling.'),
sdl_rebuild_fg_co_override BIGNUMERIC(38,0)
OPTIONS(description='As defined and set by \"lew_mart_sdl_ac.v_sdl_building_exception_list.abriss_neubau_co_override\" and possibly modified by Controlling.'),
sdl_replacement_to_dt DATE
OPTIONS(description='As defined and set by \"lew_mart_sdl_ac.v_sdl_building_exception_list.umzugsdatum_nach\". Not modified by Controlling.'),
sdl_replacement_to_dt_co_override DATE
OPTIONS(description='As defined and set by \"lew_mart_sdl_ac.v_sdl_building_exception_list.umzugsdatum_nach_co_override\" and possibly modified by Controlling.'),
sdl_replacement_from_dt DATE
OPTIONS(description='As defined and set by \"lew_mart_sdl_ac.v_sdl_building_exception_list.umzugsdatum_von\". Not modified by Controlling.'),
sdl_replacement_from_dt_co_override DATE
OPTIONS(description='As defined and set by \"lew_mart_sdl_ac.v_sdl_building_exception_list.umzugsdatum_von_co_override\" and possibly modified by Controlling.'),
sdl_sales_area_in_meas NUMERIC(18,5)
OPTIONS(description='As defined and set by \"lew_mart_sdl_ac.v_sdl_building_exception_list.verkaufsflaeche_gesamt\". Not modified by Controlling.'),
sdl_sales_area_in_meas_co_override NUMERIC(18,5)
OPTIONS(description='As defined and set by \"lew_mart_sdl_ac.v_sdl_building_exception_list.verkaufsflaeche_gesamt_co_override\" and possibly modified by Controlling.'),
sdl_parking_place_cnt BIGNUMERIC(38,0)
OPTIONS(description='As defined and set by \"lew_mart_sdl_ac.v_sdl_building_exception_list.parkplaetze_gesamt\". Not modified by Controlling.'),
sdl_parking_place_cnt_co_override BIGNUMERIC(38,0)
OPTIONS(description='As defined and set by \"lew_mart_sdl_ac.v_sdl_building_exception_list.parkplaetze_gesamt_co_override\" and possibly modified by Controlling.'),
sdl_owned_parking_place_cnt BIGNUMERIC(38,0)
OPTIONS(description='As defined and set by \"lew_mart_sdl_ac.v_sdl_building_exception_list.parkplaetze_eigene\". Not modified by Controlling.'),
sdl_owned_parking_place_cnt_co_override BIGNUMERIC(38,0)
OPTIONS(description='As defined and set by \"lew_mart_sdl_ac.v_sdl_building_exception_list.parkplaetze_eigene_co_override\" and possibly modified by Controlling.'),
sdl_longitude NUMERIC(9,6)
OPTIONS(description='As defined and set by \"lew_mart_sdl_ac.v_sdl_building_exception_list.x_koordinate\". Not modified by Controlling.'),
sdl_longitude_co_override NUMERIC(9,6)
OPTIONS(description='As defined and set by \"lew_mart_sdl_ac.v_sdl_building_exception_list.x_koordinate_co_override\" and possibly modified by Controlling.'),
sdl_latitude NUMERIC(9,6)
OPTIONS(description='As defined and set by \"lew_mart_sdl_ac.v_sdl_building_exception_list.y_koordinate\". Not modified by Controlling.'),
sdl_latitude_co_override NUMERIC(9,6)
OPTIONS(description='As defined and set by \"lew_mart_sdl_ac.v_sdl_building_exception_list.y_koordinate_co_override\" and possibly modified by Controlling.'),
sdl_city_group_name STRING(100) COLLATE 'und:ci'
OPTIONS(description='As defined and set by \"lew_mart_sdl_ac.v_sdl_building_exception_list.staedtegruppe\". Not modified by Controlling.'),
sdl_city_group_name_co_override STRING(100) COLLATE 'und:ci'
OPTIONS(description='As defined and set by \"lew_mart_sdl_ac.v_sdl_building_exception_list.staedtegruppe_co_override\" and possibly modified by Controlling.'),
sdl_city_name STRING(100) COLLATE 'und:ci'
OPTIONS(description='As defined and set by \"lew_mart_sdl_ac.v_sdl_building_exception_list.stadt\". Not modified by Controlling.'),
sdl_city_name_co_override STRING(100) COLLATE 'und:ci'
OPTIONS(description='As defined and set by \"lew_mart_sdl_ac.v_sdl_building_exception_list.stadt_co_override\" and possibly modified by Controlling.'),
sdl_zip STRING(20) COLLATE 'und:ci'
OPTIONS(description='As defined and set by \"lew_mart_sdl_ac.v_sdl_building_exception_list.postleitzahl\". Not modified by Controlling.'),
sdl_zip_co_override STRING(20) COLLATE 'und:ci'
OPTIONS(description='As defined and set by \"lew_mart_sdl_ac.v_sdl_building_exception_list.postleitzahl_co_override\" and possibly modified by Controlling.'),
sdl_street_name STRING(100) COLLATE 'und:ci'
OPTIONS(description='As defined and set by \"lew_mart_sdl_ac.v_sdl_building_exception_list.strasse\". Not modified by Controlling.'),
sdl_street_name_co_override STRING(100) COLLATE 'und:ci'
OPTIONS(description='As defined and set by \"lew_mart_sdl_ac.v_sdl_building_exception_list.strasse_co_override\" and possibly modified by Controlling.'),
sdl_house_nr STRING(40) COLLATE 'und:ci'
OPTIONS(description='As defined and set by \"lew_mart_sdl_ac.v_sdl_building_exception_list.hausnummer\". Not modified by Controlling.'),
sdl_house_nr_co_override STRING(40) COLLATE 'und:ci'
OPTIONS(description='As defined and set by \"lew_mart_sdl_ac.v_sdl_building_exception_list.hausnummer_co_override\" and possibly modified by Controlling.'),
sdl_inhabitants_500m_cnt BIGNUMERIC(38,0)
OPTIONS(description='As defined and set by \"lew_mart_sdl_ac.v_sdl_building_exception_list.einwohner_im_radius_500m\". Not modified by Controlling.'),
sdl_inhabitants_500m_cnt_co_override BIGNUMERIC(38,0)
OPTIONS(description='As defined and set by \"lew_mart_sdl_ac.v_sdl_building_exception_list.einwohner_im_radius_500m_co_override\" and possibly modified by Controlling.'),
sdl_inhabitants_1000m_cnt BIGNUMERIC(38,0)
OPTIONS(description='As defined and set by \"lew_mart_sdl_ac.v_sdl_building_exception_list.einwohner_im_radius_1000m\". Not modified by Controlling.'),
sdl_inhabitants_1000m_cnt_co_override BIGNUMERIC(38,0)
OPTIONS(description='As defined and set by \"lew_mart_sdl_ac.v_sdl_building_exception_list.einwohner_im_radius_1000m_co_override\" and possibly modified by Controlling.'),
sdl_inhabitants_catchment_area_cnt BIGNUMERIC(38,0)
OPTIONS(description='As defined and set by \"lew_mart_sdl_ac.v_sdl_building_exception_list.einwohner_im_einzugsbereich\". Not modified by Controlling.'),
sdl_inhabitants_catchment_area_cnt_co_override BIGNUMERIC(38,0)
OPTIONS(description='As defined and set by \"lew_mart_sdl_ac.v_sdl_building_exception_list.einwohner_im_einzugsbereich_co_override\" and possibly modified by Controlling.'),
sdl_country_wh_nr STRING(20) COLLATE 'und:ci'
OPTIONS(description='As defined and set by \"lew_mart_sdl_ac.v_sdl_building_exception_list.dienstleistungs_gesellschaft\". Not modified by Controlling.'),
sdl_country_wh_nr_co_override STRING(20) COLLATE 'und:ci'
OPTIONS(description='As defined and set by \"lew_mart_sdl_ac.v_sdl_building_exception_list.dienstleistungs_gesellschaft_co_override\" and possibly modified by Controlling.'),
sdl_expansion_wh_nr STRING(20) COLLATE 'und:ci'
OPTIONS(description='As defined and set by \"lew_mart_sdl_ac.v_sdl_building_exception_list.expansions_gesellschaft\". Not modified by Controlling.'),
sdl_expansion_wh_nr_co_override STRING(20) COLLATE 'und:ci'
OPTIONS(description='As defined and set by \"lew_mart_sdl_ac.v_sdl_building_exception_list.expansions_gesellschaft_co_override\" and possibly modified by Controlling.'),
sdl_balance_sheet_wh_nr STRING(20) COLLATE 'und:ci'
OPTIONS(description='As defined and set by \"lew_mart_sdl_ac.v_sdl_building_exception_list.bilanz_gesellschaft\". Not modified by Controlling.'),
sdl_balance_sheet_wh_nr_co_override STRING(20) COLLATE 'und:ci'
OPTIONS(description='As defined and set by \"lew_mart_sdl_ac.v_sdl_building_exception_list.bilanz_gesellschaft_co_override\" and possibly modified by Controlling.'),
sdl_delivery_wh_nr STRING(20) COLLATE 'und:ci'
OPTIONS(description='As defined and set by \"lew_mart_sdl_ac.v_sdl_building_exception_list.beliefernde_gesellschaft\". Not modified by Controlling.'),
sdl_delivery_wh_nr_co_override STRING(20) COLLATE 'und:ci'
OPTIONS(description='As defined and set by \"lew_mart_sdl_ac.v_sdl_building_exception_list.beliefernde_gesellschaft_co_override\" and possibly modified by Controlling.'),
sdl_sales_wh_nr STRING(20) COLLATE 'und:ci'
OPTIONS(description='As defined and set by \"lew_mart_sdl_ac.v_sdl_building_exception_list.vertriebs_gesellschaft\". Not modified by Controlling.'),
sdl_sales_wh_nr_co_override STRING(20) COLLATE 'und:ci'
OPTIONS(description='As defined and set by \"lew_mart_sdl_ac.v_sdl_building_exception_list.vertriebs_gesellschaft_co_override\" and possibly modified by Controlling.'),
sdl_owner_wh_nr STRING(20) COLLATE 'und:ci'
OPTIONS(description='As defined and set by \"lew_mart_sdl_ac.v_sdl_building_exception_list.eigentums_gesellschaft\". Not modified by Controlling.'),
sdl_owner_wh_nr_co_override STRING(20) COLLATE 'und:ci'
OPTIONS(description='As defined and set by \"lew_mart_sdl_ac.v_sdl_building_exception_list.eigentums_gesellschaft_co_override\" and possibly modified by Controlling.'),
deleted_fg BIGNUMERIC(38,0)
OPTIONS(description='Weather the record is marked as deleted ot not (0 - not deleted; 1 - deleted). Explicitly specified by the source system or evaluated by the delta recognition of loading ETL.'),
dwh_valid_from DATE NOT NULL
OPTIONS(description='Record validity_1 start date. Part of the DWH historisation. The value on the oldest record of the history is set to 01.01.1900 (\"minus infinite\").'),
dwh_valid_to DATE NOT NULL
OPTIONS(description='Record validity_1 end date. Part of the DWH historisation. The value on the youngest record of the history is set to 31.12.9999 (\"plus infinite\").'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The ID of the last load that had created or modified the record.'),
dwh_created DATETIME NOT NULL OPTIONS(description='The timestamp when the record has been created in DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='The timestamp when the record has been updated in DWH.'),
PRIMARY KEY (client_id, building_sid, dwh_valid_from) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='SDL-Building attributes resulting out of the \"SDL Building Exception List\"-process (patch A2924): (1) Export of \"lew_mart_sdl_ac.v_sdl_building_exception_list\" to CO, (2) CO changes (see column comments), (3) Import.');