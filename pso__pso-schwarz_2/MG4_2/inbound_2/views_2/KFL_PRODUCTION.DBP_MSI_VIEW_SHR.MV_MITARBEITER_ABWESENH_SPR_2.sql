create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_SHR.MV_MITARBEITER_ABWESENH_SPR_2(
	MANDANT_ID,
	ABWESENHEIT_ID,
	SPR_ID,
	ABWESENHEIT_BEZ
) as
   SELECT
   v01.mandant_id, v01.abwesenheit_id, v01.spr_id, v01.abwesenheit_bez


   FROM dbp_view.v_mitarbeiter_abwesenh_spr_zu_2 v01
   WHERE spr_id = 22
;