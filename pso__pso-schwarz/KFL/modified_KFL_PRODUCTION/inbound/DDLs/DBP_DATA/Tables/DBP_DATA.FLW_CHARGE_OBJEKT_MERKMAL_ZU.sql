--==============================================================
-- Table: flw_charge_objekt_merkmal_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_charge_objekt_merkmal_zu
   generated from Powerdesigner on Monday, March 4, 2024 12:59:39 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_CHARGE_OBJEKT_MERKMAL_ZU (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   objekt_nummer_id                    VARCHAR(50)      NOT NULL COLLATE 'en-ci' COMMENT 'Objektnummer aus SAP Quelle AUSP.OBJEK',
   int_merkmal_id                      VARCHAR(10)      NOT NULL COLLATE 'en-ci' COMMENT 'Internes Merkmal aus SAP Quelle AUSP.ATINN',
   dat_wert                            DATE             COMMENT 'Datumswert aus SAP Quelle AUSP.ATFLV, zB Produktionsdatum oder Verpackungsdatum, abhängig von int_merkmal_id',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_CHARGE_OBJEKT_MERKMAL_ZU PRIMARY KEY (mandant_id, objekt_nummer_id, int_merkmal_id) NOT ENFORCED
)  COMMENT = 'FLW - Ausprägungswerte der Sachmerkmale aus SAP P21 AUSP';

