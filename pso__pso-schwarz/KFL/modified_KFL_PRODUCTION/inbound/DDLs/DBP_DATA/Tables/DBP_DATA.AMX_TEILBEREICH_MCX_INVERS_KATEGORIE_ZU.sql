--==============================================================
-- Table: amx_teilbereich_mcx_invers_kategorie_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: amx_teilbereich_mcx_invers_kategorie_zu
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:35 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.AMX_TEILBEREICH_MCX_INVERS_KATEGORIE_ZU (
   invers_kat_id                       INTEGER     NOT NULL COMMENT 'Kategorie ID aus Maritz',
   teilbereich_id                      INTEGER     NOT NULL COMMENT 'Eindeutige ID eines Teilbereichs aus dem Quellfeld content_area.id',
   amx_system_id                       INTEGER     NOT NULL DEFAULT -1 COMMENT 'Unterscheidung zw. Den unterschiedlichen AMX Systemen. 1 = OneAudimex / 2 = KL Audimex',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_AMX_TEILBEREICH_MCX_INVERS_KATEGORIE_ZU PRIMARY KEY (invers_kat_id, teilbereich_id, amx_system_id) NOT ENFORCED
)  COMMENT = 'Zuordnungstabelle Teilbereich (AMX) zu interser Kategorie (MCX). Verwendung: um die Kategorie Sprachtabelle aus Maritz für die Audimex Teilbereiche zu nutzen';

