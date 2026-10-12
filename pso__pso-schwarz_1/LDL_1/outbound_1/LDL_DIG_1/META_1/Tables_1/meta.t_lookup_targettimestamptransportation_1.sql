CREATE TABLE IF NOT EXISTS ldl_dig_meta.t_lookup_targettimestamptransportation_1 (
lgn STRING(100),
dienstleister STRING(100),
wochentag STRING(100),
we_zeit_min TIME,
we_zus_tage_min BIGNUMERIC,
we_zeit_max TIME,
we_zus_tage_max BIGNUMERIC,
gultig_ab_datum DATE,
tmsp_insert TIMESTAMP,
tmsp_update TIMESTAMP
);