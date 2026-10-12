create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_SHR_MATERIALIZED.MV_ORG_EINHEIT_HIERARCHIE_1(
	MANDANT_ID,
	HR_OBJEKT_EBENE1_ID,
	HR_OBJEKT_EBENE2_ID,
	HR_OBJEKT_EBENE3_ID,
	HR_OBJEKT_EBENE4_ID,
	HR_OBJEKT_EBENE5_ID,
	HR_OBJEKT_EBENE6_ID,
	HR_OBJEKT_EBENE7_ID,
	HR_OBJEKT_EBENE8_ID,
	HR_OBJEKT_EBENE9_ID,
	HR_OBJEKT_EBENE10_ID,
	HR_OBJEKT_EBENE11_ID,
	KOSTENSTELLE_ID,
	HR_OBJEKT_EBENE1_BEZ,
	HR_OBJEKT_EBENE2_BEZ,
	HR_OBJEKT_EBENE3_BEZ,
	HR_OBJEKT_EBENE4_BEZ,
	HR_OBJEKT_EBENE5_BEZ,
	HR_OBJEKT_EBENE6_BEZ,
	HR_OBJEKT_EBENE7_BEZ,
	HR_OBJEKT_EBENE8_BEZ,
	HR_OBJEKT_EBENE9_BEZ,
	HR_OBJEKT_EBENE10_BEZ,
	HR_OBJEKT_EBENE11_BEZ,
	KJMO,
	MANDANT_SORT_ID,
	USER_ID
) as
--20150615 kkaiser - FB will im Land_1 6/7 nur landesspezifische Daten anzeigen lassen, deutsche Werte sind in diesen Ländern mangelhaft gepflegt
--20210715 richternic - SPEC0119986 Mandant_1 4/7 sind nun die deutschen Uebersetzung soweit gepflegt
--20240129 twie: NSR4267530 user_id ist in MSI zukünftig nur noch in Kleinbuchstaben

   SELECT
     v01.mandant_id
   , v01.hr_objekt_ebene1_id
   , v01.hr_objekt_ebene2_id
   , v01.hr_objekt_ebene3_id
   , v01.hr_objekt_ebene4_id
   , v01.hr_objekt_ebene5_id
   , v01.hr_objekt_ebene6_id
   , v01.hr_objekt_ebene7_id
   , v01.hr_objekt_ebene8_id
   , v01.hr_objekt_ebene9_id
   , v01.hr_objekt_ebene10_id
   , v01.hr_objekt_ebene11_id
   , v01.kostenstelle_id
   , v01.hr_objekt_ebene1_bez
   , v01.hr_objekt_ebene2_bez
   , v01.hr_objekt_ebene3_bez
   , v01.hr_objekt_ebene4_bez
   , v01.hr_objekt_ebene5_bez
   , v01.hr_objekt_ebene6_bez
   , v01.hr_objekt_ebene7_bez
   , v01.hr_objekt_ebene8_bez
   , v01.hr_objekt_ebene9_bez
   , v01.hr_objekt_ebene10_bez
   , v01.hr_objekt_ebene11_bez
   , v01.kjmo
   , v01.om_sort_id
   , LOWER(v03.user_id) AS user_id

   FROM KFL_PRODUCTION.DBP_MSI_VIEW_SHR_MATERIALIZED.TBL_MV_ORG_EINHEIT_HIERARCHIE_1 v01

   JOIN
   (
   SELECT
     v021.user_id
   , v021.hr_objekt_ebene1_id
   , v021.mandant_id
   , v022.session_id
   FROM dbp_security.user_hr_objekt_id_zu_1 v021
   JOIN dbp_msi.akt_msi_user_1 v022
   ON v021.user_id = v022.user_id
   ) v03
   ON v01.hr_objekt_ebene1_id = v03.hr_objekt_ebene1_id
   AND v01.mandant_id = v03.mandant_id
   AND v03.session_id = current_session()

   JOIN dbp_msi.akt_msi_user_1 v04
   ON v03.user_id = v04.user_id
   AND v04.session_id = current_session()

   JOIN dbp_msi_v_view.v_user_spr_zu_1 v05
   ON v04.user_id = v05.user_id
   AND v05.spr_id = v01.spr_id;