create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_SHR.MV_L_UNTERNMNS_BEREICH(
	MANDANT_ID,
	UNTERNEHMENS_BEREICH_ID
) as
   SELECT
   v01.mandant_id, v01.unternehmens_bereich_id

   FROM dbp_view.v_l_unternmns_bereich v01



;