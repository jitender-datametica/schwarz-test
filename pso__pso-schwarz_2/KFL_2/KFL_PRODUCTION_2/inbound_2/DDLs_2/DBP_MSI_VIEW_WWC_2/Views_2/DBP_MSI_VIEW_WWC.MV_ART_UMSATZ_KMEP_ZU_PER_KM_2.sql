create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_WWC.MV_ART_UMSATZ_KMEP_ZU_PER_KM_2(
	MANDANT_ID,
	NB_ID,
	ART_ID,
	ZEITRAUM_KZ,
	DAT_VON,
	DAT_BIS,
	BETRAG_KMEP,
	BETRAG_KMEP_EINH,
	BETRAG_KMEP_EINH_O_FWU,
	BETRAG_KMEP_EINH_ABSCHRIFT,
	KJMO
) as





  
   SELECT
   v01.mandant_id, 
   0 AS nb_id, 
   v01.art_id, 
   v01.zeitraum_kz, 
   v01.dat_von, 
   v01.dat_bis, 
   v01.betrag_kmep, 
   v01.betrag_kmep_einh, 
   v01.betrag_kmep_einh_o_fwu, 
   v01.betrag_kmep_einh_abschrift,
   v02.kjmo
   FROM dbp_view.v_art_umsatz_kmep_zu_per_2 v01
   INNER JOIN dbp_view.v_tag_2 v02
   ON v01.dat_von = v02.dat
   WHERE zeitraum_kz = 'KM';
