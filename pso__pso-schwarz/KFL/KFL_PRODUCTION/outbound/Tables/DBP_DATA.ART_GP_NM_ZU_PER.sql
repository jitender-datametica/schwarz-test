--==============================================================
-- Table: art_gp_nm_zu_per
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_gp_nm_zu_per
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:29 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.art_gp_nm_zu_per (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
art_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH Artikelnummer'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
dat_von DATE NOT NULL OPTIONS(description='Beginn der Gültigkeitsperiode            '),
gp_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Geschäftspartner - ID (Lieferanten - ID)'),
einkaufsorganisation_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Für verschiedene Unternehmensbereiche - Warenhandel, Fleischwerk - existieren unterschiedliche Einkaufsorganisationen'),
dat_bis DATE NOT NULL OPTIONS(description='Datum, bis zu dem die Zuordnung gilt. Bei aktuellen Zuordnungen: 9999-12-31'),
vz_wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Verteilzentrum, von dem der Artikel beschafft wird. Falls der Artikel nicht aus einem VZ kommt, ist in diesem Feld der Markt selbst gespeichert'),
bq_findung_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID zur Kennzeichnung eines Ausstiegspunkts aus dem Kreisprozess'),
bezugsweg_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Kennzeichnet, ob der Artikel vom Zentrallager bezogen wird (Bezugsweg = 4) oder direkt vom Lieferanten (Bezugsweg = 1)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, art_id, wup_id, nb_id, dat_von) NOT ENFORCED
)
OPTIONS(description='TP2_AIS - Artikel - Lieferanten-Zuordnung mit n:m - Beziehung. Enthält den Markt zur Herstellung der Eindeutigkeit. (entspricht etwa Tabelle art_gp_zu_per plus wup_id)');