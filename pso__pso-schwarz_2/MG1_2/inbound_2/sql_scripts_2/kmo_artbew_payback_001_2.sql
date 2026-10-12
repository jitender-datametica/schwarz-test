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

#------------------------------------------------------------------------------
*/


/*
#------------------------------------------------------------------------------
# 2.) Erzeugen der temporaeren Tabellen
#------------------------------------------------------------------------------
*/


DROP TABLE IF EXISTS dbp_etl.kmo_artbew_payback_tmp_2;


CREATE TABLE dbp_etl.kmo_artbew_payback_tmp_2 LIKE dbp_data.artbew_2;


/*
#------------------------------------------------------------------------------
# 3.) Befuellung der Temp-Tabelle kmo_artbew_payback_tmp_2
#------------------------------------------------------------------------------
#  1010: Datenherkunft FI Payback 
#------------------------------------------------------------------------------
*/

INSERT INTO dbp_etl.kmo_artbew_payback_tmp_2
(
	 mandant_id
	,wup_id
	,bewart_id
	,gp_id
	,nb_id
	,art_id
	,dat
	,aktion_id
	,promo_fg
	,ean_kasse
	,einkaufsorganisation_id
	,herst_id
	,mwst_id
	,menge
	,wrg_2
	,umsatz_netto
	,diff_umsatz_netto_konz
	,umsatz_mwst_betrag
	,diff_umsatz_mwst_betrag_konz
	,ek_brutto
	,diff_ek_brutto_konz
	,ek_netto
	,diff_ek_netto_konz
	,ek_nettonetto
	,diff_ek_nettonetto_konz
	,ek_kal_basis
	,diff_ek_kal_basis_konz
	,ek_mep
	,diff_ek_mep_konz
	,einstandspreis
	,diff_einstandspreis_konz
	,logkostenzuschlag
	,diff_logkostenzuschlag_konz
	,bezugsweg_id
	,ek_netto_bnk
	,diff_ek_netto_bnk_konz
	,ek_netto_bnk_sachk
	,diff_ek_netto_bnk_sachk_konz
	,posten_id
	,bq_findung_id
	,ek_gld
	,diff_ek_gld_konz
)
SELECT
   t1.mandant_id
  ,t1.wup_id
  ,1010 AS bewart_id  /*Payback aus FI*/
  ,-1 as gp_id
  ,t1.nb_id
  ,t1.art_id
  ,t1.dat_buch dat
  ,'          ' aktion_id
  ,0 promo_fg
  ,0 ean_kasse
  ,t3.einkaufsorganisation_id
  ,-1 herst_id
  ,t4.mwst_id
  ,0 menge
  ,t1.wrg_id wrg_2
  ,t1.betrag_fi_beleg_sum umsatz_netto
  ,0 diff_umsatz_netto_konz
  ,0 umsatz_mwst_betrag
  ,0 diff_umsatz_mwst_betrag_konz
  ,t5.zero_enc ek_brutto
  ,t5.zero_enc diff_ek_brutto_konz              
  ,t5.zero_enc ek_netto                         
  ,t5.zero_enc diff_ek_netto_konz               
  ,t5.zero_enc ek_nettonetto                    
  ,t5.zero_enc diff_ek_nettonetto_konz          
  ,t5.zero_enc ek_kal_basis                     
  ,t5.zero_enc diff_ek_kal_basis_konz           
  ,t5.zero_enc ek_mep                           
  ,t5.zero_enc diff_ek_mep_konz                 
  ,t5.zero_enc einstandspreis                   
  ,t5.zero_enc diff_einstandspreis_konz         
  ,0 logkostenzuschlag                
  ,0 diff_logkostenzuschlag_konz      
  ,1 bezugsweg_id                     
  ,t5.zero_enc ek_netto_bnk                     
  ,t5.zero_enc diff_ek_netto_bnk_konz           
  ,t5.zero_enc ek_netto_bnk_sachk               
  ,t5.zero_enc diff_ek_netto_bnk_sachk_konz     
  ,0 posten_id
  ,25 bq_findung_id
  ,0 ek_gld          
  ,0 diff_ek_gld_konz
FROM dbp_etl_process.in_fi_beleg_det_agg_payback_2 t1_2
INNER JOIN dbp_data.l_einkaufsorganisation_2 t3
ON t1.mandant_id = t3.mandant_id
INNER JOIN (SELECT mandant_id, max(mwst_id) mwst_id FROM dbp_data.mwst_per_2 WHERE dat_bis=to_date('99991231','YYYYMMDD') AND mwst=0 GROUP BY 1) t4
ON t1.mandant_id = t4.mandant_id
INNER JOIN (SELECT mandant_id, 0  AS zero_enc FROM  dbp_data.mandant_2) t5
ON t1.mandant_id = t5.mandant_id
AND getbit(t1.verarbeitet_fg,2) = 0

;



