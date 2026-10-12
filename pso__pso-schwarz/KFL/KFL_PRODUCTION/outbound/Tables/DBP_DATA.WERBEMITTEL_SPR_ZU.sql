--==============================================================
-- Table: werbemittel_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: werbemittel_spr_zu
   generated from Powerdesigner on Dienstag, 29. April 2025 06:40:28
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.werbemittel_spr_zu (
werbemittelkanal_id STRING(4) DEFAULT '-1' NOT NULL
OPTIONS(description='Werbemittel Art ID - medium through which the advertisement is shown (paper, digital)'),
werbemittel_id STRING(2) NOT NULL
OPTIONS(description='Werbemittel - on what item the advertisement is shown (for example leaflet, magazine for Paper Medium, pop-up banner for digital)'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Sprachschlüssel'),
werbemittel_bez STRING(200) OPTIONS(description='Werbemittelbezeichnung'),
werbemittel_wfl_bez STRING(200)
OPTIONS(description='Bezeichnung, durch die Warenfluss-Nutzer (WFL) gesetzt wird. Dieses Feld dient dazu, dass der Nutzer eine Bezeichnung für bestimmt Werbefläche Themen definieren kann, welche im Frontend angezeigt wird.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (spr_id, werbemittel_id, werbemittelkanal_id) NOT ENFORCED
)
OPTIONS(description='Sprachzuordnungstabelle für die Werbemittelkanal- & Werbemittel-Kombination. Enthält sowohl die Bezeichnungen aus SAP, als auch die durch die Warenfluss-Nutzer (WFL) gesetzten Kurzbezeichnungen.             Werbemittelkanal und Werbemittel geben an, wo die Werbung stattfindet (z.B. Online, Prospekt,...)');