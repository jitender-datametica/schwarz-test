create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_REB.MV_HWG_ZU_PER(
	HWG_ID,
	MANDANT_ID,
	DAT_VON,
	DAT_BIS,
	ARTHIERTYP_ID
) as
   SELECT
   hwg_id, mandant_id, dat_von, dat_bis, arthiertyp_id

   FROM dbp_view.v_hwg_per
   WHERE mandant_id = 1
   AND CURRENT_DATE BETWEEN dat_von AND dat_bis;