CREATE TABLE IF NOT EXISTS ldl_dig_meta.t_lookup_targettimestampcarrier_1 (
lgn STRING(100),
dienstleister STRING(100),
wochentag STRING(100),
we_scan_min TIME,
we_scan_max TIME,
gultig_ab_datum DATE,
zustellung_zeit_max TIME,
zustellung_tage_max BIGNUMERIC(38,0),
tmsp_insert TIMESTAMP,
tmsp_update TIMESTAMP
);