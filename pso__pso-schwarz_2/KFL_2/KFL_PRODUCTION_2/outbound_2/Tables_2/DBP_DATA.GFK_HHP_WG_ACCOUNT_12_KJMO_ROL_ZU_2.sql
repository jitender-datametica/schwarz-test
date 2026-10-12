CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.gfk_hhp_wg_account_12_kjmo_rol_zu_2 (
kjmo_bis BIGNUMERIC(38,0) NOT NULL,
umsatz_tsd_eur NUMERIC(18,4),
anz_einkauf_tsd NUMERIC(18,4),
durchschnitt_einkauf BIGNUMERIC(38,5),
durchschnitt_preis_artikel BIGNUMERIC(38,5),
anz_kaeufer_tsd NUMERIC(18,4),
einkauf_frequenz BIGNUMERIC(38,5),
kjmo_von BIGNUMERIC(38,0),
bewart_id BIGNUMERIC(38,0) NOT NULL,
gfk_account_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
anz_artikel_einkauf BIGNUMERIC(38,5),
wrg_id STRING(12),
eigenmarke_frische_kz BIGNUMERIC(38,0) NOT NULL,
gfk_wg_id BIGNUMERIC(38,0) NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);