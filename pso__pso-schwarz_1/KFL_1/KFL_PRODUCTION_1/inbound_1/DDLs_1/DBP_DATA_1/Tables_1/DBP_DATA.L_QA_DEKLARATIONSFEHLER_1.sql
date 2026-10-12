--==============================================================
-- Table: l_qa_deklarationsfehler_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_qa_deklarationsfehler_1
   generated from Powerdesigner on Mittwoch, 28. Februar 2024 10:48:43
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_QA_DEKLARATIONSFEHLER_1 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH',
   qa_deklarationsfehler_id            VARCHAR(3)       NOT NULL COMMENT 'QA-Deklarationsfehler (, z. B. 002 = Etikett fehlt)',
   aktiv_fg                            NUMBER(38,0)     COMMENT 'Aktiv, d. h. wird bei Wareneingang geprüft',
   pflanzen_fg                         NUMBER(38,0)     COMMENT 'Flag: Fehlercode für Pflanzen relevant (sonst nur O&G)',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_L_QA_DEKLARATIONSFEHLER PRIMARY KEY (mandant_id, qa_deklarationsfehler_id) NOT ENFORCED
)  COMMENT = 'Lookup für QA-Deklarationsfehler Codes, z. B. 002 = Etikett fehlt';
