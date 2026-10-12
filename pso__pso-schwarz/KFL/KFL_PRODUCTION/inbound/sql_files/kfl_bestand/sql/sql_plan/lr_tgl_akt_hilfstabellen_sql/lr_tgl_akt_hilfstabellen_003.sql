--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
--WARNING : SET TABLE functionality is not provided by Snowflake. Insert only distinct data instead.
CREATE TABLE DBP_ETL.mk_wupartcal  (
      mandant_id BYTEINT,
      wup_id INTEGER,
      nb_id SMALLINT,
      art_id INTEGER,
      dat DATE,
      wtag_id BYTEINT,
      aktion_fg BYTEINT,
      saison_fg VARCHAR(1) COLLATE 'en-ci')
;

