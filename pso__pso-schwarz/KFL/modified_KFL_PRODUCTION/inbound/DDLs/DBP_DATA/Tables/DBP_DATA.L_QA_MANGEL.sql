--==============================================================
-- Table: l_qa_mangel
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_qa_mangel
   generated from Powerdesigner on Mittwoch, 28. Februar 2024 10:49:19
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_QA_MANGEL (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   qa_mangel_id                        VARCHAR(3)       NOT NULL COMMENT 'QA-Mangel (z. B. 001 = Frischemangel)',
   pflanzen_fg                         INTEGER     COMMENT 'Flag: Fehlercode für Pflanzen relevant (sonst nur O&G)',
   qa_prio                             INTEGER     COMMENT 'Priorität für QS-Kontrolle',
   frischemangel_fg                    INTEGER     COMMENT 'Flag: QA-Mangel ist ein Frischemangel (nicht: Schädlinge, mechanische Beschädigung etc.)',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_L_QA_MANGEL PRIMARY KEY (mandant_id, qa_mangel_id) NOT ENFORCED
)  COMMENT = 'Lookup für QA-Mängel Codes, z. B. 001 = Frischemangel';
