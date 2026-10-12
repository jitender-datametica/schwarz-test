--==============================================================
-- Table: flw_schnitt_output_det_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_schnitt_output_det_1
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:43 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_SCHNITT_OUTPUT_DET_1 (
   schnitt_id                          INTEGER     NOT NULL COMMENT 'Eindeutige Nummer des Schnitts aus cutnr',
   sek_schl_typ_id                     VARCHAR(1)       NOT NULL COLLATE 'en-ci' COMMENT 'Typ des Sekundärschlüssels aus sctyp',
   sek_schl_id                         INTEGER     NOT NULL COMMENT 'ID des Sekundärschlüssels aus sckey. Entspricht der Kalkulationsnummer materialwert_kalk_id aus flw_kalk_material_1',
   schnitt_pos_id                      INTEGER     NOT NULL COMMENT 'Position aus posnr',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   system_id                           INTEGER     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   flw_art_id                          INTEGER     NOT NULL COMMENT 'Im DWH erzeugter numerischer Schlüssel für die Artikelnummer.',
   menge_schnitt                       NUMBER(29,3)     NOT NULL DEFAULT 0 COMMENT 'Menge in KG aus menge',
   wrg_id                              VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
   betrag_schnitt_output               NUMBER(29,4)     NOT NULL DEFAULT 0 COMMENT 'material_gesamt_kosten',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_SCHNITT_OUTPUT_DET PRIMARY KEY (schnitt_id, sek_schl_typ_id, sek_schl_id, schnitt_pos_id, mandant_id) NOT ENFORCED
)  COMMENT = 'FLW - Schnitt Output-Positionen aus spmeat_cutp';

