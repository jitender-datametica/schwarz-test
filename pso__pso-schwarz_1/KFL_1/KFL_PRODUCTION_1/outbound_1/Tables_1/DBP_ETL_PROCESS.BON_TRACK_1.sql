CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.bon_track_1 (
mandant_id BIGNUMERIC(38,0),
kl_art_id BIGNUMERIC(38,0),
kjmo BIGNUMERIC(38,0),
bons BIGNUMERIC(38,0),
bons_af BIGNUMERIC(38,0),
bons_sa BIGNUMERIC(38,0),
bon_umsatz_gesamt NUMERIC(18,4),
ges_umsatz_af NUMERIC(18,4),
ges_umsatz_sa NUMERIC(18,4),
markt_bon BIGNUMERIC(38,0),
a_umsatz_af NUMERIC(18,4),
a_umsatz_sa NUMERIC(18,4),
td_insert TIMESTAMP,
td_update TIMESTAMP
);