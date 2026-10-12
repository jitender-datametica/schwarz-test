UPDATE DBP_ETL.kmo_ekpo_1 SET gp_id = ag.gp_id
FROM (SELECT mandant_id, 
             art_id, 
             dat_von,
             dat_bis,
             gp_id
      FROM DBP_DATA.art_gp_zu_per_1) ag
WHERE DBP_ETL.kmo_ekpo.art_id    = ag.art_id
  AND DBP_ETL.kmo_ekpo.mandant_id= ag.mandant_id
  AND DBP_ETL.kmo_ekpo.dat_best_beleg BETWEEN ag.dat_von AND ag.dat_bis
;

DROP TABLE IF EXISTS DBP_ETL.art_wup_man_sp_besch_best_tmp_1;
CREATE TABLE DBP_ETL.art_wup_man_sp_besch_best_tmp_1  (
        mandant_id               BYTEINT NOT NULL,
        art_id                   INTEGER NOT NULL,
        wup_id                   INTEGER NOT NULL,
        nb_id                    SMALLINT NOT NULL,
        faktor_ek_effektivpreis  DECIMAL(9,4)
);

INSERT INTO DBP_ETL.art_wup_man_sp_besch_best_tmp_1
(
         mandant_id
        ,art_id
        ,wup_id
        ,nb_id
        ,faktor_ek_effektivpreis
)
-- Hier die betriebsspezifischen manuellen Spannenfaktoren
SELECT
         mandant_id
        ,art_id
        ,wup_id
        ,nb_id
        ,ek_faktor
FROM DBP_DATA.art_wup_man_spanne_per_1 e
WHERE konditionsart_id = 'ZWGE' /*ek_netto*/
AND loesch_fg = 0
AND CURRENT_DATE BETWEEN dat_von AND dat_bis
UNION
SELECT
         mandant_id
        ,art_id
        ,-1 AS wup_id
        ,-1 AS nb_id
        ,ek_faktor
FROM DBP_DATA.art_man_spanne_per_1 e
WHERE konditionsart_id = 'ZWGE' /*ek_netto*/
AND loesch_fg = 0
AND CURRENT_DATE BETWEEN dat_von AND dat_bis
;

UPDATE DBP_ETL.kmo_ekpo_1

SET      ek_netto       = a.ek_effektivpreis  /* in KMO Einstandspreis verwenden*/
        ,gp_id          = a.gp_id
        ,wrg_id         = a.wrg_id

FROM
(SELECT
        a.mandant_id
        ,a.wup_id
        ,a.nb_id
        ,a.art_id
        ,z.gp_id
        ,m.default_wrg AS wrg_id
        ,COALESCE( (COALESCE(ma.faktor_ek_effektivpreis , ms.faktor_ek_effektivpreis) ) , /*Manuelle Spanne*/
		  COALESCE(e.ek_netto, ee.ek_netto),  /*lt. FB: effektivpreis verwenden*/
                   ( 0.0000 )  /*Keine BQ Findung moeglich*/
                ) AS ek_effektivpreis
FROM DBP_ETL.kmo_ekpo_1  a

-- Waehrung aus Mandanten ermitteln, falls Ausstiegspunkt außerhalb der ZEKP.
INNER JOIN DBP_DATA.mandant_1 m
        ON a.mandant_id = m.mandant_id

-- Lieferant und Ausstiegspunkt ermitteln
LEFT OUTER JOIN DBP_DATA.art_gp_nm_zu_per_1 z
         ON a.mandant_id = z.mandant_id
        AND a.wup_id = z.wup_id
        AND a.art_id = z.art_id
        AND CURRENT_DATE BETWEEN z.dat_von AND z.dat_bis

-- Betriebsspezifischer EK Preis
LEFT OUTER JOIN DBP_DATA.art_gp_wup_zu_per_1 e
         ON z.mandant_id = e.mandant_id
        AND z.vz_wup_id = e.wup_id
        AND z.art_id = e.art_id
        AND z.gp_id = e.gp_id
        AND CURRENT_DATE BETWEEN e.dat_von AND e.dat_bis
        AND MOD(z.bq_findung_id,2) = 1 /*ungerade BQ Findung ID Zugriff mit Wup_1*/
        AND z.bq_findung_id <> 25     /*aber ohne Ausstiegspunkt "keine BQ Findung moeglich"*/

-- Betriebsuebergreifender EK Preis
LEFT OUTER JOIN DBP_DATA.art_gp_wup_zu_per_1 ee
         ON z.mandant_id = ee.mandant_id
        AND -1 = ee.wup_id
        AND z.art_id = ee.art_id
        AND z.gp_id = ee.gp_id
        AND CURRENT_DATE BETWEEN ee.dat_von AND ee.dat_bis
        AND MOD(z.bq_findung_id,2) = 0 /*gerade BQ Findung ID Zugriff ohne Wup_1*/

-- Ermittlung betriebsuebergreifernde manuelle Spannenfaktoren
LEFT OUTER JOIN DBP_ETL.art_wup_man_sp_besch_best_tmp_1 ms
         ON a.mandant_id = ms.mandant_id
        AND a.art_id = ms.art_id
        AND ms.wup_id = 0
        AND z.bq_findung_id = 27

-- Ermittlung Betriebsspezifischer manuelle Spannefaktoren
LEFT OUTER JOIN DBP_ETL.art_wup_man_sp_besch_best_tmp_1 ma
         ON a.mandant_id = ma.mandant_id
        AND a.art_id = ma.art_id
        AND a.wup_id = ma.wup_id
        AND z.bq_findung_id = 26

WHERE a.mandant_id > 1

GROUP BY 1,2,3,4,5,6,7 /*BQ Findung FBB uebergreifend*/
) a
 WHERE DBP_ETL.kmo_ekpo.mandant_id = a.mandant_id
  AND DBP_ETL.kmo_ekpo.wup_id     = a.wup_id
  AND DBP_ETL.kmo_ekpo.nb_id      = a.nb_id
  AND DBP_ETL.kmo_ekpo.art_id     = a.art_id
