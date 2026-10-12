--==============================================================
-- Table: art_nielsen_wug_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_nielsen_wug_zu
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:29 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_NIELSEN_WUG_ZU (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   art_nielsen_id                      INTEGER     NOT NULL COMMENT 'Artikel-ID aus Nielsen',
   arthiertyp_id                       INTEGER     NOT NULL COMMENT 'Artikel - Hierarchie - Typ - ID. Kennzeichnet',
   wg_id                               INTEGER     NOT NULL COMMENT 'ID der Warengruppe',
   wug_id                              INTEGER     NOT NULL,
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_NIELSEN_WUG_ZU PRIMARY KEY (mandant_id, art_nielsen_id) NOT ENFORCED
)  COMMENT = 'EK-INT - Mappingtabelle Nielsen-Artikel zu  Kaufland Unterwarengruppen';

