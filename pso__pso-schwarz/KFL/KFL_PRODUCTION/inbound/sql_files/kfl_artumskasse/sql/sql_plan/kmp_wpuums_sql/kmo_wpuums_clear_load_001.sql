/*
#------------------------------------------------------------------------------
# Skriptname   : kmo_wpuums_claer_load.btq
# Erstelldatum : 06.11.2008
#------------------------------------------------------------------------------
# Projekt   : AIS KMO
# Kommentar : Neuanlegen/Initialisieren der Load Tabelle kmo_wpuums
# Quelle    : 
# Ziel      : dbp_etl.kmo_wpuums
#------------------------------------------------------------------------------
# History:
#   06.11.2008  Michael Ueding   Ersterstellung ... 
#   16.05.2011  Michael Ueding   Erweiterung wg. Promotion (Wert, Vorz., Art)
# -----------------------------------------------------------------------------
# Processing Steps
#    1.) Logon auf der Datenbank
#    2.) Loeschen der temporaeren Multiload Tabelle
#    3.) Neuanlegen der Lade Tabelle %DBX_LOAD.kmo_wpuums
#    4.) BTEQ beenden
# -----------------------------------------------------------------------------
*/


/*
#------------------------------------------------------------------------------
# 2.) Loeschen der temporaeren Multiload Tabellen 
#------------------------------------------------------------------------------
*/


DROP TABLE IF EXISTS dbp_etl.ET_kmo_wpuums;


DROP TABLE IF EXISTS dbp_etl.WT_kmo_wpuums;


DROP TABLE IF EXISTS dbp_etl.UV_kmo_wpuums;

DROP TABLE IF EXISTS dbp_etl.LOG_kmo_wpuums;

/*
#------------------------------------------------------------------------------
# 3.)  Neuanlegen der Lade Tabelle dbp_etl.kmo_wpuums
#------------------------------------------------------------------------------
*/


DROP TABLE IF EXISTS dbp_etl.kmo_wpuums;


CREATE  TABLE dbp_etl.kmo_wpuums
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



/*
#------------------------------------------------------------------------------
# 4.) BTEQ beenden
#------------------------------------------------------------------------------
*/