;

DROP TABLE IF EXISTS DBP_ETL.fww_kmo_perf_tmp1_1;

CREATE TABLE DBP_ETL.fww_kmo_perf_tmp1_1 AS (
        SELECT dat_best_beleg_orig AS dat_best_beleg
        FROM DBP_ETL.kmo_ekpo_1
        WHERE dat_best_beleg_orig IS NOT NULL
        GROUP BY 1
);

DELETE FROM DBP_DATA.besch_best_det_1
WHERE dat_best_beleg IN 
(SELECT dat_best_beleg
  FROM DBP_ETL.fww_kmo_perf_tmp1_1) 
AND mandant_id > 1 
AND (mandant_id, best_beleg_id, best_beleg_pos_id,dat_best_beleg) IN 
        (SELECT  mandant_id
                ,best_beleg_id
                ,best_beleg_pos_id
                ,dat_best_beleg_orig
        FROM DBP_ETL.kmo_ekpo_1
        WHERE dat_best_beleg_orig IS NOT NULL)
;

INSERT INTO DBP_DATA.besch_best_det_1
(
mandant_id
, best_beleg_id
, best_beleg_pos_id
, art_id
, wup_id
, nb_id
, lagerort_id
, loesch_fg
, menge_best_bme
, selbstabhol_fg
, best_preis_menge_einh_id
, best_menge_einh_id
, menge_best_kolli
, menge_best_palette
, endlief_fg
, dat_aenderung
, kunde_id
, dat_best_beleg
, ean_id
, betrag_kond_zw_sum2
, pos_kostenlos_fg
, betrag_pos_netto
, betrag_pos_netto_best_wrg
, wrg_id
, betrag_best
, gp_teilsortiment_id
, menge_block_bestand
, flw_fg
, zentral_best_fg
, anforderer_name
,td_insert
,td_update
)
SELECT
t.mandant_id
, t.best_beleg_id
, t.best_beleg_pos_id
, t.art_id
, t.wup_id
, t.nb_id
, t.lagerort_id
, t.loesch_fg
, COALESCE (CAST(CAST(t.menge_best_kolli AS FLOAT)/COALESCE(COALESCE(aukolli.umrech_faktor,aukolli_akt.umrech_faktor), 
                                                   COALESCE(aukolli_alternativ.umrech_faktor,aukolli_alternativ_akt.umrech_faktor),1) AS DECIMAL(18,3)),0) AS  menge_best_neu
