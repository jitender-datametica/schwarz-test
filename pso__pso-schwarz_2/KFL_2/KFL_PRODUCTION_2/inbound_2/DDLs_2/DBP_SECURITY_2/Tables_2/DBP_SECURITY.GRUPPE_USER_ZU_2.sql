--==============================================================
-- Table: gruppe_user_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: gruppe_user_zu_2
   generated from Powerdesigner on Donnerstag, 24. April 2025 10:01:26
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_SECURITY.GRUPPE_USER_ZU_2 (
   gruppe_id                           NUMBER(38,0)     NOT NULL COMMENT 'Eindeutige ID einer Usergruppe',
   user_id                             VARCHAR(30)      NOT NULL COLLATE 'en-ci' COMMENT 'ID des MSI Users',
   dat_gueltig_bis                     DATE             NOT NULL DEFAULT CAST('9999-12-31' AS DATE) COMMENT 'Gültigkeitsende der Zuordnung des Users zur ZEK_2 Grupppe.(immer bis inkl. des Datums, d.h. bei einem dat_gueltig_bis vom 20.04.2025 wird der User bis und inkl. dem 20.04.2025 der Gruppe_2 zugeteilt).',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_GRUPPE_USER_ZU PRIMARY KEY (gruppe_id, user_id) NOT ENFORCED
)  COMMENT = 'AIS KMO - Securitytabelle zur Pflege von Usergruppen';
