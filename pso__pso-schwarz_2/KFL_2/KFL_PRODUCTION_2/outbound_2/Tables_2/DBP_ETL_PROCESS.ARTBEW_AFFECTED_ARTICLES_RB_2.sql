CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.artbew_affected_articles_rb_2 (
mandant_id BIGNUMERIC(38,0),
wup_id BIGNUMERIC(38,0),
art_id BIGNUMERIC(38,0),
dat DATE,
gp_id_alt BIGNUMERIC(38,0),
gp_id_neu BIGNUMERIC(38,0),
bq_findung_id_alt BIGNUMERIC(38,0),
bq_findung_id_neu BIGNUMERIC(38,0),
menge BIGNUMERIC(38,3),
umsatz_netto BIGNUMERIC(38,4),
ek_netto_alt BIGNUMERIC(38,4),
ek_netto_neu BIGNUMERIC(38,4),
ek_mep_alt BIGNUMERIC(38,4),
ek_mep_neu BIGNUMERIC(38,4),
proc_dat DATE
);