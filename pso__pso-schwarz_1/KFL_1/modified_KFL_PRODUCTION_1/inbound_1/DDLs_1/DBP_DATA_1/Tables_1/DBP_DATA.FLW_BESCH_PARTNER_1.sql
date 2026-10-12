--==============================================================
-- Table: flw_besch_partner_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_besch_partner_1
   generated from Powerdesigner on Monday, March 4, 2024 12:59:40 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_BESCH_PARTNER_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH. In der Regel länderbezogen',
   faktura_beleg_id                    INTEGER     NOT NULL COMMENT 'Faktura Belegnummer aus vbeln',
   partner_verwendung_id               VARCHAR(2)       NOT NULL COLLATE 'en-ci' COMMENT 'aus parvw',
   faktura_beleg_pos_id                INTEGER     NOT NULL COMMENT 'Belegposition aus posnr',
   flw_kunde_id                        INTEGER     NOT NULL COMMENT 'Im DWH generierter Surrogate Key für die Kundennummer aus SAP',
   system_id                           INTEGER     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_BESCH_PARTNER PRIMARY KEY (mandant_id, faktura_beleg_id, partner_verwendung_id, faktura_beleg_pos_id) NOT ENFORCED
)  COMMENT = 'FLW - Partnertabelle aus SAP VBPA';

