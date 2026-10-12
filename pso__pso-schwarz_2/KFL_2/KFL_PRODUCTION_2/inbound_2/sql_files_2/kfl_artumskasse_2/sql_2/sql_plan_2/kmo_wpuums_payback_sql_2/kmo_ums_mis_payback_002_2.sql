/*
#------------------------------------------------------------------------------
# Skriptname   : kmo_wpuums_mis.btq
# Erstelldatum : 03.11.2008
#------------------------------------------------------------------------------
# Projekt   : TP1_MIS
# Kommentar : Erweiterung des Umsatzes umd Payback aus FI ( dbp_etl_process.in_fi_beleg_det_agg_payback_2 bzw. dbp_data.in_fi_beleg_det_2
# Quelle    : Tabelle dbp_etl.kmo_wpuums_2
# Ziel      : Tabelle dbp_etl_rfi.kmo_wpuums_2
#             Tabelle dbp_data.artbew_wg_sum_2
#------------------------------------------------------------------------------
# History:
#  26.06.2018  Armin Smoor      Ersterstellung ...

#------------------------------------------------------------------------------
# Processing Steps
# 1.) Logon auf der Datenbank
# 2.) Erzeugen der temporaeren Tabellen
# 3.) Befuellung der Temp-Tabelle kmo_wpuums_tmp_2
# 4.) Berechnung der Umsaetze in Euro Waehrung
# 5.) Loeschen der bestehenden Daten aus der Zieltabelle artbew_wg_sum_2
# 6.) Befuellung der artbew_wg_sum_2
# 7.) Fullen der dbp_etl_process.artbew_wg_sum_agg_wt_2
#------------------------------------------------------------------------------
*/


/*
#------------------------------------------------------------------------------
# 2.) Erzeugen der temporaeren Tabellen
#------------------------------------------------------------------------------
*/

DROP TABLE IF EXISTS dbp_etl.kmo_wpuums_payback_tmp_2;

CREATE TABLE dbp_etl.kmo_wpuums_payback_tmp_2 LIKE dbp_data.artbew_wg_sum_2;


/*
#------------------------------------------------------------------------------
# 3.) Befuellung der Temp-Tabelle kmo_wpuums_tmp_2
#------------------------------------------------------------------------------
#  1010: Datenherkunft FI Payback 
#------------------------------------------------------------------------------
*/

INSERT INTO dbp_etl.kmo_wpuums_payback_tmp_2
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
   t1.mandant_id
  ,t1.wup_id
  ,t2.wg_id
  ,1010 AS bewart_id  /*Payback aus FI*/
  ,t1.dat_buch dat
  ,t1.nb_id
  ,t2.arthiertyp_id
  ,t1.betrag_fi_beleg_sum umsatz_brutto
  ,t1.betrag_fi_beleg_sum umsatz_netto
  ,t1.wrg_id umsatz_wrg
  ,t1.betrag_fi_beleg_sum umsatz_brutto_konz
  ,t1.betrag_fi_beleg_sum umsatz_netto_konz
  --,t1.dat_buch /100 + 190000 as kjmo
   ,CAST(to_varchar(t1.dat_buch, 'YYYYMM') AS INTEGER) AS kjmo
  ,0 menge
  ,10 AS quelle  /*Payback aus FI*/
FROM dbp_etl_process.in_fi_beleg_det_agg_payback_2 t1_2
INNER JOIN dbp_data.art_wg_zu_per_2 t2
ON t1.mandant_id = t2.mandant_id
AND t1.art_id = t2.art_id
AND t2.dat_bis=to_date('99991231','YYYYMMDD')
AND t2.arthiertyp_id=2
AND getbit(t1.verarbeitet_fg,1) = 0
;



/*
#------------------------------------------------------------------------------
# 4.) Berechnung der Umsaetze in Euro Waehrung
#     (ACHTUNG: Berechnung mit Kurstyp 3 und nicht wie bei Artbew_2 mit Kurstyp 9)
#------------------------------------------------------------------------------
*/

UPDATE dbp_etl.kmo_wpuums_payback_tmp_2
FROM dbp_data.kurs_2 k

SET umsatz_brutto_konz = CAST(umsatz_brutto * k.umrechnungskurs AS DECIMAL(18,4))
  , umsatz_netto_konz = CAST(umsatz_netto * k.umrechnungskurs AS DECIMAL(18,4))

WHERE dbp_etl.kmo_wpuums_payback_tmp.umsatz_wrg = k.von_wrg_id
  AND dbp_etl.kmo_wpuums_payback_tmp.dat BETWEEN k.dat_von AND k.dat_bis
  AND k.nach_wrg_id = 'EUR'
  AND k.kurstyp_id = 3
; 




/*
#------------------------------------------------------------------------------
# 5.) Loeschen der bestehenden Daten aus der Zieltabelle artbew_wg_sum_2
#     
#------------------------------------------------------------------------------
*/

DELETE FROM dbp_data.artbew_wg_sum_2
WHERE bewart_id = 1010
  AND (mandant_id, wup_id, nb_id, dat) IN
    (
      SELECT
         mandant_id
        ,wup_id
        ,nb_id
        ,dat
      FROM dbp_etl.kmo_wpuums_payback_tmp_2
    )
  AND quelle = 10 -- Daten in der Zieltabelle stammen aus der Payback aus FI
;


  


/*
#------------------------------------------------------------------------------
# 6.) Befuellung der artbew_wg_sum_2
#------------------------------------------------------------------------------
*/

INSERT INTO dbp_data.artbew_wg_sum_2
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
FROM dbp_etl.kmo_wpuums_payback_tmp_2
;



UPDATE dbp_etl_process.in_fi_beleg_det_agg_payback_2 
SET verarbeitet_fg = setbit(verarbeitet_fg,1) -- artbew_wg_sum_2-verarbeitung
WHERE
( mandant_id, wup_id, dat_buch ) IN ( SELECT mandant_id, wup_id, dat FROM dbp_etl.kmo_wpuums_payback_tmp_2 )
;



/*
#------------------------------------------------------------------------------
# 7.) Fullen der dbp_etl_process.artbew_wg_sum_agg_wt_2
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
FROM dbp_etl.kmo_wpuums_payback_tmp_2
WHERE ( mandant_id, wup_id, nb_id, dat ) NOT IN (SELECT mandant_id, wup_id, nb_id, dat FROM dbp_etl_process.artbew_wg_sum_agg_wt_2)
GROUP BY 1,2,3,4,5,6
;


/*
#------------------------------------------------------------------------------
# 11.) Bteq beenden
#------------------------------------------------------------------------------
*/


