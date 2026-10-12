INSERT INTO DBP_DATA.artbew_agg_wt
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
FROM DBP_ETL.artbew_kmo_tmp
WHERE
(
mandant_id
,wup_id
,nb_id
,dat
)
NOT IN
(
SELECT
mandant_id
,wup_id
,nb_id
,dat
FROM DBP_DATA.artbew_agg_wt
)

GROUP BY 1,2,3,4
;

DROP TABLE IF EXISTS DBP_ETL.artbew_reload_mseq;
CREATE TABLE DBP_ETL.artbew_reload_mseq LIKE DBP_DATA.artbew;
DROP TABLE IF EXISTS DBP_ETL.artbew_251;
CREATE TABLE DBP_ETL.artbew_251 LIKE DBP_DATA.artbew;

INSERT INTO DBP_ETL.artbew_reload_mseq
(
   mandant_id
  ,wup_id
  ,nb_id
  ,art_id
  ,gp_id
  ,einkaufsorganisation_id
  ,bewart_id
  ,dat
  ,aktion_id
  ,herst_id
  ,mwst_id
  ,wrg
  ,posten_id
  ,bezugsweg_id
  ,menge
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
  ,ek_netto_bnk
  ,diff_ek_netto_bnk_konz
  ,ek_netto_bnk_sachk
  ,diff_ek_netto_bnk_sachk_konz
  ,promo_fg
  ,bq_findung_id
  ,ek_gld
  ,diff_ek_gld_konz
  ,bewart_det_id
  ,pv_aktion_bby
  ,pv_aktion_kdn_bby
  ,pv_aktion_kdp_bby
  ,pv_bby
  ,pv_kdn_bby
  ,pv_kdp_bby
 
)
SELECT
   mandant_id
  ,wup_id
  ,nb_id
  ,art_id
  ,gp_id
  ,einkaufsorganisation_id
  ,bewart_id
  ,dat
  ,aktion_id
  ,herst_id
  ,mwst_id
  ,wrg
  ,posten_id
  ,bezugsweg_id
  ,menge_sum
  ,umsatz_netto_sum
  ,diff_umsatz_netto_konz_sum
  ,umsatz_mwst_betrag_sum
  ,diff_umsatz_mwst_betrag_konz_s
  ,zero_enc AS ek_brutto
  ,zero_enc AS diff_ek_brutto_konz
  ,zero_enc AS ek_netto
  ,zero_enc AS diff_ek_netto_konz
  ,zero_enc AS ek_nettonetto
  ,zero_enc AS diff_ek_nettonetto_konz
  ,zero_enc AS ek_kal_basis
  ,zero_enc AS diff_ek_kal_basis_konz
  ,zero_enc AS ek_mep
  ,zero_enc AS diff_ek_mep_konz
  ,zero_enc AS einstandspreis
  ,zero_enc AS diff_einstandspreis_konz
  ,0 AS logkostenzuschlag
  ,0 AS diff_logkostenzuschlag_konz
  ,zero_enc AS ek_netto_bnk
  ,zero_enc AS diff_ek_netto_bnk_konz
  ,zero_enc AS ek_netto_bnk_sachk
  ,zero_enc AS diff_ek_netto_bnk_sachk_konz
  ,0 AS promo_fg
  ,0 AS bq_findung_id 
  ,0 AS ek_gld
  ,0 AS diff_ek_gld_konz  
  ,9999 AS bewart_det_id     
  ,0 AS pv_aktion_bby     
  ,0 AS pv_aktion_kdn_bby 
  ,0 AS pv_aktion_kdp_bby 
  ,0 AS pv_bby            
  ,0 AS pv_kdn_bby        
  ,0 AS pv_kdp_bby        

