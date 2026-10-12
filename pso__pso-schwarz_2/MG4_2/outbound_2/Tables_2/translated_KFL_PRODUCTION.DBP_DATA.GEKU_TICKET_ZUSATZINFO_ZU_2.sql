CREATE OR REPLACE TABLE kfl_production_dbp_data.geku_ticket_zusatzinfo_zu_2 (
geku_ticket_id INTEGER NOT NULL,
zusatzinfo_id INTEGER NOT NULL,
zusatzinfo_sel_id INTEGER,
zusatzinfo_text STRING(10000) COLLATE 'und:ci',
zusatzinfo_date DATE,
zusatzinfo_ganzzahl INTEGER,
zusatzinfo_float NUMERIC(29,5),
td_update TIMESTAMP,
td_insert TIMESTAMP
);