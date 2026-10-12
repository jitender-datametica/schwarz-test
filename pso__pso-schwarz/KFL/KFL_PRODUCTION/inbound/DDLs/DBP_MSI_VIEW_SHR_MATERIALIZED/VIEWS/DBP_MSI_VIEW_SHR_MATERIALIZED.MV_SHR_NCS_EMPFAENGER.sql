create or replace view DBP_MSI_VIEW_SHR_MATERIALIZED.MV_SHR_NCS_EMPFAENGER(
	MANDANT_ID,
	HR_OBJEKT_EBENE1_ID,
	EMAIL,
	VORNAME,
	NACHNAME,
	GESCHLECHT_ID,
	KJMO
) as
   SELECT
   v01.mandant_id, v01.hr_objekt_ebene1_id, v01.email, v01.vorname, v01.nachname, v01.geschlecht_id, v01.kjmo
   FROM dbp_security.shr_ncs_empfaenger v01
   JOIN DBP_MSI_VIEW_SHR_MATERIALIZED.mv_abrechnungsmonat v02
   ON v01.kjmo = v02.kjmo_abr
   AND v01.mandant_id = v02.mandant_id;