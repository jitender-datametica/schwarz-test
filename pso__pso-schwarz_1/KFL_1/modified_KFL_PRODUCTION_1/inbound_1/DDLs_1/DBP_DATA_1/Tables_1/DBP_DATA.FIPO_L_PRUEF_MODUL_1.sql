--==============================================================
-- Table: fipo_l_pruef_modul_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: fipo_l_pruef_modul_1
   generated from Powerdesigner on Monday, March 4, 2024 12:59:41 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FIPO_L_PRUEF_MODUL_1 (
   fipo_pruef_modul_id                 INTEGER     NOT NULL COMMENT 'eindeutige ID des FIPO-Prüfmoduls aus dem Quellfeld pmo_id',
   fipo_objekt_typ_id                  INTEGER     NOT NULL DEFAULT -1 COMMENT 'Eindeutige ID des FIPO-Opbjekttyps aus dem Quellfeld obt_id',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FIPO_L_PRUEF_MODUL PRIMARY KEY (fipo_pruef_modul_id) NOT ENFORCED
)  COMMENT = 'FIPO - Lookup Tabelle der Prüfmodule';

