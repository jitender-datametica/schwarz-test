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


CREATE MULTISET TABLE dbp_etl.kmo_wpuums,
NO FALLBACK,
NO BEFORE JOURNAL,
NO AFTER JOURNAL,
CHECKSUM = DEFAULT
(
  segnam              CHAR( 1) CHARACTER SET LATIN NOT CASESPECIFIC NOT NULL,
  landkz              CHAR( 3) CHARACTER SET LATIN NOT CASESPECIFIC NOT NULL,
  filnr               CHAR(10) CHARACTER SET LATIN NOT CASESPECIFIC,
  refnum              CHAR(16) CHARACTER SET LATIN NOT CASESPECIFIC,
  belegdatum          CHAR( 8) CHARACTER SET LATIN NOT CASESPECIFIC,
  belegwaers          CHAR( 4) CHARACTER SET LATIN NOT CASESPECIFIC,
  qualartnr           CHAR( 4) CHARACTER SET LATIN NOT CASESPECIFIC,
  artnr               CHAR(25) CHARACTER SET LATIN NOT CASESPECIFIC,
  aktionsnr           CHAR(15) CHARACTER SET LATIN NOT CASESPECIFIC,
  vorzmenge           CHAR( 1) CHARACTER SET LATIN NOT CASESPECIFIC,
  umsmenge            CHAR(35) CHARACTER SET LATIN NOT CASESPECIFIC,
  vorzwert            CHAR( 1) CHARACTER SET LATIN NOT CASESPECIFIC,
  umswert             CHAR(35) CHARACTER SET LATIN NOT CASESPECIFIC,
  mwtax               CHAR(10) CHARACTER SET LATIN NOT CASESPECIFIC,
  wgr                 CHAR( 6) CHARACTER SET LATIN NOT CASESPECIFIC,
  promotionart        CHAR(10) CHARACTER SET LATIN NOT CASESPECIFIC,
  vorzpromotion       CHAR( 1) CHARACTER SET LATIN NOT CASESPECIFIC,
  umspromotion        CHAR(35) CHARACTER SET LATIN NOT CASESPECIFIC,
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
  lkp_posten_id       CHAR(4) CHARACTER SET LATIN NOT CASESPECIFIC,
  lkp_umrechnungskurs FLOAT, 
  lkp_mwst            DECIMAL(12,2),
  belegdatum_dat      DATE FORMAT 'YYYYMMDD'
)
PRIMARY INDEX (landkz, filnr, refnum, artnr)
;




/*
#------------------------------------------------------------------------------
# 4.) BTEQ beenden
#------------------------------------------------------------------------------
*/
