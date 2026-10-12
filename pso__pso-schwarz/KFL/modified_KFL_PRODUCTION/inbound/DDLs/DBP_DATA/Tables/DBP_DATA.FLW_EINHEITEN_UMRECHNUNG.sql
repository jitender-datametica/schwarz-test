--==============================================================
-- Table: flw_einheiten_umrechnung
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_einheiten_umrechnung
   generated from Powerdesigner on Monday, March 4, 2024 12:59:40 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_EINHEITEN_UMRECHNUNG (
   einh_id                             VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'ID der Internationalen Maßeinheit aus msehi',
   dimension_id                        VARCHAR(10)      NOT NULL COLLATE 'en-ci' COMMENT 'Dimension der Einheit. Nur Einheiten derselben Dimension können umgerechnet werden aus dimid',
   zaehler                             INTEGER     NOT NULL COMMENT 'zaehler aus zaehl',
   nenner                              INTEGER     NOT NULL COMMENT 'Nenner aus nennr',
   basis_einh_id                       VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Die Basis-Einheit der Dimension. Bei der Länge z.Bsp Meter. Quelle ist t006d.mssie',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_EINHEITEN_UMRECHNUNG PRIMARY KEY (einh_id) NOT ENFORCED
)  COMMENT = 'FLW - Maßeinheiten International und deren Umrechnung aus t006 und t006d Fleischwerkssystem';

