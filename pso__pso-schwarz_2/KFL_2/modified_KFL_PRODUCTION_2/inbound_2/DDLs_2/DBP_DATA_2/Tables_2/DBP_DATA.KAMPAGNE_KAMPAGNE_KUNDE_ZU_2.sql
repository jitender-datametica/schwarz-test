--==============================================================
-- Table: kampagne_kampagne_kunde_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: kampagne_kampagne_kunde_zu_2
   generated from Powerdesigner on Samstag, 12. Oktober 2024 16:01:47
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.KAMPAGNE_KAMPAGNE_KUNDE_ZU_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH.',
   kampagne_id                         VARCHAR(100)     NOT NULL COMMENT 'Eindeutige Kennung der Kampagnendefinition, der der Kunde zugeordnet ist. Ein Kunde kann mehreren Kampagnen und eine_2 Kampagne_2 mehreren Kunden zugeordnet sein (Many-to-Many-Beziehung).',
   kampagne_kunde_id                   VARCHAR(100)     NOT NULL COMMENT 'Eindeutige Kennung des Kunden, welcher der Empfänger der von einer Kampagne_2 gesendeten Nachrichten ist.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_KAMPAGNE_KAMPAGNE_KUNDE_ZU PRIMARY KEY (mandant_id, kampagne_id, kampagne_kunde_id) NOT ENFORCED
)  COMMENT = 'Zuordnungtabelle von Kunden zu bestimmten Kampagnendefinitionen. Sie dient dazu, die Zielgruppe einer Kampagne_2 zu definieren und die Interaktionen einzelner Kunden mit der Journey zu verfolgen.';
