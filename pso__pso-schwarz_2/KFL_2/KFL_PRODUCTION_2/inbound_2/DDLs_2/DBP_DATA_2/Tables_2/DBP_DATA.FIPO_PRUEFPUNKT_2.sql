--==============================================================
-- Table: fipo_pruefpunkt_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: fipo_pruefpunkt_2
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:46 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FIPO_PRUEFPUNKT_2 (
   fipo_pruefpunkt_id                  NUMBER(38,0)     NOT NULL COMMENT 'Eindeutige ID eines Prüfpunkts aus ppu_id',
   fipo_bereich_id                     NUMBER(38,0)     NOT NULL DEFAULT -1 COMMENT 'Eindeutige ID eines FIPO-Bereichs aus dem Quellfeld ber_id',
   fipo_kriterium_id                   NUMBER(38,0)     NOT NULL DEFAULT -1 COMMENT 'FIPO - Eindeutige ID eines FIPO Kriteriums aus der Quelltabelle kriterien',
   fipo_pruefpunkt_nr                  NUMBER(38,0)     NOT NULL DEFAULT -1,
   dat_von                             DATE             NOT NULL,
   dat_bis                             DATE             NOT NULL,
   fipo_kategorie_id                   NUMBER(38,0)     NOT NULL DEFAULT -1 COMMENT 'Eindeutige ID einer FIPO-Kategorie aus dem Quellfeld kat_id',
   fipo_pruefpunkt_typ                 VARCHAR(255)     NOT NULL COLLATE 'en-ci' DEFAULT ' ' COMMENT 'Kriterientyp des Prüfpunkt (Handelt es sich um eine_2 Zählfrage, Textfrage, OK / NOTOK - Frage, etc.)',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FIPO_PRUEFPUNKT PRIMARY KEY (fipo_pruefpunkt_id) NOT ENFORCED
)  COMMENT = 'FIPO - Pruefpunkte aus der Quelltabelle pruefpunkte';
