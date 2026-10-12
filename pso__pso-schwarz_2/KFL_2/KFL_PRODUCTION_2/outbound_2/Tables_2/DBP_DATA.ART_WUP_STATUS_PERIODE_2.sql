--==============================================================
-- Table: art_wup_status_periode_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_wup_status_periode_2
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:30 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.art_wup_status_periode_2 (
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig)            '),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
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
OPTIONS(description='kennzeichnet die Quelltabelle des Satzes. Wenn aus marc_2 dann = 1, march = 0'),
vk_brutto NUMERIC(9,3) DEFAULT 0 NOT NULL
OPTIONS(description='Der Verkaufspreis (bei auf den Monat_2 bezogenen Daten zum Monatsletzten) wird aus art_wup_zu_per_2 angereichert '),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (art_id, mandant_id, wup_id, nb_id, gjmo) NOT ENFORCED
) CLUSTER BY mandant_id
OPTIONS(description='WWC - Artikelstatus pro wup_2 und Monat_2 aus den Quelltabellen marc_2 und march');