--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
--WARNING : SET TABLE functionality is not provided by Snowflake. Insert only distinct data instead.
--original statement
--CREATE SET TABLE DBX_LOAD.wlk1_1 ,
--NO FALLBACK ,
--NO BEFORE JOURNAL,
--     NO AFTER JOURNAL,
--     CHECKSUM = DEFAULT,
--     DEFAULT MERGEBLOCKRATIO
--     (
--      art_id INTEGER NOT NULL,
--      wup_id INTEGER NOT NULL,
--      nb_id SMALLINT NOT NULL COMPRESS 0 ,
--      dat_bis DATE FORMAT 'YYYY-MM_1-DD' NOT NULL ,
--      mandant_id BYTEINT NOT NULL COMPRESS 1 ,
--      list_quelle_id CHAR(1) CHARACTER SET LATIN NOT CASESPECIFIC NOT NULL DEFAULT ' ',
--      struktur_art_id INTEGER NOT NULL,
--      baustein_id DECIMAL(18,0) NOT NULL,
--      dat_von DATE FORMAT 'YYYY-MM_1-DD' NOT NULL,
--      list_sap_id SMALLINT NOT NULL COMPRESS (1 ,2 ,3 ),
--      loesch_fg BYTEINT NOT NULL,
--      komponente_fg BYTEINT NOT NULL)
--PRIMARY INDEX NUPI_wlk1 ( art_id ,wup_id );
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_1 your local system administrator.
--translated statement
CREATE  TABLE DBP_ETL.wlk1_1  (
      art_id INTEGER NOT NULL,
      wup_id INTEGER NOT NULL,
      nb_id SMALLINT NOT NULL  ,
      dat_bis DATE NOT NULL ,
      mandant_id BYTEINT NOT NULL  ,
      list_quelle_id CHAR(1) COLLATE 'de-ci' NOT NULL DEFAULT ' ',
      struktur_art_id INTEGER NOT NULL,
      baustein_id DECIMAL(18,0) NOT NULL,
      dat_von DATE NOT NULL,
      dat_aend DATE NOT NULL,
      list_sap_id SMALLINT NOT NULL ,
      loesch_fg BYTEINT NOT NULL,
      komponente_fg BYTEINT NOT NULL,
      td_insert       TIMESTAMP_LTZ(9)
)
;

