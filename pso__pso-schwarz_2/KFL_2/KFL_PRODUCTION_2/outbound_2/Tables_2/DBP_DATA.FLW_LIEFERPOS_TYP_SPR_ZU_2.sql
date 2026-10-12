--==============================================================
-- Table: flw_lieferpos_typ_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_lieferpos_typ_spr_zu_2
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:41 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_lieferpos_typ_spr_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH. In der Regel länderbezogen'),
lief_pos_typ_id STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Positionstyp Vertriebsbeleg z.Bsp. kostenlose Lieferung aus pstyv'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Eindeutige ID für jede Sprache'),
lief_pos_typ_bez STRING(20) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Sprachabhängige Bezeichnung der Lieferpositionstyps aus vtext'),
system_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, spr_id) NOT ENFORCED
) OPTIONS(description='FLW - Sprachabhängige Bezeichnungen der Lieferpositionstypen aus tvapt');