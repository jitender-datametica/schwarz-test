--==============================================================
-- Table: amx_hauptbereich_mcx_invers_bereich_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: amx_hauptbereich_mcx_invers_bereich_zu_1
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:35 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.AMX_HAUPTBEREICH_MCX_INVERS_BEREICH_ZU_1 (
   hauptbereich_id                     INTEGER     NOT NULL COMMENT 'Eindeutige ID eines Hauptbereichs aus dem Quellfeld topic.id',
   invers_ber_id                       INTEGER     NOT NULL COMMENT 'Bereich ID aus Maritz',
   amx_system_id                       INTEGER     NOT NULL DEFAULT -1 COMMENT 'Unterscheidung zw. Den unterschiedlichen AMX Systemen. 1 = OneAudimex / 2 = KL Audimex',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_AMX_HAUPTBEREICH_MCX_INVERS_BEREICH_ZU PRIMARY KEY (hauptbereich_id, invers_ber_id, amx_system_id) NOT ENFORCED
)  COMMENT = 'Zuordnungstabelle Hauptbereich (AMX) zu inversem Bereich (MXC). Verwendung: um die Bereich Sprachtabelle aus Maritz für die Audimex Hauptbereiche zu nutzen';

