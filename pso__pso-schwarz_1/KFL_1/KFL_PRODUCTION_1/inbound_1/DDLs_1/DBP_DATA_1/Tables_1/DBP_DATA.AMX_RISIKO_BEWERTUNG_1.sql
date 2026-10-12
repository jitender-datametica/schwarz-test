--==============================================================
-- Table: amx_risiko_bewertung_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: amx_risiko_bewertung_1
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:36 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.AMX_RISIKO_BEWERTUNG_1 (
   risiko_bewertung_id                 NUMBER(38,0)     NOT NULL COMMENT 'Eindeutige ID eines Risikobereichs aus dem Quellfeld ID',
   amx_system_id                       NUMBER(38,0)     NOT NULL DEFAULT -1 COMMENT 'Unterscheidung zw. Den unterschiedlichen AMX Systemen. 1 = OneAudimex / 2 = KL Audimex',
   risiko_wert_von                     NUMBER(38,0)     NOT NULL COMMENT 'Risikowert Intervall Beginn aus dem Quellfeld risk_from. Darstellung als dreistelliger Wert, z.Bsp. 112',
   risiko_wert_bis                     NUMBER(38,0)     NOT NULL COMMENT 'Risikowert Intervall Ende aus dem Quellfeld risk_to. Darstellung als dreistelliger Wert, z.Bsp. 112',
   risiko_farbe                        VARCHAR(20)      COLLATE 'en-ci' COMMENT 'Farbcode aus dem Quellfeld background_color',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_AMX_RISIKO_BEWERTUNG PRIMARY KEY (risiko_bewertung_id, amx_system_id) NOT ENFORCED
)  COMMENT = 'Audimex - Übersetzung der Risikowerte in Farben aus der Quelltabelle rca_risk_translat';

