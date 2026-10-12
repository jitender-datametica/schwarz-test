create or replace view KFL_PRODUCTION.DBP_MSI_V_VIEW.V_SHR_DATENFREIGABE_1(
	MANDANT_ID,
	KJMO,
	DAT,
	NAT_INT_FG,
	USER_ID,
	FREIGABE_UHRZEIT,
	SHR_FREIGABE_FG,
	DAT_FREIGABE_KENNZAHLEN
) as SELECT
mandant_id,
kjmo,
dat,
nat_int_fg,
user_id,
time_from_parts(0,0,freigabe_uhrzeit/1000) as freigabe_uhrzeit,
shr_freigabe_fg,
dat_freigabe_kennzahlen


FROM dbp_msi_data.shr_datenfreigabe_1

;