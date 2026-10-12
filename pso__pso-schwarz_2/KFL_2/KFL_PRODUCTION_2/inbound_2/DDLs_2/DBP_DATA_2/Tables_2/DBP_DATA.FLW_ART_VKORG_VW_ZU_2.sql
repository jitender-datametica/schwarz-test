--==============================================================
-- Table: flw_art_vkorg_vw_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_art_vkorg_vw_zu_2
   generated from Powerdesigner on Monday, March 4, 2024 12:59:40 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_ART_VKORG_VW_ZU_2 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_2 im DWH',
   flw_art_id                          NUMBER(38,0)     NOT NULL COMMENT 'Im DWH erzeugter numerischer Schlüssel für die Artikelnummer.',
   flw_verkaufsorganisation_id         VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'Verkaufsorganisation aus vkorg',
   flw_vw_id                           NUMBER(38,0)     NOT NULL COMMENT 'ID des Vertriebswegs aus vtweg',
   system_id                           NUMBER(38,0)     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   art_status_id                       VARCHAR(2)       NOT NULL COLLATE 'en-ci' COMMENT 'Vertriebslinienspezifischer Materialstatus',
   verk_menge_einh_id                  VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'ID der Internationalen Maßeinheit aus msehi',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_ART_VKORG_VW_ZU PRIMARY KEY (flw_art_id, flw_verkaufsorganisation_id, flw_vw_id, mandant_id) NOT ENFORCED
)  COMMENT = 'FLW - Artikel_2-Verkaufsorganisation-Vertriebsweg-Zuordnung aus SAP.MVKE_2';

