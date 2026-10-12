create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_SHR.MV_L_ORG_EINHEIT(
	MANDANT_ID,
	HR_OBJEKT_ID,
	OBJEKT_TYP_ID,
	HR_OBJEKT_BEZ_KURZ
) as
   SELECT
   v01.mandant_id, v01.hr_objekt_id, v01.objekt_typ_id, v01.hr_objekt_bez_kurz

   FROM dbp_view.v_l_org_einheit v01;