/*
#------------------------------------------------------------------------------
# 5.) Berechnung der Umsaetze in Euro Waehrung
#     (ACHTUNG: Berechnung mit Kurstyp 3 und nicht wie bei Artbew_2 mit Kurstyp 9)
#------------------------------------------------------------------------------
*/

UPDATE dbp_etl.kmo_artbew_payback_tmp_2
FROM dbp_data.kurs_2 k

SET diff_umsatz_netto_konz = CAST(umsatz_netto * k.umrechnungskurs AS DECIMAL(18,4))


WHERE dbp_etl.kmo_artbew_payback_tmp.wrg_2 = k.von_wrg_id
  AND dbp_etl.kmo_artbew_payback_tmp.dat BETWEEN k.dat_von AND k.dat_bis
  AND k.nach_wrg_id = 'EUR'
  AND k.kurstyp_id = 9
; 



/*
#------------------------------------------------------------------------------
# 6.) Loeschen der bestehenden Daten aus der Zieltabelle artbew_2
#     
#------------------------------------------------------------------------------
*/


DELETE FROM dbp_data.artbew_2
WHERE bewart_id = 1010
  AND (mandant_id, wup_id, nb_id, dat) IN
    (
      SELECT
         mandant_id
        ,wup_id
        ,nb_id
        ,dat
      FROM dbp_etl.kmo_artbew_payback_tmp_2
    )

;


  


/*
#------------------------------------------------------------------------------
# 7.) Befuellung der artbew_2
#------------------------------------------------------------------------------
*/

INSERT INTO dbp_data.artbew_2
(
 mandant_id
,wup_id
,bewart_id
,gp_id
,nb_id
,art_id
,dat
,aktion_id
,promo_fg
,ean_kasse
,einkaufsorganisation_id
,herst_id
,mwst_id
,menge
,wrg_2
,umsatz_netto
,diff_umsatz_netto_konz
,umsatz_mwst_betrag
,diff_umsatz_mwst_betrag_konz
,ek_brutto
,diff_ek_brutto_konz
,ek_netto
,diff_ek_netto_konz
,ek_nettonetto
,diff_ek_nettonetto_konz
,ek_kal_basis
,diff_ek_kal_basis_konz
,ek_mep
,diff_ek_mep_konz
,einstandspreis
,diff_einstandspreis_konz
,logkostenzuschlag
,diff_logkostenzuschlag_konz
,bezugsweg_id
,ek_netto_bnk
,diff_ek_netto_bnk_konz
,ek_netto_bnk_sachk
,diff_ek_netto_bnk_sachk_konz
,posten_id
,bq_findung_id
,ek_gld
,diff_ek_gld_konz
)
SELECT
 mandant_id
,wup_id
,bewart_id
,gp_id
,nb_id
,art_id
,dat
,aktion_id
,promo_fg
,ean_kasse
,einkaufsorganisation_id
,herst_id
,mwst_id
,menge
,wrg_2
,umsatz_netto
,diff_umsatz_netto_konz
,umsatz_mwst_betrag
,diff_umsatz_mwst_betrag_konz
,ek_brutto
,diff_ek_brutto_konz
,ek_netto
,diff_ek_netto_konz
,ek_nettonetto
,diff_ek_nettonetto_konz
,ek_kal_basis
,diff_ek_kal_basis_konz
,ek_mep
,diff_ek_mep_konz
,einstandspreis
,diff_einstandspreis_konz
,logkostenzuschlag
,diff_logkostenzuschlag_konz
,bezugsweg_id
,ek_netto_bnk
,diff_ek_netto_bnk_konz
,ek_netto_bnk_sachk
,diff_ek_netto_bnk_sachk_konz
,posten_id
,bq_findung_id
,ek_gld
,diff_ek_gld_konz
FROM dbp_etl.kmo_artbew_payback_tmp_2
;





UPDATE dbp_etl_process.in_fi_beleg_det_agg_payback_2 
SET verarbeitet_fg = setbit(verarbeitet_fg,0) -- artbew_wg_sum_2-verarbeitung
WHERE
( mandant_id, wup_id, dat_buch ) IN ( SELECT mandant_id, wup_id, dat FROM dbp_etl.kmo_artbew_payback_tmp_2 )
;



/*
#------------------------------------------------------------------------------
# 10.) Fullen der dbp_etl_process.artbew_agg_wt_2
#------------------------------------------------------------------------------
*/

INSERT INTO dbp_data.artbew_agg_wt_2
(
   mandant_id
  ,wup_id
  ,nb_id
  ,dat
)
SELECT
   mandant_id
  ,wup_id
  ,nb_id
  ,dat
FROM dbp_etl.kmo_artbew_payback_tmp_2
WHERE ( mandant_id, wup_id, nb_id, dat ) NOT IN ( SELECT mandant_id, wup_id, nb_id, dat FROM dbp_data.artbew_agg_wt_2 )
GROUP BY 1,2,3,4
;


/*
#------------------------------------------------------------------------------
# 11.) Bteq beenden
#------------------------------------------------------------------------------
*/


