CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.linbew_prog_hc (
mandant_id BIGNUMERIC NOT NULL,
wup_id BIGNUMERIC NOT NULL,
dat DATE NOT NULL,
anz_prg_beendet BIGNUMERIC,
anz_prg_faellig BIGNUMERIC,
anz_prg_gesamt BIGNUMERIC,
anz_prg_bearbeitung BIGNUMERIC,
anz_prg_ausstehend BIGNUMERIC,
td_insert TIMESTAMP,
td_update TIMESTAMP
);