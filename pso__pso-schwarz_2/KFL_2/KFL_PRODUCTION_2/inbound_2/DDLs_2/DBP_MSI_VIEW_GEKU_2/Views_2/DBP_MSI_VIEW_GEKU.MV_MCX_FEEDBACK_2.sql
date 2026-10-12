CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_MCX_FEEDBACK_2
(
	FEEDBACK_ID,
	UMFRAGE_ID,
	BEFRAGTER_ID,
	SCALE_ID,
	ANTWORT_ID,
	KMR_QUELLE_ID,
	DATZEIT_ABSCHLUSS,
	DAT_FEEDBACK,
	ABSCHLUSS_ID,
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	DAT,
	ZEITSPANNE_ID,
	ZEITSPANNE,
	BONWERTSPANNE,
	OK_FG
) AS

-- 20180502 twie: SPEC0037245 Neuanlage Bewegungsdaten Maritz
--                            ohne GF_2, wird über WUP_2 ermittelt, in DE ein Dummy_2 WUP_2 pro GF_2
--                            Frage ist Elternattribut zu Antwort, deshalb FK in mcx_l_antwort_2 benutzen, nicht die frage_id aus dieser Tabelle
-- 20180529 twie: SPEC0038139 Schlüssel für Antwort um kmr_quelle_id ergänzt für Zusammenführung Hierarchie
-- 20190404 twie: SPEC0053317 Umfrage im Schlüssel, nicht mehr auf umfrage_id 20 gefiltert, da jetzt mehrere Umfragen vorhanden
-- 20200402 lsvi: SPEC0055162 Column zeitspanne_id added
-- 20240814 twie: SPEC0261627 Filialumgliederung (P1760) alle Filialen werden in den Views von wup_id auf aktuell_wup_id umgemappt
--							  somit im Frontend nur die neue ID, auch alte Bewegungsdaten werden ab Umgliederungsdatum unter der neuen ID angzeigt 

    SELECT 
    v01.feedback_id,
    v01.umfrage_id,
    v01.befragter_id,
    v01.scale_id,
    v01.antwort_id,
    2 AS kmr_quelle_id,
    v01.datzeit_abschluss,
    v01.dat_feedback,
    v01.abschluss_id,
    v01.mandant_id,
    v04.aktuell_wup_id AS wup_id,
    v01.nb_id,
    v01.dat,
    v01.zeitspanne_id,
    v01.zeitspanne,
    v01.bonwertspanne,
    v02.ok_fg
    FROM dbp_view.v_mcx_feedback_2 v01

    INNER JOIN dbp_view.v_mcx_l_antwort_ok_fg_2 v02 
    ON v01.antwort_id = v02.antwort_id
    AND v01.umfrage_id = v02.umfrage_id

    INNER JOIN dbp_view.v_mcx_antwort_kategorie_zu_2 v03 
    ON v01.antwort_id = v03.antwort_id
    AND v01.umfrage_id = v03.umfrage_id
    --nur Daten mit zugeordneter Kategorie sind relevant
    AND v03.kat_id <> -1
    
    INNER JOIN  dbp_view.v_wup_2 v04
	ON v01.wup_id = v04.wup_id
	AND v01.mandant_id = v04.mandant_id
;