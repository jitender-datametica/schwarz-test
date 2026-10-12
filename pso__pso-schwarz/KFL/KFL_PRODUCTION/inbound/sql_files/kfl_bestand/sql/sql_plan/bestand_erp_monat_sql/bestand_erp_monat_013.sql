CREATE TABLE DBP_ETL.vis_monat_bestand_wg_log_alt  (
mandant_id BYTEINT NOT NULL ,
wup_id     INTEGER NOT NULL ,
nb_id      SMALLINT NOT NULL ,
gjmo       INTEGER NOT NULL,
art_id     INTEGER NOT NULL
, UNIQUE ( mandant_id, wup_id, nb_id, gjmo, art_id )
);

