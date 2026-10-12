--==============================================================
-- Table: diff_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: diff_spr_zu_1
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:13 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.DIFF_SPR_ZU_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Der Mandant_1 1 steht im DWH für Deutschland (der Wert 22 aus dem SAP System für Deutschland wird in Wert 1 umgewandelt).',
   diff_id                             VARCHAR(1)       NOT NULL COLLATE 'en-ci' COMMENT 'Wenn eine_1 Lieferposition nicht vollständig beliefert werden kann, wird die Restmenge vom VZ nachgeliefert oder muss vom Markt neu bestellt werden. Diese Information wird auch als Nachlieferkennzeichen bezeichnet.',
   spr_id                              INTEGER     NOT NULL COMMENT 'In diesem Feld werden die Sprachen der DWH Tabelle spr_1 referenziert.',
   diff_bez                            VARCHAR(40)      COLLATE 'en-ci' COMMENT 'Sprachabhängiger Kurztext für die Nachlieferkennzeichen.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_DIFF_SPR_ZU PRIMARY KEY (mandant_id, diff_id, spr_id) NOT ENFORCED
)  COMMENT = 'TP408_LVS - In dieser Tabelle sind die sprachabhängigen Kurztexte für die unterschiedlichen Differenzkennzeichen enthalten. Die Inhalte werden einmalig manuell geladen, da keine Regelschnittstelle existiert';

