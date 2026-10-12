create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_L_BONUSKAUF_1(
	MANDANT_ID,
	BONUSKAUF_ID,
	ZEIT_VON,
	ZEIT_BIS,
	KONDITIONSART_ID,
	GESCHAEFTSVORFALL_ID,
	DAT_VON,
	DAT_BIS,
	AKTION_ID
) as SELECT
mandant_id,
bonuskauf_id,
try_to_time(to_char(MOD(zeit_von,'240000'),'000000'),'HH24MISS') as zeit_von,
try_to_time(to_char(MOD(zeit_bis,'240000'),'000000'),'HH24MISS') as zeit_bis,
konditionsart_id,
geschaeftsvorfall_id,
dat_von,
dat_bis,
aktion_id
FROM dbp_data.l_bonuskauf_1

;