, t.selbstabhol_fg
, t.best_preis_menge_einh_id
, t.best_basismenge_einh_id
, menge_best_kolli
, COALESCE(CAST(menge_best_neu * COALESCE(aupalette.umrech_faktor, aupalette_q.umrech_faktor,0) AS DECIMAL(18,3)),0)  AS menge_best_palette
, t.endlief_fg
, t.dat_aenderung
, t.kunde_id
, t.dat_best_beleg
, t.ean_id
, t.betrag_kond_zw_sum2	
, t.pos_kostenlos_fg
, t.betrag_pos_netto	
, CASE  WHEN CAST((t.betrag_pos_netto_best_wrg ) AS DECIMAL(18,4)) = 0.0000
        THEN  (CAST(menge_best_neu * CAST(CAST( (t.ek_netto ) AS DECIMAL(18,4)) AS FLOAT) AS DECIMAL(18,2)) )
        ELSE t.betrag_pos_netto_best_wrg
        END AS betrag_pos_netto_best_wrg

, t.wrg_id
, t.betrag_best
, t.gp_teilsortiment_id
, t.menge_block_bestand
,CASE 	WHEN wgfz.wg_id IS NOT NULL THEN 1
	ELSE 0 END AS flw_fg
, t.zentral_best_fg  AS zentral_best_fg
, t.anforderer_name
,CURRENT_TIMESTAMP
,CURRENT_TIMESTAMP
FROM DBP_ETL.kmo_ekpo_1 t

LEFT OUTER JOIN DBP_DATA.art_wg_zu_per_1 awzp
ON awzp.mandant_id = t.mandant_id
AND awzp.art_id = t.art_id
AND awzp.arthiertyp_id= 2
AND awzp.dat_bis = to_date('9999-12-31','YYYY-MM_1-DD')

-- Umrechnungsfaktor fuer Basismenge mit Umrechnungsfaktor aus der Bestellung holen
LEFT OUTER JOIN DBP_DATA.art_umrechnung_faktor_per_1 aukolli
ON t.art_id = aukolli.art_id
AND t.best_basismenge_einh_id = aukolli.altnv_menge_einh_id
AND t.dat_best_beleg BETWEEN aukolli.dat_von AND aukolli.dat_bis
AND t.mandant_id = aukolli.mandant_id

-- Umrechnungsfaktor fuer Basismenge mit Umrechnungsfaktor aus der Bestellung holen / current state in case there is no as-was record
LEFT OUTER JOIN DBP_DATA.art_umrechnung_faktor_per_1 aukolli_akt
ON t.art_id = aukolli_akt.art_id
AND t.best_basismenge_einh_id = aukolli_akt.altnv_menge_einh_id
AND aukolli_akt.dat_bis = '9999-12-31'
AND t.mandant_id = aukolli_akt.mandant_id

-- Palettenfaktor und Default Mengeneinheit holen
LEFT OUTER JOIN DBP_DATA.art_vorschlagswert_per_1 av
ON t.art_id = av.art_id
AND t.dat_best_beleg BETWEEN av.dat_von AND av.dat_bis
AND t.mandant_id = av.mandant_id

-- Umrechnungsfaktor fuer Palettenfaktor holen
LEFT OUTER JOIN DBP_DATA.art_umrechnung_faktor_per_1 aupalette
ON t.art_id = aupalette.art_id
AND av.paletten_faktor_einh_id = aupalette.altnv_menge_einh_id
AND t.dat_best_beleg BETWEEN aupalette.dat_von AND aupalette.dat_bis
AND t.mandant_id = aupalette.mandant_id

-- Default Umrechnungsfaktor fuer Basismenge holen, wenn Umrechnungsfaktor aus Bestellung NULL ist
LEFT OUTER JOIN DBP_DATA.art_umrechnung_faktor_per_1 aukolli_alternativ
ON t.art_id = aukolli_alternativ.art_id
AND av.ausg_menge_einh_id = aukolli_alternativ.altnv_menge_einh_id
AND t.dat_best_beleg BETWEEN aukolli_alternativ.dat_von AND aukolli_alternativ.dat_bis
AND t.mandant_id = aukolli_alternativ.mandant_id

--
LEFT OUTER JOIN DBP_DATA.art_umrechnung_faktor_per_1 aukolli_alternativ_akt
ON t.art_id = aukolli_alternativ_akt.art_id
AND av.ausg_menge_einh_id = aukolli_alternativ_akt.altnv_menge_einh_id
AND aukolli_alternativ_akt.dat_bis = '9999-12-31'
AND t.mandant_id = aukolli_alternativ_akt.mandant_id

