CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_ODS_BON_F_KOPF_2 (
	BON_ID,
	BON_DAT,
	WUP_ID,
	MANDANT_ID,
	BON_NR,
	KASSE_NR,
	KASSIERER_NR,
	KUNDE_FG,
	BON_BEGINN,
	BON_ENDE,
	UMSATZ_MWST,
	UMSATZ_BRUTTO,
	BON_BOOKING,
	DAT_BOOKING,
	TURNOVER_FG,
	WRG_ID,
	ZEITSTEMPEL_DRUCK,
	FISKALISIERUNG_FG,
	BON_NR_FISCAL,
	ONLINE_FG,
	DIENSTLEISTER_ID,
	ONLINE_TRANSAKTION_ID,
	GERAET_ID,
	ONLINE_BESTELLUNG_NR,
	BON_TYP_ID,
	BON_GEDRUCKT_FG,
	BONDRUCK_ABGELEHNT_FG
) AS

/*
	FAKT-view Gefiltert, d.h. nur nicht stornierte Bons enthalten
	2025-04-02 ssch0611 : Review. MV_ODS_BON_F_KOPF_2 neu aufgebaut aus MV_ODS_BON_KOPF_2 
*/


SELECT k.bon_id
	, k.bon_dat
	, wup.aktuell_wup_id						AS wup_id
	, k.mandant_id
	, k.bon_nr
	, k.kasse_nr
	, 0											AS kassierer_nr -- anonymisiert
	, k.kunde_fg
	, k.bon_beginn
	, k.bon_ende
	, k.umsatz_brutto * krs.umrechnungskurs		AS umsatz_brutto
	, k.umsatz_mwst * krs.umrechnungskurs		AS umsatz_mwst
	, k.bon_booking
	, k.dat_booking
	, k.turnover_fg
	, krs.nach_wrg_id							AS wrg_id
	, '9999-12-31 23:59:59'::TIMESTAMP			AS zeitstempel_druck -- dummy_2 value
	, k.fiskalisierung_fg
	, k.BON_NR_FISCAL
	, k.online_fg
	, k.dienstleister_id 
	, k.online_transaktion_id
	, k.geraet_id
	, k.online_bestellung_nr 
	, k.bon_typ_id
	, k.bon_gedruckt_fg
	, k.bondruck_abgelehnt_fg
FROM dbp_v_ods.v_ods_bon_kopf_2 k

INNER JOIN ( 
	SELECT krs1.von_wrg_id, krs1.nach_wrg_id, krs1.umrechnungskurs 
	FROM dbp_data.kurs_2 krs1 
	WHERE krs1.kurstyp_id = 3 AND krs1.dat_bis = '9999-12-31' 
		AND krs1.von_wrg_id NOT IN ('AUD', 'DEM', 'SIT') 
	UNION ALL 
	SELECT krs2.von_wrg_id, krs2.von_wrg_id, 1.0000 
	FROM dbp_data.kurs_2 krs2 
	WHERE krs2.kurstyp_id = 3 AND krs2.dat_bis = '9999-12-31'  
		AND krs2.von_wrg_id NOT IN ('AUD', 'DEM', 'SIT', 'EUR')  
) krs
ON krs.von_wrg_id = k.wrg_id

INNER JOIN dbp_view.v_wup_2 wup_2
ON k.mandant_id = wup.mandant_id AND k.wup_id = wup.wup_id

WHERE k.turnover_fg = 1
	AND (k.bon_id, k.wup_id, k.mandant_id) NOT IN (
	/* Ausschluss stornierte Bons */
	SELECT bon_id, wup_id, mandant_id 
	FROM dbp_v_ods.v_ods_bon_storno_2
	)
;