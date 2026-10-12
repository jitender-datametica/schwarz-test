create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_WUP_KUNDE_WG_DISPORHYTHMUS_LFT_ZU_PER_1(
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	MANDANT_ID_KUNDE,
	KUNDE_ID,
	WG_ID,
	ARTHIERTYP_ID,
	SORTIMENTSLISTENART_ID,
	TERMINIERUNGSGRUPPE_1_ID,
	TERMINIERUNGSGRUPPE_2_ID,
	TERMINIERUNGSGRUPPE_3_ID,
	DAT_VON,
	DAT_BIS,
	AUSLIEFERUNGSGRUPPE_ID,
	DISPOSITION_RHYTHMUS_LTF_ID
) as
   SELECT
   v01.mandant_id, v01.wup_id, v01.nb_id, v01.mandant_id AS mandant_id_kunde 
   , v01.kunde_id, v01.wg_id, v01.arthiertyp_id, v01.sortimentslistenart_id, v01.terminierungsgruppe_1_id, v01.terminierungsgruppe_2_id, v01.terminierungsgruppe_3_id, v01.dat_von, v01.dat_bis, v01.auslieferungsgruppe_id, v01.disposition_rhythmus_ltf_id

   FROM dbp_view.v_wup_kunde_wg_disporhythmus_lft_zu_per_1 v01
   WHERE CURRENT_DATE BETWEEN dat_von AND dat_bis;