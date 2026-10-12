CREATE OR REPLACE TABLE kfl_production_dbp_etl.wupcal_tmp (
wup_id INTEGER NOT NULL,
mandant_id INTEGER NOT NULL,
bon_dat DATE,
bonanzahl_sug INTEGER,
bonanzahl_kundenkarte INTEGER,
bonanzahl_imbiss INTEGER,
bonanzahl_kundenkarte_payback INTEGER,
bonanzahl_frischetheke_ohne_fisch INTEGER,
betrag_vk_netto_kundenkarte NUMERIC(29,4)
);