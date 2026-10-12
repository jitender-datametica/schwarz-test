--==============================================================
-- Table: art_nielsen_uwg_nielsen_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_nielsen_uwg_nielsen_zu
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:29 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_NIELSEN_UWG_NIELSEN_ZU (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   art_nielsen_id                      INTEGER     NOT NULL COMMENT 'Artikel-ID aus Nielsen',
   kl_uwg_id                           INTEGER     NOT NULL COMMENT 'ID Kaufland Unterwarengruppen für Nielsen-Daten (Vergabe im Beladeprozess)',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_NIELSEN_UWG_NIELSEN_ZU PRIMARY KEY (mandant_id, art_nielsen_id, kl_uwg_id) NOT ENFORCED
)  COMMENT = 'EK-INT - Mappingtabelle Nielsen-Artikel zu  Kaufland Unterwarengruppen für Nielsen';