-- 80991231 Umrechnungsfaktor fuer Basismenge mit Umrechnungsfaktor aus der Bestellung holen
LEFT OUTER JOIN DBP_DATA.art_umrechnung_faktor_per_1 aukolli_q
ON t.art_id = aukolli_q.art_id
AND t.best_basismenge_einh_id = aukolli_q.altnv_menge_einh_id
AND aukolli_q.dat_bis = to_date('9999-12-31','YYYY-MM_1-DD')
AND t.mandant_id = aukolli_q.mandant_id

-- 80991231 Palettenfaktor und Default Mengeneinheit holen
LEFT OUTER JOIN DBP_DATA.art_vorschlagswert_per_1 av_q
ON t.art_id = av_q.art_id
AND t.dat_best_beleg BETWEEN av_q.dat_von AND av_q.dat_bis
AND t.mandant_id = av_q.mandant_id

-- 80991231 Umrechnungsfaktor fuer Palettenfaktor holen
LEFT OUTER JOIN DBP_DATA.art_umrechnung_faktor_per_1 aupalette_q
ON t.art_id = aupalette_q.art_id
AND  aupalette_q.altnv_menge_einh_id = 'PAL'
AND aupalette_q.dat_bis = to_date('9999-12-31','YYYY-MM_1-DD')
AND t.mandant_id = aupalette_q.mandant_id

-- 80991231 Default Umrechnungsfaktor fuer Basismenge holen, wenn Umrechnungsfaktor aus Bestellung NULL ist
LEFT OUTER JOIN DBP_DATA.art_umrechnung_faktor_per_1 aukolli_alternativ_q
ON t.art_id = aukolli_alternativ_q.art_id
AND av_q.ausg_menge_einh_id = aukolli_alternativ_q.altnv_menge_einh_id
AND aukolli_alternativ_q.dat_bis = to_date('9999-12-31','YYYY-MM_1-DD')
AND t.mandant_id = aukolli_alternativ_q.mandant_id

LEFT JOIN DBP_DATA.wg_filter_zu_1 AS wgfz
ON wgfz.wg_id = awzp.wg_id
AND wgfz.mandant_id = awzp.mandant_id
AND wgfz.wg_filter_id = 23
AND wgfz.arthiertyp_id = 2
;


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'KFL_DEVELOPMENT.DBP_ETL.KMO_EKPO_1' does not exist or not authorized.
UPDATE DBP_DATA.besch_best_det_1 
SET zentral_best_fg = 1

FROM (SELECT DISTINCT
             t1.mandant_id,
             t1.best_beleg_id,
             t1.best_beleg_pos_id,
             t1.art_id,
             t1.wup_id,
	     t1.dat_best_beleg
      FROM DBP_DATA.besch_best_det_1 t1_1
      JOIN DBP_ETL.kmo_ekpo_1 x
        ON t1.mandant_id = x.mandant_id AND
           t1.best_beleg_id = x.best_beleg_id AND
           t1.best_beleg_pos_id = x.best_beleg_pos_id AND
           t1.wup_id = x.wup_id AND
           t1.dat_best_beleg = x.dat_best_beleg AND
           t1.art_id = x.art_id
      LEFT JOIN DBP_DATA.fur_best_vor_1  t2
        ON t1.mandant_id = t2.mandant_id AND 
           t1.wup_id = t2.wup_id AND 
           t1.art_id = t2.art_id AND 
           t1.dat_best_beleg = t2.dat_dispo 
      WHERE t1.anforderer_name = 'ZFRE0150_INT') b
 WHERE DBP_DATA.besch_best_det.mandant_id = b.mandant_id AND
       DBP_DATA.besch_best_det.best_beleg_id = b.best_beleg_id AND
       DBP_DATA.besch_best_det.best_beleg_pos_id = b.best_beleg_pos_id AND
       DBP_DATA.besch_best_det.art_id = b.art_id AND
       DBP_DATA.besch_best_det.wup_id = b.wup_id AND
       DBP_DATA.besch_best_det.dat_best_beleg = b.dat_best_beleg
;

UPDATE DBP_DATA.besch_best_1

