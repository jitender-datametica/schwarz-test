/*
#------------------------------------------------------------------------------
# Source Safe Info
#------------------------------------------------------------------------------
# Skriptname             : artbew_dispo_woche.btq
# Aktuelle Version       : 1.0
# Check-Out Datum        : 01.04.2009
# Version-erstellt Datum : 01.04.2009
#------------------------------------------------------------------------------
# Projekt : TP2_AIS
# Comment : Aufbau der Aggregationstabelle dbp_etl.artbew_dispo_woche_2 
# Source  : TABLE dbp_data.artbew_2 
# Target  : TABLE dbp_etl.artbew_dispo_woche_2
#------------------------------------------------------------------------------
# History:
# 21.09.2006  R.Wesemann        Neuerstellung
# 05.01.2007  Gia               Erweiterung/Korrektur siehe eMail Hr. Ferber 
#                               Ersetzung dbp_xxx nach $DBX_XXX
#                               PPI weggenommen und PI-Aenderung (lt. Frau Lenz) 
#                               COLLECT STATISTICS PARTITION weggenommen
# 22.01.2007  R.Wesemann        Sicherungsfunktion auskommentiert
#                               DROP TABLE eingebaut
# 22.01.2007  R.Wesemann        Zeitraum von 35 auf 42 Tage erweitert.
# 01.04.2009  Sascha Romanowski Applikations Server LOGON
# 01.04.2009  Michael Ueding    Ueberarbeitung und Einschraekung auf den Mandanten
#                               Deutschland 
# 12.08.2010	David Bandeira		Optimierung dbp_etl.artbew_dispo_woche_2 Beladung
# -----------------------------------------------------------------------------
# Processing Steps
#    1.) Logon auf der Datenbank
#    2.) Neuanlage der Zieltabelle 
#    3.) Einfuegen der Daten fuer die Wochen der letzten 42 Tage 
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


DROP TABLE IF EXISTS dbp_etl.artbew_dispo_woche_2;


CREATE TABLE dbp_etl.artbew_dispo_woche_2 
(
  kl_art_id INTEGER NOT NULL,
  wup_id INTEGER NOT NULL,
  kjwo INTEGER,
  sonntag_fg BYTEINT,
  menge DECIMAL(18,4)
)
;

/*
#------------------------------------------------------------------------------
# 3.) Einfuegen der Daten fuer die Wochen der letzten 42 Tage 
#------------------------------------------------------------------------------
*/

INSERT INTO dbp_etl.artbew_dispo_woche_2
(
   kl_art_id
  ,wup_id
  ,kjwo
  ,sonntag_fg
  ,menge
)
SELECT 
 kl_art_id
 ,wup_id
 ,kjwo
 ,sonntag_fg
 ,sum(menge_) as menge_
 FROM 
  (
  SELECT
  floor( art_id/100) AS kl_art_id
   ,wup_id
   ,kjwo
   ,'1' AS sonntag_fg
   ,menge AS menge_
   
   FROM dbp_data.artbew_2 a
   
   INNER JOIN dbp_data.tag_2 t
   ON t.dat = a.dat
   AND t.dat >= current_date -49 AND t.dat <= current_date +7
   
   WHERE a.mandant_id = 1 and a.art_id > 0 
   AND a.dat >= (SELECT 
                  MIN(dat) 
                  
                  FROM dbp_data.tag_2 t 
                  
                  WHERE t.wo_dat_bis >= current_date - 42 
                  AND t.wo_dat_von <= current_date
                  ) 
   AND a.dat <= (SELECT
                  MAX(dat) 
                  
                  FROM dbp_data.tag_2 t 
                  
                  WHERE t.wo_dat_bis >= current_date - 42 
                  AND t.wo_dat_von <= current_date
                  )
  
  UNION ALL
  
  SELECT
   floor(art_id/100) AS kl_art_id
   ,wup_id
   ,kjwo
   ,'0' AS sonntag_fg
   ,menge AS menge_
   
   FROM dbp_data.artbew_2 a
   
   INNER JOIN dbp_data.tag_2 t
   ON t.dat = a.dat
   AND t.dat >= current_date -49 AND t.dat <= current_date +7
   
   
   WHERE a.mandant_id = 1 and a.art_id > 0 
   AND a.dat >= (SELECT 
                  MIN(dat) 
                  
                  FROM dbp_data.tag_2 t 
                  
                  WHERE t.wo_dat_bis >= current_date - 42 
                  AND t.wo_dat_von <= current_date
                  ) 
   AND a.dat <= (SELECT
                  MAX(dat) 
                  
                  FROM dbp_data.tag_2 t 
                  
                  WHERE t.wo_dat_bis >= current_date - 42 
                  AND t.wo_dat_von <= current_date
                  )
   AND t.wtag_id < 7
  ) s

GROUP BY 1,2,3,4;

/*
# ALTE AGRREGATION 
SELECT
   art_id/100 AS kl_art_id 
  ,wup_id
  ,kjwo
  ,'1' AS sonntag_fg
  ,SUM(menge) AS menge_
FROM dbp_data.artbew_2 a
 
INNER JOIN dbp_data.tag_2 t
ON t.wo_dat_bis >= date - 42 
  AND t.wo_dat_von <= date
  AND t.dat = a.dat
  AND t.wtag_id BETWEEN 1 AND 7

WHERE a.mandant_id = 1 
  AND a.art_id > 0

GROUP BY 1,2,3

UNION ALL

SELECT
   art_id/100 AS kl_art_id 
  ,wup_id
  ,kjwo
  ,'0' AS sonntag_fg
  ,SUM(menge) AS menge_
FROM dbp_data.artbew_2 a
   
INNER JOIN dbp_data.tag_2 t
ON t.wo_dat_bis >= date - 42 
  AND t.wo_dat_von <= date
  AND t.dat = a.dat
  AND t.wtag_id BETWEEN 1 AND 6

WHERE a.mandant_id = 1
  AND a.art_id > 0

GROUP BY 1,2,3
;
*/



/*
#------------------------------------------------------------------------------
# 4.) Tabellenkommentar setzen
#------------------------------------------------------------------------------
*/

COMMENT ON TABLE dbp_etl.artbew_dispo_woche_2 IS 'TP2_AIS Wochentabelle fuer DISPO';

/*
#------------------------------------------------------------------------------
# 6.) Bteq beenden
#------------------------------------------------------------------------------
*/
