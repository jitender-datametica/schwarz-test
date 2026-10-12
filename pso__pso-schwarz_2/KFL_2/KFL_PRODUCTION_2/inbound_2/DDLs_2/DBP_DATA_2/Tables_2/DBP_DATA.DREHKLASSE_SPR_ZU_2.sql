--==============================================================
-- Table: drehklasse_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: drehklasse_spr_zu_2
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:15 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.DREHKLASSE_SPR_ZU_2 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_2 im DWH',
   drehklasse_kz                       VARCHAR(1)       NOT NULL COLLATE 'en-ci' COMMENT 'Drehklasse auf Artikel_2-/ Markt-Kombination(z.B. A, B oder C (Schnell-, Mittel- und Langsamdreher )-wird im ETL-Prozess auf Basis der F&R-Daten ermittelt: Schwellwerte: A=80% des Absatz (Stückbedarf an Gesamtmenge), B= 15% des Absatz, C= 5% des Absatz)',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'ID der Sprache',
   drehklasse_bez                      VARCHAR(20)      NOT NULL COLLATE 'en-ci' COMMENT 'Bezeichnung der Drehklasse (Ausprägungen z.B. A, B oder C - wird im ETL-Prozess auf Basis der F&R-Daten ermittelt)',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_DREHKLASSE_SPR_ZU PRIMARY KEY (mandant_id, drehklasse_kz, spr_id) NOT ENFORCED
)  COMMENT = 'SCM - Sprachabhängige Bezeichnungen für Drehklassen (z.B. A,B und C resp. Schnell-, Mittel- und Langsamdreher) wird auf Basis der Daten auf SAP RET FRE - Tabelle';

