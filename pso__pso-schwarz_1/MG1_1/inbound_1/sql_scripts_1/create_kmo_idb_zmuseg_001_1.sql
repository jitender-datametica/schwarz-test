
DROP TABLE IF EXISTS DBP_ETL.kmo_idb_zmuseg_1 ;


CREATE TABLE DBP_ETL.kmo_idb_zmuseg_1  (
mandant_id              BYTEINT NOT NULL,
umbew_beleg_id          DECIMAL(18,0) NOT NULL,
umbew_beleg_pos_id      INTEGER NOT NULL,
kj                      SMALLINT NOT NULL,
preis_aend_grund_id     SMALLINT NOT NULL,
td_insert TIMESTAMP_LTZ(9),
td_update TIMESTAMP_LTZ(9)
)
;

DROP TABLE IF EXISTS DBP_ETL.art_umbewertung_temp_1;

CREATE TABLE DBP_ETL.art_umbewertung_temp_1 like DBP_DATA.art_umbewertung_1;
