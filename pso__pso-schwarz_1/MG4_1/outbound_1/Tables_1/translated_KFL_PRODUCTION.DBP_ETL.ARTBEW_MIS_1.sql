CREATE OR REPLACE TABLE kfl_production_dbp_etl.artbew_mis_1 (
mandant_id INTEGER,
art_id INTEGER NOT NULL,
wup_id INTEGER NOT NULL,
nb_id INTEGER,
wg_id INTEGER,
arthiertyp_id INTEGER,
bewart_id INTEGER,
dat DATE,
menge NUMERIC(18,4),
wrg_1 STRING(3) COLLATE 'und:ci',
umsatz_netto NUMERIC(18,4),
diff_umsatz_netto_konz NUMERIC(18,4),
umsatz_mwst_betrag NUMERIC(18,4),
diff_umsatz_mwst_betrag_konz NUMERIC(18,4)
);