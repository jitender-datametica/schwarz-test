--==============================================================
-- Table: faktura_status_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: faktura_status_spr_zu_2
   generated from Powerdesigner on Monday, March 4, 2024 12:59:39 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FAKTURA_STATUS_SPR_ZU_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Der Mandant_2 1 steht im DWH für Deutschland (der Wert 222 aus dem SAP System für Deutschland wird in Wert 1 umgewandelt).',
   faktura_status_id                   VARCHAR(1)       NOT NULL COMMENT 'Buchhaltungsstatus des Fakturabelegs (z.B. einer Rechnung). Der Status_2 gibt Auskunft darüber, ob das System die Faktura erfolgreich an die Buchhaltung übergeleitet hat, oder ob die Überleitung gesperrt ist, weil für die Fakturaart eine_2 Buchungssperre gese',
   spr_id                              INTEGER     NOT NULL COMMENT 'In diesem Feld werden die Sprachen der DWH Tabelle spr_2 referenziert.',
   faktura_status_bez                  VARCHAR(50)      COMMENT 'Sprachabhängier Kurztext für den Status_2 eines Fakturabeleges.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FAKTURA_STATUS_SPR_ZU PRIMARY KEY (mandant_id, faktura_status_id, spr_id) NOT ENFORCED
)  COMMENT = 'In dieser Tabelle sind die sprachabhängigen Kurztexte für die unterschiedlichen Zustände (Status_2) einer Faktura enthalten. Die Inhalte werden einmalig manuell geladen, da keine Regelschnittstelle existiert. - TP3';