FROM 
(
  SELECT  
     l.mandant_id 
    ,l.wup_id
    ,l.nb_id
    ,l.art_id
    ,-1 AS gp_id
    ,-1 AS einkaufsorganisation_id 
    ,COALESCE(r.bewart_id, 1001) AS bewart_id
    ,dat_buch AS dat
    ,CASE WHEN r.anz_aktion = 1 
          THEN r.max_aktion_id
          ELSE ''
     END AS aktion_id
    ,-1 AS herst_id
    ,a.mwst_id
    ,m.default_wrg AS wrg 
    ,COALESCE(a.posten_id, ' ') AS posten_id 
    ,0 AS bezugsweg_id
    ,0 AS zero_enc
    --,0 AS zero_enc
    ,SUM(menge_erf)*-1 AS menge_sum
    ,SUM(CAST(betrag_verkauf_ist / (1+(mwst.mwst/100)) AS DECIMAL(18,4)))*-1 AS umsatz_netto_sum
    ,SUM(betrag_verkauf_ist - (CAST(betrag_verkauf_ist / (1+(mwst.mwst/100)) AS DECIMAL(18,4))))*-1 AS umsatz_mwst_betrag_sum
    ,SUM((CAST(betrag_verkauf_ist / (1+(mwst.mwst/100)) AS DECIMAL(18,4))) * k.umrechnungskurs)*-1 AS diff_umsatz_netto_konz_sum
    ,SUM((betrag_verkauf_ist - (CAST(betrag_verkauf_ist / (1+(mwst.mwst/100)) AS DECIMAL(18,4)))) * k.umrechnungskurs)*-1 AS diff_umsatz_mwst_betrag_konz_s
  FROM DBP_DATA.lagerbew_det l
  
  INNER JOIN DBP_DATA.art a
  ON l.mandant_id = a.mandant_id
    AND l.art_id = a.art_id
    AND a.mandant_id = l.mandant_id 
  
  INNER JOIN DBP_DATA.mwst_per mwst
  ON l.mandant_id = mwst.mandant_id
    AND a.mwst_id = mwst.mwst_id
    AND l.dat_buch BETWEEN mwst.dat_von AND mwst.dat_bis
  
  INNER JOIN DBP_DATA.mandant m
  ON l.mandant_id = m.mandant_id 
  
  INNER JOIN DBP_DATA.kurs k
  ON k.von_wrg_id = m.default_wrg
    AND k.kurstyp_id = 9
    AND k.nach_wrg_id = 'EUR'
    AND l.dat_buch BETWEEN k.dat_von AND k.dat_bis
  
  LEFT OUTER JOIN 
  (
    SELECT
       mandant_id
      ,MAX(aktion_id) AS max_aktion_id
      ,bewart_id
      ,dat
      ,art_id
      ,wup_id
      ,nb_id
      ,MAX(zaehler) AS anz_aktion
    FROM
    (
      SELECT
         a.mandant_id
        ,a.aktion_id
        ,a.bewart_id
        ,d.dat AS dat
        ,aaw.art_id
        ,aaw.wup_id
        ,aaw.nb_id
        ,ROW_NUMBER()
         OVER (PARTITION BY a.mandant_id, a.bewart_id, aaw.art_id, aaw.wup_id, aaw.nb_id, d.dat ORDER BY a.dat_von)
         AS zaehler
      FROM DBP_DATA.aktion a
      
      INNER JOIN 
      (
        SELECT dat FROM DBP_DATA.artbew_agg_wt
           group by 1
             ) d
      ON d.dat BETWEEN a.dat_von AND a.dat_bis
      
      INNER JOIN DBP_DATA.aktion_art_wup_zu aaw
      ON a.mandant_id = aaw.mandant_id
        AND a.aktion_id = aaw.aktion_id
        AND a.bewart_id = aaw.bewart_id
                           
      WHERE a.bewart_id = 1002 -- Kennzeichen Aktion
        AND (UPPER(aaw.grund_sperrung) <> 'X'  OR aaw.grund_sperrung IS NULL) -- Kennzeichen Zuordnung Aktion, Artikel, Wup aktiv
        AND a.mandant_id in (3,8)
    ) a                    
    GROUP BY 1, 3 ,4, 5, 6, 7
  ) r
  ON l.mandant_id  = r.mandant_id
    AND l.art_id   = r.art_id
    AND l.wup_id   = r.wup_id
    AND l.nb_id    = r.nb_id
    AND l.dat_buch = r.dat
 /*SALESDATE SETZEN  / WUP_ID SETZEN  /MANDANT SETZEN */  
  WHERE 
   l.lager_bewart_id IN ('251','252')   
  
   and (l.mandant_id, l.wup_id, l.dat_buch)
   in 
   (select mandant_id, wup_id, dat from DBP_DATA.artbew_agg_wt
   where mandant_id in (3,8)
   )     
    
  GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15
) a
;

INSERT INTO DBP_ETL.artbew_251
(
wup_id
,mandant_id
,bewart_id
,gp_id
,nb_id
,art_id
,dat
,aktion_id
,promo_fg /*FEHLT*/
,einkaufsorganisation_id
,herst_id
,mwst_id
,menge
,wrg
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
,bq_findung_id /*FEHLT*/
,ek_gld /*FEHLT*/
,diff_ek_gld_konz /*FEHLT*/
 ,bewart_det_id
  ,pv_aktion_bby
  ,pv_aktion_kdn_bby
  ,pv_aktion_kdp_bby
  ,pv_bby
  ,pv_kdn_bby
  ,pv_kdp_bby
)
SELECT 
wup_id
,mandant_id
,bewart_id
,gp_id
,nb_id
,art_id
,dat
,aktion_id
,promo_fg
,einkaufsorganisation_id
,herst_id
,mwst_id
,menge
,wrg
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
 ,bewart_det_id
  ,pv_aktion_bby
  ,pv_aktion_kdn_bby
  ,pv_aktion_kdp_bby
  ,pv_bby
  ,pv_kdn_bby
  ,pv_kdp_bby

FROM DBP_ETL.artbew_reload_mseq;

CREATE OR REPLACE TRANSIENT TABLE __vol_art_gp_wup_zu_per  (
  mandant_id              BYTEINT NOT NULL,
  art_id                  INTEGER NOT NULL,
  gp_id                   INTEGER NOT NULL,
  wup_id                  INTEGER NOT NULL,
  nb_id                   SMALLINT,
  einkaufsorganisation_id SMALLINT NOT NULL,
  dat                     DATE NOT NULL,
  ek_brutto               DECIMAL(18,4),
  ek_netto                DECIMAL(18,4),
  ek_nettonetto           DECIMAL(18,4),
  ek_kal_basis            DECIMAL(18,4),
  ek_mep                  DECIMAL(18,4),
  einstandspreis          DECIMAL(18,4),
  logistikkostenzuschlag  DECIMAL(18,4),
  ek_netto_bnk            DECIMAL(18,4),
  ek_netto_bnk_sachk      DECIMAL(18,4)
)
;

CREATE OR REPLACE TRANSIENT TABLE _kmo_wpuums_dat_${TRANSIENT_TABLE_SUFFIX}  (
  dat DATE
, UNIQUE (dat)

);

CREATE OR REPLACE TRANSIENT TABLE _kmo_wpuums_dat_min_${TRANSIENT_TABLE_SUFFIX}  (
  dat DATE
, UNIQUE (dat)

);

DELETE FROM _kmo_wpuums_dat_${TRANSIENT_TABLE_SUFFIX};
DELETE FROM _kmo_wpuums_dat_min_${TRANSIENT_TABLE_SUFFIX};

INSERT INTO _kmo_wpuums_dat_${TRANSIENT_TABLE_SUFFIX}
(dat)
SELECT
dat FROM DBP_DATA.tag

WHERE dat IN 
(select dat from DBP_DATA.artbew_agg_wt
where mandant_id in (3,8)
group by 1
)

;

INSERT INTO _kmo_wpuums_dat_min_${TRANSIENT_TABLE_SUFFIX} 
(dat)
SELECT MIN(dat)
FROM
DBP_DATA.TAG
WHERE dat IN 
(select dat from DBP_DATA.artbew_agg_wt
where mandant_id in (3,8)
group by 1
)

;

