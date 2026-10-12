--==============================================================
-- Table: werbemittel_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: werbemittel_spr_zu
   generated from Powerdesigner on Dienstag, 29. April 2025 06:40:28
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.WERBEMITTEL_SPR_ZU (
   werbemittelkanal_id                 VARCHAR(4)       NOT NULL DEFAULT '-1' COMMENT 'Werbemittel Art ID - medium through which the advertisement is shown (paper, digital)',
   werbemittel_id                      VARCHAR(2)       NOT NULL COMMENT 'Werbemittel - on what item the advertisement is shown (for example leaflet, magazine for Paper Medium, pop-up banner for digital)',
   spr_id                              INTEGER     NOT NULL COMMENT 'Sprachschlüssel',
   werbemittel_bez                     VARCHAR(200)     COMMENT 'Werbemittelbezeichnung',
   werbemittel_wfl_bez                 VARCHAR(200)     COMMENT 'Bezeichnung, durch die Warenfluss-Nutzer (WFL) gesetzt wird. Dieses Feld dient dazu, dass der Nutzer eine Bezeichnung für bestimmt Werbefläche Themen definieren kann, welche im Frontend angezeigt wird.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_WERBEMITTEL_SPR_ZU PRIMARY KEY (spr_id, werbemittel_id, werbemittelkanal_id) NOT ENFORCED
)  COMMENT = 'Sprachzuordnungstabelle für die Werbemittelkanal- & Werbemittel-Kombination. Enthält sowohl die Bezeichnungen aus SAP, als auch die durch die Warenfluss-Nutzer (WFL) gesetzten Kurzbezeichnungen.
             Werbemittelkanal und Werbemittel geben an, wo die Werbung stattfindet (z.B. Online, Prospekt,...)';
