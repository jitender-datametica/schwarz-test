--==============================================================
-- Table: l_werbeflaechenabschnitt
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_werbeflaechenabschnitt
   generated from Powerdesigner on Montag, 6. Oktober 2025 12:43:24
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_werbeflaechenabschnitt (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH.'),
werbeflaechenabschnitt_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID des Werbeflächenabschnitts'),
werbeflaechenabschnitt_avq_prio_nr BIGNUMERIC(38,0)
OPTIONS(description='Priorisierungs-ID zur Gruppierung und Reihenfolge der Werbeflächenabschnitte bei der Berechnung der Abverkaufsquote (AVQ). Werbeflächenabschnitte mit der gleichen ID werden zusammengefasst.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, werbeflaechenabschnitt_id) NOT ENFORCED
)
OPTIONS(description='Lookup-Tabelle für den Werbeflächenabschnitt. Aus ZPMR_WBM_ABSBEZ(SAP P11). Enthält sowohl die Werbeflächenabschnitts-Bezeichnungen aus SAP, als auch die Bezeichnungen zur Priorisierung der Abverkaufsquote (AVQ).             Der Werbeflächenabschnitt gibt an, in welchem Abschnitt eines Bereichs das Angebot abgebildet ist (z.B. TOPLEFT1 = oben links auf der Seite im Prospekt).');