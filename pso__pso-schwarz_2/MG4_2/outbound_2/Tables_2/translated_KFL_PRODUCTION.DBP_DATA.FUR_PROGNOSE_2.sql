DROP TABLE IF EXISTS kfl_production_dbp_data.fur_prognose_2;
CREATE OR REPLACE TABLE kfl_production_dbp_data.fur_prognose_2 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH'),
wup_id INTEGER NOT NULL OPTIONS(description='Marktnummer'),
nb_id INTEGER NOT NULL OPTIONS(description=' Nebenbetriebskennziffer'),
art_id INTEGER NOT NULL OPTIONS(description='DWH-Artikelnummer'),
dat DATE NOT NULL OPTIONS(description='Prognosedatumim Format JJJJ-MM_2-TT'),
menge_prognose NUMERIC(13,3) DEFAULT 0 NOT NULL
OPTIONS(description='Normalprognosemenge in Basismengeneinheit  aus dem Quellfeld fc_mean '),
menge_prognose_bef NUMERIC(13,3) DEFAULT 0 NOT NULL
OPTIONS(description='Normalprognosemenge  in Basismengeneinheit verändert um den BEF (Bedarfseinflussfaktor)  aus dem Quellfeld fc_dif_effect'),
menge_prognose_max NUMERIC(13,3) DEFAULT 0 NOT NULL
OPTIONS(description='Maximalprognosemenge in Basismengeneinheit  aus dem Quellfeld fc_max'),
listung_id INTEGER NOT NULL
OPTIONS(description='kennzeichnet die Zulistung eines Artikels zum Markt: 1 = gelistet, 0 = nicht mehr gelistet. Denormalisiert - aus art_wup_zu_per_2 angereichert'),
kdis INTEGER NOT NULL
OPTIONS(description='kdis = kein Druck in Sortimentsliste. Kennzeichnet die Bestellbarkeit eines Artikels. kdis 0: der Artikel_2 ist über den normalen Weg bestellbar, 1: der Artikel_2 wird  zugeteilt'),
dispomerkmal STRING(2) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Dispomerkmal. Denormalisiert aus der Tabelle art_wup_status_per. Referenz zur Lookuptabelle l_dispomerkmal_2'),
progn_groesser_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='menge_prognose ist größer als die menge_af in bestimmten Verhältnissen zur menge_af (unter Berücksichtigung von Toleranzen)'),
menge_af_groesser_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='menge_af ist größer als die menge_prognose in bestimmten Verhältnissen zur menge_af (unter Berücksichtigung von Toleranzen)'),
menge_prognose_aktion NUMERIC(13,3) DEFAULT 0 NOT NULL
OPTIONS(description='Prognostizierte Aktionsmenge. Wird vorläufig nur gefüllt sein für Backshop-Artikel_2 (WG 291), wenn sie in Aktion_2 sind. Aus der Quellspalte fc_act'),
prognose_horizont INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Prognosehorizont: für wie viele Tage gab es prognostizierte Mengen (wie viele Felder von ZFRE_DWH_FCST.menge_01 bis menge_35 waren gefüllt)'),
menge_ofc NUMERIC(13,3) OPTIONS(description='Menge OF'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wup_id, nb_id, art_id, dat) NOT ENFORCED
) CLUSTER BY mandant_id, dat
OPTIONS(description='AIS - Hier werden die prognostizierten Abverkaufsmengen aus SAP F&R für 35 Tage im Voraus und mehrere Jahre historisch gespeichert');