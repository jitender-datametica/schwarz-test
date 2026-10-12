create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_SHR.MV_L_MA_TARIFGEBIET_1(
	MANDANT_ID,
	TARIFGEBIET_ID
) as
   SELECT
   v01.mandant_id, v01.tarifgebiet_id

   FROM dbp_view.v_l_ma_tarifgebiet_1 v01
;