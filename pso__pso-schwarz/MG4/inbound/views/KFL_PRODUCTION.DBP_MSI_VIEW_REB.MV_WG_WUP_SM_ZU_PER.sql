create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_REB.MV_WG_WUP_SM_ZU_PER(
	MANDANT_ID,
	WUP_ID,
	WG_ID,
	NB_ID,
	DAT_VON,
	ARTHIERTYP_ID,
	DAT_BIS,
	SM_ID
) as
   SELECT
   mandant_id, wup_id, wg_id, nb_id, dat_von, arthiertyp_id, dat_bis, sm_id

   FROM dbp_view.v_sm_wup_wg_zu_per
   WHERE mandant_id = 1
   AND arthiertyp_id = 2
   AND dat_bis = '9999-12-31'
   
   AND nb_id <> 99
;