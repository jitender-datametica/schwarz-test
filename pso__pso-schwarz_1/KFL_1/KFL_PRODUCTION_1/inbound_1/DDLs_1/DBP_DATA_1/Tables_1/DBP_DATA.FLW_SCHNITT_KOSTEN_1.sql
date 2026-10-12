--==============================================================
-- Table: flw_schnitt_kosten_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_schnitt_kosten_1
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:43 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_SCHNITT_KOSTEN_1 CLUSTER BY (SEK_SCHL_TYP_ID) (
   schnitt_id                          NUMBER(18,0)     NOT NULL COMMENT 'Eindeutige Nummer des Schnitts aus cutnr',
   sek_schl_typ_id                     VARCHAR(1)       NOT NULL COLLATE 'en-ci' COMMENT 'Typ des Sekundärschlüssels aus sctyp',
   sek_schl_id                         NUMBER(18,0)     NOT NULL COMMENT 'ID des Sekundärschlüssels aus sckey',
   input_typ_id                        VARCHAR(1)       NOT NULL COLLATE 'en-ci' COMMENT 'Input Typ aus itypc. S steht für Summe',
   kosten_block_id                     VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Kostenblock aus costb',
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH',
   fertig_einzel_kosten_kg             NUMBER(18,4)     NOT NULL DEFAULT 0 COMMENT 'interne Var. Kosten (Preis) pro kg aus ivarp',
   wrg_id                              VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
   system_id                           NUMBER(38,0)     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_SCHNITT_KOSTEN PRIMARY KEY (schnitt_id, sek_schl_typ_id, sek_schl_id, input_typ_id, kosten_block_id, mandant_id) NOT ENFORCED
)  COMMENT = 'FLW - Schnitt Kopf Kosten aus cutkc - MULTISET';

