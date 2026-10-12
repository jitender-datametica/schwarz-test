--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.fww_wme_pos_1;

--[OK] statement is translated correctly (syntax and type checks are fine)
CREATE TABLE DBP_ETL.fww_wme_pos_1  (
         mandant_1          CHAR( 3)
        ,aktionsnummer    CHAR(10) COLLATE 'en-ci'
        ,markt            INTEGER
        ,artikelnummer    INTEGER
        ,aktionspreis     DECIMAL(9,3)
        ,waehrung_id      CHAR( 3)
        ,bezugsquelle     BYTEINT
        ,sperrkennzeichen CHAR (1)
        ,sperrdatum       CHAR(10)
        ,aktionsthema     CHAR( 4)
        ,aktionsthema_bez CHAR(20)
)

;

--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.fww_wme_pos_tmp_1;

--[OK] statement is translated correctly (syntax and type checks are fine)
CREATE TABLE DBP_ETL.fww_wme_pos_tmp_1  (
      mandant_1           CHAR(3) COLLATE 'en-cs',
      aktionsthema      CHAR(4) COLLATE 'en-cs',
      aktionsthema_bez  CHAR(20) COLLATE 'en-cs',
      SPRAS             CHAR(1) COLLATE 'en-ci')
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.aktion_art_wup_zu_fdenorm_1;

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
CREATE TABLE DBP_ETL.aktion_art_wup_zu_fdenorm_1  (
      mandant_id  BYTEINT NOT NULL,
      aktion_id   CHAR(10) COLLATE 'en-ci' NOT NULL,
      art_id    INTEGER NOT NULL,
      bewart_id   SMALLINT NOT NULL,
      wup_id    INTEGER NOT NULL,
      nb_id     SMALLINT NOT NULL,
      vk_aktion_brutto  DECIMAL(9,3) NOT NULL ,
      bezugsweg_id  BYTEINT NOT NULL ,
      wrg_id    CHAR(3) COLLATE 'en-ci' NOT NULL ,
      grund_sperrung    CHAR(1) COLLATE 'en-ci' ,
      dat_sperrung      DATE,
      aktion_thema_id   CHAR(4)NOT NULL 
)
;

