create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW.MV_LAGERBEW_1(
	MANDANT_ID,
	LAGERBEW_BELEG_ID,
	KJ,
	VORGANGSART_ID,
	DAT_BUCH,
	BELEG_USER_NAME,
	WAREN_BEGL_SCHEIN_ID,
	DAT_BELEG,
	DAT_ERFASST,
	BELEGART_ID,
	SYSTEM_ID,
	BELEGKOPFTEXT,
	REF_LAGERBEW_BELEG_ID
) as
SELECT
mandant_id,
lagerbew_beleg_id,
kj,
vorgangsart_id,
dat_buch,
beleg_user_name,
coalesce(waren_begl_schein_id,''),
dat_beleg,
dat_erfasst,
belegart_id,
7,
belegkopftext,
COALESCE(ref_lagerbew_beleg_id,'-1') as ref_lagerbew_beleg_id
FROM dbp_view.v_lagerbew_1
WHERE mandant_id = 1;
