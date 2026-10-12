--==============================================================
-- Table: user_zek_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: user_zek_zu_1
   generated from Powerdesigner on Donnerstag, 31. August 2023 10:18:55
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_SECURITY.USER_ZEK_ZU_1 (
   user_id                             VARCHAR(30)      NOT NULL COLLATE 'en-ci' COMMENT 'ID des MSI Users',
   zek_id                              VARCHAR(3)       NOT NULL COMMENT 'Zentraleinkäufer - ID: Diese ID ist nicht mit der Mitarbeiter - ID identisch',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_USER_ZEK_ZU PRIMARY KEY (user_id, zek_id, mandant_id) NOT ENFORCED
)  COMMENT = 'AIS_KMO - alle Zentraleinkäufer, auf deren Artikel_1 / Warengruppen ein User Anzeigeberechtigung hat';
