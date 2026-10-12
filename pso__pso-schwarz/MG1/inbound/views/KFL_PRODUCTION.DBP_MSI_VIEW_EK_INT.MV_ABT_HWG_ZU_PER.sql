create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_EK_INT.MV_ABT_HWG_ZU_PER(
	ABT_ID,
	HWG_ID,
	MANDANT_ID,
	DAT_VON,
	DAT_BIS,
	ARTHIERTYP_ID
) as
   SELECT
   v01.abt_id,
   v02.hwg_id,
   v01.mandant_id,
   v02.dat_von,
   v02.dat_bis,
   v01.arthiertyp_id
   --abt_id
   FROM
   dbp_view.v_abt v01
   INNER JOIN dbp_view.v_hwg_per v02
   ON v01.mandant_id = v02.mandant_id
   AND v01.abt_id = v02.abt_id
   AND CURRENT_DATE BETWEEN v02.dat_von AND v02.dat_bis;