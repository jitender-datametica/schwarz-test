CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.lis_plan_wup_tour_mo_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
lis_planzahl_id BIGNUMERIC(38,0) NOT NULL,
lis_plan_typ_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
nb_id BIGNUMERIC(38,0) NOT NULL,
belos_tourart_id BIGNUMERIC(38,0) NOT NULL,
kjmo BIGNUMERIC(38,0) NOT NULL,
lis_plan_wert NUMERIC(18,2),
td_insert TIMESTAMP,
td_update TIMESTAMP
);