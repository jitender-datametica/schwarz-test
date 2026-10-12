INSERT INTO DBP_ETL.wpuums_build_tmp (mandant_id
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
                                       ,umsatz_mwst_betrag
                                       ,kjmo
                                       ,menge
                                       ,quelle)
SELECT a.mandant_id
      ,a.wup_id
      ,b.wg_id
      ,1001 AS bewart_id
      ,a.dat
      ,a.nb_id
      ,2 AS arthiertyp_id
      ,SUM ((umsatz_netto+umsatz_mwst_betrag)*b.alt_neu_kz) AS umsatz_brutto
      ,SUM(umsatz_netto*b.alt_neu_kz)
      ,a.wrg
      ,0
      ,0
      ,SUM(a.umsatz_mwst_betrag*b.alt_neu_kz) AS umsatz_mwst_betrag
      -- bartosiewiczadm - cloud migration
      --,(a.dat / 100) +  190000 AS kjmo
      ,CAST(to_varchar(a.dat, 'YYYYMM') AS INTEGER) AS kjmo
      ,SUM(a.menge*b.alt_neu_kz) AS menge
      ,1
      
FROM DBP_DATA.artbew a

JOIN DBP_ETL.artbew_wg_wechsel_join b
ON a.mandant_id = b.mandant_id
AND a.art_id = b.art_id
AND a.dat = b.dat

INNER JOIN dbp_data.art_wg_zu_per w
ON  a.mandant_id = w.mandant_id
AND a.art_id = w.art_id
AND w.dat_bis = to_date('9999-12-31','YYYY-MM-DD')
AND w.arthiertyp_id = 2

WHERE CASE
        WHEN a.mandant_id = 1 AND a.dat >= '2017-03-01' AND
             a.art_id IN (590006700,590006900)
        THEN 0
        WHEN a.mandant_id = 6 AND
             a.art_id/10 IN (9800130,9800131,9800132)
        THEN 0
        WHEN a.mandant_id = 7 AND
             a.dat >= '2019-03-01' AND
             w.wg_id = 969 AND
             w.wug_id = 6
        THEN 0
        ELSE 1
      END = 1 AND
      b.wg_id NOT IN (818,969)

GROUP BY 1,2,3,4,5,6,7,10,11,12,14,16
;

UPDATE DBP_ETL.wpuums_build_tmp
FROM DBP_DATA.kurs k

SET umsatz_brutto_konz = CAST(umsatz_brutto * k.umrechnungskurs AS DECIMAL(18,4))
, umsatz_netto_konz = CAST(umsatz_netto * k.umrechnungskurs AS DECIMAL(18,4))

WHERE DBP_ETL.wpuums_build_tmp.umsatz_wrg = k.von_wrg_id
AND k.dat_bis = to_date('9999-12-31','YYYY-MM-DD')
AND k.nach_wrg_id = 'EUR'
AND k.kurstyp_id = 3
;

UPDATE DBP_DATA.artbew_wg_sum aws
SET menge = aws.menge + b.menge,
    umsatz_netto = aws.umsatz_netto + b.umsatz_netto,
    umsatz_brutto = aws.umsatz_brutto + b.umsatz_brutto,
    umsatz_brutto_konz = aws.umsatz_brutto_konz + b.umsatz_brutto_konz,
    umsatz_netto_konz = aws.umsatz_netto_konz + b.umsatz_netto_konz

FROM (SELECT mandant_id
                                           ,nb_id
                                           ,arthiertyp_id
                                           ,wg_id
                                           ,dat
                                           ,wup_id
                                           ,bewart_id
                                           ,kjmo
                                           ,umsatz_brutto
                                           ,umsatz_netto
                                           ,umsatz_wrg
                                           ,umsatz_brutto_konz
                                           ,umsatz_netto_konz
                                           ,quelle
                                           ,menge
                                     FROM DBP_ETL.wpuums_build_tmp) b
                                         WHERE aws.mandant_id = b.mandant_id AND
      aws.nb_id = b.nb_id AND
      aws.arthiertyp_id = b.arthiertyp_id AND
      aws.wg_id = b.wg_id AND
      aws.dat = b.dat AND
      aws.wup_id = b.wup_id AND
      aws.bewart_id = b.bewart_id AND
      aws.umsatz_wrg = b.umsatz_wrg AND
      aws.quelle = b.quelle
;

INSERT INTO DBP_DATA.artbew_wg_sum (mandant_id
                                    ,nb_id
                                    ,arthiertyp_id
                                    ,wg_id
                                    ,dat
                                    ,wup_id
                                    ,bewart_id
                                    ,kjmo
                                    ,umsatz_brutto
                                    ,umsatz_netto
                                    ,umsatz_wrg
                                    ,umsatz_brutto_konz
                                    ,umsatz_netto_konz
                                    ,quelle
                                    ,menge)
