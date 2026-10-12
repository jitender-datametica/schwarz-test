--==============================================================
-- Table: einh_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: einh_spr_zu_1
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:15 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.EINH_SPR_ZU_1 (
   einh_id                             VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Masseinheit aus der Spalte msehi, zum Beispiel  %',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   spr_id                              INTEGER     NOT NULL COMMENT 'ID der Sprache
            ',
   einh_bez_kaufm                      VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'externe Masseinheit kaufmaännische Darstellung aus mseh3',
   einh_bez                            VARCHAR(10)      NOT NULL COLLATE 'en-ci' COMMENT 'Kurztext der Masseinheiten Bezeichnung aus mseht (z.Bsp. Prozent)',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_EINH_SPR_ZU PRIMARY KEY (einh_id, mandant_id, spr_id) NOT ENFORCED
)  COMMENT = 'AIS - Sprachabhängige Bezeichnungen der Einheiten (für Einkauf) aus t006a';