DELETE FROM __vol_art_gp_wup_zu_per;
INSERT INTO __vol_art_gp_wup_zu_per
(
   mandant_id
  ,wup_id
  ,nb_id
  ,art_id
  ,gp_id
  ,einkaufsorganisation_id
  ,dat
  ,ek_brutto
  ,ek_netto
  ,ek_nettonetto
  ,ek_kal_basis
  ,ek_mep
  ,einstandspreis
  ,logistikkostenzuschlag
  ,ek_netto_bnk
  ,ek_netto_bnk_sachk
)
SELECT
   mandant_id
  ,wup_id
  ,nb_id
  ,art_id
  ,gp_id
  ,einkaufsorganisation_id
  ,dat
  ,ek_brutto
  ,ek_netto
  ,ek_nettonetto
  ,ek_kal_basis
  ,ek_mep
  ,einstandspreis
  ,logistikkostenzuschlag
  ,ek_netto_bnk
  ,ek_netto_bnk_sachk
FROM
(
  SELECT
     mandant_id
    ,wup_id
    ,nb_id
    ,art_id
    ,gp_id
    ,einkaufsorganisation_id
    ,dat_von
    ,dat_bis
    ,wrg_id
    ,ek_brutto  AS ek_brutto
    ,ek_netto AS ek_netto
    ,ek_nettonetto  AS ek_nettonetto
    ,ek_kal_basis   AS ek_kal_basis
    ,ek_mep         AS ek_mep
    ,einstandspreis    AS einstandspreis
    ,logistikkostenzuschlag
    ,ek_netto_bnk     AS ek_netto_bnk
    ,ek_netto_bnk_sachk  AS ek_netto_bnk_sachk
  FROM DBP_DATA.art_gp_wup_zu_per a

  INNER JOIN _kmo_wpuums_dat_min_${TRANSIENT_TABLE_SUFFIX} m
  ON a.dat_bis >= m.dat

/*MANDANT SETZEN */
  WHERE a.mandant_id in (3,8)
) a

INNER JOIN _kmo_wpuums_dat_${TRANSIENT_TABLE_SUFFIX} d
ON d.dat BETWEEN a.dat_von AND a.dat_bis
;

CREATE OR REPLACE TRANSIENT TABLE __vol_artbew_rb  (
  art_id                       INTEGER NOT NULL,
  ean_kasse                    DECIMAL(18,0) NOT NULL,
  wup_id                       INTEGER NOT NULL,
  mandant_id                   BYTEINT NOT NULL,
  bewart_id                    SMALLINT NOT NULL,
  gp_id                        INTEGER NOT NULL,
  einkaufsorganisation_id      SMALLINT NOT NULL,
  nb_id                        SMALLINT NOT NULL,
  dat                          DATE,
  aktion_id                    CHAR(10) COLLATE 'en-ci' NOT NULL,
  herst_id                     INTEGER,
  mwst_id                      BYTEINT,
  menge                        DECIMAL(18,4),
  wrg                          CHAR(3) COLLATE 'en-ci',
  umsatz_netto                 DECIMAL(18,4),
  diff_umsatz_netto_konz       DECIMAL(18,4),
  umsatz_mwst_betrag           DECIMAL(18,4),
  diff_umsatz_mwst_betrag_konz DECIMAL(18,4),
  ek_brutto                    DECIMAL(18,4),
  diff_ek_brutto_konz          DECIMAL(18,4),
  ek_netto                     DECIMAL(18,4),
  diff_ek_netto_konz           DECIMAL(18,4),
  ek_nettonetto                DECIMAL(18,4),
  diff_ek_nettonetto_konz      DECIMAL(18,4),
  ek_kal_basis                 DECIMAL(18,4),
  diff_ek_kal_basis_konz       DECIMAL(18,4),
  ek_mep                       DECIMAL(18,4),
  diff_ek_mep_konz             DECIMAL(18,4),
  einstandspreis               DECIMAL(18,4),
  diff_einstandspreis_konz     DECIMAL(18,4),
  logkostenzuschlag            DECIMAL(18,4),
  diff_logkostenzuschlag_konz  DECIMAL(18,4),
  bezugsweg_id                 BYTEINT,
  ek_netto_bnk                 DECIMAL(18,4),
  diff_ek_netto_bnk_konz       DECIMAL(18,4),
  ek_netto_bnk_sachk           DECIMAL(18,4),
  diff_ek_netto_bnk_sachk_konz DECIMAL(18,4),
  ek_gld                       DECIMAL(18,4),
  diff_ek_gld_konz             DECIMAL(18,4),
  posten_id                    CHAR(2) COLLATE 'en-cs',
  bq_findung_id                BYTEINT,
  promo_fg                     BYTEINT
)
;

CREATE OR REPLACE TRANSIENT TABLE _art_wup_man_spanne_tmp_${TRANSIENT_TABLE_SUFFIX}  (
  mandant_id BYTEINT NOT NULL,
  art_id     INTEGER NOT NULL,
  wup_id     INTEGER NOT NULL,
  nb_id      SMALLINT NOT NULL,
  dat        DATE NOT NULL,
  zwgs       DECIMAL(9,4),
  zwgm       DECIMAL(9,4),
  zwge       DECIMAL(9,4)
) ;

INSERT INTO _art_wup_man_spanne_tmp_${TRANSIENT_TABLE_SUFFIX} (mandant_id,
                                     art_id,
                                     wup_id,
                                     nb_id,
                                     dat,
                                     zwgs,
                                     zwgm,
                                     zwge)
SELECT ein.mandant_id
      ,ein.art_id
      ,-1 AS wup_id
      ,-1 AS nb_id
      ,a.dat
      ,ein.ek_faktor AS zwgs
      ,COALESCE(mep.ek_faktor, ein.ek_faktor) AS zwgm
      ,COALESCE(ekbnk.ek_faktor, mep.ek_faktor, ein.ek_faktor) AS zwge
FROM _kmo_wpuums_dat_${TRANSIENT_TABLE_SUFFIX} a

