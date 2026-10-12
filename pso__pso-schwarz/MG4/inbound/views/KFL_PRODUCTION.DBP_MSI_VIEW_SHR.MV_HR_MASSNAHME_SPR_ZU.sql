create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_SHR.MV_HR_MASSNAHME_SPR_ZU(
	MANDANT_ID,
	HR_MASSNAHME_GRUND_ID,
	HR_MASSNAHME_ID,
	HR_MASSNAHME_GRUND_BEZ
) as
   SELECT
   v01.mandant_id, v01.hr_massnahme_grund_id, v01.hr_massnahme_id, v01.hr_massnahme_grund_bez

   FROM dbp_view.v_hr_massnahme_spr_zu v01
   WHERE v01.spr_id = 22
;