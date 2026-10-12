create or replace TABLE KFL_PRODUCTION.DBP_DATA.FUR_PROGNOSE cluster by (
     MANDANT_ID,
     DAT 
)(
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH',
	WUP_ID NUMBER(38,0) NOT NULL COMMENT 'Marktnummer',
	NB_ID NUMBER(38,0) NOT NULL COMMENT ' Nebenbetriebskennziffer',
	ART_ID NUMBER(38,0) NOT NULL COMMENT 'DWH-Artikelnummer',
	DAT DATE NOT NULL COMMENT 'Prognosedatumim Format JJJJ-MM-TT',
	MENGE_PROGNOSE NUMBER(13,3) NOT NULL DEFAULT 0 COMMENT 'Normalprognosemenge in Basismengeneinheit  aus dem Quellfeld fc_mean ',
	MENGE_PROGNOSE_BEF NUMBER(13,3) NOT NULL DEFAULT 0 COMMENT 'Normalprognosemenge  in Basismengeneinheit verändert um den BEF (Bedarfseinflussfaktor)  aus dem Quellfeld fc_dif_effect',
	MENGE_PROGNOSE_MAX NUMBER(13,3) NOT NULL DEFAULT 0 COMMENT 'Maximalprognosemenge in Basismengeneinheit  aus dem Quellfeld fc_max',
	LISTUNG_ID NUMBER(38,0) NOT NULL COMMENT 'kennzeichnet die Zulistung eines Artikels zum Markt: 1 = gelistet, 0 = nicht mehr gelistet. Denormalisiert - aus art_wup_zu_per angereichert',
	KDIS NUMBER(38,0) NOT NULL COMMENT 'kdis = kein Druck in Sortimentsliste. Kennzeichnet die Bestellbarkeit eines Artikels. kdis 0: der Artikel ist über den normalen Weg bestellbar, 1: der Artikel wird  zugeteilt',
	DISPOMERKMAL VARCHAR(2) NOT NULL COLLATE 'en-ci' COMMENT 'Dispomerkmal. Denormalisiert aus der Tabelle art_wup_status_per. Referenz zur Lookuptabelle l_dispomerkmal',
	PROGN_GROESSER_FG NUMBER(38,0) NOT NULL DEFAULT 0 COMMENT 'menge_prognose ist größer als die menge_af in bestimmten Verhältnissen zur menge_af (unter Berücksichtigung von Toleranzen)',
	MENGE_AF_GROESSER_FG NUMBER(38,0) NOT NULL DEFAULT 0 COMMENT 'menge_af ist größer als die menge_prognose in bestimmten Verhältnissen zur menge_af (unter Berücksichtigung von Toleranzen)',
	MENGE_PROGNOSE_AKTION NUMBER(13,3) NOT NULL DEFAULT 0 COMMENT 'Prognostizierte Aktionsmenge. Wird vorläufig nur gefüllt sein für Backshop-Artikel (WG 291), wenn sie in Aktion sind. Aus der Quellspalte fc_act',
	PROGNOSE_HORIZONT NUMBER(38,0) NOT NULL DEFAULT 0 COMMENT 'Prognosehorizont: für wie viele Tage gab es prognostizierte Mengen (wie viele Felder von ZFRE_DWH_FCST.menge_01 bis menge_35 waren gefüllt)',
	MENGE_OFC NUMBER(13,3) COMMENT 'Menge OF',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_FUR_PROGNOSE primary key (MANDANT_ID, WUP_ID, NB_ID, ART_ID, DAT)
)COMMENT='AIS - Hier werden die prognostizierten Abverkaufsmengen aus SAP F&R für 35 Tage im Voraus und mehrere Jahre historisch gespeichert'
;