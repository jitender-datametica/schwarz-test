--==============================================================
-- Table: art_nielsen_uwg_nielsen_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_nielsen_uwg_nielsen_zu
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:29 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.art_nielsen_uwg_nielsen_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
art_nielsen_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Artikel-ID aus Nielsen'),
kl_uwg_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID Kaufland Unterwarengruppen für Nielsen-Daten (Vergabe im Beladeprozess)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, art_nielsen_id, kl_uwg_id) NOT ENFORCED
) OPTIONS(description='EK-INTEGER  - Mappingtabelle Nielsen-Artikel zu  Kaufland Unterwarengruppen für Nielsen');