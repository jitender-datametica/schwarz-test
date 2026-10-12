create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_EK_INT.MV_WG_PER(
	MANDANT_ID,
	ARTHIERTYP_ID,
	LEAD_MWST_ID,
	WG_ID,
	ABT_ID,
	DAT_VON,
	DAT_BIS,
	OWG_ID
) as
   SELECT
   v01.mandant_id, v01.arthiertyp_id, v01.lead_mwst_id, v01.wg_id, v01.abt_id, v01.dat_von, v01.dat_bis, v01.owg_id

   FROM dbp_view.v_wg_per v01

   WHERE dat_bis > CURRENT_DATE
   AND   arthiertyp_id = 2;