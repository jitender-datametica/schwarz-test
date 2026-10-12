--==============================================================
-- Table: markt_lagerbereich_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: markt_lagerbereich_spr_zu
   generated from Powerdesigner on Freitag, 28. März 2025 10:02:19
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.MARKT_LAGERBEREICH_SPR_ZU (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH.',
   markt_lagerbereich_id               INTEGER     NOT NULL COMMENT 'ID des Lagerbereichs in der Filiale.',
   spr_id                              INTEGER     NOT NULL COMMENT 'ID der DWH-Sprache, z.B. 22 = Deutsch, 24 = Englisch, etc.',
   markt_lagerbereich_bez              VARCHAR(200)     NOT NULL COLLATE 'en-ci' COMMENT 'Sprachabhängige Bezeichnung der Lagerbereichen in der Filiale.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_MARKT_LAGERBEREICH_SPR_ZU PRIMARY KEY (mandant_id, markt_lagerbereich_id, spr_id) NOT ENFORCED
)  COMMENT = 'Diese Tabelle enthält die sprachabhänigige Bezeichnungen der Lagerbereichen in der Filiale. Wird manuell beladen.';
