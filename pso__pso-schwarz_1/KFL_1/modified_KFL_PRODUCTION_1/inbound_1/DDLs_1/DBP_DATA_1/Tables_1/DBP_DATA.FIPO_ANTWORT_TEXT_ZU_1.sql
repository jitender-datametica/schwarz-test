--==============================================================
-- Table: fipo_antwort_text_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: fipo_antwort_text_zu_1
   generated from Powerdesigner on Monday, March 4, 2024 12:59:39 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FIPO_ANTWORT_TEXT_ZU_1 (
   fipo_antwort_text_id                INTEGER     NOT NULL COMMENT 'Eindeutige ID der Zuordnung',
   fipo_antwort_id                     INTEGER     NOT NULL DEFAULT -1 COMMENT 'Eindeutige ID einer Antwort aus ant_id',
   fipo_standard_text_id               INTEGER     NOT NULL DEFAULT -1 COMMENT 'Eindeutige ID eines Standardtextes aus ste_id',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FIPO_ANTWORT_TEXT_ZU PRIMARY KEY (fipo_antwort_text_id) NOT ENFORCED
)  COMMENT = 'FIPO - Zuordnungstabelle von Texten zu Antworten aus der Quelltabelle antworten_texte';

