--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
--WARNING : SET TABLE functionality is not provided by Snowflake. Insert only distinct data instead.
CREATE TABLE DBP_ETL.mseg_reichweite_1  (
mandant_id BYTEINT NOT NULL,
wup_id INTEGER NOT NULL,
nb_id SMALLINT NOT NULL,
dat_buch DATE NOT NULL)
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : Snowflake syntax for comments is COMMENT ON <object_type> <object_name> IS '<string_literal>';
--original statement
--COMMENT ON TABLE DBX_LOAD.mseg_reichweite_1 IS 'Arbeitstabelle fuer Bestand-Reichweite, bitte nicht loeschen';
--
--Comment from validation checker
--error line 1 at position 19 unexpected 'COMMENT'.
--COMMENT ON TABLE DB ^^^> P_ETL.mseg_reichweite_1 IS 'Arbeitstabelle fuer Bestand-Reichweite, bitte nicht loeschen';
--translated statement
COMMENT ON TABLE DBP_ETL.mseg_reichweite_1 IS 'Arbeitstabelle fuer Bestand-Reichweite, bitte nicht loeschen';

