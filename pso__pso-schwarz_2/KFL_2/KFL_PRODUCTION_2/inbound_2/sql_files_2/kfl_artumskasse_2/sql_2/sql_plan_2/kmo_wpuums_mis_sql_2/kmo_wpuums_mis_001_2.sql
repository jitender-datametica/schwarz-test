
--#------------------------------------------------------------------------------
--# Skriptname   : kmo_wpuums_mis.btq
--# Erstelldatum : 03.11.2008
--#------------------------------------------------------------------------------
--# Projekt   : TP1_MIS
--# Kommentar : weiterfuehrende RFI Ueberpruefung der Daten der Schnittstelle
--#             KMO_WPUUMS_2 (Kassen Direktentsorgung) fuer die Teiprojekte MIS
--#             und laden der Daten in das Aggregat artbew_wg_sum_2
--# Quelle    : Tabelle DBP_LOAD.kmo_wpuums_2
--# Ziel      : Tabelle DBP_RFI.kmo_wpuums_2
--#             Tabelle DBP_DATA.artbew_wg_sum_2
--#------------------------------------------------------------------------------
--# History:
--#  03.11.2008  Michael Ueding   Ersterstellung ...
--#  10.02.2011  Adrien Bieligk   Parallelbeladung MIS für alle Länder
--#  17.05.2011  Michael Ueding   Erweiterung wg. Promotion, Entfernen der
--#                               Information HERKUNFT
--#  16.09.2011  Adrien Bieligk   Parallelbeladung MIS für alle Länder gelöscht
--#  10.10.2012  Michael Ueding   Anforderung Bestand Reichweite: Menge fortschreiben
--#  09.01.2014  Alex Alberg      COMMIT WORK nach dem INSERT in die Tab. artbew_wg_sum_2
--#                               und vor dem UPDATE auf die Tab. wupcal_2 implementiert
--#------------------------------------------------------------------------------
--# Processing Steps
--#    1.) Logon auf der Datenbank
--#    2.) Erzeugen der temporaeren Tabellen
--#    3.) Loeschen der Artikel_2 0000009800130, 0000009800131, 0000009800132 fuer
--#        Kroatien (fuer MIS nicht relevant)
--#    4.) Befuellung der Temp-Tabelle kmo_wpuums_tmp_2
--#    5.) Berechnung der Umsaetze in Euro Waehrung
--#    6.) Loeschen der bestehenden Daten aus der Zieltabelle artbew_wg_sum_2
--#    7.) Befuellung der artbew_wg_sum_2
--#    8.) Bereinigung der RFI Tabelle kmo_wpuums_2
--#    9.) Marktkalender Update
--#   10.) Füllen der dbp_process.artbew_wg_sum_agg_wt_2
--#   11.) Bteq beenden
--#------------------------------------------------------------------------------


/*
#------------------------------------------------------------------------------
# 2.) Erzeugen der temporaeren Tabellen
#------------------------------------------------------------------------------
*/


DROP TABLE IF EXISTS DBP_ETL.kmo_wpuums_tmp_2;



CREATE TABLE DBP_ETL.kmo_wpuums_tmp_2 LIKE DBP_DATA.artbew_wg_sum_2;


/*
#------------------------------------------------------------------------------
# 3.) Loeschen der Artikel_2 0000009800130, 0000009800131, 0000009800132 fuer
#     Kroatien (fuer MIS nicht relevant)
#------------------------------------------------------------------------------
*/

DELETE FROM DBP_ETL.kmo_wpuums_2
WHERE landkz = 'HR'
AND artnr_integer IN
(
9800130
,9800131
,9800132
)
;


/*
#------------------------------------------------------------------------------
# 4.) Befuellung der Temp-Tabelle kmo_wpuums_tmp_2
#------------------------------------------------------------------------------
#  Bedeutung der Bewegungsarten (Abweichend von der Lookuptabelle bewart_2!!):
#  1001: Datenherkunft Kasse (SAP wird ueber diesen Weg nicht eingespielt)
#------------------------------------------------------------------------------
*/

