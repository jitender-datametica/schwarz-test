--==============================================================
-- Table: filialart_altersstruktur_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: filialart_altersstruktur_zu_1
   generated from Powerdesigner on Monday, March 4, 2024 12:59:39 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FILIALART_ALTERSSTRUKTUR_ZU_1 (
   altersstruktur_id                   NUMBER(38,0)     NOT NULL COMMENT 'ID der Altersstruktur, z.B. 1 = Stammfiliale, 2 = Durchsetzungsfiliale, 3 = Expansionsbereinigt',
   filialart_id                        NUMBER(38,0)     NOT NULL COMMENT 'ID der Filialart, z.B. 1 = Stammfiliale, 2 = Durchsetzungsfiliale',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FILIALART_ALTERSSTRUKTUR_ZU PRIMARY KEY (altersstruktur_id, filialart_id) NOT ENFORCED
)  COMMENT = 'VIS - Filialart-Altersstruktur-Zuordnung';

