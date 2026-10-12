--==============================================================
-- Table: art_nielsen_wug_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_nielsen_wug_zu_1
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:29 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.art_nielsen_wug_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
art_nielsen_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Artikel_1-ID aus Nielsen'),
arthiertyp_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Artikel_1 - Hierarchie - Typ - ID. Kennzeichnet'),
wg_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Warengruppe'),
wug_id BIGNUMERIC(38,0) NOT NULL,
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, art_nielsen_id) NOT ENFORCED
) OPTIONS(description='EK-INTEGER  - Mappingtabelle Nielsen-Artikel_1 zu  Kaufland Unterwarengruppen');