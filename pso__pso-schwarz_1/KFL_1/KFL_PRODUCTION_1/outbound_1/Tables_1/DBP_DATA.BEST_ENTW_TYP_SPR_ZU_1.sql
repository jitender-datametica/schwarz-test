--==============================================================
-- Table: best_entw_typ_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: best_entw_typ_spr_zu_1
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:13 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.best_entw_typ_spr_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Der Mandant_1 1 steht im DWH für Deutschland (der Wert 22 aus dem SAP System für Deutschland wird in Wert 1 umgewandelt).'),
best_entw_typ_id STRING(1) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Kennzeichen über die Art_1 des Folgebeleges:             E = Wareneingang, Lagerbewegung, U = Warenausgang, Lagerbewegung, L = Lieferschein'),
spr_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='In diesem Feld werden die Sprachen der DWH Tabelle spr_1 referenziert.'),
best_entw_typ_kbez STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Kurzbezeichnung des Bestell-Entwicklungstyps aus t163c.bewtk'),
best_entw_typ_bez STRING(20) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='Dieses Feld enthält die Kurztexte der Typen der Bestellentwicklung.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, spr_id) NOT ENFORCED
)
OPTIONS(description='TP408_LVS - In dieser Tabelle sind die sprachabhängigen Kurztexte für die Belegtypen der Bestellungen enthalten aus t163');