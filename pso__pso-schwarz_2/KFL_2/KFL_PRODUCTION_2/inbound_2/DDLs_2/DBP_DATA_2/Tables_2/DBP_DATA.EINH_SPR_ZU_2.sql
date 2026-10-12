--==============================================================
-- Table: einh_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: einh_spr_zu_2
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:15 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.EINH_SPR_ZU_2 (
   einh_id                             VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Masseinheit aus der Spalte msehi, zum Beispiel  %',
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_2 im DWH',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'ID der Sprache
            ',
   einh_bez_kaufm                      VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'externe Masseinheit kaufmaännische Darstellung aus mseh3',
   einh_bez                            VARCHAR(10)      NOT NULL COLLATE 'en-ci' COMMENT 'Kurztext der Masseinheiten Bezeichnung aus mseht (z.Bsp. Prozent)',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_EINH_SPR_ZU PRIMARY KEY (einh_id, mandant_id, spr_id) NOT ENFORCED
)  COMMENT = 'AIS - Sprachabhängige Bezeichnungen der Einheiten (für Einkauf) aus t006a';

