CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.teku_tour_markt_zu (
teku_tour_wup_zu_id BIGNUMERIC(38,0) NOT NULL,
teku_tour_pos_id BIGNUMERIC(38,0) NOT NULL,
teku_tour_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
teku_checkliste_id BIGNUMERIC(38,0) NOT NULL,
aktiv_fg BIGNUMERIC(38,0) DEFAULT 1 NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);