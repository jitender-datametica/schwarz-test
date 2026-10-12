--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.artbew_wg_wechsel_tmp_2;

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : SET TABLE functionality is not provided by Snowflake. Insert only distinct data instead.
--WARNING : UNIQUE PRIMARY INDEX applied on the table. Use PRIMARY KEY or UNIQUE constraint.
CREATE TABLE DBP_ETL.artbew_wg_wechsel_tmp_2  (
	 mandant_id       BYTEINT NOT NULL
	,art_id           INTEGER NOT NULL
	,arthiertyp_id    BYTEINT NOT NULL
	,alt_neu_kz       BYTEINT NOT NULL
	,wg_id            SMALLINT NOT NULL
	,wg_art_fg        BYTEINT
	, UNIQUE (mandant_id, art_id, arthiertyp_id, alt_neu_kz)
);

