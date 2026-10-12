CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.sortiment_kl_wg_verteilung_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
kjmo BIGNUMERIC(38,0) NOT NULL,
kl_uwg_id BIGNUMERIC(38,0) NOT NULL,
kl_wg_id BIGNUMERIC(38,0),
kl_owg_id BIGNUMERIC(38,0),
nielsen_umsatz_anteil_owg BIGNUMERIC(38,5),
nielsen_umsatz_anteil_uwg BIGNUMERIC(38,5),
nielsen_artikel_anteil_owg BIGNUMERIC(38,5),
nielsen_artikel_anteil_uwg BIGNUMERIC(38,5),
kl_umsatz_anteil_owg BIGNUMERIC(38,5),
kl_umsatz_anteil_uwg BIGNUMERIC(38,5),
kl_artikel_anteil_owg BIGNUMERIC(38,5),
kl_artikel_anteil_uwg BIGNUMERIC(38,5),
kl_ertrag_anteil_owg BIGNUMERIC(38,5),
kl_ertrag_anteil_uwg BIGNUMERIC(38,5),
td_insert TIMESTAMP,
td_update TIMESTAMP
);