INSERT INTO DBP_ETL.kmo_wpuums_tmp_2
(
mandant_id
,wup_id
,wg_id
,bewart_id
,dat
,nb_id
,arthiertyp_id
,umsatz_brutto
,umsatz_netto
,umsatz_wrg
,umsatz_brutto_konz
,umsatz_netto_konz
,kjmo
,menge
,quelle
)
SELECT
mandant_id
,wup_id
,wg_id
,1001 AS bewart_id  /*Kassen Direktentsorgung*/
,dat
,nb_id
,arthiertyp_id
,SUM(umsatz_brutto)
,SUM(umsatz_netto)
,umsatz_wrg
,SUM(umsatz_brutto_konz)
,SUM(umsatz_netto_konz)
,kjmo
,SUM(menge)
,1 AS quelle  /*Kassen Direktentsorgung*/
FROM
(
SELECT
l.lkp_mandant_id AS mandant_id
,l.lkp_wup_id AS wup_id
,l.lkp_wg_id AS wg_id
,l.belegdatum_dat AS dat
,l.lkp_nb_id AS nb_id
,2 AS arthiertyp_id      /*mue 13.01.2010: Nach Abstimmung mit Hr. Ferber/VIS auf Arthiertyp_2 2 gesetzt*/
                         -- Mai 2011: Promotionswert von Umsatz abziehen (addieren, weil negatives Vorzeichen)
,(CAST(SUBSTRING(umswert , 16 , 20) AS DECIMAL(18,4)) *
(CASE WHEN vorzwert = '-' THEN (-1) ELSE 1 END)) +
(CAST(SUBSTRING(umspromotion , 16 , 20) AS DECIMAL(18,4)) *
(CASE WHEN vorzpromotion = '-' THEN (-1) ELSE 1 END))
AS umsatz_brutto        /*Belegbruttoumsatz - Promotionsumsatz = (Brutto)Kassenumsatz*/
,CAST(umsatz_brutto / (1+(lkp_mwst/100)) AS DECIMAL(18,4)) AS umsatz_netto
,l.belegwaers AS umsatz_wrg
,0 AS umsatz_brutto_konz                                -- die Konz Betraege werden in einem folgenden
,0 AS umsatz_netto_konz                                 -- Schritt berechnet
--,(l.belegdatum_dat / 100) +  190000 AS kjmo
,CAST(to_varchar(l.belegdatum_dat, 'YYYYMM') AS INTEGER) AS kjmo
,CAST(SUBSTRING(umsmenge , 16 , 20) AS DECIMAL(18,4)) *
(CASE WHEN vorzmenge = '-' THEN (-1) ELSE 1 END) * (-1) AS menge -- Anforderung Bestand/Reichweite
FROM DBP_ETL.kmo_wpuums_2 l
) a
GROUP BY
mandant_id
,wup_id
,wg_id
,bewart_id
,dat
,nb_id
,arthiertyp_id
,umsatz_wrg
,kjmo
,quelle
;


/*
#------------------------------------------------------------------------------
# 5.) Berechnung der Umsaetze in Euro Waehrung
#     (ACHTUNG: Berechnung mit Kurstyp 3 und nicht wie bei Artbew_2 mit Kurstyp 9)
#------------------------------------------------------------------------------
*/

UPDATE DBP_ETL.kmo_wpuums_tmp_2
FROM DBP_DATA.kurs_2 k

SET umsatz_brutto_konz = CAST(umsatz_brutto * k.umrechnungskurs AS DECIMAL(18,4))
, umsatz_netto_konz = CAST(umsatz_netto * k.umrechnungskurs AS DECIMAL(18,4))

WHERE DBP_ETL.kmo_wpuums_tmp.umsatz_wrg = k.von_wrg_id
AND DBP_ETL.kmo_wpuums_tmp.dat BETWEEN k.dat_von AND k.dat_bis
AND k.nach_wrg_id = 'EUR'
AND k.kurstyp_id = 3
;


/*
#------------------------------------------------------------------------------
# 6.) Loeschen der bestehenden Daten aus der Zieltabelle artbew_wg_sum_2
#
#------------------------------------------------------------------------------
*/

