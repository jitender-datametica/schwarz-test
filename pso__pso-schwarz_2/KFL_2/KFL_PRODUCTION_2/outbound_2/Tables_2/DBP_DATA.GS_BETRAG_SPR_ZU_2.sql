--==============================================================
-- Table: gs_betrag_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: gs_betrag_spr_zu_2
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:45 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.gs_betrag_spr_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
ausgeber_typ_id STRING(3) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Typ des Ausgebers, es gibt z. Bsp. KDC, TIP und Filiale'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Nummer der Sprache'),
betrag_von NUMERIC(9,2) NOT NULL OPTIONS(description='Untere Grenze des Betragsbereichs, z.Bsp.0,00'),
betrag_bez STRING(40) COLLATE 'und:ci' NOT NULL OPTIONS(description='Bezeichnung des Betragsbereichs'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, spr_id, betrag_von) NOT ENFORCED
)
OPTIONS(description='VIS - Bezeichnungen der auswertungsrelevanten Betragskategorien pro Ausgebertyp. Wird manuell gepflegt.');