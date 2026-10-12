--==============================================================
-- Table: abteilung_per
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: abteilung_per
   generated from Powerdesigner on Wednesday, January 31, 2024 2:33:01 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.abteilung_per (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
kstabt_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Abteilungen nach Kostenstellen'),
dat_von DATE NOT NULL OPTIONS(description='Beginn der Gültigkeitsperiode'),
dat_bis DATE NOT NULL OPTIONS(description='Ende der Gültigkeitsperiode'),
kstabt_bez STRING(40) NOT NULL OPTIONS(description='Bezeichnung der Abteilungen nach Kostenstellen'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
abt_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Abteilungs ID negativer Zahlenraum: im DWH generierte ID\'s, positive Werte: aus Stammdatensystem übernommen'),
arthiertyp_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Artikel - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt            '),
dat_extrakt DATE NOT NULL OPTIONS(description='Extraktions- bzw. Erstellungsdatum des Datensatzes'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, kstabt_id, dat_von) NOT ENFORCED
)
OPTIONS(description='VIS - Neue Abteilungstabelle, Zusammenführung der Kostenstellen-Abteilungen mit den TP1-Abteilungen. Soll die Tabellen abt und abt_spr_zu ersetzen.');