SELECT a.mandant_id
      ,a.nb_id
      ,a.arthiertyp_id
      ,a.wg_id
      ,a.dat
      ,a.wup_id
      ,a.bewart_id
      ,a.kjmo
      ,a.umsatz_brutto
      ,a.umsatz_netto
      ,a.umsatz_wrg
      ,a.umsatz_brutto_konz
      ,a.umsatz_netto_konz
      ,a.quelle
      ,a.menge
FROM (SELECT a.mandant_id
            ,a.nb_id
            ,a.arthiertyp_id
            ,a.wg_id
            ,a.dat
            ,a.wup_id
            ,a.bewart_id
            ,a.kjmo
            ,a.umsatz_wrg
            ,a.quelle
            ,SUM(a.umsatz_brutto) AS umsatz_brutto
            ,SUM(a.umsatz_netto) AS umsatz_netto
            ,SUM(a.umsatz_brutto_konz) AS umsatz_brutto_konz
            ,SUM(a.umsatz_netto_konz) AS umsatz_netto_konz
            ,SUM(a.menge) AS menge
      FROM DBP_ETL.wpuums_build_tmp a
      GROUP BY 1,2,3,4,5,6,7,8,9,10) a
LEFT JOIN DBP_DATA.artbew_wg_sum b
  ON a.mandant_id = b.mandant_id AND
     a.wup_id = b.wup_id AND
     a.nb_id = b.nb_id AND
     a.dat = b.dat AND
     a.arthiertyp_id = b.arthiertyp_id AND
     a.wg_id = b.wg_id AND
     a.bewart_id = b.bewart_id AND
     a.kjmo = b.kjmo AND
     a.umsatz_wrg = b.umsatz_wrg AND
     a.quelle = b.quelle
WHERE b.mandant_id IS NULL
;

DROP TABLE IF EXISTS DBP_ETL.maabs_build_tmp;
CREATE TABLE DBP_ETL.maabs_build_tmp  (
      mandant_id BYTEINT NOT NULL ,
      wup_id INTEGER NOT NULL,
      nb_id SMALLINT NOT NULL ,
      abschriftart_id SMALLINT NOT NULL ,
      wg_id SMALLINT NOT NULL,
      arthiertyp_id BYTEINT NOT NULL ,
      dat DATE NOT NULL,
      abschriftbetrag_netto DECIMAL(18,2) NOT NULL,
      abschriftbetrag_brutto DECIMAL(18,2) NOT NULL,
      wrg_id CHAR(3) COLLATE 'en-ci' NOT NULL )
;

INSERT INTO DBP_ETL.maabs_build_tmp
(
wup_id
,nb_id
,dat
,mandant_id
,wg_id
,abschriftart_ID
,wrg_id
,arthiertyp_id
,abschriftbetrag_netto
,abschriftbetrag_brutto
)
SELECT
t1.wup_id
,t1.nb_id
,t1.dat_umbew
,t1.mandant_id
,t2.wg_id
,t1.preis_aend_grund_id
,t1.wrg_id
,t2.arthiertyp_id
,SUM(t1.diff_wert_bestand_netto*t2.alt_neu_kz)
,SUM(t1.diff_wert_bestand_brutto*t2.alt_neu_kz)

FROM  dbp_data.art_umbewertung t1

JOIN DBP_ETL.artbew_wg_wechsel_join t2
ON t1.mandant_id = t2.mandant_id
AND t1.art_id = t2.art_id
AND t1.dat_umbew = t2.dat

INNER JOIN dbp_data.abschriftart_abschriftgrp_zu t3
ON  t3.mandant_id      = t1.mandant_id
AND t3.abschriftart_id = t1.preis_aend_grund_id
AND t3.abschriftgruppe_id = 400

GROUP BY 1,2,3,4,5,6,7,8
;

INSERT INTO DBP_ETL.maabs_build_tmp
(        wup_id
        ,nb_id
        ,dat
        ,mandant_id
        ,wg_id
        ,abschriftart_ID
        ,wrg_id
        ,arthiertyp_id
        ,abschriftbetrag_netto
        ,abschriftbetrag_brutto
)
SELECT   t1.wup_id
        ,t1.nb_id
        ,t1.dat
        ,t1.mandant_id
        ,t2.wg_id
        ,t1.abschriftart_ID
        ,t1.wrg_id
        ,t2.arthiertyp_id
        ,SUM(t1.abschriftbetrag_netto*t2.alt_neu_kz)
        ,SUM(t1.abschriftbetrag_brutto*t2.alt_neu_kz)
