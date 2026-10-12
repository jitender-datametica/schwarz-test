--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : UNIQUE PRIMARY INDEX applied on the table. Use PRIMARY KEY or UNIQUE constraint.


CREATE TABLE IF NOT EXISTS dbp_etl.vis_monat_bestand_wg_log_1 (
    mandant_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    gjmo INTEGER NOT NULL,
    art_id INTEGER NOT NULL,
    log_tstmp DATETIME DEFAULT CAST(CURRENT_TIMESTAMP() AS DATETIME) NOT NULL
);

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : Snowflake syntax for comments is COMMENT ON <object_type> <object_name> IS '<string_literal>';
--original statement
--COMMENT ON KFL_PRODUCTION.${DWH_COMMON_DBX_LOAD}.vis_monat_bestand_wg_log_1 IS 'Protokoll-Tabelle fuer VIS-Aggregat vis_monat_bestand_wg. NICHT LOESCHEN';
--
--Comment from validation checker
--error line 1 at position 19 unexpected 'COMMENT'.
--COMMENT ON DBP_ETL. ^^^> vis_monat_bestand_wg_log_1 IS 'Protokoll-Tabelle fuer VIS-Aggregat vis_monat_bestand_wg. NICHT LOESCHEN';
--translated statement
--COMMENT ON DBP_ETL.vis_monat_bestand_wg_log_1 IS 'Protokoll-Tabelle fuer VIS-Aggregat vis_monat_bestand_wg. NICHT LOESCHEN';
