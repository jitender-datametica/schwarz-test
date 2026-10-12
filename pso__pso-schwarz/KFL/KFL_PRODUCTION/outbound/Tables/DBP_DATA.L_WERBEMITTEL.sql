--==============================================================
-- Table: l_werbemittel
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_werbemittel
   generated from Powerdesigner on Montag, 6. Oktober 2025 12:43:24
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_werbemittel (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH.'),
werbemittelkanal_id STRING(4) DEFAULT '-1' NOT NULL
OPTIONS(description='Werbemittel Art ID - medium through which the advertisement is shown (paper, digital)'),
werbemittel_id STRING(2) NOT NULL
OPTIONS(description='Werbemittel - on what item the advertisement is shown (for example leaflet, magazine for Paper Medium, pop-up banner for digital)'),
werbemittel_avq_prio_nr BIGNUMERIC(38,0)
OPTIONS(description='Priorisierungs-ID zur Gruppierung und Reihenfolge der Werbemittel bei der Berechnung der Abverkaufsquote (AVQ). Werbemittel mit der gleichen ID werden zusammengefasst.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, werbemittelkanal_id, werbemittel_id) NOT ENFORCED
)
OPTIONS(description='Lookup-Tabelle für die Werbemittel, in denen die Werbung geschaltet wird (z.B. Online, Prospekt,...). Aus SAP P11. Die Tabelle enthält zudem Bezeichnungen zur Priorisierung der Abverkaufsquote (AVQ).');