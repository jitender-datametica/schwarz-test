--==============================================================
-- Table: flw_schnitt_input_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_schnitt_input_1
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:42 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_SCHNITT_INPUT_1 (
   schnitt_id                          INTEGER     NOT NULL COMMENT 'Eindeutige Nummer des Schnitts aus cutnr',
   sek_schl_typ_id                     VARCHAR(1)       NOT NULL COLLATE 'en-ci' COMMENT 'Typ des Sekundärschlüssels aus sctyp',
   sek_schl_id                         INTEGER     NOT NULL COMMENT 'ID des Sekundärschlüssels aus sckey',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   flw_art_id                          INTEGER     NOT NULL COMMENT 'Im DWH erzeugter numerischer Schlüssel für die Artikelnummer.',
   werk_id                             INTEGER     NOT NULL COMMENT 'Numerischer Surrogate key für das Werk werks',
   dat_von                             DATE             NOT NULL COMMENT 'Gültigkeitsbeginn des Satzes aus gtvon',
   dat_bis                             DATE             NOT NULL COMMENT 'Gültigkeitsende des Satzes aus gtbis',
   material_einzel_kosten              NUMBER(29,4)     NOT NULL DEFAULT 0 COMMENT 'Materialeinzelkosten aus price',
   wrg_id                              VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
   system_id                           INTEGER     COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   trennprozess_id                     VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'ID des Trennprozesses aus trpro. Werte sind SDZ oder ZERL',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_SCHNITT_INPUT PRIMARY KEY (schnitt_id, sek_schl_typ_id, sek_schl_id, mandant_id) NOT ENFORCED
)  COMMENT = 'FLW - Kopftabelle Schnitt-Input aus cutk';

