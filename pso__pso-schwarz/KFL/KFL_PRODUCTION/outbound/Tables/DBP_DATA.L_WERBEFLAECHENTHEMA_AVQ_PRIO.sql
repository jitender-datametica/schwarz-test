--==============================================================
-- Table: l_werbeflaechenthema_avq_prio
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_werbeflaechenthema_avq_prio
   generated from Powerdesigner on Montag, 6. Oktober 2025 12:43:24
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_werbeflaechenthema_avq_prio (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH.'),
werbeflaechenthema_avq_prio_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Priorisierungs-ID zur Gruppierung und Reihenfolge der Werbeflächenthemen bei der Berechnung der Abverkaufsquote (AVQ). Werbeflächenthemen mit der gleichen ID werden zusammengefasst.'),
werbeflaechenthema_avq_prio_bez STRING(200)
OPTIONS(description='Bezeichnung für die Priorisierung der Abverkaufsquote (AVQ) im Kontext des Werbeflächenthemas.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, werbeflaechenthema_avq_prio_nr) NOT ENFORCED
)
OPTIONS(description='Lookup-Tabelle für die Priorisierung der Abverkaufsquote (AVQ) im Kontext des Werbeflächenthemas.');