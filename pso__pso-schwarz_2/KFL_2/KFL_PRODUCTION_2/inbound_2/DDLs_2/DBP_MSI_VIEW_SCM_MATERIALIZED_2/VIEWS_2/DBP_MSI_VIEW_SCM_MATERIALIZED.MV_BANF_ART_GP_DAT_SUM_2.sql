create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_BANF_ART_GP_DAT_SUM_2(
	MANDANT_ID,
	ART_ID,
	GP_ID,
	WUP_ID,
	NB_ID,
	DAT_LIEF_SOLL,
	IN_AKTION_FG,
	DAT_KALK,
	VK_BRUTTO,
	BANF_MENGE_KOLLI,
	FORECAST_MENGE_KOLLI,
	MENGE_BEST_KOLLI,
	BANF_MENGE_KG,
	FORECAST_MENGE_KG,
	MENGE_BEST_KG
) as
   SELECT
     
   
   v01.mandant_id
   , art_id, gp_id, 
   
   
   v05.aktuell_wup_id wup_id,
   v01.nb_id, dat_lief_soll, in_aktion_fg       
   , dat_kalk, vk_brutto, banf_menge_kolli, forecast_menge_kolli, menge_best_kolli, banf_menge_kg, forecast_menge_kg, menge_best_kg
   FROM dbp_view.v_banf_art_gp_dat_sum_2 v01
   INNER JOIN dbp_view.v_wup_2 v05
   ON v05.mandant_id = v01.mandant_id 
   
   AND v05.wup_id = v01.wup_id
   AND ((v05.nb_id IN (2, 0, -111) AND v05.wup_id > 0) OR (v05.nb_id = -1 AND v05.wup_id = 0));