FROM dbp_data.marktabschriften t1

JOIN DBP_ETL.artbew_wg_wechsel_join t2
ON t1.mandant_id = t2.mandant_id
AND t1.art_id = t2.art_id
AND t1.dat = t2.dat

GROUP BY 1,2,3,4,5,6,7,8
;

UPDATE DBP_DATA.marktabschriften_wg_sum mws
SET abschriftbetrag_netto = mws.abschriftbetrag_netto + b.abschriftbetrag_netto,
    abschriftbetrag_brutto = mws.abschriftbetrag_brutto + b.abschriftbetrag_brutto

FROM (SELECT wup_id
                                                     ,nb_id
                                                     ,dat
                                                     ,mandant_id
                                                     ,wg_id
                                                     ,abschriftart_ID
                                                     ,wrg_id
                                                     ,arthiertyp_id
                                                     ,abschriftbetrag_netto
                                                     ,abschriftbetrag_brutto
                                              FROM DBP_ETL.maabs_build_tmp) b
                                               WHERE mws.wup_id = b.wup_id AND
      mws.nb_id = b.nb_id AND
      mws.dat = b.dat AND
      mws.mandant_id = b.mandant_id AND
      mws.wg_id = b.wg_id AND
      mws.abschriftart_ID = b.abschriftart_ID AND
      mws.wrg_id = b.wrg_id AND
      mws.arthiertyp_id = b.arthiertyp_id
;

INSERT INTO DBP_DATA.marktabschriften_wg_sum (wup_id
                                              ,nb_id
                                              ,dat
                                              ,mandant_id
                                              ,wg_id
                                              ,abschriftart_ID
                                              ,wrg_id
                                              ,arthiertyp_id
                                              ,abschriftbetrag_netto
                                              ,abschriftbetrag_brutto)
SELECT a.wup_id
      ,a.nb_id
      ,a.dat
      ,a.mandant_id
      ,a.wg_id
      ,a.abschriftart_ID
      ,a.wrg_id
      ,a.arthiertyp_id
      ,a.abschriftbetrag_netto
      ,a.abschriftbetrag_brutto
FROM (SELECT wup_id
            ,nb_id
            ,dat
            ,mandant_id
            ,wg_id
            ,abschriftart_ID
            ,wrg_id
            ,arthiertyp_id
            ,SUM(abschriftbetrag_netto) AS abschriftbetrag_netto
            ,SUM(abschriftbetrag_brutto) AS abschriftbetrag_brutto
      FROM DBP_ETL.maabs_build_tmp
      GROUP BY 1,2,3,4,5,6,7,8) a
LEFT JOIN DBP_DATA.marktabschriften_wg_sum b
  ON a.wup_id = b.wup_id AND
     a.nb_id = b.nb_id AND
     a.dat = b.dat AND
     a.mandant_id = b.mandant_id AND
     a.wg_id = b.wg_id AND
     a.abschriftart_ID = b.abschriftart_ID AND
     a.wrg_id = b.wrg_id AND
     a.arthiertyp_id = b.arthiertyp_id
WHERE b.mandant_id IS NULL
;

DELETE FROM DBP_ETL_PROCESS.artbew_wg_wechsel;
INSERT INTO DBP_ETL_PROCESS.artbew_wg_wechsel (mandant_id, art_id, arthiertyp_id, wg_id, wg_art_fg)
SELECT mandant_id, art_id, arthiertyp_id, wg_id, wg_art_fg
FROM DBP_ETL.artbew_wg_wechsel_tmp
WHERE alt_neu_kz = 1
;

DELETE FROM DBP_DATA.artbew_wg_mo_sum awms using DBP_ETL.artbew_wg_sum_tmp awst
WHERE
awms.wg_id = awst.wg_id AND
awms.wup_id = awst.wup_id AND
awms.nb_id = awst.nb_id AND
awms.arthiertyp_id = awst.arthiertyp_id AND
awms.bewart_id = awst.bewart_id AND
awms.posten_id = awst.posten_id AND
awms.mandant_id = awst.mandant_id AND
awms.menge                         = 0 AND
awms.umsatz_netto                  = 0 AND
awms.diff_umsatz_netto_konz        = 0 AND
awms.umsatz_mwst_betrag            = 0 AND
awms.diff_umsatz_mwst_betrag_konz  = 0 AND
awms.ek_brutto                     = 0 AND
awms.diff_ek_brutto_konz           = 0 AND
awms.ek_netto                      = 0 AND
awms.diff_ek_netto_konz            = 0 AND
awms.ek_nettonetto                 = 0 AND
awms.diff_ek_nettonetto_konz       = 0 AND
awms.ek_kal_basis                  = 0 AND
awms.diff_ek_kal_basis_konz        = 0 AND
awms.ek_mep                        = 0 AND
awms.diff_ek_mep_konz              = 0 AND
awms.einstandspreis                = 0 AND
awms.diff_einstandspreis_konz      = 0 AND
awms.logkostenzuschlag             = 0 AND
awms.diff_logkostenzuschlag_konz   = 0 AND
awms.ek_netto_bnk                  = 0 AND
awms.diff_ek_netto_bnk_konz        = 0 AND
awms.ek_netto_bnk_sachk            = 0 AND
awms.diff_ek_netto_bnk_sachk_konz  = 0 
;

