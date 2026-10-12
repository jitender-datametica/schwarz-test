--==============================================================
-- Table: artbew_konto_tag
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: artbew_konto_tag
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:30 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.artbew_konto_tag (
konto_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Nummer des Kontos'),
arthiertyp_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Artikel - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt            '),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
bewart_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Hier ist nur bewart 1006 drin - Tageskorrektur'),
dat DATE NOT NULL OPTIONS(description='Tagesdatum'),
umsatz_brutto NUMERIC(18,2) NOT NULL OPTIONS(description='Bruttoumsatz in Originalwaehrung'),
umsatz_netto NUMERIC(18,2) NOT NULL OPTIONS(description='Umsatz bereinigt um Mehrwertsteuer in Originalwaehrung'),
umsatz_wrg STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Waehrung des Originalumsatzes'),
umsatz_brutto_konz NUMERIC(18,2) NOT NULL OPTIONS(description='Bruttoumsatz in Konzernwaehrung'),
umsatz_netto_konz NUMERIC(18,2) NOT NULL OPTIONS(description='Umsatz bereinigt um Mehrwertsteuer in Konzernwaehrung'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (konto_id, arthiertyp_id, mandant_id, wup_id, nb_id, bewart_id, dat) NOT ENFORCED
) OPTIONS(description='TP1_MIS - Sicherungstabelle fuer Kontoumsaetze taeglich Umsnetto');