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
# Comment : Aufbau der Aggregationstabelle dbp_etl.artbew_dispo_tag_2 
# Source  : TABLE dbp_data.artbew_2 
# Target  : TABLE dbp_etl.artbew_dispo_tag_2
#------------------------------------------------------------------------------
# History:
#   21.09.2006  R.Wesemann         Neuerstellung
#   05.01.2007  Giannoulakes St.   Ersetzung dbp_xxx nach $DBX_XXX
#                                  PPI weggenommen (lt. Frau Lenz)
#   22.01.2007  R.Wesemann         Sicherungsfunktion auskommentiert
#                                  DROP TABLE eingebaut
#   01.04.2009  Sascha Romanowski  Applikations Server LOGON
#   01.04.2009  Michael Ueding     Ueberarbeitung und Einschraenkung auf 
#                                  Mandant_2 Deutschland
# -----------------------------------------------------------------------------
# Processing Steps
#    1.) Logon auf der Datenbank
#    2.) Neuanlage der Zieltabelle 
#    3.) Einfuegen der Daten fuer die letzten 15 Tage 
#    4.) Tabellenkommentar setzen 
#    5.) Statistiken_2 sammeln
#    6.) Bteq beenden
# -----------------------------------------------------------------------------
*/


/*
#------------------------------------------------------------------------------
# 2.) Neuanlage der Zieltabelle 
#------------------------------------------------------------------------------
*/


DROP TABLE IF EXISTS dbp_etl.artbew_dispo_tag_2;


CREATE  TABLE dbp_etl.artbew_dispo_tag_2 
(
  kl_art_id INTEGER NOT NULL,
  wup_id INTEGER NOT NULL,
  dat DATE ,
  sonntag_fg BYTEINT,
  menge DECIMAL(18,4)
)
;

/*
#------------------------------------------------------------------------------
# 3.) Einfuegen der Daten fuer die letzten 15 Tage 
#------------------------------------------------------------------------------
*/

INSERT INTO dbp_etl.artbew_dispo_tag_2
(
   kl_art_id
  ,wup_id
  ,dat
  ,sonntag_fg
  ,menge
) 
SELECT
   floor(a.art_id/100) AS kl_art_id 
  ,a.wup_id
  ,a.dat
  ,CASE WHEN t.wtag_id = '7' 
        THEN '1'
        ELSE '0' 
   END AS sonntag_fg
  ,SUM(a.menge) AS menge_
FROM dbp_data.artbew_2 a

INNER JOIN 
(
  SELECT 
     dat
    ,wtag_id 
  FROM dbp_data.tag_2 
  WHERE akt_tag BETWEEN -15 AND 0
) t
ON a.dat = t.dat

WHERE a.mandant_id = 1 
  AND a.art_id > 0

GROUP BY 1, 2, 3, 4;

/*
#------------------------------------------------------------------------------
# 4.) Tabellenkommentar setzen 
#------------------------------------------------------------------------------
*/

COMMENT ON TABLE dbp_etl.artbew_dispo_tag_2 IS 'TP2_AIS Tagtabelle fuer DISPO';

/*
#------------------------------------------------------------------------------
# 6.) Bteq beenden
#------------------------------------------------------------------------------
*/