DELETE FROM DBP_DATA.artbew_wg_tp2_sum awts using DBP_ETL.artbew_wg_sum_tmp abwstmp
WHERE
  awts.menge                         = 0 AND
  awts.menge_ohne_wg_erf_art         = 0 AND
  awts.umsatz_netto                  = 0 AND
  awts.diff_umsatz_netto_konz        = 0 AND
  awts.umsatz_mwst_betrag            = 0 AND
  awts.diff_umsatz_mwst_betrag_konz  = 0 AND
  awts.ek_brutto                     = 0 AND
  awts.diff_ek_brutto_konz           = 0 AND
  awts.ek_netto                      = 0 AND
  awts.diff_ek_netto_konz            = 0 AND
  awts.ek_nettonetto                 = 0 AND
  awts.diff_ek_nettonetto_konz       = 0 AND
  awts.ek_kal_basis                  = 0 AND
  awts.diff_ek_kal_basis_konz        = 0 AND
  awts.ek_mep                        = 0 AND
  awts.diff_ek_mep_konz              = 0 AND
  awts.einstandspreis                = 0 AND
  awts.diff_einstandspreis_konz      = 0 AND
  awts.logkostenzuschlag             = 0 AND
  awts.diff_logkostenzuschlag_konz   = 0 AND
  awts.ek_netto_bnk                  = 0 AND
  awts.diff_ek_netto_bnk_konz        = 0 AND
  awts.ek_netto_bnk_sachk            = 0 AND
  awts.diff_ek_netto_bnk_sachk_konz  = 0 AND
  awts.wg_id = abwstmp.wg_id  AND
  awts.wup_id = abwstmp.wup_id AND
  awts.nb_id = abwstmp.nb_id  AND
  awts.arthiertyp_id = abwstmp.arthiertyp_id  AND
  awts.dat = abwstmp.dat  AND
  awts.bewart_id = abwstmp.bewart_id  AND
  awts.posten_id = collate(abwstmp.posten_id, 'en-ci')  AND
  awts.mandant_id = abwstmp.mandant_id 
;

DELETE FROM DBP_DATA.artbew_wg_sum aws using DBP_ETL.wpuums_build_tmp wbt
WHERE
aws.menge               = 0 AND
aws.umsatz_netto        = 0 AND
aws.umsatz_brutto       = 0 AND
aws.umsatz_brutto_konz  = 0 AND
aws.umsatz_netto_konz   = 0 AND
aws.wg_id = wbt.wg_id  AND
aws.wup_id = wbt.wup_id   AND
aws.nb_id = wbt.nb_id   AND
aws.arthiertyp_id = wbt.arthiertyp_id   AND
aws.bewart_id = wbt.bewart_id   AND
aws.mandant_id = wbt.mandant_id   AND
aws.dat = wbt.dat   AND
aws.umsatz_wrg = wbt.umsatz_wrg   AND
aws.quelle = wbt.quelle  
;

DELETE FROM DBP_DATA.marktabschriften_wg_sum mws using DBP_ETL.maabs_build_tmp mbt
WHERE
mws.abschriftbetrag_netto  = 0 AND
mws.abschriftbetrag_brutto = 0 AND
mws.wup_id = mbt.wup_id  AND
mws.nb_id = mbt.nb_id  AND
mws.dat = mbt.dat  AND
mws.mandant_id = mbt.mandant_id  AND
mws.wg_id = mbt.wg_id  AND
mws.abschriftart_ID = mbt.abschriftart_ID  AND
mws.wrg_id = mbt.wrg_id  AND
mws.arthiertyp_id = mbt.arthiertyp_id 
;

DROP TABLE IF EXISTS DBP_ETL.artbew_wg_wechsel_tmp;
DROP TABLE IF EXISTS DBP_ETL.artbew_wg_sum_tmp;

