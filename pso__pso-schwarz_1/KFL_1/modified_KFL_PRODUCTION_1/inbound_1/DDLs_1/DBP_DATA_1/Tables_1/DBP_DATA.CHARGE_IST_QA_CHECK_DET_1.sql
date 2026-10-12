--==============================================================
-- Table: charge_ist_qa_check_det_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: charge_ist_qa_check_det_1
   generated from Powerdesigner on Mittwoch, 28. Februar 2024 10:47:43
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.CHARGE_IST_QA_CHECK_DET_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   seq_nr                              INTEGER     NOT NULL COMMENT 'Laufende Nummer, wird bei mehreren Meldungen zur selben Charge in SAP einfach hochgezählt',
   charge_nr_qa                        VARCHAR(10)      NOT NULL COLLATE 'en-ci' COMMENT 'Chargennummer, die bei einer QS-Meldung erzeugt wird  / QA steht für O&G, PF für Pflanzen, FL für Fleischwerk -> aber nicht zwingend - Feld CHARG_QA',
   qa_mangel_id                        VARCHAR(3)       COMMENT 'QA-Mangel (z. B. 001 = Frischemangel)',
   qa_deklarationsfehler_id            VARCHAR(3)       COMMENT 'QA-Deklarationsfehler (, z. B. 002 = Etikett fehlt)',
   kommentar_qa_txt                    VARCHAR(500)     COMMENT 'User-Kommentar QA',
   kommentar_ek_txt                    VARCHAR(500)     COMMENT 'User-Kommentar Einkauf',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_CHARGE_IST_QA_CHECK_DET PRIMARY KEY (mandant_id, seq_nr, charge_nr_qa) NOT ENFORCED
)  COMMENT = 'Detailinformationen zu QA-Prüfungen Obst & Gemüse -  fasst Meldungen zu Qualitäts- und Deklarationsmängeln + Kommentare seitens QA und Einkauf zusammen';
