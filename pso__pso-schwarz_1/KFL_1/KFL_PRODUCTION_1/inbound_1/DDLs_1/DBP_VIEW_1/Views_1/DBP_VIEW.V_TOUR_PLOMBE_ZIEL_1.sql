create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_TOUR_PLOMBE_ZIEL_1(
	MANDANT_ID,
	NB_ID,
	WUP_ID,
	TOUR_ID,
	PLOMBE_ID,
	PLOMBE_PROZESS_ID,
	PLOMBE_AKTIVITAET,
	DAT_SCAN,
	ZEIT_SCAN,
	INFO_CODE
) as SELECT
mandant_id,
nb_id,
wup_id,
tour_id,
plombe_id,
plombe_prozess_id,
plombe_aktivitaet,
dat_scan,
try_to_time(to_char(MOD(zeit_scan,'240000'),'000000'),'HH24MISS') as zeit_scan,
info_code

FROM dbp_data.tour_plombe_ziel_1

;
