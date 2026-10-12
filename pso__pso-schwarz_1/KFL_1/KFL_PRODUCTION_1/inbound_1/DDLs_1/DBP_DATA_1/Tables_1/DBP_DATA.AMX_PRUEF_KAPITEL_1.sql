--==============================================================
-- Table: amx_pruef_kapitel_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: amx_pruef_kapitel_1
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:35 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.AMX_PRUEF_KAPITEL_1 (
   pruef_kapitel_id                    NUMBER(38,0)     NOT NULL COMMENT 'Eindeutige ID eines Pruef-Kapitels. Aus dem Quellfeld id',
   amx_system_id                       NUMBER(38,0)     NOT NULL DEFAULT -1 COMMENT 'Unterscheidung zw. Den unterschiedlichen AMX Systemen. 1 = OneAudimex / 2 = KL Audimex',
   pruefung_id                         NUMBER(38,0)     NOT NULL DEFAULT -1 COMMENT 'Die Prüfung, zu der dieses Kapitel im Prüfprogramm gehört aus dem Quellfeld auditing.id',
   pruef_kapitel_bez                   VARCHAR(255)     NOT NULL COLLATE 'en-ci' DEFAULT ' ' COMMENT 'Bezeichnung des Prüfkapitels aus der Quellspalte name',
   hauptbereich_id                     NUMBER(38,0)     NOT NULL DEFAULT -1 COMMENT 'Eindeutige ID eines Hauptbereichs aus dem Quellfeld topic.id',
   teilbereich_id                      NUMBER(38,0)     NOT NULL DEFAULT -1 COMMENT 'Eindeutige ID eines Teilbereichs aus dem Quellfeld content_area.id',
   kapitel_ergebnis_wert               NUMBER(38,0)     NOT NULL DEFAULT -1 COMMENT 'Ergebniswert aus Quellfeld numeric_result',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_AMX_PRUEF_KAPITEL PRIMARY KEY (pruef_kapitel_id, amx_system_id) NOT ENFORCED
)  COMMENT = 'VIS audimex - Die Tabelle amx_pruef_kapitel_1 enthält die Kapitel der Prüfprogramme. Aus der Quelle audimex.activity';

