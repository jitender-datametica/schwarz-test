--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
CREATE TABLE DBP_ETL.art_bestand_vw_sum_artbew_dat  (
  mandant_id BYTEINT NOT NULL,
  dat DATE
)
;

