--==============================================================
-- Table: flw_schnitt_output_kosten_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_schnitt_output_kosten_1
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:43 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_SCHNITT_OUTPUT_KOSTEN_1 CLUSTER BY (MANDANT_ID) (
   schnitt_id                          NUMBER(18,0)     NOT NULL COMMENT 'Eindeutige Nummer des Schnitts aus cutnr',
   sek_schl_typ_id                     VARCHAR(1)       NOT NULL COLLATE 'en-ci' COMMENT 'Typ des Sekundärschlüssels aus sctyp',
   sek_schl_id                         NUMBER(18,0)     NOT NULL COMMENT 'ID des Sekundärschlüssels aus sckey. Entspricht der Kalkulationsnummer materialwert_kalk_id aus flw_kalk_material_1',
   schnitt_pos_id                      NUMBER(38,0)     NOT NULL COMMENT 'Position aus posnr',
   kosten_block_id                     VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Kostenblock aus costb',
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH',
   fertig_einzel_kosten_kg             NUMBER(18,4)     NOT NULL COMMENT 'interne Var. Kosten (Preis) pro kg aus ivarp',
   fertig_einzel_kosten_gesamt         NUMBER(18,4)     NOT NULL DEFAULT 0 COMMENT 'interne Var. Kosten (Wert)',
   wrg_id                              VARCHAR(3)       NOT NULL COLLATE 'en-ci' DEFAULT 'EUR' COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
   system_id                           NUMBER(38,0)     COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_SCHNITT_OUTPUT_KOSTEN PRIMARY KEY (schnitt_id, sek_schl_typ_id, sek_schl_id, schnitt_pos_id, kosten_block_id, mandant_id) NOT ENFORCED
)  COMMENT = 'FLW - Schnitt-Position-Kosten aus cutpc';

