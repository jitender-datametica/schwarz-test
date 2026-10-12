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


DROP TABLE IF EXISTS dbp_etl.et_kmo_wpuums;


DROP TABLE IF EXISTS dbp_etl.wt_kmo_wpuums;


DROP TABLE IF EXISTS dbp_etl.uv_kmo_wpuums;


DROP TABLE IF EXISTS dbp_etl.log_kmo_wpuums;


/*
#------------------------------------------------------------------------------
# 3.)  Neuanlegen der Lade Tabelle dbp_etl.kmo_wpuums
#------------------------------------------------------------------------------
*/


DROP TABLE IF EXISTS dbp_etl.kmo_wpuums;


CREATE TABLE IF NOT EXISTS dbp_etl.kmo_wpuums (
    segnam STRING(1) NOT NULL,
    landkz STRING(3) NOT NULL,
    filnr STRING(10),
    refnum STRING(16),
    belegdatum STRING(8),
    belegwaers STRING(4),
    qualartnr STRING(4),
    artnr STRING(25),
    aktionsnr STRING(15),
    vorzmenge STRING(1),
    umsmenge STRING(35),
    vorzwert STRING(1),
    umswert STRING(35),
    mwtax STRING(10),
    wgr STRING(6),
    promotionart STRING(10),
    vorzpromotion STRING(1),
    umspromotion STRING(35),
    filnr_integer INTEGER,
    artnr_integer INTEGER,
    lkp_mandant_id INTEGER,
    lkp_art_id INTEGER,
    lkp_wup_id INTEGER,
    lkp_nb_id INTEGER,
    lkp_wg_id INTEGER,
    lkp_arthiertyp_id INTEGER,
    lkp_zek_id INTEGER,
    lkp_mwst_id INTEGER,
    lkp_posten_id STRING(4),
    lkp_umrechnungskurs FLOAT64,
    lkp_mwst NUMERIC(29, 2),
    belegdatum_dat DATE
);


/*
#------------------------------------------------------------------------------
# 4.) BTEQ beenden
#------------------------------------------------------------------------------
*/
