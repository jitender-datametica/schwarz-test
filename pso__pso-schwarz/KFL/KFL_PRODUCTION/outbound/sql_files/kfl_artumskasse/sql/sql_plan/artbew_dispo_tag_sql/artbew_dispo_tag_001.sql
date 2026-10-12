/*
#------------------------------------------------------------------------------
# Source Safe Info
#------------------------------------------------------------------------------
# Skriptname             : artbew_dispo_tag.btq
# Aktuelle Version       : 1.0
# Check-Out Datum        : 01.04.2009
# Version-erstellt Datum : 01.04.2009
#------------------------------------------------------------------------------
# Projekt : TP2_AIS
# Comment : Aufbau der Aggregationstabelle dbp_etl.artbew_dispo_tag
# Source  : TABLE dbp_data.artbew
# Target  : TABLE dbp_etl.artbew_dispo_tag
#------------------------------------------------------------------------------
# History:
#   21.09.2006  R.Wesemann         Neuerstellung
#   05.01.2007  Giannoulakes St.   Ersetzung dbp_xxx nach $DBX_XXX
#                                  PPI weggenommen (lt. Frau Lenz)
#   22.01.2007  R.Wesemann         Sicherungsfunktion auskommentiert
#                                  DROP TABLE eingebaut
#   01.04.2009  Sascha Romanowski  Applikations Server LOGON
#   01.04.2009  Michael Ueding     Ueberarbeitung und Einschraenkung auf
#                                  Mandant Deutschland
# -----------------------------------------------------------------------------
# Processing Steps
#    1.) Logon auf der Datenbank
#    2.) Neuanlage der Zieltabelle
#    3.) Einfuegen der Daten fuer die letzten 15 Tage
#    4.) Tabellenkommentar setzen
#    5.) Statistiken sammeln
#    6.) Bteq beenden
# -----------------------------------------------------------------------------
*/


/*
#------------------------------------------------------------------------------
# 2.) Neuanlage der Zieltabelle
#------------------------------------------------------------------------------
*/


DROP TABLE IF EXISTS dbp_etl.artbew_dispo_tag;


CREATE TABLE IF NOT EXISTS dbp_etl.artbew_dispo_tag (
    kl_art_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    dat DATE,
    sonntag_fg INTEGER,
    menge NUMERIC(18, 4)
);


/*
#------------------------------------------------------------------------------
# 3.) Einfuegen der Daten fuer die letzten 15 Tage
#------------------------------------------------------------------------------
*/


INSERT INTO dbp_etl.artbew_dispo_tag (kl_art_id, wup_id, dat, sonntag_fg, menge)
(
    SELECT
        CAST(CAST(FLOOR(A.art_id / 100) AS INTEGER) AS INTEGER) AS kl_art_id,
        A.wup_id,
        A.dat,
        CAST(CASE
            WHEN t.wtag_id = 7
                THEN '1'
            ELSE '0'
        END AS INTEGER) AS sonntag_fg,
        SUM(A.menge) AS menge_
    FROM dbp_data.artbew AS A
    INNER JOIN (SELECT
        dat,
        wtag_id
    FROM dbp_data.tag
    WHERE akt_tag BETWEEN -15 AND 0) AS t ON A.dat = t.dat
    WHERE
        A.mandant_id = 1
        AND A.art_id > 0
    GROUP BY
        kl_art_id,
        A.wup_id,
        A.dat,
        sonntag_fg
);


/*
#------------------------------------------------------------------------------
# 4.) Tabellenkommentar setzen
#------------------------------------------------------------------------------
*/


ALTER TABLE dbp_etl.artbew_dispo_tag
SET OPTIONS (
    description = 'TP2_AIS Tagtabelle fuer DISPO'
);


/*
#------------------------------------------------------------------------------
# 6.) Bteq beenden
#------------------------------------------------------------------------------
*/
