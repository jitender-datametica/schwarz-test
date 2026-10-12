--==============================================================
-- Table: art_wup_status_periode
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_wup_status_periode
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:30 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.art_wup_status_periode (
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig)            '),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
gjmo BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Geschäftsjahresmonat'),
menge_bestand_umlag_bme NUMERIC(18,3) DEFAULT 0 NOT NULL
OPTIONS(description='Umlagerungsbestand (Werk an Werk) aus dem Quellfeld umlmc'),
menge_bestand_transit_bme NUMERIC(18,3) DEFAULT 0 NOT NULL OPTIONS(description='Transitbestand aus dem Quellfeld trame'),
menge_bestand_geb_leergut NUMERIC(18,3) DEFAULT 0 NOT NULL
OPTIONS(description='Gebundener Leergutbestand  (ist dem Vollgut als Leergutkomponente Zugeordnet) aus dem Quellfeld glgmg'),
gjmo_bis BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Geschäftsjahresmonat bis. Wird im DWH angereichert, um die Abfrage bei Lücken in den Monaten zu vereinfachen'),
marc_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='kennzeichnet die Quelltabelle des Satzes. Wenn aus marc dann = 1, march = 0'),
vk_brutto NUMERIC(9,3) DEFAULT 0 NOT NULL
OPTIONS(description='Der Verkaufspreis (bei auf den Monat bezogenen Daten zum Monatsletzten) wird aus art_wup_zu_per angereichert '),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (art_id, mandant_id, wup_id, nb_id, gjmo) NOT ENFORCED
) CLUSTER BY mandant_id
OPTIONS(description='WWC - Artikelstatus pro wup und Monat aus den Quelltabellen marc und march');