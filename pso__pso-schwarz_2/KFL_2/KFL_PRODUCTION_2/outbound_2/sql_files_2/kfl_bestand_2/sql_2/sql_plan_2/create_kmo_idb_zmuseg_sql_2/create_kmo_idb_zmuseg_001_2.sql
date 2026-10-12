DROP TABLE IF EXISTS dbp_etl.kmo_idb_zmuseg_2;


CREATE TABLE IF NOT EXISTS dbp_etl.kmo_idb_zmuseg_2 (
    mandant_id INTEGER NOT NULL,
    umbew_beleg_id INTEGER NOT NULL,
    umbew_beleg_pos_id INTEGER NOT NULL,
    kj INTEGER NOT NULL,
    preis_aend_grund_id INTEGER NOT NULL,
    td_insert TIMESTAMP,
    td_update TIMESTAMP
);


DROP TABLE IF EXISTS dbp_etl.art_umbewertung_temp_2;


CREATE TABLE IF NOT EXISTS dbp_etl.art_umbewertung_temp_2 LIKE dbp_data.art_umbewertung_2;
