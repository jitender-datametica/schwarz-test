create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_REB.MV_OWG_PER(
	OWG_ID,
	MANDANT_ID,
	DAT_VON,
	DAT_BIS,
	ARTHIERTYP_ID,
	HWG_ID
) as

   SELECT
   v01.owg_id,
   v01.mandant_id,
   v01.dat_von,
   v01.dat_bis,
   v01.arthiertyp_id,
   v01.hwg_id
   FROM dbp_view.v_owg_per v01

   WHERE v01.mandant_id = 1
   AND CURRENT_DATE BETWEEN v01.dat_von AND v01.dat_bis;