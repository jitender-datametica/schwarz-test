--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
--WARNING : SET TABLE functionality is not provided by Snowflake. Insert only distinct data instead.
--original statement
--CREATE SET TABLE DBX_LOAD.wlk1_2 ,
--NO FALLBACK ,
--NO BEFORE JOURNAL,
--     NO AFTER JOURNAL,
--     CHECKSUM = DEFAULT,
--     DEFAULT MERGEBLOCKRATIO
--     (
--      art_id INTEGER NOT NULL,
--      wup_id INTEGER NOT NULL,
--      nb_id INTEGER NOT NULL COMPRESS 0 ,
--      dat_bis DATE FORMAT 'YYYY-MM_2-DD' NOT NULL ,
--      mandant_id INTEGER NOT NULL COMPRESS 1 ,
--      list_quelle_id CHAR(1) CHARACTER SET LATIN NOT CASESPECIFIC NOT NULL DEFAULT ' ',
--      struktur_art_id INTEGER NOT NULL,
--      baustein_id INTEGER  NOT NULL,
--      dat_von DATE FORMAT 'YYYY-MM_2-DD' NOT NULL,
--      list_sap_id INTEGER NOT NULL COMPRESS (1 ,2 ,3 ),
--      loesch_fg INTEGER NOT NULL,
--      komponente_fg INTEGER NOT NULL)
--PRIMARY INDEX NUPI_wlk1 ( art_id ,wup_id );
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_2 your local system administrator.
--translated statement



CREATE TABLE IF NOT EXISTS KFL_PRODUCTION_DBP_ETL.WLK1_2 (
ART_ID INTEGER NOT NULL,
WUP_ID INTEGER NOT NULL,
NB_ID INTEGER NOT NULL,
DAT_BIS DATE NOT NULL,
MANDANT_ID INTEGER NOT NULL,
LIST_QUELLE_ID STRING COLLATE 'und:ci' DEFAULT ' ' NOT NULL,
STRUKTUR_ART_ID INTEGER NOT NULL,
BAUSTEIN_ID INTEGER NOT NULL,
DAT_VON DATE NOT NULL,
DAT_AEND DATE NOT NULL,
LIST_SAP_ID INTEGER NOT NULL,
LOESCH_FG INTEGER NOT NULL,
KOMPONENTE_FG INTEGER NOT NULL,
TD_INSERT TIMESTAMP
);