INNER JOIN DBP_DATA.art_man_spanne_per ein /*Einstandspreis zwingend erforderlich*/
  ON ein.konditionsart_id = 'ZWGS' /*einstandspreis*/
 AND ein.loesch_fg = 0
 AND a.dat BETWEEN ein.dat_von AND ein.dat_bis

LEFT OUTER JOIN DBP_DATA.art_man_spanne_per mep /*optional*/
  ON mep.mandant_id = ein.mandant_id
 AND mep.art_id  = ein.art_id
 AND mep.konditionsart_id = 'ZWGM' /*MEP*/
 AND mep.loesch_fg = 0
 AND a.dat BETWEEN mep.dat_von AND mep.dat_bis

LEFT OUTER JOIN DBP_DATA.art_man_spanne_per ekbnk /*optional*/
  ON ekbnk.mandant_id = ein.mandant_id
 AND ekbnk.art_id  = ein.art_id
 AND ekbnk.konditionsart_id = 'ZWGE' /*eknetto bnk*/
 AND ekbnk.loesch_fg = 0
 AND a.dat BETWEEN ekbnk.dat_von AND ekbnk.dat_bis
;

INSERT INTO _art_wup_man_spanne_tmp_${TRANSIENT_TABLE_SUFFIX} (mandant_id,
                                     art_id,
                                     wup_id,
                                     nb_id,
                                     dat,
                                     zwgs,
                                     zwgm,
                                     zwge)
SELECT ein.mandant_id
      ,ein.art_id
      ,ein.wup_id 
      ,ein.nb_id
      ,a.dat
      ,ein.ek_faktor AS zwgs
      ,COALESCE(mep.ek_faktor, ein.ek_faktor) AS zwgm
      ,COALESCE(ekbnk.ek_faktor, mep.ek_faktor, ein.ek_faktor) AS zwge
FROM _kmo_wpuums_dat_${TRANSIENT_TABLE_SUFFIX} a

INNER JOIN DBP_DATA.art_wup_man_spanne_per ein /*Einstandspreis zwingend erforderlich*/
  ON ein.konditionsart_id = 'ZWGS' /*einstandspreis*/
 AND ein.loesch_fg = 0
 AND a.dat BETWEEN ein.dat_von AND ein.dat_bis

LEFT OUTER JOIN DBP_DATA.art_wup_man_spanne_per mep /*optional*/
  ON mep.mandant_id = ein.mandant_id
 AND mep.wup_id  = ein.wup_id 
 AND mep.art_id  = ein.art_id
 AND mep.konditionsart_id = 'ZWGM' /*MEP*/
 AND mep.loesch_fg = 0
 AND a.dat BETWEEN mep.dat_von AND mep.dat_bis

LEFT OUTER JOIN DBP_DATA.art_wup_man_spanne_per ekbnk /*optional*/
  ON ekbnk.mandant_id = ein.mandant_id
 AND ekbnk.wup_id  = ein.wup_id 
 AND ekbnk.art_id  = ein.art_id
 AND ekbnk.konditionsart_id = 'ZWGE' /*eknetto bnk*/
 AND ekbnk.loesch_fg = 0
 AND a.dat BETWEEN ekbnk.dat_von AND ekbnk.dat_bis
;

DROP TABLE IF EXISTS DBP_ETL.kmo_251_wpuums_art_gp_wup_zu;
CREATE TABLE DBP_ETL.kmo_251_wpuums_art_gp_wup_zu  (
      mandant_id BYTEINT NOT NULL,
      art_id INTEGER NOT NULL,
      wup_id INTEGER NOT NULL,
      nb_id SMALLINT NOT NULL,
      dat DATE NOT NULL,
      bezugsweg_id BYTEINT,
      anz_ek_infosatz SMALLINT,
      anz_ek_orderbuch SMALLINT,
      bq_gp_id INTEGER,
      bq_ekorg SMALLINT,
      bq_findung_id BYTEINT,
      regel_gp_id INTEGER,
      regel_ekorg SMALLINT,
      ref_wup_id INTEGER,
      ref_nb_id SMALLINT,
      kreistyp_gruppe_id CHAR(4) COLLATE 'en-ci',
      wg_id SMALLINT,
      umrechnungskurs FLOAT)
;

INSERT INTO DBP_ETL.kmo_251_wpuums_art_gp_wup_zu

(
   mandant_id
  ,wup_id
  ,nb_id
  ,art_id
  ,dat
  ,bezugsweg_id
  ,anz_ek_infosatz
  ,anz_ek_orderbuch
  ,bq_gp_id
  ,bq_ekorg
  ,bq_findung_id
  ,regel_gp_id
  ,regel_ekorg
  ,ref_wup_id
  ,ref_nb_id
  ,wg_id
  ,kreistyp_gruppe_id
  ,umrechnungskurs 
) 
SELECT 
   a.mandant_id
  ,a.wup_id
  ,a.nb_id
  ,a.art_id
  ,a.dat
  ,a.bezugsweg_id
  ,0 AS anz_ek_infosatz
  ,0 AS anz_ek_orderbuch
  ,a.gp_id AS bq_gp_id
  ,a.einkaufsorganisation_id AS bq_ekorg
   -- Rückbau des Ausstiegspunktes auf den Zustand vor dem Zugriff auf ZEKP
   -- kein Bezugsquellenfindung und man. Spanne auf 0 setzen
   -- Bezugsweg zental: -12
   -- allg. oder betriebsspezifischer Zugriff auf ZEKP: betriebsspezifisch -1
  ,MAX(CASE WHEN bq_findung_id BETWEEN 25 AND 27
        THEN 0
        WHEN bq_findung_id = 28
        THEN 28
        ELSE CASE WHEN bq_findung_id > 1
                  THEN CASE WHEN bezugsweg_id = 4 
   -- bartosiewiczadm - cloud migration
                            -- THEN bq_findung_id - 12 + (bq_findung_id MOD 2) - 1
                            -- ELSE bq_findung_id + (bq_findung_id MOD 2) - 1
                            THEN bq_findung_id - 12 + MOD(bq_findung_id, 2) - 1
                            ELSE bq_findung_id + MOD(bq_findung_id, 2) - 1
                       END 
                  ELSE bq_findung_id 
             END 
   END) AS bq_findung_id_
  ,0 AS regel_gp_id
  ,0 AS regel_ekorg
  ,0 AS ref_wup_id
  ,0 AS ref_nb_id 
  ,0 AS wg_id
  ,'' AS kreistyp_gruppe_id       
  ,k.umrechnungskurs
