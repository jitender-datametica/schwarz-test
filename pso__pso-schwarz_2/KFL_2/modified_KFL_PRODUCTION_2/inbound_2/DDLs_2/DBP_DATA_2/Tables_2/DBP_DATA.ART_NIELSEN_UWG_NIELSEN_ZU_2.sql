--==============================================================
-- Table: art_nielsen_uwg_nielsen_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_nielsen_uwg_nielsen_zu_2
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:29 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_NIELSEN_UWG_NIELSEN_ZU_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   art_nielsen_id                      INTEGER     NOT NULL COMMENT 'Artikel_2-ID aus Nielsen',
   kl_uwg_id                           INTEGER     NOT NULL COMMENT 'ID Kaufland Unterwarengruppen für Nielsen-Daten (Vergabe im Beladeprozess)',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_NIELSEN_UWG_NIELSEN_ZU PRIMARY KEY (mandant_id, art_nielsen_id, kl_uwg_id) NOT ENFORCED
)  COMMENT = 'EK-INT - Mappingtabelle Nielsen-Artikel_2 zu  Kaufland Unterwarengruppen für Nielsen';

