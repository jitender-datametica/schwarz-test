--==============================================================
-- Table: l_werbeflaechenabschnitt_avq_prio_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_werbeflaechenabschnitt_avq_prio_1
   generated from Powerdesigner on Montag, 6. Oktober 2025 12:43:24
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_werbeflaechenabschnitt_avq_prio_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH.'),
werbeflaechenabschnitt_avq_prio_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Priorisierungs-ID zur Gruppierung und Reihenfolge der Werbeflächenabschnitte bei der Berechnung der Abverkaufsquote (AVQ). Werbeflächenabschnitte mit der gleichen ID werden zusammengefasst.'),
werbeflaechenabschnitt_avq_prio_bez STRING(200)
OPTIONS(description='Bezeichnung für die Priorisierung der Abverkaufsquote (AVQ) im Kontext des Werbeflächenabschnitts.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, werbeflaechenabschnitt_avq_prio_nr) NOT ENFORCED
)
OPTIONS(description='Lookup-Tabelle für die Priorisierung der Abverkaufsquote (AVQ) im Kontext des Werbeflächenabschnitts.');