FROM DBP_ETL.artbew_251 a

-- Kurs merken, damit dieser bei der Anreicherung nicht 
-- ermittelt werden muss
INNER JOIN DBP_DATA.kurs k 
ON k.von_wrg_id = a.wrg
  AND k.kurstyp_id = 9
  AND k.nach_wrg_id = 'EUR'
  AND a.dat BETWEEN k.dat_von AND k.dat_bis
  
GROUP BY 1,2,3,4,5,6,9,10,18 /*Gruppierung wg. Promotion Kennzeichen erforderlich*/
;

INSERT INTO __vol_artbew_rb (mandant_id
                            ,wup_id
                            ,nb_id
                            ,art_id
                            ,ean_kasse 
                            ,gp_id
                            ,einkaufsorganisation_id
                            ,bewart_id
                            ,dat
                            ,aktion_id
                            ,herst_id
                            ,mwst_id
                            ,wrg
                            ,posten_id
                            ,bezugsweg_id
                            ,menge
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
                            ,ek_netto_bnk
                            ,diff_ek_netto_bnk_konz
                            ,ek_netto_bnk_sachk
                            ,diff_ek_netto_bnk_sachk_konz
                            ,ek_gld
                            ,diff_ek_gld_konz
                            ,bq_findung_id      
                            ,promo_fg)
SELECT y.mandant_id
      ,y.wup_id
      ,y.nb_id
      ,y.art_id
      ,y.ean_kasse
      ,y.gp_id
      ,y.einkaufsorganisation_id
      ,y.bewart_id
      ,y.dat
      ,y.aktion_id
      ,y.herst_id
      ,y.mwst_id
      ,y.wrg
      ,y.posten_id
      ,y.bezugsweg_id
      ,y.menge
      ,y.umsatz_netto
      ,y.diff_umsatz_netto_konz
      ,y.umsatz_mwst_betrag
      ,y.diff_umsatz_mwst_betrag_konz
      ,y.ek_brutto_                    AS ek_brutto 
      ,y.diff_ek_brutto_konz_          AS diff_ek_brutto_konz
      ,y.ek_netto_                     AS ek_netto 
      ,y.diff_ek_netto_konz_           AS diff_ek_netto_konz
      ,y.ek_nettonetto_                AS ek_nettonetto 
      ,y.diff_ek_nettonetto_konz_      AS diff_ek_nettonetto_konz     
      ,y.ek_kal_basis_                 AS ek_kal_basis 
      ,y.diff_ek_kal_basis_konz_       AS diff_ek_kal_basis_konz 
      ,y.ek_mep_                       AS ek_mep 
      ,y.diff_ek_mep_konz_             AS diff_ek_mep_konz 
      ,y.einstandspreis_               AS einstandspreis 
      ,y.diff_einstandspreis_konz_     AS diff_einstandspreis_konz 
      ,y.logkostenzuschlag_
      ,y.diff_logkostenzuschlag_konz_
      ,y.ek_netto_bnk_                 AS ek_netto_bnk 
      ,y.diff_ek_netto_bnk_konz_       AS diff_ek_netto_bnk_konz 
      ,y.ek_netto_bnk_sachk_           AS ek_netto_bnk_sachk 
      ,y.diff_ek_netto_bnk_sachk_konz_ AS diff_ek_netto_bnk_sachk_konz 
      ,y.ek_gld 
      ,y.diff_ek_gld_konz
      ,y.bq_findung_id
      ,y.promo_fg
