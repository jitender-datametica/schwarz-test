-- 1. Verarbeitung Payback (PL) fuers AIS

DROP TABLE IF EXISTS dbp_etl.kmo_artbew_payback_tmp_1;
CREATE TABLE dbp_etl.kmo_artbew_payback_tmp_1 LIKE dbp_data.artbew_1;

INSERT INTO dbp_etl.kmo_artbew_payback_tmp_1 (mandant_id
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
                                           ,wrg_1
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
                                           ,ek_mep_vor_fwu
                                           ,ek_mep_vor_fwu_konz
                                           ,bonusbasis
                                           ,bonusbasis_konz)
SELECT t1.mandant_id
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
      ,t1.wrg_id wrg_1
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
      ,0 ek_mep_vor_fwu
      ,0 ek_mep_vor_fwu_konz
      ,0 bonusbasis
      ,0 bonusbasis_konz
FROM dbp_etl_process.in_fi_beleg_det_agg_payback_1 t1_1
JOIN dbp_data.l_einkaufsorganisation_1 t3
  ON t1.mandant_id = t3.mandant_id
JOIN (SELECT mandant_id, max(mwst_id) mwst_id FROM dbp_data.mwst_per_1 WHERE dat_bis=to_date('99991231','YYYYMMDD') AND mwst=0 GROUP BY 1) t4
  ON t1.mandant_id = t4.mandant_id
JOIN (SELECT mandant_id, 0  AS zero_enc FROM  dbp_data.mandant_1) t5
  ON t1.mandant_id = t5.mandant_id AND 
     getbit(t1.verarbeitet_fg,2) = 0
;

UPDATE dbp_etl.kmo_artbew_payback_tmp_1
FROM dbp_data.kurs_1 k

SET diff_umsatz_netto_konz = CAST(umsatz_netto * k.umrechnungskurs AS DECIMAL(18,4))


WHERE dbp_etl.kmo_artbew_payback_tmp.wrg_1 = k.von_wrg_id
  --AND dbp_etl.kmo_artbew_payback_tmp.dat BETWEEN k.dat_von AND k.dat_bis
  AND k.dat_bis = '9999-12-31'
  AND k.nach_wrg_id = 'EUR'
  AND k.kurstyp_id = 3
; 

DELETE FROM dbp_data.artbew_1
WHERE bewart_id = 1010
  AND (mandant_id,wup_id,nb_id,dat) IN (SELECT mandant_id,wup_id,nb_id,dat FROM dbp_etl.kmo_artbew_payback_tmp_1)
;

INSERT INTO dbp_data.artbew_1
(
 mandant_id
,wup_id
,bewart_id
,bewart_det_id
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
,wrg_1
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
,td_insert
,td_update
,wup_bereinigt_fg
,ek_mep_vor_fwu
,ek_mep_vor_fwu_konz
,bonusbasis
,bonusbasis_konz
,standard_aktion_id
,umrechnungskurs_hist
)
SELECT
 a.mandant_id
,a.wup_id
,a.bewart_id
,100110 as bewart_det_id
,a.gp_id
,a.nb_id
,a.art_id
,a.dat
,a.aktion_id
,a.promo_fg
,a.ean_kasse
,a.einkaufsorganisation_id
,a.herst_id
,a.mwst_id
,a.menge
,a.wrg_1
,a.umsatz_netto
,a.diff_umsatz_netto_konz
,a.umsatz_mwst_betrag
,a.diff_umsatz_mwst_betrag_konz
,a.ek_brutto
,a.diff_ek_brutto_konz
,a.ek_netto
,a.diff_ek_netto_konz
,a.ek_nettonetto
,a.diff_ek_nettonetto_konz
,a.ek_kal_basis
,a.diff_ek_kal_basis_konz
,a.ek_mep
,a.diff_ek_mep_konz
,a.einstandspreis
,a.diff_einstandspreis_konz
,a.logkostenzuschlag
,a.diff_logkostenzuschlag_konz
,a.bezugsweg_id
,a.ek_netto_bnk
,a.diff_ek_netto_bnk_konz
,a.ek_netto_bnk_sachk
,a.diff_ek_netto_bnk_sachk_konz
,a.posten_id
,a.bq_findung_id
,a.ek_gld
,a.diff_ek_gld_konz
,CURRENT_TIMESTAMP as td_insert
,CURRENT_TIMESTAMP as td_update
,coalesce(b.wup_bereinigt_fg,0) as wup_bereinigt_fg
,a.ek_mep_vor_fwu
,a.ek_mep_vor_fwu_konz
,a.bonusbasis
,a.bonusbasis_konz
,'' as standard_aktion_id
,k.umrechnungskurs as umrechnungskurs_hist
FROM dbp_etl.kmo_artbew_payback_tmp_1 a
left join dbp_etl_process.wup_fg_1 b
  on a.mandant_id = b.mandant_id and
     a.wup_id = b.wup_id and
     a.dat = b.dat
left join dbp_data.kurs_1 k
  on a.wrg_1 = k.von_wrg_id and
     a.dat between k.dat_von and k.dat_bis and
     k.nach_wrg_id = 'EUR' and 
     k.kurstyp_id = 3
;

