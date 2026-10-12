--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
CREATE TABLE DBP_ETL.art_wup_gp_tmp_2  (
   mandant_id BYTEINT NOT NULL
  ,wup_id INTEGER
  ,nb_id SMALLINT
  ,bezugsweg_id BYTEINT
  ,art_id INTEGER
  ,gp_id INTEGER
  ,einkaufsorganisation_id SMALLINT
  ,dat DATE NOT NULL
  ,verarbeitet_fg BYTEINT
)
;

