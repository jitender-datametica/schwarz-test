create or replace view KFL_PRODUCTION.DBP_SPEZIAL.V_ODS_TALON_UNION_1(
	MANDANT_ID,
	TALON_ID,
	WUP_ID,
	TALON_DAT,
	TALON_BOOKING
) as 
SELECT mandant_id
,talon_id
,wup_id
,talon_dat
,talon_booking
FROM dbp_ods.ods_talon_1
UNION ALL
SELECT mandant_id
,talon_id
,wup_id
,talon_dat
,talon_booking
FROM dbp_ods_archiv.ods_talon_1
;