--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : UNIQUE PRIMARY INDEX applied on the table. Use PRIMARY KEY or UNIQUE constraint.
CREATE TABLE DBP_ETL.vis_monat_bestand_wg_log  (
  mandant_id BYTEINT NOT NULL ,
  wup_id     INTEGER NOT NULL ,
  nb_id      SMALLINT NOT NULL ,
  gjmo       INTEGER NOT NULL,
  art_id     INTEGER NOT NULL,
  log_tstmp  TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0)
, UNIQUE ( mandant_id, wup_id, nb_id, gjmo, art_id )
);

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : Snowflake syntax for comments is COMMENT ON <object_type> <object_name> IS '<string_literal>';
--original statement
--COMMENT ON ${DWH_COMMON_DBX_LOAD}.vis_monat_bestand_wg_log IS 'Protokoll-Tabelle fuer VIS-Aggregat vis_monat_bestand_wg. NICHT LOESCHEN';
--
--Comment from validation checker
--error line 1 at position 19 unexpected 'COMMENT'.
--COMMENT ON DBP_ETL. ^^^> vis_monat_bestand_wg_log IS 'Protokoll-Tabelle fuer VIS-Aggregat vis_monat_bestand_wg. NICHT LOESCHEN';
--translated statement
--COMMENT ON DBP_ETL.vis_monat_bestand_wg_log IS 'Protokoll-Tabelle fuer VIS-Aggregat vis_monat_bestand_wg. NICHT LOESCHEN';

