/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_quintiq_rdcaddress_1
Description		|	QUINTIQ - prepared view on raw data
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_quintiq_rdcaddress_1 (client_id
OPTIONS(description='CLIENT ID - CALCULATED BASED ON THE COUNTRY_1 CODE'), lidl_country
OPTIONS(description='COUNTRY_1 CODE. ORIGINAL FIELD NAME BIC_ZMLILA'), source_system OPTIONS(description='SOURCE SYSTEM'),
wh_id OPTIONS(description='WAREHOUSE ID'), city_name OPTIONS(description='CITY'), country_name
OPTIONS(description='COUNTRY_1'), day_of_week OPTIONS(description='DAY OF THE WEEK THIS ADDRESS_1 IS FOR'), default_comment
OPTIONS(description='DEFAULT COMMENT FOR ANY ADDRESS_1 STATES FOR THIS ADDRESS_1'), end_open_tm
OPTIONS(description='END OF THE OPENING HOURS '), extra_info
OPTIONS(description='FREE TEXT FIELD TO FILL EXTERNAL INFORMATION'), has_ramp_fg
OPTIONS(description='INDICATES WHETHER A RAMP IS AVAILABLE AT THE ADDRESS_1'), house_nr OPTIONS(description='HOUSENUMBER'),
address_id OPTIONS(description='ID OF THE ADDRESS_1/STORE'), soft_delete_fg OPTIONS(description='USED FOR SOFT DELETE'),
special_store_fg
OPTIONS(description='TRUE IF THIS ADDRESS_1 IS A SPECIAL STORES THAT REQUIRE DIFFERENT DELIVERY HANDLING'), store_fg
OPTIONS(description='INDICATES WHETHER THE ADDRESS_1 IS A STORE'), dismount_allowed_fg
OPTIONS(description='INDICATES WHETHER AT THIS LOCATION_1 A RESOURCE CAN BE LEFT BEHIND - PHASE 2'),
unman_deliv_allowed_fg OPTIONS(description='INDICATOR OF AN UNMANNED DELIVERY IS ALLOWED'), address_long_name
OPTIONS(description='FULL NAME OF AN ADDRESS_1'), address_name OPTIONS(description='NAME OF THE ADDRESS_1/STORE'), post_code
OPTIONS(description='POSTCODE'), start_open_tm OPTIONS(description='START OF THE OPENING HOURS'), state
OPTIONS(description='STATE'), street_name OPTIONS(description='STREET'), max_length
OPTIONS(description='THE MAXIMUM LENGTH A RESOURCE SET IS ALLOWED TO HAVE TO VISIT THIS ADDRESS.'), max_predelivered_cnt
OPTIONS(description='MAXIMUM NUMBER OF PALLETS THAT CAN BE DELIVERED EARLY PER STORE'), max_undelivered_cnt
OPTIONS(description='MAXIMUM NUMBER OF PALLETS THAT CAN BE DELIVERED LATE PER STORE'), location_lat
OPTIONS(description='THE GEOGRAPHICAL LOCATION.'), location_lon OPTIONS(description='THE GEOGRAPHICAL LOCATION.'),
location_x OPTIONS(description='X VALUE FOR THE LOCATION_1 OBJECT'), location_y
OPTIONS(description='Y VALUE FOR THE LOCATION_1 OBJECT'), location_y_user
OPTIONS(description='Y VALUE FOR THE LOCATION_1 OBJECT'), vehicles_unmanned_delivery_max_cnt
OPTIONS(description='NUMBER OF DIFFERENT VEHICLES ALLOWED (MODELS NUMBER OF KEYS)'), stops_per_delivery_day_user_max_cnt
OPTIONS(description='NUMBER OF STOPS THAT ARE ALLOWED FOR ONE STORE PER DELIVERY DAY SET BY A USER'), max_weight
OPTIONS(description='MAXIMUM WEIGHT OF A TRUCK THAT CAN PARK/APPROACH THE STORE.'), docks_max_cnt
OPTIONS(description='MAXIMUM NUMBER OF (UN)LOADS ALLOWED AT THE SAME TIME'), max_width
OPTIONS(description='THE MAXIMUM WIDTH A RESOURCE SET IS ALLOWED TO HAVE TO VISIT THIS ADDRESS.'), pre_action_duration
OPTIONS(description='FIXED (UN)LOADING TIME IN SECONDS WHEN LOADING IS DONE AT AN ADDRESS_1'),
pre_action_duration_unloading OPTIONS(description='FIXED (UN)LOADING TIME WHEN UNLOADING IS DONE AT AN RDC ONLY'),
additionaladdressinfo OPTIONS(description='ADDITIONAL INFORMATION FOR THE ADDRESS_1 SET BY THE USER E.G. TAX NUMBER'),
hasuniquedefinitionperweekday
OPTIONS(description='TRUE (NOT VIOLATED) IF THERE ARE NO RDCGLOBALPARAMETER OBJECTS THAT COVER ANY OF THE SAME DAYS OF THE WEEK AS THIS OBJECT'),
isaddressindicatoravailable OPTIONS(description='TRUE IF THERE IS INDICATOR RELATED TO THIS RDC ADDRESS_1'),
isclusteravailable OPTIONS(description='TRUE IF THERE IS CLUSTER RELATED TO THIS RDC ADDRESS_1'), nicplacestoreid
OPTIONS(description='PRESENTS WHICH ALERT RULES NICCOMPARTMENT NEEDS TO APPLY WHEN TRAVELLING TO THAT ADDRESS.'),
isemissionfree OPTIONS(description='TRUE IF ONLY EMISSION FREE DELIVERIES ARE ALLOWED ON THIS ADDRESS_1'),
isexternalwarehouse OPTIONS(description='TRUE IF THIS IS AN EXTERNAL WAREHOUSE'), isinternalwarehouse
OPTIONS(description='TRUE IF THIS IS AN INTERNAL WAREHOUSE'), isnonfoodwarehouse
OPTIONS(description='TRUE IF THIS IS A NON FOOD WAREHOUSE'), dwh_load_id OPTIONS(description='LOAD ID'), dwh_created
OPTIONS(description='RECORD CREATED AT'), dwh_updated OPTIONS(description='RECORD UPDATED AT'), dwh_valid_from
OPTIONS(description='VALID FROM DATE'), dwh_valid_to OPTIONS(description='VALID TO DATE'), deleted_fg
OPTIONS(description='FLAG IF RECORD IS DELETED')) OPTIONS(DESCRIPTION = `QUINTIQ - PREPARED VIEW ON RAW DATA`) AS SELECT
 *
FROM ldl_logop_data.t_quintiq_rdcaddress_1;