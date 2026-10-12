--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.


CREATE TABLE IF NOT EXISTS dbp_etl.bestand_mardh_mard_vz_log_kmo (
    art_id INTEGER NOT NULL,
    mandant_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    lagerort_id STRING(4) COLLATE 'und:ci' NOT NULL,
    dat DATE NOT NULL
);


--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : Snowflake syntax for comments is COMMENT ON <object_type> <object_name> IS '<string_literal>';
--original statement
--COMMENT ON TABLE ${DWH_COMMON_DBX_LOAD}.bestand_mardh_mard_vz_log_kmo IS 'Arbeitstabelle aus MARD fuer KMO Monatsaggregat in BESTAND.cfg - bitte nicht loeschen' ;
--
--Comment from validation checker
--error line 1 at position 19 unexpected 'COMMENT'.
--COMMENT ON TABLE DB ^^^> P_ETL.bestand_mardh_mard_vz_log_kmo IS 'Arbeitstabelle aus MARD fuer KMO Monatsaggregat in BESTAND.cfg - bitte nicht loeschen' ;
--translated statement
--COMMENT ON TABLE DBP_ETL.bestand_mardh_mard_vz_log_kmo IS 'Arbeitstabelle aus MARD fuer KMO Monatsaggregat in BESTAND.cfg - bitte nicht loeschen' ;

