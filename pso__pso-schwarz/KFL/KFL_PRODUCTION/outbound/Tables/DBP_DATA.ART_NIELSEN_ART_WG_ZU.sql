--==============================================================
-- Table: art_nielsen_art_wg_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_nielsen_art_wg_zu
   generated from Powerdesigner on Dienstag, 1. August 2023 16:25:25
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.art_nielsen_art_wg_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
art_nielsen_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Artikel-ID aus Nielsen'),
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1.'),
kjwo BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Kalenderjahreswoche. Format JJJJWW'),
wg_id BIGNUMERIC(38,0) OPTIONS(description='ID der Warengruppe'),
wug_id BIGNUMERIC(38,0) OPTIONS(description='ID der Warenuntergruppe'),
wg_quelle_bez STRING(500)
OPTIONS(description='The name of the source from which the data for the WG_ID and WUG_ID fields come from.'),
wg_quelle_hierarchie_lvl_id BIGNUMERIC(38,0)
OPTIONS(description='Hierarchy level of WG_QUELLE_BEZ field, the smaller the level ID, the higher the priority. The lowest possible level ID for which a matching was accepted is always displayed.            Levels in the hierarchy:            Level 1 -> There is a match between Nielsen Article with our Kaufland Article. Article will have ART_ID            Level 2 -> Nielsen article has a match with Sharepoint upload data from BI (No match from level 1)            Level 3 -> Nielsen article has a match with no empty value with Nielsen data in art_nielsen table (No match from level 1,2)            Level 4 -> Nielsen article has a match with DWH estimation data (No match from level 1,2,3)            Level 5 -> Nielsen\'s article inherits a value from another filled article from matching_id to which it belongs (No match from level 1,2,3,4)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, art_nielsen_id, art_id, kjwo) NOT ENFORCED
)
OPTIONS(description='This table contains the article group (Warengruppen) for Nielsen articles. The article group assignment goes through a process that assigns the most suitable article group based on the available information. Information sources have different priority which is why it does not have to be the article group provided by Nielsen.             Not a real history on key level but full snapshot of current data from Nielsen on a weekly basis. New rows are created even if for the key combination nothing changed, meaning that the most current week has the most recent data for all occurences.                          Levels in the hierarchy:             Level 1 -> There is a match between Nielsen Article with our Kaufland Article. Article will have ART_ID             Level 2 -> Nielsen article has a match with Sharepoint upload data from BI (No match from level 1)             Level 3 -> Nielsen article has a match with no empty value with Nielsen data in art_nielsen table (No match from level 1,2)             Level 4 -> Nielsen article has a match with DWH estimation data (No match from level 1,2,3)             Level 5 -> Nielsen article inherits a value from another filled article from matching_id to which it belongs (No match from level 1,2,3,4)');