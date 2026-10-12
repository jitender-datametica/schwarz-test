--==============================================================
-- Table: fipo_bericht_verteiler_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: fipo_bericht_verteiler_1
   generated from Powerdesigner on Monday, March 4, 2024 12:59:39 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FIPO_BERICHT_VERTEILER_1 (
   fipo_bericht_id                     NUMBER(38,0)     NOT NULL COMMENT 'Eindeutige ID eines FIPO-Berichts aus bri_id',
   fipo_bericht_verteiler_id           VARCHAR(255)     NOT NULL COLLATE 'en-ci' DEFAULT ' ' COMMENT 'Hier ist hinterlegt, wer (welche Position, wi HL_1) den Bericht erhält. Aus dem Quellfeld value',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FIPO_BERICHT_VERTEILER PRIMARY KEY (fipo_bericht_id, fipo_bericht_verteiler_id) NOT ENFORCED
)  COMMENT = 'FIPO - Verteilerinformation für Berichte aus der Quelltabelle berichte_verteiler';

