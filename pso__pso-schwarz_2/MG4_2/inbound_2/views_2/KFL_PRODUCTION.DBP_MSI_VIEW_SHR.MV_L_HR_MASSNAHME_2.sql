create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_SHR.MV_L_HR_MASSNAHME_2(
	MANDANT_ID,
	HR_MASSNAHME_GRUND_ID,
	HR_MASSNAHME_ID
) as
   SELECT
   v01.mandant_id, v01.hr_massnahme_grund_id, v01.hr_massnahme_id

   FROM dbp_view.v_l_hr_massnahme_2 v01;