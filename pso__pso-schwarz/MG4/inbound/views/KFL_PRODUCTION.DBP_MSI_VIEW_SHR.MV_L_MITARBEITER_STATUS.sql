create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_SHR.MV_L_MITARBEITER_STATUS(
	MANDANT_ID,
	MA_STATUS_ID
) as
   SELECT
   v01.mandant_id, v01.ma_status_id

   FROM dbp_view.v_l_mitarbeiter_status v01;