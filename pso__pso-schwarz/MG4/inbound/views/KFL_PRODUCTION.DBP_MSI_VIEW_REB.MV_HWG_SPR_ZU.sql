create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_REB.MV_HWG_SPR_ZU(
	HWG_ID,
	HWG_BEZ,
	MANDANT_ID,
	ARTHIERTYP_ID,
	SPR_ID
) as
   SELECT
   v01.hwg_id, v02.hwg_bez, v01.mandant_id, v01.arthiertyp_id, v02.spr_id
   FROM dbp_view.v_hwg_per v01
   INNER JOIN dbp_view.v_hwg_spr_zu v02
   ON v02.mandant_id = v01.mandant_id
   AND v02.hwg_id = v01.hwg_id
   AND v02.spr_id = 22

   WHERE v01.mandant_id = 1
   AND CURRENT_DATE BETWEEN v01.dat_von AND v01.dat_bis;