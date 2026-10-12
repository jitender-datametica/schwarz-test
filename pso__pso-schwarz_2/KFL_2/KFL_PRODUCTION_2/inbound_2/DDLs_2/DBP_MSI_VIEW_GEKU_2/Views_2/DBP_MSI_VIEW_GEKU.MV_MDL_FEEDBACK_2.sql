CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_MDL_FEEDBACK_2
(
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
) AS

-- 22.09.2020 SPEC0087215, AP0066293, Pawel Staniszewski, Creation of the View 
-- 20.11.2020 SPEC0087215, AP0066293, Pawel Staniszewski, adding new Flag for Antwort
-- 10.12.2020 SPEC0087215, AP0066293, Pawel Staniszewski, adding new field sek_kz
-- 17.12.2020 SPEC0087215, AP0066293, Pawel Staniszewski, removing old flag
-- 24.02.2021 SPEC0093024, AP0077949, Pawel Staniszewski, excluding German feedbacks/main-questions on store-level
-- 14.08.2024 twie: SPEC0261627 Filialumgliederung (P1760) alle Filialen werden in den Views von wup_id auf aktuell_wup_id umgemappt
--							    somit im Frontend nur die neue ID, auch alte Bewegungsdaten werden ab Umgliederungsdatum unter der neuen ID angzeigt 

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

 FROM dbp_view.v_mdl_feedback_2 v01
 
 INNER JOIN  dbp_view.v_wup_2 v02
 ON v01.wup_id = v02.wup_id
 AND v01.mandant_id = v02.mandant_id
 
 WHERE v01.de_wup_load_fg <> 1
 ;