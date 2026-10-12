--==============================================================
-- Table: fipo_anlage_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: fipo_anlage_1
   generated from Powerdesigner on Monday, March 4, 2024 12:59:39 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FIPO_ANLAGE_1 (
   fipo_anlage_id                      INTEGER     NOT NULL COMMENT 'Eindeutige ID einer Anlage_1',
   fipo_antwort_id                     INTEGER     COMMENT 'Eindeutige ID einer Antwort aus ant_id',
   fipo_anlage_content                 BINARY           COMMENT 'Bild zu einer Anlage_1 aus der Quelle ant_content',
   mime_type                           VARCHAR(255)     COLLATE 'en-ci' COMMENT 'Der Internet Media Type der Anlage_1 aus der Quelle anl_mime_type, z.Bsp. jpg',
   dat_bis                             DATE             COMMENT 'Änderungsdatum der Anlage_1 aus dem Quellfeld anl_geaendert_am , soll im DWH als dat_bis erscheinen',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FIPO_ANLAGE PRIMARY KEY (fipo_anlage_id) NOT ENFORCED
)  COMMENT = 'FIPO - Anlagen (Bilder) zu den Antworten aus der Quelltabelle Anlagen';