FROM (SELECT a.mandant_id
            ,a.wup_id
            ,a.nb_id
            ,a.art_id
            ,a.ean_kasse
            ,a.gp_id
            ,a.einkaufsorganisation_id
            ,a.bewart_id
            ,a.dat
            ,a.aktion_id
            ,a.herst_id
            ,a.mwst_id
            ,a.wrg
            ,a.posten_id
            ,a.bezugsweg_id
            ,a.menge
            ,a.umsatz_netto
            ,a.diff_umsatz_netto_konz
            ,a.umsatz_mwst_betrag
            ,a.diff_umsatz_mwst_betrag_konz
            ,CASE
               WHEN x.bq_findung_id = 25
               THEN CAST(a.umsatz_netto AS DECIMAL(18,4))
               ELSE COALESCE(/* (1) manuelle Spanne         */ CAST(a.umsatz_netto * COALESCE(ma.zwge, ms.zwge) AS DECIMAL(18,4)),
                             /* (2) EK-Preise ZEKP          */ CAST(a.menge * COALESCE(agw.ek_brutto, agww.ek_brutto) AS DECIMAL(18,4)),
                             /* (3) kein Treffer; 0%-Spanne */ CAST(a.umsatz_netto AS DECIMAL(18,4)))
             END AS ek_brutto_
            ,CASE
               WHEN x.bq_findung_id = 25
               THEN CAST(a.diff_umsatz_netto_konz AS DECIMAL(18,4))
               ELSE COALESCE(/* (1) manuelle Spanne         */ CAST(a.diff_umsatz_netto_konz * COALESCE(ma.zwge, ms.zwge) AS DECIMAL(18,4)),
                             /* (2) EK-Preise ZEKP          */ CAST(ek_brutto_ * z.umrechnungskurs AS DECIMAL(18,4)),
                             /* (3) kein Treffer; 0%-Spanne */ CAST(a.diff_umsatz_netto_konz AS DECIMAL(18,4)))
             END AS diff_ek_brutto_konz_
            ,CASE
               WHEN x.bq_findung_id = 25
               THEN CAST(a.umsatz_netto AS DECIMAL(18,4))
               ELSE COALESCE(/* (1) manuelle Spanne         */ CAST(a.umsatz_netto * COALESCE(ma.zwge, ms.zwge) AS DECIMAL(18,4)),
                             /* (2) EK-Preise ZEKP          */ CAST(a.menge * COALESCE(agw.ek_netto, agww.ek_netto) AS DECIMAL(18,4)),
                             /* (3) kein Treffer; 0%-Spanne */ CAST(a.umsatz_netto AS DECIMAL(18,4)))
             END AS ek_netto_
            ,CASE
               WHEN x.bq_findung_id = 25
               THEN CAST(a.diff_umsatz_netto_konz AS DECIMAL(18,4))
               ELSE COALESCE(/* (1) manuelle Spanne         */ CAST(a.diff_umsatz_netto_konz * COALESCE(ma.zwge, ms.zwge) AS DECIMAL(18,4)),
                             /* (2) EK-Preise ZEKP          */ CAST(ek_netto_ * z.umrechnungskurs AS DECIMAL(18,4)),
                             /* (3) kein Treffer; 0%-Spanne */ CAST(a.diff_umsatz_netto_konz AS DECIMAL(18,4)))
             END AS diff_ek_netto_konz_
            ,CASE
               WHEN x.bq_findung_id = 25
               THEN CAST(a.umsatz_netto AS DECIMAL(18,4))
               ELSE COALESCE(/* (1) manuelle Spanne         */ CAST(a.umsatz_netto * COALESCE(ma.zwge, ms.zwge) AS DECIMAL(18,4)),
                             /* (2) EK-Preise ZEKP          */ CAST(a.menge * COALESCE(agw.ek_nettonetto, agww.ek_nettonetto) AS DECIMAL(18,4)),
                             /* (3) kein Treffer; 0%-Spanne */ CAST(a.umsatz_netto AS DECIMAL(18,4)))
             END AS ek_nettonetto_
            ,CASE
               WHEN x.bq_findung_id = 25
               THEN CAST(a.diff_umsatz_netto_konz AS DECIMAL(18,4))
               ELSE COALESCE(/* (1) manuelle Spanne         */ CAST(a.diff_umsatz_netto_konz * COALESCE(ma.zwge, ms.zwge) AS DECIMAL(18,4)),
                             /* (2) EK-Preise ZEKP          */ CAST(ek_nettonetto_ * z.umrechnungskurs AS DECIMAL(18,4)),
                             /* (3) kein Treffer; 0%-Spanne */ CAST(a.diff_umsatz_netto_konz AS DECIMAL(18,4)))
             END AS diff_ek_nettonetto_konz_
            ,CASE
               WHEN x.bq_findung_id = 25
               THEN CAST(a.umsatz_netto AS DECIMAL(18,4))
               ELSE COALESCE(/* (1) manuelle Spanne         */ CAST(a.umsatz_netto * COALESCE(ma.zwge, ms.zwge) AS DECIMAL(18,4)),
                             /* (2) EK-Preise ZEKP          */ CAST(a.menge * COALESCE(agw.ek_kal_basis, agww.ek_kal_basis) AS DECIMAL(18,4)),
                             /* (3) kein Treffer; 0%-Spanne */ CAST(a.umsatz_netto AS DECIMAL(18,4)))
             END AS ek_kal_basis_
            ,CASE
               WHEN x.bq_findung_id = 25
               THEN CAST(a.diff_umsatz_netto_konz AS DECIMAL(18,4))
               ELSE COALESCE(/* (1) manuelle Spanne         */ CAST(a.diff_umsatz_netto_konz * COALESCE(ma.zwge, ms.zwge) AS DECIMAL(18,4)),
                             /* (2) EK-Preise ZEKP          */ CAST(ek_kal_basis_ * z.umrechnungskurs AS DECIMAL(18,4)),
                             /* (3) kein Treffer; 0%-Spanne */ CAST(a.diff_umsatz_netto_konz AS DECIMAL(18,4)))
             END AS diff_ek_kal_basis_konz_                
            ,CASE
               WHEN x.bq_findung_id = 25
               THEN CAST(a.umsatz_netto AS DECIMAL(18,4))
               ELSE COALESCE(/* (1) manuelle Spanne         */ CAST(a.umsatz_netto * COALESCE(ma.zwge, ms.zwge) AS DECIMAL(18,4)),
                             /* (2) EK-Preise ZEKP          */ CAST(a.menge * COALESCE(agw.ek_mep, agww.ek_mep) AS DECIMAL(18,4)),
                             /* (3) kein Treffer; 0%-Spanne */ CAST(a.umsatz_netto AS DECIMAL(18,4)))
             END AS ek_mep_
            ,CASE
               WHEN x.bq_findung_id = 25
               THEN CAST(a.diff_umsatz_netto_konz AS DECIMAL(18,4))
               ELSE COALESCE(/* (1) manuelle Spanne         */ CAST(a.diff_umsatz_netto_konz * COALESCE(ma.zwge, ms.zwge) AS DECIMAL(18,4)),
                             /* (2) EK-Preise ZEKP          */ CAST(ek_mep_ * z.umrechnungskurs AS DECIMAL(18,4)),
                             /* (3) kein Treffer; 0%-Spanne */ CAST(a.diff_umsatz_netto_konz AS DECIMAL(18,4)))
             END AS diff_ek_mep_konz_                 
            ,CASE
               WHEN x.bq_findung_id = 25
               THEN CAST(a.umsatz_netto AS DECIMAL(18,4))
               ELSE COALESCE(/* (1) manuelle Spanne         */ CAST(a.umsatz_netto * COALESCE(ma.zwge, ms.zwge) AS DECIMAL(18,4)),
                             /* (2) EK-Preise ZEKP          */ CAST(a.menge * COALESCE(agw.einstandspreis, agww.einstandspreis) AS DECIMAL(18,4)),
                             /* (3) kein Treffer; 0%-Spanne */ CAST(a.umsatz_netto AS DECIMAL(18,4)))
             END AS einstandspreis_
            ,CASE
               WHEN x.bq_findung_id = 25
               THEN CAST(a.diff_umsatz_netto_konz AS DECIMAL(18,4))
               ELSE COALESCE(/* (1) manuelle Spanne         */ CAST(a.diff_umsatz_netto_konz * COALESCE(ma.zwge, ms.zwge) AS DECIMAL(18,4)),
                             /* (2) EK-Preise ZEKP          */ CAST(einstandspreis_ * z.umrechnungskurs AS DECIMAL(18,4)),
                             /* (3) kein Treffer; 0%-Spanne */ CAST(a.diff_umsatz_netto_konz AS DECIMAL(18,4)))
             END AS diff_einstandspreis_konz_
            ,menge * COALESCE(agw.logistikkostenzuschlag, agww.logistikkostenzuschlag, 0.0000) AS logkostenzuschlag_
            ,logkostenzuschlag_ * z.umrechnungskurs AS diff_logkostenzuschlag_konz_
            ,CASE
               WHEN x.bq_findung_id = 25
               THEN CAST(a.umsatz_netto AS DECIMAL(18,4))
               ELSE COALESCE(/* (1) manuelle Spanne         */ CAST(a.umsatz_netto * COALESCE(ma.zwge, ms.zwge) AS DECIMAL(18,4)),
                             /* (2) EK-Preise ZEKP          */ CAST(a.menge * COALESCE(agw.ek_netto_bnk, agww.ek_netto_bnk) AS DECIMAL(18,4)),
                             /* (3) kein Treffer; 0%-Spanne */ CAST(a.umsatz_netto AS DECIMAL(18,4)))
             END AS ek_netto_bnk_
            ,CASE
               WHEN x.bq_findung_id = 25
               THEN CAST(a.diff_umsatz_netto_konz AS DECIMAL(18,4))
               ELSE COALESCE(/* (1) manuelle Spanne         */ CAST(a.diff_umsatz_netto_konz * COALESCE(ma.zwge, ms.zwge) AS DECIMAL(18,4)),
                             /* (2) EK-Preise ZEKP          */ CAST(ek_netto_bnk_ * z.umrechnungskurs AS DECIMAL(18,4)),
                             /* (3) kein Treffer; 0%-Spanne */ CAST(a.diff_umsatz_netto_konz AS DECIMAL(18,4)))
             END AS diff_ek_netto_bnk_konz_
            ,CASE
               WHEN x.bq_findung_id = 25
               THEN CAST(a.umsatz_netto AS DECIMAL(18,4))
               ELSE COALESCE(/* (1) manuelle Spanne         */ CAST(a.umsatz_netto * COALESCE(ma.zwge, ms.zwge) AS DECIMAL(18,4)),
                             /* (2) EK-Preise ZEKP          */ CAST(a.menge * COALESCE(agw.ek_netto_bnk_sachk, agww.ek_netto_bnk_sachk) AS DECIMAL(18,4)),
                             /* (3) kein Treffer; 0%-Spanne */ CAST(a.umsatz_netto AS DECIMAL(18,4)))
             END AS ek_netto_bnk_sachk_
            ,CASE
               WHEN x.bq_findung_id = 25
               THEN CAST(a.diff_umsatz_netto_konz AS DECIMAL(18,4))
               ELSE COALESCE(/* (1) manuelle Spanne         */ CAST(a.diff_umsatz_netto_konz * COALESCE(ma.zwge, ms.zwge) AS DECIMAL(18,4)),
                             /* (2) EK-Preise ZEKP          */ CAST(ek_netto_bnk_sachk_ * z.umrechnungskurs AS DECIMAL(18,4)),
                             /* (3) kein Treffer; 0%-Spanne */ CAST(a.diff_umsatz_netto_konz AS DECIMAL(18,4)))
             END AS diff_ek_netto_bnk_sachk_konz_
            ,a.ek_gld 
            ,a.diff_ek_gld_konz
            ,CASE
               WHEN a.bq_findung_id = 28
               THEN 28
               ELSE COALESCE(x.bq_findung_id, 30)
             END AS bq_findung_id
            ,a.promo_fg
      FROM DBP_ETL.artbew_251 a
      
      INNER JOIN _kmo_wpuums_dat_${TRANSIENT_TABLE_SUFFIX} d
      ON a.dat = d.dat
        
      INNER JOIN DBP_ETL.kmo_251_wpuums_art_gp_wup_zu z
        ON a.mandant_id = z.mandant_id
       AND a.art_id = z.art_id
       AND a.wup_id = z.wup_id
       AND a.nb_id = z.nb_id
       AND a.dat = z.dat
          
      -- Lieferant und Ausstiegspunkt ermitteln
      LEFT OUTER JOIN DBP_DATA.art_gp_nm_zu_per x
      ON a.mandant_id = x.mandant_id
        AND a.wup_id = x.wup_id
        AND a.art_id = x.art_id 
        AND a.dat BETWEEN x.dat_von AND x.dat_bis 
          
      -- Betriebsspezifischer EK Preis 
      LEFT OUTER JOIN __vol_art_gp_wup_zu_per agw
      ON x.mandant_id   = agw.mandant_id 
        AND x.vz_wup_id = agw.wup_id 
        AND x.art_id    = agw.art_id
        AND a.gp_id     = agw.gp_id 
        AND a.dat       = agw.dat
        
      -- Betriebsuebergreifender EK Preis
      LEFT OUTER JOIN __vol_art_gp_wup_zu_per agww
      ON x.mandant_id = agww.mandant_id 
        AND -1        = agww.wup_id 
        AND x.art_id  = agww.art_id
        AND a.gp_id   = agww.gp_id 
        AND a.dat     = agww.dat
        
      -- Ermittlung betriebsuebergreifernde manuelle Spannenfaktoren
      LEFT OUTER JOIN _art_wup_man_spanne_tmp_${TRANSIENT_TABLE_SUFFIX} ms
      ON a.mandant_id = ms.mandant_id
        AND a.art_id  = ms.art_id
        AND ms.wup_id = -1
        AND a.dat = ms.dat
        AND a.bq_findung_id = 27
      
      -- Ermittlung Betriebsspezifischer manuelle Spannefaktoren
      LEFT OUTER JOIN _art_wup_man_spanne_tmp_${TRANSIENT_TABLE_SUFFIX} ma
      ON a.mandant_id = ma.mandant_id
        AND a.art_id = ma.art_id
        AND a.wup_id = ma.wup_id
        AND a.dat    = ma.dat
        AND a.bq_findung_id = 26) y
