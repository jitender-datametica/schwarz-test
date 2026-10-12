DROP TABLE IF EXISTS KFL_PRODUCTION_DBP_DATA.FUR_PROGNOSE;
CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.FUR_PROGNOSE (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
WUP_ID INTEGER NOT NULL OPTIONS(description='Marktnummer'),
NB_ID INTEGER NOT NULL OPTIONS(description=' Nebenbetriebskennziffer'),
ART_ID INTEGER NOT NULL OPTIONS(description='DWH-Artikelnummer'),
DAT DATE NOT NULL OPTIONS(description='Prognosedatumim Format JJJJ-MM-TT'),
MENGE_PROGNOSE NUMERIC(13,3) DEFAULT 0 NOT NULL
OPTIONS(description='Normalprognosemenge in Basismengeneinheit  aus dem Quellfeld fc_mean '),
MENGE_PROGNOSE_BEF NUMERIC(13,3) DEFAULT 0 NOT NULL
OPTIONS(description='Normalprognosemenge  in Basismengeneinheit verändert um den BEF (Bedarfseinflussfaktor)  aus dem Quellfeld fc_dif_effect'),
MENGE_PROGNOSE_MAX NUMERIC(13,3) DEFAULT 0 NOT NULL
OPTIONS(description='Maximalprognosemenge in Basismengeneinheit  aus dem Quellfeld fc_max'),
LISTUNG_ID INTEGER NOT NULL
OPTIONS(description='kennzeichnet die Zulistung eines Artikels zum Markt: 1 = gelistet, 0 = nicht mehr gelistet. Denormalisiert - aus art_wup_zu_per angereichert'),
KDIS INTEGER NOT NULL
OPTIONS(description='kdis = kein Druck in Sortimentsliste. Kennzeichnet die Bestellbarkeit eines Artikels. kdis 0: der Artikel ist über den normalen Weg bestellbar, 1: der Artikel wird  zugeteilt'),
DISPOMERKMAL STRING(2) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Dispomerkmal. Denormalisiert aus der Tabelle art_wup_status_per. Referenz zur Lookuptabelle l_dispomerkmal'),
PROGN_GROESSER_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='menge_prognose ist größer als die menge_af in bestimmten Verhältnissen zur menge_af (unter Berücksichtigung von Toleranzen)'),
MENGE_AF_GROESSER_FG INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='menge_af ist größer als die menge_prognose in bestimmten Verhältnissen zur menge_af (unter Berücksichtigung von Toleranzen)'),
MENGE_PROGNOSE_AKTION NUMERIC(13,3) DEFAULT 0 NOT NULL
OPTIONS(description='Prognostizierte Aktionsmenge. Wird vorläufig nur gefüllt sein für Backshop-Artikel (WG 291), wenn sie in Aktion sind. Aus der Quellspalte fc_act'),
PROGNOSE_HORIZONT INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Prognosehorizont: für wie viele Tage gab es prognostizierte Mengen (wie viele Felder von ZFRE_DWH_FCST.menge_01 bis menge_35 waren gefüllt)'),
MENGE_OFC NUMERIC(13,3) OPTIONS(description='Menge OF'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (MANDANT_ID, WUP_ID, NB_ID, ART_ID, DAT) NOT ENFORCED
) CLUSTER BY MANDANT_ID, DAT
OPTIONS(description='AIS - Hier werden die prognostizierten Abverkaufsmengen aus SAP F&R für 35 Tage im Voraus und mehrere Jahre historisch gespeichert');