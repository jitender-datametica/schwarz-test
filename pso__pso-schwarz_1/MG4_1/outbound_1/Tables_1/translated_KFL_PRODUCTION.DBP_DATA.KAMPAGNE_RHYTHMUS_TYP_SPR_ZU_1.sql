CREATE OR REPLACE TABLE kfl_production_dbp_data.kampagne_rhythmus_typ_spr_zu_1 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH.'),
kampagne_rhythmus_typ_id INTEGER NOT NULL
OPTIONS(description='Numerischer Code zur Kennzeichnung der Wiederholungshäufigkeit der Kampagne.'),
spr_id INTEGER NOT NULL OPTIONS(description='ID der DWH-Sprache, z.B. 22 = Deutsch, 24 = Englisch, etc.'),
kampagne_rhythmus_typ_bez STRING(200) NOT NULL
OPTIONS(description='Bezeichnung der Art_1 der Wiederholungshäufigkeit der Kampagne_1 in unterschiedlichen Sprachen.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, kampagne_rhythmus_typ_id, spr_id) NOT ENFORCED
) OPTIONS(description='Sprachabhängige Bezeichnungen des Rhythmustyps der Kampagne_1 - manuell versorgt.');