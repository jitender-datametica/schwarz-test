--==============================================================
-- Table: art_nielsen_art_wg_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_nielsen_art_wg_zu_2
   generated from Powerdesigner on Dienstag, 1. August 2023 16:25:25
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_NIELSEN_ART_WG_ZU_2 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_2 im DWH',
   art_nielsen_id                      NUMBER(38,0)     NOT NULL COMMENT 'Artikel_2-ID aus Nielsen',
   art_id                              NUMBER(38,0)     NOT NULL COMMENT 'Input: Artikel_2-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel_2-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1.',
   kjwo                                NUMBER(38,0)     NOT NULL COMMENT 'Kalenderjahreswoche. Format JJJJWW',
   wg_id                               NUMBER(38,0)     COMMENT 'ID der Warengruppe',
   wug_id                              NUMBER(38,0)     COMMENT 'ID der Warenuntergruppe',
   wg_quelle_bez                       VARCHAR(500)     COMMENT 'The name of the source from which the data for the WG_ID and WUG_ID fields come from.',
   wg_quelle_hierarchie_lvl_id         NUMBER(38,0)     COMMENT 'Hierarchy_2 level of WG_QUELLE_BEZ field, the smaller the level ID, the higher the priority. The lowest possible level ID for which a matching was accepted is always displayed.
            Levels in the hierarchy_2:
            Level 1 -> There is a match between Nielsen Article with our Kaufland Article. Article will have ART_ID
            Level 2 -> Nielsen article has a match with Sharepoint upload data from BI (No match from level 1)
            Level 3 -> Nielsen article has a match with no empty value with Nielsen data in art_nielsen_2 table (No match from level 1,2)
            Level 4 -> Nielsen article has a match with DWH estimation data (No match from level 1,2,3)
            Level 5 -> Nielsen''s article inherits a value from another filled article from matching_id to which it belongs (No match from level 1,2,3,4)',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_NIELSEN_ART_WG_ZU PRIMARY KEY (mandant_id, art_nielsen_id, art_id, kjwo) NOT ENFORCED
)  COMMENT = 'This table contains the article group (Warengruppen) for Nielsen articles. The article group assignment goes through a process that assigns the most suitable article group based on the available information. Information sources have different priority which is why it does not have to be the article group provided by Nielsen.
             Not a real history on key level but full snapshot_2 of current data from Nielsen on a weekly basis. New rows are created even if for the key combination nothing changed, meaning that the most current week has the most recent data for all occurences.
             
             Levels in the hierarchy_2:
             Level 1 -> There is a match between Nielsen Article with our Kaufland Article. Article will have ART_ID
             Level 2 -> Nielsen article has a match with Sharepoint upload data from BI (No match from level 1)
             Level 3 -> Nielsen article has a match with no empty value with Nielsen data in art_nielsen_2 table (No match from level 1,2)
             Level 4 -> Nielsen article has a match with DWH estimation data (No match from level 1,2,3)
             Level 5 -> Nielsen article inherits a value from another filled article from matching_id to which it belongs (No match from level 1,2,3,4)';
