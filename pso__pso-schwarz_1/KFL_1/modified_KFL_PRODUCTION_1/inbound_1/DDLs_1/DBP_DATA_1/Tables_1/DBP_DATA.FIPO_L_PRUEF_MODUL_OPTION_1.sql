--==============================================================
-- Table: fipo_l_pruef_modul_option_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: fipo_l_pruef_modul_option_1
   generated from Powerdesigner on Monday, March 4, 2024 12:59:41 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FIPO_L_PRUEF_MODUL_OPTION_1 (
   fipo_pruef_modul_id                 INTEGER     NOT NULL COMMENT 'eindeutige ID des FIPO-Prüfmoduls aus dem Quellfeld pmo_id',
   fipo_pruef_modul_option_id          VARCHAR(255)     NOT NULL COLLATE 'en-ci' COMMENT 'Bezeichnung der Option, z_bsp. Einsatzplanung. Aus dem Quellfeld value',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FIPO_L_PRUEF_MODUL_OPTION PRIMARY KEY (fipo_pruef_modul_id, fipo_pruef_modul_option_id) NOT ENFORCED
)  COMMENT = 'FIPO - Lookup Tabelle der Prüfmodul-Optionen aus der Quelltabelle pruefmodule_optionen';

