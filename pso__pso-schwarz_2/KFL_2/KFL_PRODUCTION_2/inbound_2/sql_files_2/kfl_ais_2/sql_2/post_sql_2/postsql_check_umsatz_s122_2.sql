--[OK] statement is translated correctly (syntax and type checks are fine)
DELETE FROM  DBP_MSI_DATA.check_kunden_umsatz_2;

INSERT INTO  DBP_MSI_DATA.check_kunden_umsatz_2                               
(
  dat
, mandant_id
, wup_id
, kassierer_nr
, kasse_nr
, umsatz_wrg
, anz_bon_sap
, umsatz_brutto_gesamt
, umsatz_netto_gesamt
, umsatz_brutto_kasse
)
SELECT  
  to_Date(l.dat_bon ,'YYYYMMDD')     AS dat
, s.mandant_id                                  AS mandant_id
, l.wup_id                                      AS wup_id
, case  when l.kassierer_id > 999999  then 999999
	else l.kassierer_id  end                AS kassierer_nr
, case  when l.kasse_nr > 999999  then 999999
	else l.kasse_nr end                     AS kasse_nr
, l.wrg_id                                      AS umsatz_wrg
, SUM( l.anz_bon_sap )                          AS anz_bon_sap
, SUM( l.umsatz_brutto_sap )                    AS umsatz_brutto_gesamt
, SUM( l.umsatz_netto_sap )                     AS umsatz_netto_gesamt           
, SUM( l.umsatz_brutto_kassennr_sap )           AS umsatz_brutto_kasse  
 
FROM  DBP_ETL.check_umsatz_s122_2 l

INNER JOIN DBP_DATA.l_system_2 s
   ON l.quellsystem=s.kl_system_id

GROUP BY 1,2,3,4,5,6
;