;

UPDATE __vol_artbew_rb 
SET gp_id = b.gp_id,
    bezugsweg_id = b.bezugsweg_id,
    ek_gld = b.ek_gld,
    diff_ek_gld_konz = b.diff_ek_gld_konz

FROM (SELECT *
                             FROM DBP_DATA.artbew
                             WHERE (mandant_id, wup_id, dat)
         in (select mandant_id, wup_id,dat from DBP_DATA.artbew_agg_wt
             where mandant_id in (3,8)) ) b
 WHERE __vol_artbew_rb.wup_id = b.wup_id AND
      __vol_artbew_rb.art_id = b.art_id AND
      __vol_artbew_rb.bewart_id = b.bewart_id AND
      __vol_artbew_rb.ean_kasse = b.ean_kasse AND
	  __vol_artbew_rb.promo_fg = b.promo_fg AND
      __vol_artbew_rb.dat = b.dat AND
      __vol_artbew_rb.mandant_id = b.mandant_id
;

UPDATE __vol_artbew_rb SET aktion_id = ''
WHERE aktion_id = '   0      ';

UPDATE __vol_artbew_rb 
SET gp_id = b.gp_id_neu

FROM (SELECT a.*,
                                    b.gp_id AS gp_id_neu
                             FROM __vol_artbew_rb a
                             JOIN DBP_DATA.art_gp_zu_per b
                               ON a.mandant_id = b.mandant_id AND
                                  a.art_id = b.art_id AND
	                              b.dat_bis = to_date('9999-12-31','YYYY-MM-DD')
                             WHERE a.gp_id = -1) b
							  WHERE __vol_artbew_rb.mandant_id = b.mandant_id AND
      __vol_artbew_rb.dat = b.dat AND
	  __vol_artbew_rb.wup_id = b.wup_id AND
	  __vol_artbew_rb.art_id = b.art_id AND
	  __vol_artbew_rb.bewart_id = b.bewart_id AND
      __vol_artbew_rb.ean_kasse = b.ean_kasse
