create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU_MATERIALIZED.MV_MDL_FEEDBACK(
	FEEDBACK_ID,
	FRAGE_ID,
	ANTWORT_ID,
	DAT_FEEDBACK,
	DAT_EINKAUF,
	ZEITSPANNE_EINKAUF_ID,
	MANDANT_ID,
	GF_ID,
	WUP_ID,
	NB_ID
) as









SELECT
  v01.feedback_id
 ,v01.frage_id
 ,v01.antwort_id
 ,v01.dat_feedback
 ,v01.dat_einkauf
 ,v01.zeitspanne_einkauf_id
 ,v01.mandant_id
 ,v01.gf_id
 ,v02.aktuell_wup_id AS wup_id
 ,v01.nb_id

 FROM dbp_view.v_mdl_feedback v01
 
 INNER JOIN  dbp_view.v_wup v02
 ON v01.wup_id = v02.wup_id
 AND v01.mandant_id = v02.mandant_id
 
 WHERE v01.de_wup_load_fg <> 1
 ;
