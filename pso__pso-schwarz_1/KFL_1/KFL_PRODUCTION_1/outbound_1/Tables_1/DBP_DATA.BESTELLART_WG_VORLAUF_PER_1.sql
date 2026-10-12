--==============================================================
-- Table: bestellart_wg_vorlauf_per_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: bestellart_wg_vorlauf_per_1
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:14 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.bestellart_wg_vorlauf_per_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
wg_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Warengruppe'),
arthiertyp_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Artikel_1 - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine_1 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt'),
bestellart_id STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Durch die Einkaufsbelegart kann man z.B. zwischen einer Bestellung, einer Anfrage und einem Lieferplan unterscheiden.'),
dat_von DATE NOT NULL OPTIONS(description='Datum im Format JJJJ-MM_1-TT'),
dat_bis DATE NOT NULL OPTIONS(description='Datum im Format JJJJ-MM_1-TT'),
tage_vorlauf BIGNUMERIC(38,0) DEFAULT 0 NOT NULL OPTIONS(description='Anzahl Tage Vorlauf'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wg_id, arthiertyp_id, dat_von) NOT ENFORCED
) OPTIONS(description='SCM - Tagevorlauf zur Ermittlung des Lieferdatums, aus SAP ZSCM_DC_GI_DATE');