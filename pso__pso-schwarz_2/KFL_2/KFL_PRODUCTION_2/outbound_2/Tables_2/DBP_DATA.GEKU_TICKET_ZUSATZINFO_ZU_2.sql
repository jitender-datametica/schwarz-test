CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.geku_ticket_zusatzinfo_zu_2 (
geku_ticket_id INTEGER NOT NULL,
zusatzinfo_id INTEGER NOT NULL,
zusatzinfo_sel_id INTEGER,
zusatzinfo_text STRING(10000) COLLATE 'und:ci',
zusatzinfo_date DATE,
zusatzinfo_ganzzahl BIGNUMERIC(38,0),
zusatzinfo_float BIGNUMERIC(38,5),
td_update TIMESTAMP,
td_insert TIMESTAMP
);