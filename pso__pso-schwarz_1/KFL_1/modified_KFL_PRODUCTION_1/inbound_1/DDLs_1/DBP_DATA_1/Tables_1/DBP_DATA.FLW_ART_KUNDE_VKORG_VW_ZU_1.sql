--==============================================================
-- Table: flw_art_kunde_vkorg_vw_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_art_kunde_vkorg_vw_zu_1
   generated from Powerdesigner on Monday, March 4, 2024 12:59:40 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_ART_KUNDE_VKORG_VW_ZU_1 (
   flw_art_id                          INTEGER     NOT NULL COMMENT 'Im DWH erzeugter numerischer Schlüssel für die Artikelnummer.',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   flw_kunde_id                        INTEGER     NOT NULL COMMENT 'Im DWH generierter Surrogate Key für die Kundennummer aus SAP',
   flw_verkaufsorganisation_id         VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'Verkaufsorganisation aus vkorg',
   flw_vw_id                           INTEGER     NOT NULL COMMENT 'ID des Vertriebswegs aus vtweg',
   mandant_id_kunde                    INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   flw_art_id_kunde                    INTEGER     NOT NULL COMMENT 'Im DWH erzeugter numerischer Schlüssel für die Artikelnummer.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_ART_KUNDE_VKORG_VW_ZU PRIMARY KEY (flw_art_id, mandant_id, flw_kunde_id, flw_verkaufsorganisation_id, flw_vw_id) NOT ENFORCED
)  COMMENT = 'FLW - Zuordnung der Artikelnummern von Land_1 zu Land_1 (für Fertigerzeugnisse) aus der Quelltabelle knmt';

