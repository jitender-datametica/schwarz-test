create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_L_BACKZEIT_1(
	OFEN_TYP_ID,
	BACK_PROGRAMM_ID,
	GP_BACKEN_BEZ,
	MANDANT_ID,
	BACK_DAUER
) as SELECT
ofen_typ_id,
back_programm_id,
gp_backen_bez,
mandant_id,
try_to_time(to_char(MOD(back_dauer,'240000'),'000000'),'HH24MISS') as back_dauer
FROM dbp_data.l_backzeit_1

;
