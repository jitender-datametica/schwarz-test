--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : SET TABLE functionality is not provided by Snowflake. Insert only distinct data instead.
--WARNING : UNIQUE PRIMARY INDEX applied on the table. Use PRIMARY KEY or UNIQUE constraint.


CREATE TABLE IF NOT EXISTS dbp_etl.vis_tag_bestand_wg_wechsel_log_2 (
    mandant_id INTEGER NOT NULL,
    art_id INTEGER NOT NULL,
    arthiertyp_id INTEGER NOT NULL,
    wg_id INTEGER NOT NULL
);


--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : Snowflake syntax for comments is COMMENT ON <object_type> <object_name> IS '<string_literal>';
--original statement
--COMMENT ON DBX_LOAD.vis_tag_bestand_wg_wechsel_log_2 IS 'Protokoll-Tabelle fuer WG-Wechsel fuer Bestands-Agg. BITTE NICHT LOESCHEN!!!';
--
--Comment from validation checker
--error line 1 at position 19 unexpected 'COMMENT'.
--COMMENT ON DBP_ETL. ^^^> vis_tag_bestand_wg_wechsel_log_2 IS 'Protokoll-Tabelle fuer WG-Wechsel fuer Bestands-Agg. BITTE NICHT LOESCHEN!!!';
--translated statement
--COMMENT ON DBP_ETL.vis_tag_bestand_wg_wechsel_log_2 IS 'Protokoll-Tabelle fuer WG-Wechsel fuer Bestands-Agg. BITTE NICHT LOESCHEN!!!';