;

UPDATE __vol_artbew_rb 
SET bezugsweg_id = b.bezugsweg_id_neu

FROM (SELECT a.*,
                                    b.bezugsweg_id AS bezugsweg_id_neu
                             FROM __vol_artbew_rb a
                             JOIN DBP_DATA.art_wup_zu_per b
                               ON a.mandant_id = b.mandant_id AND
                                  a.art_id = b.art_id AND
								  a.wup_id = b.wup_id AND
	                              b.dat_bis = to_date('9999-12-31','YYYY-MM-DD')
                             WHERE a.bezugsweg_id = 0) b
							  WHERE __vol_artbew_rb.mandant_id = b.mandant_id AND
      __vol_artbew_rb.dat = b.dat AND
	  __vol_artbew_rb.wup_id = b.wup_id AND
	  __vol_artbew_rb.art_id = b.art_id AND
	  __vol_artbew_rb.bewart_id = b.bewart_id AND
      __vol_artbew_rb.ean_kasse = b.ean_kasse
;

DELETE FROM DBP_DATA.artbew
WHERE bewart_id <>1010
and
 (mandant_id, wup_id, dat) in
(select mandant_id, wup_id,dat from 
__vol_artbew_rb )

;

INSERT INTO DBP_DATA.artbew
(
   mandant_id
  ,wup_id
  ,nb_id
  ,art_id
  ,ean_kasse
  ,gp_id
  ,einkaufsorganisation_id
  ,bewart_id
  ,dat
  ,aktion_id
  ,herst_id
  ,mwst_id
  ,wrg
  ,posten_id
  ,bezugsweg_id
  ,menge
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
  ,ek_netto_bnk
  ,diff_ek_netto_bnk_konz
  ,ek_netto_bnk_sachk
  ,diff_ek_netto_bnk_sachk_konz
  ,ek_gld
  ,diff_ek_gld_konz
  ,bq_findung_id
  ,promo_fg 
    ,bewart_det_id
  ,pv_aktion_bby
  ,pv_aktion_kdn_bby
  ,pv_aktion_kdp_bby
  ,pv_bby
  ,pv_kdn_bby
  ,pv_kdp_bby
)
SELECT
   mandant_id
  ,wup_id
  ,nb_id
  ,art_id
  ,ean_kasse
  ,gp_id
  ,einkaufsorganisation_id
  ,bewart_id
  ,dat
  ,aktion_id
  ,herst_id
  ,mwst_id
  ,wrg
  ,posten_id
  ,bezugsweg_id
  ,menge
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
  ,ek_netto_bnk                 
  ,diff_ek_netto_bnk_konz       
  ,ek_netto_bnk_sachk          
  ,diff_ek_netto_bnk_sachk_konz 
  ,ek_gld
  ,diff_ek_gld_konz
  ,bq_findung_id
  ,promo_fg
  ,9999 AS bewart_det_id
  ,0 AS pv_aktion_bby
  ,0 AS pv_aktion_kdn_bby
  ,0 AS pv_aktion_kdp_bby
  ,0 AS pv_bby
  ,0 AS pv_kdn_bby
  ,0 AS pv_kdp_bby
FROM __vol_artbew_rb;

DROP TABLE IF EXISTS DBP_ETL.kmo_artbew_bon_delta;
DROP TABLE IF EXISTS DBP_ETL.artbew_kmo_tmp;
DROP TABLE IF EXISTS DBP_ETL.kmo_artbew_bon_aktion_relevant;

