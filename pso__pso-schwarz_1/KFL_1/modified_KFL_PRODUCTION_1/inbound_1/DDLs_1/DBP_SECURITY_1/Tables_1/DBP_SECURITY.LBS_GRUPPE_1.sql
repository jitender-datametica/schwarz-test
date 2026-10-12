--==============================================================
-- Table: lbs_gruppe_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: lbs_gruppe_1
   generated from Powerdesigner on Montag, 5. August 2024 10:11:17
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_SECURITY.LBS_GRUPPE_1 (
   LBS_GRUPPE_ID                       INTEGER     NOT NULL COMMENT 'ID der lbs-einkäufergruppe. gruppe_1 bündelt eine_1 oder mehrere zeks gem. pflege aus dem kfl-ek fachbereich',
   LBS_GRUPPE_BEZ                      VARCHAR(300)     NOT NULL COMMENT 'Name der LBS-Einkäufergruppe.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_LBS_GRUPPE PRIMARY KEY (LBS_GRUPPE_ID) NOT ENFORCED
)  COMMENT = 'Securitytabelle, Fachbereich pflegt LBS Einkäufergruppen.';
