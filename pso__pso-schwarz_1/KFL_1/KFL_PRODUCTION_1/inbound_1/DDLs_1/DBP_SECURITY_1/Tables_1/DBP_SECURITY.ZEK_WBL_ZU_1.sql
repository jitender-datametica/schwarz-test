--==============================================================
-- Table: zek_wbl_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: zek_wbl_zu_1
   generated from Powerdesigner on Donnerstag, 31. August 2023 10:18:10
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_SECURITY.ZEK_WBL_ZU_1 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH',
   zek_id                              VARCHAR(3)       NOT NULL COMMENT 'Zentraleinkäufer - ID: Diese ID ist nicht mit der Mitarbeiter - ID identisch',
   wbl_id                              NUMBER(38,0)     COMMENT 'Warenbereichsleiter ID',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ZEK_WBL_ZU PRIMARY KEY (mandant_id, zek_id) NOT ENFORCED
)  COMMENT = 'EK-INT - Zuordnungstabelle Zentraleinkäufer zu WBL_1 (EKL - Einkaufsleiter) - wird manuell über MSI (TAS) befüllt';