UPDATE dbp_etl_process.in_fi_beleg_det_agg_payback_1 
SET verarbeitet_fg = setbit(verarbeitet_fg,0) -- artbew_wg_sum_1-verarbeitung
WHERE
( mandant_id, wup_id, dat_buch ) IN ( SELECT mandant_id, wup_id, dat FROM dbp_etl.kmo_artbew_payback_tmp_1 )
;

INSERT INTO dbp_data.artbew_agg_wt_1
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
FROM dbp_etl.kmo_artbew_payback_tmp_1
WHERE ( mandant_id, wup_id, nb_id, dat ) NOT IN ( SELECT mandant_id, wup_id, nb_id, dat FROM dbp_data.artbew_agg_wt_1 )
GROUP BY 1,2,3,4
;

insert into dbp_etl_process.uapc_artbew_delta_1 (mandant_id
                                              ,wup_id
                                              ,dat
                                              ,row_id
                                              ,processed_at
                                              ,td_insert
                                              ,td_update)
select mandant_id,
       wup_id,
       dat,
      (row_number() over (order by mandant_id,wup_id,dat) + coalesce((select max(row_id) from dbp_etl_process.uapc_artbew_delta_1),0)) as row_id,
       null as processed_at,
       current_timestamp as td_insert,
       current_timestamp as td_update
from dbp_etl.kmo_artbew_payback_tmp_1
where (mandant_id,wup_id,dat,cast(current_timestamp as date)) not in (select mandant_id,wup_id,dat,cast(td_insert as date) from dbp_etl_process.uapc_artbew_delta_1)
group by 1,2,3
;

-- 2. Verarbeitung Payback (PL) fuers VIS

DROP TABLE IF EXISTS dbp_etl.kmo_wpuums_payback_tmp_1;
CREATE TABLE dbp_etl.kmo_wpuums_payback_tmp_1 LIKE dbp_data.artbew_wg_sum_1;

INSERT INTO dbp_etl.kmo_wpuums_payback_tmp_1
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
FROM dbp_etl_process.in_fi_beleg_det_agg_payback_1 t1_1
INNER JOIN dbp_data.art_wg_zu_per_1 t2
ON t1.mandant_id = t2.mandant_id
AND t1.art_id = t2.art_id
AND t2.dat_bis=to_date('99991231','YYYYMMDD')
AND t2.arthiertyp_id=2
AND getbit(t1.verarbeitet_fg,1) = 0
;

UPDATE dbp_etl.kmo_wpuums_payback_tmp_1
FROM dbp_data.kurs_1 k

SET umsatz_brutto_konz = CAST(umsatz_brutto * k.umrechnungskurs AS DECIMAL(18,4))
  , umsatz_netto_konz = CAST(umsatz_netto * k.umrechnungskurs AS DECIMAL(18,4))

WHERE dbp_etl.kmo_wpuums_payback_tmp.umsatz_wrg = k.von_wrg_id
  AND dbp_etl.kmo_wpuums_payback_tmp.dat BETWEEN k.dat_von AND k.dat_bis
  AND k.nach_wrg_id = 'EUR'
  AND k.kurstyp_id = 3
; 

DELETE FROM dbp_data.artbew_wg_sum_1
WHERE bewart_id = 1010
  AND (mandant_id,wup_id,nb_id,dat) IN (SELECT mandant_id,wup_id,nb_id,dat FROM dbp_etl.kmo_wpuums_payback_tmp_1)
  AND quelle = 10 -- Daten in der Zieltabelle stammen aus der Payback aus FI
;

INSERT INTO dbp_data.artbew_wg_sum_1
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
  ,umrechnungskurs_hist
)
SELECT
   a.mandant_id
  ,a.wup_id
  ,a.wg_id
  ,a.bewart_id
  ,a.dat
  ,a.nb_id
  ,a.arthiertyp_id
  ,a.umsatz_brutto
  ,a.umsatz_netto
  ,a.umsatz_wrg
  ,a.umsatz_brutto_konz
  ,a.umsatz_netto_konz
  ,a.kjmo
  ,a.menge
  ,a.quelle
  ,k.umrechnungskurs as umrechnungskurs_hist
FROM dbp_etl.kmo_wpuums_payback_tmp_1 a
left join dbp_data.kurs_1 k
  on a.umsatz_wrg = k.von_wrg_id and
     a.dat between k.dat_von and k.dat_bis and
     k.nach_wrg_id = 'EUR' and 
     k.kurstyp_id = 3
;

UPDATE dbp_etl_process.in_fi_beleg_det_agg_payback_1 
SET verarbeitet_fg = setbit(verarbeitet_fg,1) -- artbew_wg_sum_1-verarbeitung
WHERE
( mandant_id, wup_id, dat_buch ) IN ( SELECT mandant_id, wup_id, dat FROM dbp_etl.kmo_wpuums_payback_tmp_1 )
;

INSERT INTO dbp_etl_process.artbew_wg_sum_agg_wt_1
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
FROM dbp_etl.kmo_wpuums_payback_tmp_1
WHERE ( mandant_id, wup_id, nb_id, dat ) NOT IN (SELECT mandant_id, wup_id, nb_id, dat FROM dbp_etl_process.artbew_wg_sum_agg_wt_1)
GROUP BY 1,2,3,4,5,6
;
