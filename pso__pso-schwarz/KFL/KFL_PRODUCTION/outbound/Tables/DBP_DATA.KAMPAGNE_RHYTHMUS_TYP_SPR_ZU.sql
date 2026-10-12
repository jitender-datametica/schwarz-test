--==============================================================
-- Table: kampagne_rhythmus_typ_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: kampagne_rhythmus_typ_spr_zu
   generated from Powerdesigner on Samstag, 12. Oktober 2024 16:01:47
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.kampagne_rhythmus_typ_spr_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH.'),
kampagne_rhythmus_typ_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Numerischer Code zur Kennzeichnung der Wiederholungshäufigkeit der Kampagne.'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der DWH-Sprache, z.B. 22 = Deutsch, 24 = Englisch, etc.'),
kampagne_rhythmus_typ_bez STRING(200) NOT NULL
OPTIONS(description='Bezeichnung der Art der Wiederholungshäufigkeit der Kampagne in unterschiedlichen Sprachen.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, kampagne_rhythmus_typ_id, spr_id) NOT ENFORCED
) OPTIONS(description='Sprachabhängige Bezeichnungen des Rhythmustyps der Kampagne - manuell versorgt.');