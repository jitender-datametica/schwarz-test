create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_SHR.MV_HR_MITARBEITER_2(
	MANDANT_ID,
	MITARBEITER_ID,
	DAT_GEBURTSTAG,
	LAND_ID,
	DAT_UEBERNAHME_AZUBI
) as
   SELECT
   v01.mandant_id, v01.mitarbeiter_id, v01.dat_geburtstag, v01.land_id, v01.dat_uebernahme_azubi

   FROM dbp_view.v_hr_mitarbeiter_2 v01;