--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
--WARNING : SET TABLE functionality is not provided by Snowflake. Insert only distinct data instead.
--original statement
--CREATE SET TABLE DBX_LOAD.wlk1 ,
--NO FALLBACK ,
--NO BEFORE JOURNAL,
--     NO AFTER JOURNAL,
--     CHECKSUM = DEFAULT,
--     DEFAULT MERGEBLOCKRATIO
--     (
--      art_id INTEGER NOT NULL,
--      wup_id INTEGER NOT NULL,
--      nb_id INTEGER NOT NULL COMPRESS 0 ,
--      dat_bis DATE FORMAT 'YYYY-MM-DD' NOT NULL ,
--      mandant_id INTEGER NOT NULL COMPRESS 1 ,
--      list_quelle_id STRING(1) CHARACTER SET LATIN NOT CASESPECIFIC NOT NULL DEFAULT ' ',
--      struktur_art_id INTEGER NOT NULL,
--      baustein_id INTEGER NOT NULL,
--      dat_von DATE FORMAT 'YYYY-MM-DD' NOT NULL,
--      list_sap_id INTEGER NOT NULL COMPRESS (1 ,2 ,3 ),
--      loesch_fg INTEGER NOT NULL,
--      komponente_fg INTEGER NOT NULL)
--PRIMARY INDEX NUPI_wlk1 ( art_id ,wup_id );
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement


CREATE TABLE IF NOT EXISTS dbp_etl.wlk1 (
    art_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    dat_bis DATE NOT NULL,
    mandant_id INTEGER NOT NULL,
    list_quelle_id STRING(1) COLLATE 'und:ci' DEFAULT ' ' NOT NULL,
    struktur_art_id INTEGER NOT NULL,
    baustein_id INTEGER NOT NULL,
    dat_von DATE NOT NULL,
    dat_aend DATE NOT NULL,
    list_sap_id INTEGER NOT NULL,
    loesch_fg INTEGER NOT NULL,
    komponente_fg INTEGER NOT NULL,
    td_insert TIMESTAMP
);