DELETE FROM DBP_DATA.artbew_wg_sum_2
WHERE bewart_id = 1001
AND (mandant_id, wup_id, nb_id, dat) IN
(
SELECT
mandant_id
,wup_id
,nb_id
,dat
FROM DBP_ETL.kmo_wpuums_tmp_2
)
AND quelle = 1 -- Daten in der Zieltabelle stammen aus der Kasse
;


--kalkulierte Umsaetze werden durch Kasse Direkt oder SAP Korrektur ersetzt.
DELETE FROM DBP_DATA.artbew_wg_sum_2
WHERE bewart_id IN (1001,1009)
AND (mandant_id, wup_id, nb_id, dat) IN
(
SELECT
mandant_id
,wup_id
,nb_id
,dat
FROM DBP_ETL.kmo_wpuums_tmp_2
)
AND (mandant_id, wup_id, nb_id, dat) IN
(
SELECT
mandant_id
,wup_id
,nb_id
,dat
FROM DBP_DATA.wupcal_2
WHERE datenlieferung_artbew_wg_sum = 2
)
;


-- nun alle Daten aus der temporaeren Tabelle loeschen
-- die nicht in die in die Zieltabelle uebernommen werden,
-- weil obige Bedinung(en) nicht erfuellt sind.

DELETE FROM DBP_ETL.kmo_wpuums_tmp_2
WHERE (mandant_id, wup_id, dat, nb_id) IN
(
SELECT
t.mandant_id
,t.wup_id
,t.dat
,t.nb_id
FROM DBP_ETL.kmo_wpuums_tmp_2 t

INNER JOIN DBP_DATA.artbew_wg_sum_2 a
ON t.mandant_id = a.mandant_id
AND t.wup_id = a.wup_id
AND t.nb_id = a.nb_id
AND t.dat = a.dat
AND a.bewart_id IN (1001,1009)
)
;


/*
#------------------------------------------------------------------------------
# 7.) Befuellung der artbew_wg_sum_2
#------------------------------------------------------------------------------
*/

INSERT INTO DBP_DATA.artbew_wg_sum_2
(
mandant_id
,wup_id
,wg_id
,bewart_id
,dat
,nb_id
,arthiertyp_id
,umsatz_brutto
,umsatz_netto
,umsatz_wrg
,umsatz_brutto_konz
,umsatz_netto_konz
,kjmo
,menge
,quelle
)
SELECT
mandant_id
,wup_id
,wg_id
,bewart_id
,dat
,nb_id
,arthiertyp_id
,umsatz_brutto
,umsatz_netto
,umsatz_wrg
,umsatz_brutto_konz
,umsatz_netto_konz
,kjmo
,menge
,quelle
FROM DBP_ETL.kmo_wpuums_tmp_2
;


/*
#------------------------------------------------------------------------------
#  9.) Marktkalender Update
#      Hier folgt der Update auf den Marktkalender (wupcal_2) wenn Tagesdaten
#      geliefert und verarbeitet wurden
#------------------------------------------------------------------------------
*/

UPDATE DBP_DATA.wupcal_2
SET datenlieferung_artbew_wg_sum = 1

WHERE (mandant_id, wup_id, nb_id, dat) IN
(
SELECT
mandant_id
,wup_id
,nb_id
,dat
FROM DBP_ETL.kmo_wpuums_tmp_2
)
;


/*
#------------------------------------------------------------------------------
# 10.) Fuellen der dbp_process.artbew_wg_sum_agg_wt_2
#------------------------------------------------------------------------------
*/

INSERT INTO dbp_etl_process.artbew_wg_sum_agg_wt_2
(
mandant_id
,wup_id
,nb_id
,dat
,calc_fg
,dat_lief
)
SELECT
mandant_id
,wup_id
,nb_id
,dat
,0 AS calc_fg
,CURRENT_DATE AS dat_lief
FROM DBP_ETL.kmo_wpuums_tmp_2

GROUP BY 1,2,3,4,5,6
;


/*
#------------------------------------------------------------------------------
# 11.) Ende
#------------------------------------------------------------------------------
*/

