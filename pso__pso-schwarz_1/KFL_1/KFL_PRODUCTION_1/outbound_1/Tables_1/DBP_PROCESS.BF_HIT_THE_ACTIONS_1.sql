CREATE TABLE IF NOT EXISTS kfl_production_dbp_process.bf_hit_the_actions_1 (
mandant_id BIGNUMERIC(38,0),
wup_id BIGNUMERIC(38,0),
kjwo BIGNUMERIC(38,0),
aktion_thema_gruppe_id BIGNUMERIC(38,0) NOT NULL,
art_id BIGNUMERIC(38,0),
kl_art_id BIGNUMERIC(38,0),
muki STRING(1),
dat_bis DATE,
mengen_faktor NUMERIC(15,3),
posten_id STRING(2),
vk_brutto NUMERIC(9,2),
td_update TIMESTAMP,
td_insert TIMESTAMP
);