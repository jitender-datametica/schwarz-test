--==============================================================
-- Table: bestaetigung_typ_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: bestaetigung_typ_spr_zu_2
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:13 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BESTAETIGUNG_TYP_SPR_ZU_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Der Mandant_2 1 steht im DWH für Deutschland (der Wert 22 aus dem SAP System für Deutschland wird in Wert 1 umgewandelt).',
   bestaetigung_typ_id                 VARCHAR(2)       NOT NULL COMMENT 'Schlüssel für die Art_2 der Bestätigung.',
   spr_id                              INTEGER     NOT NULL COMMENT 'In diesem Feld werden die Sprachen der DWH Tabelle spr_2 referenziert.',
   bestaetigung_typ_bez                VARCHAR(20)      NOT NULL DEFAULT ' ' COMMENT 'Sprachabhängiger Kurztext für die Art_2 der Bestätigungen.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BESTAETIGUNG_TYP_SPR_ZU PRIMARY KEY (mandant_id, bestaetigung_typ_id, spr_id) NOT ENFORCED
)  COMMENT = 'TP408_LVS - In dieser Tabelle sind die sprachabhängigen Kurztexte für die Typen der Bestellbestätigung enthalten. - MULTISET';

