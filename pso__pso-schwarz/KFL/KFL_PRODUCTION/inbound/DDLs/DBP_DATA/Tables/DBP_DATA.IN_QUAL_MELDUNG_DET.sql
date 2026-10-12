--==============================================================
-- Table: in_qual_meldung_det
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_qual_meldung_det
   generated from Powerdesigner on Mittwoch, 17. August 2022 14:54:03
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.IN_QUAL_MELDUNG_DET (
   mandant_id                          NUMBER(38,0)    NOT NULL COMMENT 'Mandant im DWH',
   qual_meldung_id                     NUMBER(18,0)    NOT NULL COMMENT 'ID der Qualitätsmeldung aus qmnum',
   qual_meldung_pos_id                 NUMBER(38,0)    NOT NULL COMMENT 'Positionsnummer im Positionssatz',
   problemcode_id                      VARCHAR(20)     COLLATE 'en-ci' COMMENT 'Problem- oder Schadenscode',
   katalogart_id_pc                    VARCHAR(1)      COMMENT 'Katalogart - Probleme/Fehler (Problemcode)',
   codegruppe_id_pc                    VARCHAR(8)      COMMENT 'Codegruppe - Probleme (Problemcode)',
   katalogart_id_ot                    VARCHAR(1)      COMMENT 'Katalogart - Probleme/Fehler (Objektteil)',
   codegruppe_id_ot                    VARCHAR(8)      COMMENT 'Codegruppe - Probleme (Objektteil)',
   pruefcode_id_ot                     VARCHAR(4)      COMMENT 'Prüfcode (Objektteil)',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_IN_QUAL_MELDUNG_DET PRIMARY KEY (mandant_id, qual_meldung_id, qual_meldung_pos_id) NOT ENFORCED
)  COMMENT = 'LIS - IND Tabelle QMFE, enthält Qualitätsmeldung-Positionen';
