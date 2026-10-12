--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.


CREATE TABLE IF NOT EXISTS dbp_etl.kmo_mseg_dat_2 (
    dat_buch DATE NOT NULL,
    mandant_id INTEGER NOT NULL
);


--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : Snowflake syntax for comments is COMMENT ON <object_type> <object_name> IS '<string_literal>';
--original statement
--COMMENT ON TABLE DBX_LOAD.kmo_mseg_dat_2 IS 'Arbeitstabelle fuer FWW_KMO - kmo_mkpfmseg_agg, bitte nicht loeschen';
--
--Comment from validation checker
--error line 1 at position 19 unexpected 'COMMENT'.
--COMMENT ON TABLE DB ^^^> P_ETL.kmo_mseg_dat_2 IS 'Arbeitstabelle fuer FWW_KMO - kmo_mkpfmseg_agg, bitte nicht loeschen';
--translated statement


ALTER TABLE dbp_etl.kmo_mseg_dat_2 SET OPTIONS (description = 'Arbeitstabelle fuer FWW_KMO - kmo_mkpfmseg_agg, bitte nicht loeschen');
