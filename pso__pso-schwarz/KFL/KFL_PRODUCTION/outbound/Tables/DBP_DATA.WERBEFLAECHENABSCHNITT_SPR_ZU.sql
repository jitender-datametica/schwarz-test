--==============================================================
-- Table: werbeflaechenabschnitt_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: werbeflaechenabschnitt_spr_zu
   generated from Powerdesigner on Montag, 6. Oktober 2025 12:43:24
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.werbeflaechenabschnitt_spr_zu (
werbeflaechenabschnitt_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID des Werbeflächenabschnitts'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
werbeflaechenabschnitt_name STRING(100) OPTIONS(description='Bezeichnung des Werbeflächenabschnitts'),
werbeflaechenabschnitt_wfl_bez STRING(200)
OPTIONS(description='Bezeichnung, durch die Warenfluss-Nutzer (WFL) gesetzt wird. Dieses Feld dient dazu, dass der Nutzer eine Bezeichnung für bestimmt Werbeflächenabschnitt definieren kann, welche im Frontend angezeigt wird.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (werbeflaechenabschnitt_id, spr_id) NOT ENFORCED
)
OPTIONS(description='Sprachzuordnungstabelle für den Werbeflächenabschnitt. Aus ZPMR_WBM_ABSBEZ(SAP P11). Enthält sowohl die Werbeflächenabschnitts-Bezeichnungen aus SAP, als auch die durch die Warenfluss-Nutzer (WFL) gesetzten Kurzbezeichnungen.             Der Werbeflächenabschnitt gibt an, in welchem Abschnitt eines Bereichs das Angebot abgebildet ist (z.B. TOPLEFT1 = oben links auf der Seite im Prospekt).');