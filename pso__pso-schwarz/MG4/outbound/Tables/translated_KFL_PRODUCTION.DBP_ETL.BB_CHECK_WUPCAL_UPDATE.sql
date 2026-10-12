CREATE OR REPLACE TABLE kfl_production_dbp_etl.bb_check_wupcal_update (
mandant_id INTEGER NOT NULL,
dat DATE NOT NULL,
wup_id INTEGER NOT NULL,
offen INTEGER,
bonanzahl_sug INTEGER,
nb_id INTEGER NOT NULL,
umsatz_brutto_ods_verkauf NUMERIC(18,4),
umsatz_brutto_ods_kassenabschluss NUMERIC(18,4),
diff_wert NUMERIC(18,4),
diff_proz NUMERIC(18,4),
pruef_status_id_umsatz INTEGER,
pruef_grund_id_umsatz STRING(3)
);