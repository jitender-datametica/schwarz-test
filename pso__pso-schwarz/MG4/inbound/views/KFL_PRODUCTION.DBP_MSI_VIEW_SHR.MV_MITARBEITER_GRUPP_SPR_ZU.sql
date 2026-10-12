create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_SHR.MV_MITARBEITER_GRUPP_SPR_ZU(
	MANDANT_ID,
	MITARBEITER_GRUPPE_ID,
	MITARBEITER_GRUPPE_BEZ
) as
   SELECT
   v01.mandant_id, v01.mitarbeiter_gruppe_id, v01.mitarbeiter_gruppe_bez

   FROM dbp_view.v_mitarbeiter_gruppe_spr_zu v01
   WHERE v01.spr_id = 22
;