DROP TABLE IF EXISTS dbp_etl.kmo_wpuums_2;

CREATE  TABLE dbp_etl.kmo_wpuums_2
(
  segnam              CHAR( 1)  NOT NULL,
  landkz              CHAR( 3)  NOT NULL,
  filnr               CHAR(10) ,
  refnum              CHAR(16) ,
  belegdatum          CHAR( 8) ,
  belegwaers          CHAR( 4) ,
  qualartnr           CHAR( 4) ,
  artnr               CHAR(25) ,
  aktionsnr           CHAR(15) ,
  vorzmenge           CHAR( 1) ,
  umsmenge            CHAR(35) ,
  vorzwert            CHAR( 1) ,
  umswert             CHAR(35) ,
  mwtax               CHAR(10) ,
  wgr                 CHAR( 6) ,
  promotionart        CHAR(10) ,
  vorzpromotion       CHAR( 1) ,
  umspromotion        CHAR(35) ,
  filnr_integer       INTEGER,
  artnr_integer       INTEGER,
  lkp_mandant_id      BYTEINT,
  lkp_art_id          INTEGER,
  lkp_wup_id          INTEGER,
  lkp_nb_id           SMALLINT,
  lkp_wg_id           SMALLINT,
  lkp_arthiertyp_id   BYTEINT,
  lkp_zek_id          SMALLINT,
  lkp_mwst_id         BYTEINT,
  lkp_posten_id       CHAR(4) ,
  lkp_umrechnungskurs FLOAT, 
  lkp_mwst            DECIMAL(12,2),
  belegdatum_dat      DATE
)
;
