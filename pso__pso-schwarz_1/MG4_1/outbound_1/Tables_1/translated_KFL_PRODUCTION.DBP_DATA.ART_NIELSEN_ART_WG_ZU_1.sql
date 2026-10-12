CREATE OR REPLACE TABLE kfl_production_dbp_data.art_nielsen_art_wg_zu_1 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
art_nielsen_id INTEGER NOT NULL OPTIONS(description='Artikel_1-ID aus Nielsen'),
art_id INTEGER NOT NULL
OPTIONS(description='Input: Artikel_1-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel_1-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1.'),
kjwo INTEGER NOT NULL OPTIONS(description='Kalenderjahreswoche. Format JJJJWW'),
wg_id INTEGER OPTIONS(description='ID der Warengruppe'),
wug_id INTEGER OPTIONS(description='ID der Warenuntergruppe'),
wg_quelle_bez STRING(500)
OPTIONS(description='The name of the source from which the data for the WG_ID and WUG_ID fields come from.'),
wg_quelle_hierarchie_lvl_id INTEGER
OPTIONS(description='Hierarchy_1 level of WG_QUELLE_BEZ field, the smaller the level ID, the higher the priority. The lowest possible level ID for which a matching was accepted is always displayed.\n            Levels in the hierarchy_1:\n            Level 1 -> There is a match between Nielsen Article with our Kaufland Article. Article will have ART_ID\n            Level 2 -> Nielsen article has a match with Sharepoint upload data from BI (No match from level 1)\n            Level 3 -> Nielsen article has a match with no empty value with Nielsen data in art_nielsen_1 table (No match from level 1,2)\n            Level 4 -> Nielsen article has a match with DWH estimation data (No match from level 1,2,3)\n            Level 5 -> Nielsen\'s article inherits a value from another filled article from matching_id to which it belongs (No match from level 1,2,3,4)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, art_nielsen_id, art_id, kjwo) NOT ENFORCED
)
OPTIONS(description='This table contains the article group (Warengruppen) for Nielsen articles. The article group assignment goes through a process that assigns the most suitable article group based on the available information. Information sources have different priority which is why it does not have to be the article group provided by Nielsen.\n             Not a real history on key level but full snapshot_1 of current data from Nielsen on a weekly basis. New rows are created even if for the key combination nothing changed, meaning that the most current week has the most recent data for all occurences.\n\n             Levels in the hierarchy_1:\n             Level 1 -> There is a match between Nielsen Article with our Kaufland Article. Article will have ART_ID\n             Level 2 -> Nielsen article has a match with Sharepoint upload data from BI (No match from level 1)\n             Level 3 -> Nielsen article has a match with no empty value with Nielsen data in art_nielsen_1 table (No match from level 1,2)\n             Level 4 -> Nielsen article has a match with DWH estimation data (No match from level 1,2,3)\n             Level 5 -> Nielsen article inherits a value from another filled article from matching_id to which it belongs (No match from level 1,2,3,4)');