SET  
	empfaenger_wup_id  = bzeile.empfaenger_wup_id,
	anz_pos_aktiv      = bzeile.anz_pos_aktiv,
	anz_pos_offen      = bzeile.anz_pos_offen

FROM (SELECT mandant_id,
             best_beleg_id,
             MAX(wup_id) empfaenger_wup_id,
             COUNT(*) anz_pos_aktiv,
             SUM(CASE WHEN endlief_fg=1 THEN 0 ELSE 1 END) anz_pos_offen
      FROM DBP_DATA.besch_best_det_1
      WHERE loesch_fg = 0 AND
           (mandant_id, best_beleg_id, dat_best_beleg) IN (SELECT mandant_id, best_beleg_id, dat_best_beleg
                                                           FROM DBP_ETL.kmo_ekpo_1
                                                           -- Bestellungen an Lieferanten
                                                           WHERE NULLIFZERO(kopf_wup_id) IS NULL) 
      GROUP BY mandant_id,best_beleg_id) bzeile
 
WHERE DBP_DATA.besch_best.mandant_id     = bzeile.mandant_id AND
      DBP_DATA.besch_best.best_beleg_id  = bzeile.best_beleg_id 
;

DROP TABLE IF EXISTS DBP_ETL.lief_eint_tmp_1;

CREATE TABLE DBP_ETL.lief_eint_tmp_1  (
      mandant_id           BYTEINT NOT NULL,
      best_beleg_id        DECIMAL(18,0) NOT NULL,
      best_beleg_pos_id    INTEGER NOT NULL ,
      einteil_id           SMALLINT NOT NULL  ,
      menge_einteil        DECIMAL(18,3) NOT NULL ,
      dat_lief_wunsch      DATE NOT NULL,
      dat_lief_bewertung   DATE,
      mahnung_anz          SMALLINT NOT NULL  ,
      system_id            BYTEINT NOT NULL  ,
      flw_fg               BYTEINT NOT NULL
      )
;

INSERT INTO DBP_ETL.lief_eint_tmp_1
(
 mandant_id         
,best_beleg_id      
,best_beleg_pos_id  
,einteil_id         
,menge_einteil      
,dat_lief_wunsch    
,dat_lief_bewertung 
,mahnung_anz        
,system_id          
,flw_fg             
)
SELECT t3.mandant_id
      ,t3.best_beleg_id
      ,t3.best_beleg_pos_id
      ,t3.einteil_id
      ,t3.menge_einteil
      ,t3.dat_lief_wunsch
      ,t3.dat_lief_bewertung
      ,t3.mahnung_anz
      ,t3.system_id
      ,t1.flw_fg

FROM DBP_DATA.besch_best_det_1 t1_1

INNER JOIN DBP_ETL.kmo_ekpo_1 t2
ON   t1.mandant_id        = t2.mandant_id
AND  t1.best_beleg_id     = t2.best_beleg_id
AND  t1.best_beleg_pos_id = t2.best_beleg_pos_id
AND  t1.dat_best_beleg    = t2.dat_best_beleg

INNER JOIN DBP_DATA.lief_einteilung_1 t3
ON   t1.mandant_id        = t3.mandant_id
AND  t1.best_beleg_id     = t3.best_beleg_id
AND  t1.best_beleg_pos_id = t3.best_beleg_pos_id

WHERE t1.flw_fg = 1
AND t1.mandant_id = 2
;

DELETE FROM DBP_DATA.lief_einteilung_1
WHERE (mandant_id, best_beleg_id, best_beleg_pos_id, dat_lief_wunsch)
IN
(SELECT
mandant_id, best_beleg_id, best_beleg_pos_id, dat_lief_wunsch
FROM DBP_ETL.lief_eint_tmp_1
)
;

INSERT INTO DBP_DATA.lief_einteilung_1
(
	 mandant_id         
	,best_beleg_id      
	,best_beleg_pos_id  
	,einteil_id         
	,menge_einteil      
	,dat_lief_wunsch    
	,dat_lief_bewertung 
	,mahnung_anz        
	,system_id          
	,flw_fg  
)
SELECT 
	 mandant_id         
	,best_beleg_id      
	,best_beleg_pos_id  
	,einteil_id         
	,menge_einteil      
	,dat_lief_wunsch    
	,dat_lief_bewertung 
	,mahnung_anz        
	,system_id          
	,flw_fg 
FROM DBP_ETL.lief_eint_tmp_1
;
