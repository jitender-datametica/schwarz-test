--==============================================================
-- Table: aad_paym_type_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: aad_paym_type_spr_zu
   generated from Powerdesigner on Mittwoch, 10. Mai 2023 08:39:42
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.AAD_PAYM_TYPE_SPR_ZU (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH - ein Mandant pro Land.',
   spr_id                              INTEGER     NOT NULL COMMENT 'ID der Sprache',
   kpos_zahlung_typ_id                 VARCHAR(4)       NOT NULL COMMENT 'KPOS Zahlung Typ id',
   kpos_zahlung_typ_bez                VARCHAR(50)      COMMENT 'KPOS Zahlung typ Bezeichnung',
   paym_type_name                      VARCHAR(100)     COMMENT 'The payment type for the combination of mandant_id and kpos_zahlung_typ_id',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_AAD_PAYM_TYPE_SPR_ZU PRIMARY KEY (mandant_id, spr_id, kpos_zahlung_typ_id) NOT ENFORCED
)  COMMENT = 'Contains the translations of payment type (e.g. cash, ec) for each "mandant" and kpos_zahlung_typ_id';
