create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_SHR.MV_MITARBEITER_STATU_SPR_ZU(
	MANDANT_ID,
	MA_STATUS_ID,
	MA_STATUS_BEZ
) as
   SELECT
   v01.mandant_id, v01.ma_status_id, v01.ma_status_bez

   FROM dbp_view.v_mitarbeiter_status_spr_zu v01
   WHERE v01.spr_id = 22
;