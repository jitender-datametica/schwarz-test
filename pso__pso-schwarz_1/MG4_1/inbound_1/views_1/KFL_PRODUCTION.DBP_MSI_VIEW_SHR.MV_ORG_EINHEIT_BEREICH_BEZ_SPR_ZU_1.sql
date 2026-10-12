create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_SHR.MV_ORG_EINHEIT_BEREICH_BEZ_SPR_ZU_1(
	MANDANT_ID,
	HR_OBJEKT_ID,
	HR_OBJEKT_BEZ_KURZ,
	HR_OBJEKT_BEREICH_ID,
	HR_OBJEKT_BEREICH_BEZ
) as
   SELECT
   v01.mandant_id, v01.hr_objekt_id, v01.hr_objekt_bez_kurz, v01.hr_objekt_bereich_id, v02.hr_objekt_bereich_bez

   FROM dbp_view.v_l_org_einheit_1 v01
   JOIN dbp_view.v_org_einheit_bereich_spr_zu_1 v02
   ON v01.hr_objekt_bereich_id = v02.hr_objekt_bereich_id
   WHERE v02.spr_id = 22;