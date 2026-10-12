create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_SHR.MV_L_MITARBEITER_STATUS_2(
	MANDANT_ID,
	MA_STATUS_ID
) as
   SELECT
   v01.mandant_id, v01.ma_status_id

   FROM dbp_view.v_l_mitarbeiter_status_2 v01;