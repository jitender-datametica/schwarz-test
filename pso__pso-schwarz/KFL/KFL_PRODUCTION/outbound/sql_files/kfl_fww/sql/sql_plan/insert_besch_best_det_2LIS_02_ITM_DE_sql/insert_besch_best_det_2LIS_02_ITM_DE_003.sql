--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.


/* decimal 18,4 */ CREATE TABLE IF NOT EXISTS dbp_etl.besch_best_lbs (
    mandant_id INTEGER NOT NULL,
    best_beleg_id INTEGER NOT NULL,
    best_beleg_pos_id INTEGER NOT NULL,
    art_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    lagerort_id STRING(4) COLLATE 'und:ci',
    menge_best_bme NUMERIC(29, 3) NOT NULL,
    endlief_fg INTEGER NOT NULL,
    dat_best_beleg DATE NOT NULL,
    wrg_id STRING(3) COLLATE 'und:ci',
    ek_netto NUMERIC(29, 4),
    betrag_best_ekn NUMERIC(29, 4),
    gp_id INTEGER NOT NULL,
    bestellart_id STRING(4) COLLATE 'und:ci' NOT NULL,
    komponentenmenge NUMERIC(29, 4),
    menge_best_kolli NUMERIC(29, 3),
    loesch_fg INTEGER,
    selbstabhol_fg INTEGER
);


--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : Snowflake syntax for comments is COMMENT ON <object_type> <object_name> IS '<string_literal>';
--original statement
--COMMENT ON TABLE DBX_LOAD.besch_best_LBS IS 'Arbeitstabelle fuer lvs_aktion - bsch_lief_LBS, bitte nicht loeschen';
--
--Comment from validation checker
--error line 1 at position 19 unexpected 'COMMENT'.
--COMMENT ON TABLE DB ^^^> P_ETL.besch_best_LBS IS 'Arbeitstabelle fuer lvs_aktion - bsch_lief_LBS, bitte nicht loeschen';
--translated statement


ALTER TABLE dbp_etl.besch_best_lbs SET OPTIONS (
    description
    = 'Arbeitstabelle fuer lvs_aktion - bsch_lief_LBS, bitte nicht loeschen'
);
