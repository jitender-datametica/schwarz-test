--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
CREATE TABLE DBP_ETL.bestand_mardh_mard_vz_log_1  (
art_id          INTEGER NOT NULL,
mandant_id      BYTEINT NOT NULL ,
wup_id          INTEGER NOT NULL ,
nb_id           SMALLINT NOT NULL ,
lagerort_id     CHAR(4) COLLATE 'en-ci' NOT NULL,
dat             DATE NOT NULL
)
;

