CREATE OR REPLACE TABLE DBP_ETL.artbew_mis_1  (
      mandant_id BYTEINT,
      art_id INTEGER NOT NULL,
      wup_id INTEGER NOT NULL,
      nb_id SMALLINT,
      wg_id SMALLINT,
      arthiertyp_id BYTEINT,
      bewart_id SMALLINT,
      dat DATE,
      menge DECIMAL(18,4),
      wrg_1 CHAR(3) COLLATE 'en-ci',
      umsatz_netto DECIMAL(18,4),
      diff_umsatz_netto_konz DECIMAL(18,4) ,
      umsatz_mwst_betrag DECIMAL(18,4),
      diff_umsatz_mwst_betrag_konz DECIMAL(18,4) 
);

CREATE OR REPLACE TRANSIENT TABLE _artbew_tmp  (
  art_id                  INTEGER NOT NULL,
  wup_id                  INTEGER NOT NULL,
  mandant_id              BYTEINT NOT NULL,
  bewart_id               SMALLINT NOT NULL,
  gp_id                   INTEGER,
  einkaufsorganisation_id SMALLINT,
  nb_id                   SMALLINT NOT NULL,
  dat                     DATE NOT NULL,
  aktion_id               CHAR(10) COLLATE 'en-ci' NOT NULL,
  ean_kasse               DECIMAL(26,0) NOT NULL,
  herst_id                INTEGER,
  wg_id                   INTEGER,
  mwst_id                 BYTEINT,
  menge                   DECIMAL(18,4) ,
  wrg_1                     CHAR(3) COLLATE 'en-ci',
  umsatz_netto            DECIMAL(18,4),
  umsatz_mwst_betrag      DECIMAL(18,4),
  ek_brutto               DECIMAL(18,4),
  ek_netto                DECIMAL(18,4),
  ek_nettonetto           DECIMAL(18,4),
  ek_kal_basis            DECIMAL(18,4),
  ek_mep                  DECIMAL(18,4),
  einstandspreis          DECIMAL(18,4),
  logkostenzuschlag       DECIMAL(18,4),
  bezugsweg_id            BYTEINT,
  ek_netto_bnk            DECIMAL(18,4),
  ek_netto_bnk_sachk      DECIMAL(18,4),
  posten_id               CHAR(2) COLLATE 'en-cs',
  bewart_det_id           INTEGER NOT NULL,
  standard_aktion_id      CHAR(10) COLLATE 'en-ci'
);

CREATE OR REPLACE TRANSIENT TABLE _artbew_tmp2  (
  art_id                  INTEGER NOT NULL,
  wup_id                  INTEGER NOT NULL,
  mandant_id              BYTEINT NOT NULL,
  bewart_id               SMALLINT NOT NULL,
  gp_id                   INTEGER,
  einkaufsorganisation_id SMALLINT,
  nb_id                   SMALLINT NOT NULL,
  dat                     DATE NOT NULL,
  aktion_id               CHAR(10) COLLATE 'en-ci' NOT NULL,
  ean_kasse               DECIMAL(26,0) NOT NULL,
  herst_id                INTEGER,
  wg_id                   INTEGER,
  mwst_id                 BYTEINT,
  menge                   DECIMAL(18,4) ,
  wrg_1                     CHAR(3) COLLATE 'en-ci',
  umsatz_netto            DECIMAL(18,4),
  umsatz_mwst_betrag      DECIMAL(18,4),
  ek_brutto               DECIMAL(18,4),
  ek_netto                DECIMAL(18,4),
  ek_nettonetto           DECIMAL(18,4),
  ek_kal_basis            DECIMAL(18,4),
  ek_mep                  DECIMAL(18,4),
  einstandspreis          DECIMAL(18,4),
  logkostenzuschlag       DECIMAL(18,4),
  bezugsweg_id            BYTEINT,
  ek_netto_bnk            DECIMAL(18,4),
  ek_netto_bnk_sachk      DECIMAL(18,4),
  posten_id               CHAR(2) COLLATE 'en-cs',
  bewart_det_id           INTEGER NOT NULL,
  kundenkarte_id          VARCHAR(255) COLLATE 'en-ci'
);

CREATE OR REPLACE TRANSIENT TABLE _artbew_tmp_anr  (
  art_id                  INTEGER NOT NULL,
  mandant_id              BYTEINT NOT NULL,
  gp_id                   INTEGER,
  faktor_fg               SMALLINT,
  wg_id                   INTEGER,
  einkaufsorganisation_id SMALLINT,
  dat                     DATE NOT NULL,
  herst_id                INTEGER,
  zekp_dat_von            DATE, 
  ek_brutto               DECIMAL(18,4),
  ek_netto                DECIMAL(18,4),
  ek_nettonetto           DECIMAL(18,4),
  ek_kal_basis            DECIMAL(18,4),
  ek_mep                  DECIMAL(18,4),
  einstandspreis          DECIMAL(18,4),
  logkostenzuschlag       DECIMAL(18,4),
  bezugsweg_id            BYTEINT,
  ek_netto_bnk            DECIMAL(18,4),
  ek_netto_bnk_sachk      DECIMAL(18,4)
);

-- -dbay-, 20.11.2023
--
-- neue logik

INSERT INTO _artbew_tmp
(
   mandant_id
  ,wrg_1
  ,wup_id
  ,nb_id
  ,dat
  ,posten_id
  ,bezugsweg_id
  ,art_id
  ,ean_kasse 
  ,bewart_id
  ,mwst_id
  ,aktion_id
  ,menge
  ,umsatz_mwst_betrag
  ,umsatz_netto
  ,bewart_det_id
  ,standard_aktion_id
)
SELECT 
   p.mandant_id
  ,'EUR' as wrg_1
  ,p.wup_id
  ,w.nb_id
  ,p.dat
  ,COALESCE(a.posten_id,'') AS posten_id
  ,COALESCE(aw.bezugsweg_id, p.bezugsweg_id) /*fuehrend */
  ,COALESCE(a.art_id, erf.art_id, 0)
  ,COALESCE(p.ean_kasse, 0)          AS ean_kasse 
  ,p.bewart_id
  ,COALESCE(mw.mwst_id, mws.mwst_id) /*fuehrend MWST aus Bondaten*/ 
  ,p.aktion_id
  ,SUM(p.menge) AS menge_
  ,SUM(p.umsatz /(1 + COALESCE(mw.mwst, mws.mwst) / 100)*(COALESCE(mw.mwst, mws.mwst) / 100)) AS umsatz_mwst_betrag
  ,SUM(p.umsatz) - umsatz_mwst_betrag AS umsatz_netto
  ,p.bewart_det_id
  ,'' as standard_aktion_id
FROM
(
  SELECT
        mandant_id
        ,wup_id
        ,dat
        ,kl_art_id
        ,ean_kasse
        ,wg_id
        ,CAST(umsatz_brutto AS FLOAT) AS umsatz
        ,mwst_id
        ,menge
        ,CASE WHEN LTRIM(aktion_id) IN ('0','0000000000','')
              THEN 1001 /*aktoinsfrei*/
              ELSE 1002 /*Sonderaktion*/
              END AS bewart_id
        ,CASE WHEN LTRIM(aktion_id) IN ('0','0000000000','')
              THEN ''
              ELSE aktion_id
              END AS aktion_id
        ,4 AS bezugsweg_id /*Initialisierung, im Anschluss erfolgt Ermittlung ueber MARC_1*/
        ,CASE 
           when ltrim(aktion_id) in ('0','0000000000','') and
              ((kundenkarte_id is null and kundenkarte_typ_id in (0)) or 
                kundenkarte_typ_id IN (3,4))
            then 100110
            ELSE 
             CASE 
               WHEN LTRIM(aktion_id) IN ('0','0000000000','')
                    AND kundenkarte_id IS NOT NULL
                    AND kundenkarte_typ_id IN (2)
              THEN 100111  
              ELSE CASE WHEN LTRIM(bby_aktion) IN ('0','0000000000','') 
                    AND bby_bewart = 1 
                    AND bonuskauf_id is not null  
                    AND customer_promotion_fg = 0  
                    AND trim(promotion_art) = 'COMMON'  
                    AND (((kundenkarte_id is null and kundenkarte_typ_id in (0)) or (kundenkarte_typ_id in (3,4)) or trim(kundenkarte_id) is not null) or ((kundenkarte_typ_id in (1,2) and kundenkarte_id is not null) or trim(kundenkarte_id) is not null))
              THEN 100130
              WHEN LTRIM(bby_aktion) IN ('0','0000000000','') 
                    AND bby_bewart = 1 
                    AND kundenkarte_id is not null  
                    AND kundenkarte_typ_id in (2)  
                    AND ((customer_promotion_fg = 1 and trim(promotion_art) = 'CUSTOMER') or(customer_promotion_fg = 1 and trim(promotion_art) = 'PERSONAL') or (customer_promotion_fg = 0 and trim(promotion_art) = 'COMMON'))
              THEN 100131  
              WHEN LTRIM(aktion_id) NOT IN ('0','0000000000','') and
                 ((kundenkarte_id is null and kundenkarte_typ_id in (0)) or 
                   kundenkarte_typ_id IN (3,4)) AND 
                   aktion_id_obv IS NOT NULL AND 
                  (bonuskauf_id IS NULL OR bonuskauf_id = 0)
              THEN 100210
              ELSE
                CASE 
                  WHEN LTRIM(aktion_id) NOT IN ('0','0000000000','')
                       AND kundenkarte_id IS NOT NULL
                       AND kundenkarte_typ_id IN (2)
                       AND aktion_id_obv IS NOT NULL
                       AND (( (important = 'N' or important is null) and bonuskauf_id is not null) or ( (important = 'Y' or important is null) and (bonuskauf_id is null or bonuskauf_id = 0)))
                  THEN 100211
                  ELSE
                    CASE
                      WHEN LTRIM(aktion_id) NOT IN ('0','0000000000','')
                           AND bonuskauf_id IS NOT NULL
                           and ((kundenkarte_id is null and kundenkarte_typ_id in (0)) or 
                                 kundenkarte_typ_id IN (3,4))
                           AND customer_promotion_fg = 0
                           AND promotion_art = 'COMMON'
                      THEN 100220
                      ELSE
                        CASE
                          WHEN LTRIM(aktion_id) NOT IN ('0','0000000000','')
                               AND bonuskauf_id IS NOT NULL
                               AND kundenkarte_id IS NOT NULL
                               AND kundenkarte_typ_id IN (2) 
                               AND customer_promotion_fg = 0
                               AND promotion_art = 'COMMON'
                          THEN 100221
                          ELSE
                            CASE
                              WHEN LTRIM(aktion_id) NOT IN ('0','0000000000','')
                                   AND bonuskauf_id IS NOT NULL
                                   AND customer_promotion_fg = 1
                                   AND promotion_art = 'CUSTOMER'
                              THEN 100231
                              ELSE
                                CASE
                                  WHEN LTRIM(aktion_id) NOT IN ('0','0000000000','')
                                       AND bonuskauf_id IS NOT NULL
                                       AND customer_promotion_fg = 1
                                       AND promotion_art = 'PERSONAL'
                                  THEN 100241
                                  ELSE 9999
                                END
                            END
                        END
                    END
                END
            END
        END
	END AS bewart_det_id
FROM dbp_etl.bon_artbew_tmp_talon_1
where dat >= '2022-04-01' and
      wg_id not in (822)
) p

-- Ermittlung nb_id
INNER JOIN DBP_DATA.wup_1 w
ON w.mandant_id = p.mandant_id 
  AND w.wup_id = p.wup_id

-- Ermittlung art_id
LEFT OUTER JOIN 
(
  SELECT 
     mandant_id
    ,art_id
    ,kl_art_id
    ,posten_id
    ,mwst_id 
  FROM DBP_DATA.art_1 
  QUALIFY row_number() OVER (PARTITION BY mandant_id,kl_art_id ORDER BY art_id DESC) = 1
) a
ON p.kl_art_id = a.kl_art_id
  AND p.mandant_id = a.mandant_id 

-- Ermittlung art_id für unbekannte Artikel_1 und alle Artikel_1, 
-- deren Kassen-wg nicht mit der wg_id arthiertyp_1 2 der Stammdaten übereinstimmt
LEFT OUTER JOIN DBP_ETL_PROCESS.dwh_wg_erfass_artikel_1 erf
ON p.mandant_id = erf.mandant_id 
  AND p.wg_id = erf.wg_id
  AND erf.arthiertyp_id = 2
  
-- Ermittlung MWST ID fuer Artikel_1 der WG Erfassung 
LEFT OUTER JOIN DBP_DATA.art_1 aerf
ON erf.mandant_id = aerf.mandant_id 
  AND erf.art_id = aerf.art_id 

-- Ermittlung der MWST-ID aus den Bondaten (fuehrend) 
LEFT OUTER JOIN DBP_DATA.mwst_per_1 mw
ON mw.mandant_id = p.mandant_id 
  AND p.dat BETWEEN mw.dat_von AND mw.dat_bis
  AND p.mwst_id = mw.mwst_id
  AND COALESCE(mw.mwst, 0) <> 0 

-- Ermittlung der MWST-ID aus den Stammdaten (falls in Bondaten nicht korrekt gepflegt
LEFT OUTER JOIN DBP_DATA.mwst_per_1 mws
ON mws.mandant_id = p.mandant_id 
  AND p.dat BETWEEN mws.dat_von AND mws.dat_bis
  AND COALESCE(a.mwst_id, aerf.mwst_id) = mws.mwst_id
    
-- Ermittlung des Bezugsweges (Default ist 4) aus Stammdaten
LEFT OUTER JOIN DBP_DATA.art_wup_zu_per_1  aw
ON p.mandant_id = aw.mandant_id
  AND p.wup_id = aw.wup_id
  -- Artikelnummer aus Stammdaten!!! s.o.
  AND COALESCE(a.art_id, erf.art_id, 0) = aw.art_id 
  AND p.dat BETWEEN aw.dat_von AND aw.dat_bis     

GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,16,17
HAVING (menge_ <> 0 OR umsatz_netto <> 0)
;

create or replace volatile table _artbew_822 as (
select a.*,
       888888 as bewart_det_id
FROM dbp_etl.bon_artbew_tmp_talon_1 a
where dat >= '2022-04-01' and
      wg_id in (822)
);

update _artbew_822 set bewart_det_id = 100111
where important = 'B'
;

create or replace volatile table _track_personal as (
select a.mandant_id,
       a.bon_id,
       a.bon_zeile,
       a.bon_dat,
       a.wup_id,
       a.promotion_art,
       max(b.anz) as anz,
       count(*) as anz_zeilen,
       max(b.bonrabatt) as bonrabatt
from dbp_ods.ods_promotion_1 a
join (select mandant_id,
             bon_id,
             bon_zeile,
             bon_dat,
             wup_id,
             count(distinct promotion_art) as anz,
             max(case when konditionsart_id in ('ZBON','ZBOV') then 1 else 0 end) as bonrabatt
      from dbp_ods.ods_promotion_1
      group by 1,2,3,4,5) b
  on a.mandant_id = b.mandant_id and
     a.bon_id = b.bon_id and
     a.bon_zeile = b.bon_zeile and
     a.bon_dat = b.bon_dat and
     a.wup_id = b.wup_id
where (a.mandant_id,a.bon_id,a.bon_zeile,a.bon_dat,a.wup_id) in (select mandant_id,
                                                                        bon_id,
                                                                        bon_zeile,
                                                                        bon_dat,
                                                                        wup_id
                                                                 from dbp_ods.ods_promotion_1
                                                                 where promotion_art = 'PERSONAL'
                                                                 group by 1,2,3,4,5) and
       a.konditionsart_id not in ('ZRT3','ZTAG','ZGEB')
group by 1,2,3,4,5,6
);

-- 1. Update fuer 100231
update _artbew_822 from (select mandant_id,
                                           bon_id,
                                           bon_zeile,
                                           wup_id,
                                           bon_dat
                                    from _track_personal
                                    where promotion_art = 'CUSTOMER'
                                    group by 1,2,3,4,5) b
                                    
set bewart_det_id = 100231

where _artbew_822.wup_id = b.wup_id and 
      _artbew_822.mandant_id = b.mandant_id and 
      _artbew_822.dat = b.bon_dat and 
      _artbew_822.bon_id = b.bon_id and
      _artbew_822.bon_zeile = b.bon_zeile and
      _artbew_822.bewart_det_id = 888888 and
      _artbew_822.wg_id = 822
;

update _artbew_822 from (select mandant_id,
                                           bon_id,
                                           bon_zeile,
                                           wup_id,
                                           bon_dat
                                    from _track_personal
                                    where (promotion_art = 'PERSONAL' and
                                           anz = 1) or
                                          (promotion_art = 'PERSONAL' and
                                           bonrabatt = 1)
                                    group by 1,2,3,4,5) b
                                    
set bewart_det_id = 100211

where _artbew_822.wup_id = b.wup_id and 
      _artbew_822.mandant_id = b.mandant_id and 
      _artbew_822.dat = b.bon_dat and 
      _artbew_822.bon_id = b.bon_id and
      _artbew_822.bon_zeile = b.bon_zeile and
      _artbew_822.bewart_det_id = 888888 and
      _artbew_822.bby_aktion <> '' and
      _artbew_822.kundenkarte_id is not null and
      _artbew_822.wg_id = 822
;

-- 2. Update fuer 100221
update _artbew_822 from (select mandant_id,
                                           bon_id,
                                           bon_zeile,
                                           wup_id,
                                           bon_dat
                                    from _track_personal
                                    where promotion_art = 'COMMON'
                                    group by 1,2,3,4,5) b
                                    
set bewart_det_id = 100221

where _artbew_822.wup_id = b.wup_id and 
      _artbew_822.mandant_id = b.mandant_id and 
      _artbew_822.dat = b.bon_dat and 
      _artbew_822.bon_id = b.bon_id and
      _artbew_822.bon_zeile = b.bon_zeile and
      _artbew_822.bewart_det_id = 888888 and
      _artbew_822.wg_id = 822
;

-- 3. Update fuer 100211
update _artbew_822 from (select mandant_id,
                                           bon_id,
                                           bon_zeile,
                                           wup_id,
                                           bon_dat
                                    from _track_personal
                                    where promotion_art = 'PERSONAL_SMP'
                                    group by 1,2,3,4,5) b
                                    
set bewart_det_id = 100211

where _artbew_822.wup_id = b.wup_id and 
      _artbew_822.mandant_id = b.mandant_id and 
      _artbew_822.dat = b.bon_dat and 
      _artbew_822.bon_id = b.bon_id and
      _artbew_822.bon_zeile = b.bon_zeile and
      _artbew_822.bewart_det_id = 888888 and
      _artbew_822.bby_aktion <> '' and
      _artbew_822.wg_id = 822
;

update _artbew_822 from (select mandant_id,
                                           bon_id,
                                           bon_zeile,
                                           wup_id,
                                           bon_dat
                                    from _track_personal
                                    where promotion_art = 'PERSONAL' and
                                          anz_zeilen > 1 and
                                          anz = 1 and
                                          bonrabatt = 0
                                    group by 1,2,3,4,5) b
                                    
set bewart_det_id = 100241

where _artbew_822.wup_id = b.wup_id and 
      _artbew_822.mandant_id = b.mandant_id and 
      _artbew_822.dat = b.bon_dat and 
      _artbew_822.bon_id = b.bon_id and
      _artbew_822.bon_zeile = b.bon_zeile and
      _artbew_822.bewart_det_id = 888888 and
      _artbew_822.bby_aktion <> '' and
      _artbew_822.wg_id = 822
;

-- 4. Update fuer 100131

update _artbew_822 from (select mandant_id,
                                           bon_id,
                                           bon_zeile,
                                           wup_id,
                                           bon_dat
                                    from _track_personal
                                    where promotion_art in ('PERSONAL','PERSONAL_SMP','CUSTOMER','COMMON') and
                                          bonrabatt = 1
                                    group by 1,2,3,4,5) b
                                    
set bewart_det_id = 100131

where _artbew_822.wup_id = b.wup_id and 
      _artbew_822.mandant_id = b.mandant_id and 
      _artbew_822.dat = b.bon_dat and 
      _artbew_822.bon_id = b.bon_id and
      _artbew_822.bon_zeile = b.bon_zeile and
      _artbew_822.bewart_det_id = 888888 and
      _artbew_822.bby_aktion = '' and
      _artbew_822.wg_id = 822
;

-- 5. Update fuer 100121

update _artbew_822 from (select mandant_id,
                                           bon_id,
                                           bon_zeile,
                                           wup_id,
                                           bon_dat
                                    from _track_personal
                                    where promotion_art in ('PERSONAL_SMP')
                                    group by 1,2,3,4,5) b
                                    
set bewart_det_id = 100121

where _artbew_822.wup_id = b.wup_id and 
      _artbew_822.mandant_id = b.mandant_id and 
      _artbew_822.dat = b.bon_dat and 
      _artbew_822.bon_id = b.bon_id and
      _artbew_822.bon_zeile = b.bon_zeile and
      _artbew_822.bewart_det_id = 888888 and
      _artbew_822.bby_aktion = '' and
      _artbew_822.wg_id = 822
;

-- 6. Update fuer 100211

update _artbew_822 from (select mandant_id,
                                           bon_id,
                                           bon_zeile,
                                           wup_id,
                                           bon_dat
                                    from _track_personal
                                    group by 1,2,3,4,5) b
                                    
set bewart_det_id = 100211

where _artbew_822.wup_id = b.wup_id and 
      _artbew_822.mandant_id = b.mandant_id and 
      _artbew_822.dat = b.bon_dat and 
      _artbew_822.bon_id = b.bon_id and
      _artbew_822.bon_zeile = b.bon_zeile and
      _artbew_822.bewart_det_id = 888888 and
      _artbew_822.bby_aktion <> '' and
      _artbew_822.wg_id = 822
;

create or replace volatile table _snap_822 as (
select p.mandant_id
      ,'EUR' as wrg_1
      ,p.wup_id
      ,w.nb_id
      ,p.dat
      ,coalesce(a.posten_id,'') as posten_id
      ,coalesce(aw.bezugsweg_id, p.bezugsweg_id) as bezugsweg_id
      ,coalesce(a.art_id, erf.art_id, 0) as art_id
      ,coalesce(p.ean_kasse, 0) as ean_kasse 
      ,p.bewart_id
      ,coalesce(mw.mwst_id, mws.mwst_id) as mwst_id
      ,p.aktion_id
      ,sum(p.menge) as menge_
      ,sum(p.umsatz /(1 + coalesce(mw.mwst, mws.mwst) / 100)*(coalesce(mw.mwst, mws.mwst) / 100)) as umsatz_mwst_betrag
      ,sum(p.umsatz) - umsatz_mwst_betrag as umsatz_netto
      ,p.bewart_det_id
      ,'' as standard_aktion_id
from (select mandant_id
            ,wup_id
            ,dat
            ,kl_art_id
            ,ean_kasse
            ,wg_id
            ,cast(umsatz_brutto as float) as umsatz
            ,mwst_id
            ,menge
            ,case 
               when ltrim(aktion_id) in ('0','0000000000','') then 1001
               else 1002
             end as bewart_id
            ,case 
               when ltrim(aktion_id) in ('0','0000000000','') then ''
               else aktion_id
             end as aktion_id
            ,4 as bezugsweg_id
            ,case
               when x.bewart_det_id <> 888888 then x.bewart_det_id
               when ltrim(aktion_id) in ('0','0000000000','') and ((kundenkarte_id is null and kundenkarte_typ_id in (0)) or kundenkarte_typ_id IN (3,4)) then 100110
               when ltrim(aktion_id) in ('0','0000000000','') and kundenkarte_id is not null and kundenkarte_typ_id in (2) then 100111
               when ltrim(bby_aktion) in ('0','0000000000','') and bby_bewart = 1 and bonuskauf_id is not null  and customer_promotion_fg = 0 and trim(promotion_art) = 'COMMON' and (((kundenkarte_typ_id in (0,3,4) and kundenkarte_id is null) or trim(kundenkarte_id) is not null) or ((kundenkarte_typ_id in (1,2) and kundenkarte_id is not null) or trim(kundenkarte_id) is not null)) then 100130
               when ltrim(bby_aktion) in ('0','0000000000','') and bby_bewart = 1 and kundenkarte_id is not null  and kundenkarte_typ_id in (2)  and ((customer_promotion_fg = 1 and trim(promotion_art) = 'CUSTOMER') or(customer_promotion_fg = 1 and trim(promotion_art) = 'PERSONAL') or (customer_promotion_fg = 0 and trim(promotion_art) = 'COMMON')) then 100131  
               when ltrim(aktion_id) not in ('0','0000000000','') and ((kundenkarte_id is null and kundenkarte_typ_id in (0)) or kundenkarte_typ_id IN (3,4)) and aktion_id_obv is not null and (bonuskauf_id is null or bonuskauf_id = 0) then 100210
               when ltrim(aktion_id) not in ('0','0000000000','') and kundenkarte_id is not null and kundenkarte_typ_id in (2) and aktion_id_obv is not null and (( (important = 'N' or important is null) and bonuskauf_id is not null) or ( (important = 'Y' or important is null) and (bonuskauf_id is null or bonuskauf_id = 0))) then 100211
               when ltrim(aktion_id) not in ('0','0000000000','') and bonuskauf_id is not null and ((kundenkarte_id is null and kundenkarte_typ_id in (0)) or kundenkarte_typ_id IN (3,4)) and customer_promotion_fg = 0 and promotion_art = 'COMMON' then 100220
               when ltrim(aktion_id) not in ('0','0000000000','') and bonuskauf_id is not null and kundenkarte_id is not null and kundenkarte_typ_id in (2) and customer_promotion_fg = 0 and promotion_art = 'COMMON' then 100221
               when ltrim(aktion_id) not in ('0','0000000000','') and bonuskauf_id is not null and customer_promotion_fg = 1 and promotion_art = 'CUSTOMER' then 100231 
               when ltrim(aktion_id) not in ('0','0000000000','') and bonuskauf_id is not null and customer_promotion_fg = 1 and promotion_art = 'PERSONAL' then 100241
               else 9999
	         end as bewart_det_id
      from _artbew_822 x
      where dat >= '2022-04-01' and
            wg_id in (822)) p

join dbp_data.wup_1 w
  on w.mandant_id = p.mandant_id and
     w.wup_id = p.wup_id

left join (select mandant_id
                 ,art_id
                 ,kl_art_id
                 ,posten_id
                 ,mwst_id 
           from dbp_data.art_1 
           qualify row_number() over (partition by mandant_id,kl_art_id order by art_id desc) = 1) a
  on p.kl_art_id = a.kl_art_id and 
     p.mandant_id = a.mandant_id 

left join dbp_etl_process.dwh_wg_erfass_artikel_1 erf
  on p.mandant_id = erf.mandant_id and 
     p.wg_id = erf.wg_id and 
     erf.arthiertyp_id = 2

left join dbp_data.art_1 aerf
  on erf.mandant_id = aerf.mandant_id and
     erf.art_id = aerf.art_id 

left join dbp_data.mwst_per_1 mw
  on mw.mandant_id = p.mandant_id and 
     p.dat between mw.dat_von and mw.dat_bis and 
     p.mwst_id = mw.mwst_id and 
     coalesce(mw.mwst, 0) <> 0 

left join dbp_data.mwst_per_1 mws
  on mws.mandant_id = p.mandant_id and 
     p.dat between mws.dat_von and mws.dat_bis and 
     coalesce(a.mwst_id, aerf.mwst_id) = mws.mwst_id
    
left join dbp_data.art_wup_zu_per_1 aw
  on p.mandant_id = aw.mandant_id and 
     p.wup_id = aw.wup_id and 
     coalesce(a.art_id, erf.art_id, 0) = aw.art_id and 
     p.dat between aw.dat_von and aw.dat_bis     

group by 1,2,3,4,5,6,7,8,9,10,11,12,16,17
having (menge_ <> 0 or umsatz_netto <> 0)
);

insert into _artbew_tmp (mandant_id
                        ,wrg_1
                        ,wup_id
                        ,nb_id
                        ,dat
                        ,posten_id
                        ,bezugsweg_id
                        ,art_id
                        ,ean_kasse 
                        ,bewart_id
                        ,mwst_id
                        ,aktion_id
                        ,menge
                        ,umsatz_mwst_betrag
                        ,umsatz_netto
                        ,bewart_det_id
                        ,standard_aktion_id)
select mandant_id
      ,wrg_1
      ,wup_id
      ,nb_id
      ,dat
      ,posten_id
      ,bezugsweg_id
      ,art_id
      ,ean_kasse 
      ,bewart_id
      ,mwst_id
      ,aktion_id
      ,menge_
      ,umsatz_mwst_betrag
      ,umsatz_netto
      ,bewart_det_id
      ,standard_aktion_id
from _snap_822
;

update _artbew_tmp set bewart_id = 1001
where bewart_det_id in (100110,100111,100121,100130,100131)
;

update _artbew_tmp from (

select x.mandant_id,
       x.bon_dat,
       x.wup_id,
       x.art_id
from (select a.mandant_id,
             a.bon_dat,
             a.wup_id,
             b.art_id,
             a.bon_id,
             a.bon_zeile
      from dbp_ods.ods_promotion_1 a
      join (select mandant_id
                  ,art_id
                  ,kl_art_id
            from dbp_data.art_1
            qualify row_number() over (partition by mandant_id,kl_art_id order by art_id desc) = 1) b
        on a.mandant_id = b.mandant_id and
           a.kl_art_id = b.kl_art_id
      where (a.mandant_id,a.bon_id,a.bon_zeile,a.bon_dat,a.wup_id) in (select mandant_id,
                                                                              bon_id,
                                                                              bon_zeile,
                                                                              bon_dat,
                                                                              wup_id
                                                                       from dbp_ods.ods_promotion_1
                                                                       where promotion_art in ('PERSONAL_SMP')
                                                                       group by 1,2,3,4,5)
      group by 1,2,3,4,5,6
      having count(distinct a.promotion_art) = 1) x
group by 1,2,3,4

) b

set bewart_id = 1001,
    bewart_det_id = 100121
                                    
where _artbew_tmp.mandant_id = b.mandant_id and
      _artbew_tmp.art_id = b.art_id and
      _artbew_tmp.dat = b.bon_dat and
      _artbew_tmp.wup_id = b.wup_id and
      _artbew_tmp.bewart_det_id = 9999 and
      _artbew_tmp.bewart_id = 1002
;

INSERT INTO _artbew_tmp_anr
(
   art_id
  ,wg_id
  ,mandant_id
  ,dat
  ,bezugsweg_id
)
SELECT
   a.art_id
  ,w.wg_id
  ,a.mandant_id
  ,a.dat
  ,a.bezugsweg_id
FROM _artbew_tmp a

INNER JOIN DBP_DATA.art_wg_zu_per_1 w
ON a.mandant_id = w.mandant_id 
  AND a.art_id = w.art_id
  AND w.dat_bis = to_date('9999-12-31','YYYY-MM_1-DD')
  AND w.arthiertyp_id = 2

GROUP BY 1,2,3,4,5
;

create or replace volatile table _xxx as 
select t2.*
from _artbew_tmp_anr t1_1
join DBP_DATA.art_gp_wup_zu_per_1 t2
  ON t1.mandant_id = t2.mandant_id
    AND t1.art_id = t2.art_id
    AND t1.dat BETWEEN t2.dat_von AND t2.dat_bis
where t2.wup_id = -1
union
select t2.*
from _artbew_tmp_anr t1_1
join DBP_DATA.art_gp_wup_zu_per_1 t2
  ON t1.mandant_id = t2.mandant_id
    AND t1.art_id = t2.art_id
    AND t1.dat BETWEEN t2.dat_von AND t2.dat_bis
where t2.wup_id = 6906 AND (t1.mandant_id,t1.wg_id) NOT IN (SELECT mandant_id,wg_id FROM DBP_DATA.wg_filter_zu_1  where wg_filter_id =20 group by 1,2)
union
select t2.*
from _artbew_tmp_anr t1_1
join DBP_DATA.art_gp_wup_zu_per_1 t2
  ON t1.mandant_id = t2.mandant_id
    AND t1.art_id = t2.art_id
    AND t1.dat BETWEEN t2.dat_von AND t2.dat_bis
where t2.wup_id = 6907 AND (t1.mandant_id,t1.wg_id) IN (SELECT mandant_id,wg_id FROM DBP_DATA.wg_filter_zu_1  where wg_filter_id =20 group by 1,2)
;

UPDATE _artbew_tmp_anr 
SET 
   herst_id                = _herst_id                
  ,gp_id                   = _gp_id                   
  ,einkaufsorganisation_id = COALESCE(_einkaufsorganisation_id,1000)
  ,ek_brutto               = CASE WHEN _ek_brutto          IS NOT NULL THEN CAST(_ek_brutto           AS DECIMAL(18,4)) END
  ,ek_netto                = CASE WHEN _ek_netto           IS NOT NULL THEN CAST(_ek_netto            AS DECIMAL(18,4)) END
  ,ek_nettonetto           = CASE WHEN _ek_nettonetto      IS NOT NULL THEN CAST(_ek_nettonetto       AS DECIMAL(18,4)) END
  ,ek_kal_basis            = CASE WHEN _ek_kal_basis       IS NOT NULL THEN CAST(_ek_kal_basis        AS DECIMAL(18,4)) END
  ,ek_mep                  = CASE WHEN _ek_mep             IS NOT NULL THEN CAST(_ek_mep              AS DECIMAL(18,4)) END
  ,einstandspreis          = CASE WHEN _einstandspreis     IS NOT NULL THEN CAST(_einstandspreis      AS DECIMAL(18,4)) END
  ,logkostenzuschlag       = CASE WHEN _logkostenzuschlag  IS NOT NULL THEN _logkostenzuschlag                          END
  ,ek_netto_bnk            = CASE WHEN _ek_netto_bnk       IS NOT NULL THEN CAST(_ek_netto_bnk        AS DECIMAL(18,4)) END
  ,ek_netto_bnk_sachk      = CASE WHEN _ek_netto_bnk_sachk IS NOT NULL THEN CAST(_ek_netto_bnk_sachk  AS DECIMAL(18,4)) END

FROM
(
  SELECT
     t1.mandant_id                        AS _mandant_id
    ,t1.art_id                            AS _art_id
    ,t1.bezugsweg_id                      AS _bezugsweg_id
    ,t1.dat                               AS _dat
    ,COALESCE(t4.herst_id , t2.gp_id, -1) AS _herst_id
    ,COALESCE(t2.gp_id, -1)               AS _gp_id
    ,t2.einkaufsorganisation_id           AS _einkaufsorganisation_id
    ,t2.ek_brutto                         AS _ek_brutto
    ,t2.ek_netto                          AS _ek_netto
    ,t2.ek_nettonetto                     AS _ek_nettonetto
    ,t2.ek_kal_basis                      AS _ek_kal_basis
    ,t2.ek_mep                            AS _ek_mep
    ,t2.einstandspreis                    AS _einstandspreis
    ,t2.logistikkostenzuschlag            AS _logkostenzuschlag
    ,t2.ek_netto_bnk                      AS _ek_netto_bnk
    ,t2.ek_netto_bnk_sachk                AS _ek_netto_bnk_sachk
  FROM _artbew_tmp_anr t1_1
   
  -- Ermittelung potentieller ZEKP_1-Sätze für EK und GP_1
  LEFT OUTER JOIN _xxx t2
  ON t1.mandant_id = t2.mandant_id
    AND t1.art_id = t2.art_id
    AND t1.dat BETWEEN t2.dat_von AND t2.dat_bis
     
  -- Ermittelung der Hersteller_id
  LEFT OUTER JOIN DBP_DATA.art_gp_zu_per_1 t4
  ON t1.mandant_id = t4.mandant_id
    AND t1.art_id = t4.art_id
    AND t1.dat BETWEEN t4.dat_von AND t4.dat_bis
  
  WHERE t1.mandant_id = 1
  QUALIFY row_number() OVER (PARTITION BY _mandant_id, _art_id, _bezugsweg_id, _dat 
                            ORDER BY CASE WHEN (t1.bezugsweg_id = 1 AND t2.wup_id = -1) OR (t1.bezugsweg_id = 4 AND t2.wup_id <> -1) THEN 1 ELSE 0 END DESC --Richtiger Bezugsweg
                                     ,t2.dat_von DESC -- jüngster Satz
                                     ,CAST(t2.ek_brutto  AS DECIMAL(18,4)) DESC -- kleinster ek_brutto
                                     ,t2.gp_id -- höchte Lieferantennummer
  ) = 1

) dt1 WHERE mandant_id   = _mandant_id              
  AND art_id       = _art_id                  
  AND bezugsweg_id = _bezugsweg_id
  AND dat          = _dat                     
;

UPDATE _artbew_tmp_anr 
SET
    faktor_fg          = 1
   ,ek_brutto          = ZWGE
   ,ek_netto           = ZWGE
   ,ek_nettonetto      = ZWGM
   ,ek_kal_basis       = ZWGM
   ,ek_mep             = ZWGM
   ,einstandspreis     = ZWGS
   ,logkostenzuschlag  = 0
   ,ek_netto_bnk       = ZWGE
   ,ek_netto_bnk_sachk = ZWGM

FROM
(
  SELECT
     t0.mandant_id _mandant_id
    ,t0.art_id     _art_id
    ,t0.dat        _dat
    ,MAX(t1.ek_faktor) AS ZWGS
    ,MAX(COALESCE(t2.ek_faktor, t1.ek_faktor)) AS ZWGM
    ,MAX(COALESCE(t3.ek_faktor, t2.ek_faktor, t1.ek_faktor)) AS ZWGE
  FROM _artbew_tmp_anr t0
  
  INNER JOIN DBP_DATA.art_man_spanne_per_1 t1_1 
  ON t0.mandant_id = t1.mandant_id
    AND t0.art_id = t1.art_id
    AND t0.dat BETWEEN t1.dat_von AND t1.dat_bis
    AND t1.konditionsart_id = 'ZWGS'
    AND t1.loesch_fg = 0
  
  LEFT OUTER JOIN DBP_DATA.art_man_spanne_per_1 t2 
  ON t0.mandant_id = t2.mandant_id
    AND t0.art_id = t2.art_id
    AND t0.dat BETWEEN t2.dat_von AND t2.dat_bis
    AND t2.konditionsart_id = 'ZWGM'
    AND t2.loesch_fg = 0
  
  LEFT OUTER JOIN DBP_DATA.art_man_spanne_per_1 t3 
  ON t0.mandant_id = t3.mandant_id
    AND t0.art_id = t3.art_id
    AND t0.dat BETWEEN t3.dat_von AND t3.dat_bis
    AND t3.konditionsart_id ='ZWGE'
    AND t3.loesch_fg = 0
    
  GROUP BY 1,2,3
)dt1 WHERE mandant_id  = _mandant_id              
  AND art_id      = _art_id                  
  AND dat         = _dat                     
;

UPDATE _artbew_tmp

SET herst_id                =_herst_id                
  ,gp_id                    =_gp_id                   
  ,einkaufsorganisation_id  =_einkaufsorganisation_id 
  -- Wenn mit EKS aus der ZEKP_1 angereichert werden soll, so ist das "faktor_fg" NULL 
  ,ek_brutto                = COALESCE(umsatz_netto * _faktor_fg * _ek_brutto         , menge * _ek_brutto         )
  ,ek_netto                 = COALESCE(umsatz_netto * _faktor_fg * _ek_netto          , menge * _ek_netto          )
  ,ek_nettonetto            = COALESCE(umsatz_netto * _faktor_fg * _ek_nettonetto     , menge * _ek_nettonetto     )
  ,ek_kal_basis             = COALESCE(umsatz_netto * _faktor_fg * _ek_kal_basis      , menge * _ek_kal_basis      )
  ,ek_mep                   = COALESCE(umsatz_netto * _faktor_fg * _ek_mep            , menge * _ek_mep            )
  ,einstandspreis           = COALESCE(umsatz_netto * _faktor_fg * _einstandspreis    , menge * _einstandspreis    )
  ,logkostenzuschlag        = COALESCE(umsatz_netto * _faktor_fg * _logkostenzuschlag , menge * _logkostenzuschlag )
  ,ek_netto_bnk             = COALESCE(umsatz_netto * _faktor_fg * _ek_netto_bnk      , menge * _ek_netto_bnk      )
  ,ek_netto_bnk_sachk       = COALESCE(umsatz_netto * _faktor_fg * _ek_netto_bnk_sachk, menge * _ek_netto_bnk_sachk)
  ,wg_id                    =_wg_id 
            
FROM
(
  SELECT
     mandant_id               _mandant_id              
    ,art_id                   _art_id                  
    ,bezugsweg_id             _bezugsweg_id            
    ,dat                      _dat                     
    ,herst_id                 _herst_id                
    ,wg_id                    _wg_id
    ,gp_id                    _gp_id                   
    ,einkaufsorganisation_id  _einkaufsorganisation_id 
    ,ek_brutto                _ek_brutto               
    ,ek_netto                 _ek_netto                
    ,ek_nettonetto            _ek_nettonetto           
    ,ek_kal_basis             _ek_kal_basis            
    ,ek_mep                   _ek_mep                  
    ,einstandspreis           _einstandspreis          
    ,logkostenzuschlag        _logkostenzuschlag       
    ,ek_netto_bnk             _ek_netto_bnk            
    ,ek_netto_bnk_sachk       _ek_netto_bnk_sachk      
    ,faktor_fg                _faktor_fg
  FROM _artbew_tmp_anr
)t1_1 WHERE mandant_id   = _mandant_id   
  AND art_id       = _art_id       
  AND bezugsweg_id = _bezugsweg_id
  AND dat          = _dat    
;

UPDATE _artbew_tmp

SET 
   ek_brutto          = umsatz_netto * ZWGE
  ,ek_netto           = umsatz_netto * ZWGE
  ,ek_nettonetto      = umsatz_netto * ZWGM
  ,ek_kal_basis       = umsatz_netto * ZWGM
  ,ek_mep             = umsatz_netto * ZWGM
  ,einstandspreis     = umsatz_netto * ZWGS
  ,logkostenzuschlag  = 0
  ,ek_netto_bnk       = umsatz_netto * ZWGE
  ,ek_netto_bnk_sachk = umsatz_netto * ZWGM
   
FROM
(
  SELECT
     t0.mandant_id _mandant_id
    ,t0.art_id     _art_id
    ,t0.wup_id     _wup_id
    ,t0.dat        _dat
    ,MAX(t1.ek_faktor) AS ZWGS
    ,MAX(COALESCE(t2.ek_faktor, t1.ek_faktor)) AS  ZWGM
    ,MAX(COALESCE(t3.ek_faktor, t2.ek_faktor, t1.ek_faktor)) AS ZWGE
  FROM _artbew_tmp t0
  
  INNER JOIN DBP_DATA.art_wup_man_spanne_per_1 t1_1 
  ON t0.mandant_id = t1.mandant_id
    AND t0.art_id = t1.art_id
    AND t0.wup_id = t1.wup_id
    AND t0.dat BETWEEN t1.dat_von AND t1.dat_bis
    AND t1.konditionsart_id = 'ZWGS'
    AND t1.loesch_fg = 0
  
  LEFT OUTER JOIN DBP_DATA.art_wup_man_spanne_per_1 t2 
  ON t0.mandant_id = t2.mandant_id
    AND t0.art_id = t2.art_id
    AND t0.wup_id = t2.wup_id
    AND t0.dat BETWEEN t2.dat_von AND t2.dat_bis
    AND t2.konditionsart_id = 'ZWGM'
    AND t2.loesch_fg = 0
  
  LEFT OUTER JOIN DBP_DATA.art_wup_man_spanne_per_1 t3 
  ON t0.mandant_id = t3.mandant_id
    AND t0.art_id = t3.art_id
    AND t0.wup_id = t3.wup_id
    AND t0.dat BETWEEN t3.dat_von AND t3.dat_bis
    AND t3.konditionsart_id = 'ZWGE'
    AND t3.loesch_fg = 0
  
  GROUP BY 1,2,3,4
)dt1 WHERE mandant_id = _mandant_id   
  AND art_id     = _art_id       
  AND wup_id     = _wup_id 
  AND dat        = _dat    
;

UPDATE _artbew_tmp 
SET
   ek_brutto          = umsatz_netto * (CAST(_ek_brutto AS FLOAT)         / NULLIFZERO(_umsatz_netto))
  ,ek_netto           = umsatz_netto * (CAST(_ek_netto AS FLOAT)          / NULLIFZERO(_umsatz_netto))
  ,ek_nettonetto      = umsatz_netto * (CAST(_ek_nettonetto AS FLOAT)     / NULLIFZERO(_umsatz_netto))
  ,ek_kal_basis       = umsatz_netto * (CAST(_ek_kal_basis AS FLOAT)      / NULLIFZERO(_umsatz_netto))
  ,ek_mep             = umsatz_netto * (CAST(_ek_mep AS FLOAT)            / NULLIFZERO(_umsatz_netto))
  ,einstandspreis     = umsatz_netto * (CAST(_einstandspreis AS FLOAT)    / NULLIFZERO(_umsatz_netto))
  ,logkostenzuschlag  = umsatz_netto * (CAST(_logkostenzuschlag AS FLOAT) / NULLIFZERO(_umsatz_netto))
  ,ek_netto_bnk       = umsatz_netto * (CAST(_ek_netto_bnk AS FLOAT)      / NULLIFZERO(_umsatz_netto))
  ,ek_netto_bnk_sachk = umsatz_netto * (CAST(_ek_netto_bnk_sachk AS FLOAT)/ NULLIFZERO(_umsatz_netto))

FROM
(
  SELECT
     artbew.wup_id           AS _wup_id
    ,SUM(ek_brutto         ) AS _ek_brutto         
    ,SUM(ek_netto          ) AS _ek_netto          
    ,SUM(ek_nettonetto     ) AS _ek_nettonetto     
    ,SUM(ek_kal_basis      ) AS _ek_kal_basis      
    ,SUM(ek_mep            ) AS _ek_mep            
    ,SUM(einstandspreis    ) AS _einstandspreis    
    ,SUM(logkostenzuschlag ) AS _logkostenzuschlag 
    ,SUM(ek_netto_bnk      ) AS _ek_netto_bnk      
    ,SUM(ek_netto_bnk_sachk) AS _ek_netto_bnk_sachk
    ,SUM(umsatz_netto      ) AS _umsatz_netto
  FROM _artbew_tmp artbew_1

  INNER JOIN DBP_DATA.wg_filter_zu_1 AS wgfz 
	 ON	wgfz.mandant_id  = artbew.mandant_id
	AND wgfz.wg_id       = artbew.wg_id
	
  WHERE	wgfz.wg_filter_id =1
    
  GROUP BY 1
)dt1 WHERE wup_id = _wup_id
  AND (mandant_id,wg_id) in ( SELECT mandant_id, wg_id FROM DBP_DATA.wg_filter_zu_1 where wg_filter_id= 33 GROUP BY 1,2)
;

UPDATE _artbew_tmp 
SET
   ek_brutto          = umsatz_netto * (CAST(_ek_brutto AS FLOAT)         / NULLIFZERO(_umsatz_netto))
  ,ek_netto           = umsatz_netto * (CAST(_ek_netto AS FLOAT)          / NULLIFZERO(_umsatz_netto))
  ,ek_nettonetto      = umsatz_netto * (CAST(_ek_nettonetto AS FLOAT)     / NULLIFZERO(_umsatz_netto))
  ,ek_kal_basis       = umsatz_netto * (CAST(_ek_kal_basis AS FLOAT)      / NULLIFZERO(_umsatz_netto))
  ,ek_mep             = umsatz_netto * (CAST(_ek_mep AS FLOAT)            / NULLIFZERO(_umsatz_netto))
  ,einstandspreis     = umsatz_netto * (CAST(_einstandspreis AS FLOAT)    / NULLIFZERO(_umsatz_netto))
  ,logkostenzuschlag  = umsatz_netto * (CAST(_logkostenzuschlag AS FLOAT) / NULLIFZERO(_umsatz_netto))
  ,ek_netto_bnk       = umsatz_netto * (CAST(_ek_netto_bnk AS FLOAT)      / NULLIFZERO(_umsatz_netto))
  ,ek_netto_bnk_sachk = umsatz_netto * (CAST(_ek_netto_bnk_sachk AS FLOAT)/ NULLIFZERO(_umsatz_netto))

FROM
(
  SELECT
     artbew.wup_id           AS _wup_id
    ,SUM(ek_brutto         ) AS _ek_brutto         
    ,SUM(ek_netto          ) AS _ek_netto          
    ,SUM(ek_nettonetto     ) AS _ek_nettonetto     
    ,SUM(ek_kal_basis      ) AS _ek_kal_basis      
    ,SUM(ek_mep            ) AS _ek_mep            
    ,SUM(einstandspreis    ) AS _einstandspreis    
    ,SUM(logkostenzuschlag ) AS _logkostenzuschlag 
    ,SUM(ek_netto_bnk      ) AS _ek_netto_bnk      
    ,SUM(ek_netto_bnk_sachk) AS _ek_netto_bnk_sachk
    ,SUM(umsatz_netto      ) AS _umsatz_netto
  FROM _artbew_tmp artbew_1

  INNER JOIN DBP_DATA.wg_filter_zu_1 AS wgfz 
	 ON	wgfz.mandant_id  = artbew.mandant_id
	AND wgfz.wg_id       = artbew.wg_id
	
  WHERE	wgfz.wg_filter_id =32
    
  GROUP BY 1
)dt1 WHERE wup_id = _wup_id
  AND (mandant_id,wg_id) in 
  ( SELECT mandant_id, wg_id FROM DBP_DATA.wg_filter_zu_1 where wg_filter_id= 34 GROUP BY 1,2)

;

create or replace volatile table _update as (
select b.*,
       max(a.aktion_id) as aktion_id_
from dbp_data.aktion_art_wup_zu_1 a
join _artbew_tmp b
  on a.art_id = b.art_id and
     a.mandant_id = b.mandant_id and
     a.wup_id = b.wup_id and
     a.nb_id = b.nb_id 
join dbp_data.aktion_1 c
  on a.mandant_id = c.mandant_id and
     a.aktion_id = c.aktion_id and
     b.dat between c.dat_von and c.dat_bis
where a.grund_sperrung is null and
      case
        when c.mandant_id = 1
        then c.preisaktiviert_fg
        when c.mandant_id > 1 and
             a.dat_preisaktiviert <> '1900-01-01' and
            (c.mandant_id,c.aktion_id) not in (select mandant_id,aktion_id
                                               from dbp_data.l_bonuskauf_1)
        then 1
        else 0
      end = 1
group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,
         18,19,20,21,22,23,24,25,26,27,28,29,30
);

update _artbew_tmp from (select mandant_id,
                                wup_id,
                                nb_id,
                                art_id,
                                dat,
                                max(aktion_id_) as aktion_id_
                         from _update
                         group by 1,2,3,4,5) b

set standard_aktion_id = b.aktion_id_
						  
where _artbew_tmp.mandant_id = b.mandant_id and
      _artbew_tmp.wup_id = b.wup_id and
      _artbew_tmp.nb_id = b.nb_id and
      _artbew_tmp.art_id = b.art_id and
      _artbew_tmp.dat = b.dat
;

DELETE FROM DBP_DATA.artbew_1 a
WHERE a.mandant_id = 1
  AND a.dat IN
  (
    SELECT dat
    FROM DBP_ETL.bon_artbew_dat_1 
  )
  AND (a.mandant_id, a.wup_id, a.dat) IN
  (
    SELECT 
       mandant_id
      ,wup_id
      ,dat
    FROM _artbew_tmp
  )
  AND bewart_id <> 1010
;

DELETE FROM DBP_DATA.artbew_dra_1 d
WHERE d.mandant_id = 1
  AND d.dat IN
  (
    SELECT dat
    FROM DBP_ETL.bon_artbew_dat_1
  )
  AND (d.mandant_id, d.wup_id, d.dat) IN
  (
    SELECT 
       mandant_id
      ,wup_id
      ,dat
    FROM _artbew_tmp
  )
;

/*2021-09-22 mfialkiewicz adding missing scripts after migration*/
--START
INSERT INTO DBP_DATA.artbew_dra_1
(
        wup_id
        ,mandant_id
        ,bewart_id
        ,gp_id
        ,nb_id
        ,art_id
        ,ean_kasse
        ,dat
        ,aktion_id
        ,wrg_1
        ,menge
        ,umsatz_netto
        ,umsatz_mwst_betrag
)
        SELECT
                wup_id
                ,mandant_id
                ,bewart_id
                ,gp_id
                ,nb_id
                ,art_id
                ,ean_kasse
                ,dat
                ,aktion_id
                ,wrg_1
                ,menge_
                ,umsatz_netto_
                ,umsatz_mwst_betrag_
        FROM
(
        SELECT
                wup_id
                ,a.mandant_id
                ,bewart_id
                ,COALESCE(gp_id,-1) gp_id
                ,nb_id
                ,a.art_id
                ,ean_kasse
                ,dat
                ,aktion_id
                ,wrg_1
                ,SUM(menge             ) AS menge_
                ,SUM(umsatz_netto      ) AS umsatz_netto_
                ,SUM(umsatz_mwst_betrag) AS umsatz_mwst_betrag_
        FROM _artbew_tmp a

        INNER JOIN DBP_DATA.art_wg_zu_per_1 w
        ON a.mandant_id = w.mandant_id
        AND a.art_id = w.art_id

        INNER JOIN DBP_DATA.wg_filter_zu_1 AS wgfz
        ON wgfz.mandant_id    = w.mandant_id
        AND wgfz.arthiertyp_id = w.arthiertyp_id
        AND wgfz.wg_id         = w.wg_id

        WHERE w.arthiertyp_id   = 2
        AND w.dat_bis         = to_date('9999-12-31','YYYY-MM_1-DD')
        AND wgfz.wg_filter_id = 9 
--WG Spenden fuer Aktion_1 Deutschland rundet auf
GROUP BY
        wup_id
        ,a.mandant_id
        ,bewart_id
        ,COALESCE(gp_id,-1)
        ,nb_id
        ,a.art_id
        ,ean_kasse
        ,dat
        ,aktion_id
        ,wrg_1
) a;
--END



DELETE FROM _artbew_tmp

WHERE (mandant_id, art_id) IN 
  (
     SELECT 
        awzp.mandant_id
       ,awzp.art_id
     FROM DBP_DATA.art_wg_zu_per_1 awzp
	 
     INNER JOIN DBP_DATA.wg_filter_zu_1 AS wgfz 
	    ON wgfz.mandant_id    = awzp.mandant_id
       AND wgfz.arthiertyp_id = awzp.arthiertyp_id
       AND wgfz.wg_id         = awzp.wg_id
     
     WHERE awzp.arthiertyp_id = 2
       AND awzp.dat_bis       = to_date('9999-12-31','YYYY-MM_1-DD') 
       AND wgfz.wg_filter_id  = 9 /*WG Spenden fuer Aktion_1 Deutschland rundet auf*/	
	 
	 GROUP BY awzp.mandant_id
           ,awzp.art_id
  )
;

delete from _artbew_tmp
where (mandant_id,art_id) in (select mandant_id,art_id 
                              from dbp_data.art_wg_zu_per_1
                              where mandant_id = 1 and
                                    arthiertyp_id = 2 and
                                    dat_bis = '9999-12-31' and
                                    wg_id = 961)
;

delete from _artbew_tmp
where mandant_id = 1 and
      art_id = 2076821600
;


-- 12.06.2025, dbay: historical tracking of posten_id
create or replace volatile table _tage as (
select dat
from _artbew_tmp
group by 1
);

create or replace volatile table _min_tage as (
select min(dat) as min_dat
from _artbew_tmp
);

create or replace volatile table _art_per as (
select a.*,
       b.dat
from (select a.*
      from dbp_data.art_per_1 a
      join _min_tage b
        on a.dat_bis >= b.min_dat) a
join _tage b
  on b.dat BETWEEN a.dat_von AND a.dat_bis
);

update _artbew_tmp from (select *
                         from _art_per) b

set posten_id = b.posten_id

where _artbew_tmp.dat = b.dat and
      _artbew_tmp.mandant_id = b.mandant_id and
      _artbew_tmp.art_id = b.art_id
;

INSERT INTO DBP_DATA.artbew_1
(
   art_id
  ,wup_id
  ,mandant_id
  ,bewart_id
  ,gp_id
  ,einkaufsorganisation_id
  ,nb_id
  ,dat
  ,herst_id
  ,mwst_id
  ,menge
  ,wrg_1
  ,umsatz_netto
  ,umsatz_mwst_betrag
  ,ek_brutto
  ,ek_netto
  ,ek_nettonetto
  ,ek_kal_basis
  ,ek_mep
  ,einstandspreis
  ,logkostenzuschlag
  ,bezugsweg_id
  ,ek_netto_bnk
  ,ek_netto_bnk_sachk
  ,posten_id
  ,aktion_id
  ,ean_kasse
  ,bewart_det_id
  ,promo_fg
  ,td_insert
  ,td_update
  ,wup_bereinigt_fg
  ,standard_aktion_id
  ,umrechnungskurs_hist
)
SELECT
   art_id
  ,wup_id
  ,mandant_id
  ,bewart_id
  ,gp_id
  ,einkaufsorganisation_id
  ,nb_id
  ,dat
  ,herst_id
  ,mwst_id
  ,menge_
  ,wrg_1
  ,umsatz_netto_
  ,umsatz_mwst_betrag_
  ,COALESCE(ek_brutto_     , 0) 
  ,COALESCE(ek_netto_      , 0) 
  ,COALESCE(ek_nettonetto_ , 0) 
  ,COALESCE(ek_kal_basis_  , 0) 
  ,COALESCE(ek_mep_        , 0) 
  ,COALESCE(einstandspreis_, 0) 
  ,COALESCE(logkostenzuschlag_, 0)
  ,bezugsweg_id
  ,COALESCE(ek_netto_bnk_      , 0) 
  ,COALESCE(ek_netto_bnk_sachk_, 0) 
  ,posten_id
  ,aktion_id
  ,ean_kasse
  ,bewart_det_id
  ,promo_fg 
  ,CURRENT_TIMESTAMP as td_insert
  ,CURRENT_TIMESTAMP as td_update
  ,wup_bereinigt_fg
  ,standard_aktion_id
  ,umrechnungskurs_hist
FROM
(
  SELECT
     a.art_id
    ,a.wup_id
    ,a.mandant_id
    ,a.bewart_id
    ,COALESCE(a.gp_id, -1)                     AS gp_id
    ,COALESCE(a.einkaufsorganisation_id, 1000) AS einkaufsorganisation_id
    ,a.nb_id
    ,a.dat
    ,COALESCE(a.herst_id,-1)              AS herst_id
    ,a.mwst_id
    ,SUM(a.menge)                         AS menge_
    ,a.wrg_1
    ,SUM(a.umsatz_netto                 ) AS umsatz_netto_
    ,SUM(a.umsatz_mwst_betrag           ) AS umsatz_mwst_betrag_
    ,SUM(a.ek_brutto                    ) AS ek_brutto_
    ,SUM(a.ek_netto                     ) AS ek_netto_
    ,SUM(a.ek_nettonetto                ) AS ek_nettonetto_
    ,SUM(a.ek_kal_basis                 ) AS ek_kal_basis_
    ,SUM(a.ek_mep                       ) AS ek_mep_
    ,SUM(a.einstandspreis               ) AS einstandspreis_
    ,SUM(a.logkostenzuschlag            ) AS logkostenzuschlag_
    ,a.bezugsweg_id
    ,SUM(a.ek_netto_bnk                 ) AS ek_netto_bnk_
    ,SUM(a.ek_netto_bnk_sachk           ) AS ek_netto_bnk_sachk_
    ,a.posten_id
    ,a.aktion_id
    ,a.ean_kasse
    ,a.bewart_det_id
    ,CASE WHEN a.bewart_det_id IN (100220, 100221, 100231, 100241) THEN 1 ELSE 0 END AS promo_fg
    ,coalesce(b.wup_bereinigt_fg,0) as wup_bereinigt_fg
    ,a.standard_aktion_id
    ,k.umrechnungskurs as umrechnungskurs_hist
  from _artbew_tmp a
  left join dbp_etl_process.wup_fg_1 b
    on a.mandant_id = b.mandant_id and
       a.wup_id = b.wup_id and
       a.dat = b.dat
  left join dbp_data.kurs_1 k
    on a.wrg_1 = k.von_wrg_id and
       a.dat between k.dat_von and k.dat_bis and
       k.nach_wrg_id = 'EUR' and 
       k.kurstyp_id = 3
  group by 1,2,3,4,5,6,7,8,9,10,12,22,25,26,27,28,29,30,31,32
) a
;

--update dbp_ods.ods_talon_det_1 set artbew_fg = 1
--where (mandant_id,wup_id,talon_id) in (select mandant_id,wup_id,talon_id from dbp_etl.bon_artbew_tmp_talon_1)
--;

create or replace table dbp_etl.artbew_agg_tmp_1 (
  wup_id integer not null,
  mandant_id byteint not null,
  nb_id smallint not null ,
  dat date not null
);

insert into dbp_etl.artbew_agg_tmp_1 (wup_id
                                   ,mandant_id
                                   ,nb_id
                                   ,dat)
select wup_id
      ,mandant_id
      ,nb_id
      ,dat
from _artbew_tmp
group by 1,2,3,4
;

insert into dbp_data.artbew_agg_wt_1 (mandant_id
                                   ,wup_id
                                   ,nb_id
                                   ,dat)
select mandant_id
      ,wup_id
      ,nb_id
      ,dat
from dbp_etl.artbew_agg_tmp_1
where (mandant_id,wup_id,nb_id,dat) not in (select mandant_id,wup_id,nb_id,dat from dbp_data.artbew_agg_wt_1)
group by 1,2,3,4
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
from dbp_etl.artbew_agg_tmp_1
group by 1,2,3
;

create or replace table dbp_etl.art_bestand_vw_sum_artbew_dat_1 (
  mandant_id byteint not null,
  dat date
);

insert into dbp_etl.art_bestand_vw_sum_artbew_dat_1 (mandant_id,
                                                   dat)
select mandant_id,
       dat
from dbp_etl.artbew_agg_tmp_1
where (mandant_id,dat) not in (select mandant_id,dat from dbp_etl.art_bestand_vw_sum_artbew_dat_1)
group by 1,2
;

delete from dbp_etl.artbew_mis_1
where (mandant_id,wup_id,dat) in (select mandant_id,wup_id,dat from dbp_etl.artbew_agg_tmp_1)
;

insert into dbp_etl.artbew_mis_1 (mandant_id
                               ,art_id
                               ,wup_id
                               ,nb_id
                               ,bewart_id
                               ,dat
                               ,wrg_1
                               ,diff_umsatz_netto_konz
                               ,diff_umsatz_mwst_betrag_konz
                               ,menge
                               ,umsatz_netto
                               ,umsatz_mwst_betrag)
select mandant_id
      ,art_id
      ,wup_id
      ,nb_id
      ,1001
      ,dat
      ,wrg_1
      ,0 diff_umsatz_netto_konz
      ,0 diff_umsatz_mwst_betrag_konz
      ,sum(menge)
      ,sum(umsatz_netto)
      ,sum(umsatz_mwst_betrag)
from _artbew_tmp
group by 1,2,3,4,5,6,7,8,9
;

update dbp_etl.artbew_mis_1 from (select mandant_id
                                      ,art_id
                                      ,wg_id
                                      ,arthiertyp_id
                                from dbp_data.art_wg_zu_per_1
                                where arthiertyp_id = 2 and
                                      dat_bis = '9999-12-31'
                                group by 1,2,3,4) dt
set wg_id = dt.wg_id
   ,arthiertyp_id = dt.arthiertyp_id
 
where dbp_etl.artbew_mis.mandant_id = dt.mandant_id
  and dbp_etl.artbew_mis.art_id = dt.art_id
;

update dbp_data.wupcal_1 from (select a.mandant_id mandant_id_
                                   ,a.wup_id wup_id_
                                   ,w.nb_id nb_id_
                                   ,a.dat dat_
                                   ,sum(a.umsatz_brutto) as umsatz_brutto
                             from dbp_etl.bon_artbew_tmp_talon_1 a
                             join dbp_data.wup_1 w
                               on w.mandant_id = a.mandant_id and 
                                  w.wup_id = a.wup_id
                             group by 1,2,3,4) x1

set datenlieferung_artbew = 1
   ,dat_extrakt_umsatz = current_date
   ,umsatz_brutto_ods_verkauf = umsatz_brutto
   ,td_update= current_timestamp

where mandant_id = mandant_id_ and 
      wup_id = wup_id_ and 
      nb_id = nb_id_ and 
      dat = dat_
;

update dbp_data.wupcal_1 from (select k.mandant_id mandant_id_,
                                    k.wup_id wup_id_,
                                    k.bon_dat dat_,
                                    sum(k.anz_kunden) - sum(k.anz_kunden_imbiss) anz_kunden_,
                                    sum(k.anz_kunden_imbiss) anz_kunden_imbiss_,
                                    sum(k.umsatz_brutto) umsatz_brutto_ods_kassenabschluss_
                             from dbp_ods.ods_bon_kassenabschluss_1 k
                             join (select distinct mandant_id,wup_id,dat
                                   from dbp_etl.artbew_agg_tmp_1) a
                               on a.mandant_id = k.mandant_id and 
                                  a.wup_id = k.wup_id and 
                                  a.dat = k.bon_dat
                             group by 1,2,3) s 

set bonanzahl = anz_kunden_
  , bonanzahl_imbiss = anz_kunden_imbiss_
  , umsatz_brutto_ods_kassenabschluss = umsatz_brutto_ods_kassenabschluss_
  , datenlieferung_bonanzahl = 1
  , td_update = current_timestamp

where mandant_id = mandant_id_ and 
      wup_id = wup_id_ and 
      dat = dat_
;

/* 
Jetzt kann nachträglich noch eine_1 Kassenabschluss kommen.
Wir benötigen dann die Summe der beiden Werte in der wupcal_1 Spalte.
*/

create or replace table dbp_etl.wupcal_correction_1 as 
    select distinct 
       mandant_id, 
       wup_id, 
       bon_dat, 
       --sum(umsatz_brutto) AS
       --umsatz_brutto 
    from dbp_ods.ods_bon_kassenabschluss_1 
        where (mandant_id, wup_id, bon_dat) in 
         (
          select  mandant_id, wup_id,bon_dat from 
            (
               select mandant_id, wup_id,bon_dat, count(bon_id) 
                     from dbp_ods.ods_bon_kassenabschluss_1
                        where
                          mandant_id = 1 and
                          bon_dat between current_date-7 and current_date
                        group by all
                        having count(1) > 1
             )
          ) 
    --group by all
    order by mandant_id, wup_id, bon_dat desc
;

update dbp_data.wupcal_1
set bonanzahl = anz_kunden_
   ,bonanzahl_imbiss = anz_kunden_imbiss_
   ,umsatz_brutto_ods_kassenabschluss = umsatz_brutto_ods_kassenabschluss_
   ,datenlieferung_bonanzahl = 1
   ,wrg_id = wrg_id_
from (select k.mandant_id mandant_id_,
             k.wup_id wup_id_,
             k.bon_dat dat_,
             sum(k.anz_kunden)-sum(k.anz_kunden_imbiss) anz_kunden_,
             sum(k.anz_kunden_imbiss) anz_kunden_imbiss_,
             sum(k.umsatz_brutto * coalesce(x.umrech,1)) umsatz_brutto_ods_kassenabschluss_,
             min(x.wrg_id) wrg_id_
      from dbp_ods.ods_bon_kassenabschluss_1 k
      join dbp_data.mandant_wrg_zu_per_1 wrg_1 
        on k.mandant_id = wrg.mandant_id
        and k.bon_dat between wrg.dat_von and wrg.dat_bis
      join dbp_data.mandant_1 y
        on k.mandant_id = y.mandant_id
      left join (select *,
                        cast(1 as float)/cast(umrechnungskurs as float) as umrech
                 from dbp_data.mandant_wrg_zu_per_1
                 where von_wrg_id is not null and
                       wrg_id <> von_wrg_id and
                       current_date between dat_von and dat_bis) x
        on k.mandant_id = x.mandant_id and
           wrg.wrg_id = x.von_wrg_id
      join (select mandant_id,
                   wup_id,
                   bon_dat 
            from dbp_etl.wupcal_correction_1
            group by 1,2,3) a
        on a.mandant_id = k.mandant_id and 
           a.wup_id = k.wup_id and 
           a.bon_dat = k.bon_dat
      group by 1,2,3) s 
where mandant_id = mandant_id_ and 
      wup_id = wup_id_ and 
      dat = dat_
;

-- CRM-Verarbeitung

INSERT INTO _artbew_tmp2
(
   mandant_id
  ,wrg_1
  ,wup_id
  ,nb_id
  ,dat
  ,posten_id
  ,bezugsweg_id
  ,art_id
  ,ean_kasse 
  ,bewart_id
  ,mwst_id
  ,aktion_id
  ,menge
  ,umsatz_mwst_betrag
  ,umsatz_netto
  ,bewart_det_id
  ,kundenkarte_id
)
SELECT 
   p.mandant_id
  ,'EUR' as wrg_1
  ,p.wup_id
  ,w.nb_id
  ,p.dat
  ,COALESCE(a.posten_id,'') AS posten_id
  ,COALESCE(aw.bezugsweg_id, p.bezugsweg_id) /*fuehrend */
  ,COALESCE(a.art_id, erf.art_id, 0)
  ,COALESCE(p.ean_kasse, 0)          AS ean_kasse 
  ,p.bewart_id
  ,COALESCE(mw.mwst_id, mws.mwst_id) /*fuehrend MWST aus Bondaten*/ 
  ,p.aktion_id
  ,SUM(p.menge) AS menge_
  ,SUM(p.umsatz /(1 + COALESCE(mw.mwst, mws.mwst) / 100)*(COALESCE(mw.mwst, mws.mwst) / 100)) AS umsatz_mwst_betrag
  ,SUM(p.umsatz) - umsatz_mwst_betrag AS umsatz_netto
  ,p.bewart_det_id
  ,p.kundenkarte_id
FROM
(
  SELECT
        mandant_id
        ,wup_id
        ,dat
        ,kl_art_id
        ,ean_kasse
        ,wg_id
        ,CAST(umsatz_brutto AS FLOAT) AS umsatz
        ,mwst_id
        ,menge
        ,CASE WHEN LTRIM(aktion_id) IN ('0','0000000000','')
              THEN 1001 /*aktoinsfrei*/
              ELSE 1002 /*Sonderaktion*/
              END AS bewart_id
        ,CASE WHEN LTRIM(aktion_id) IN ('0','0000000000','')
              THEN ''
              ELSE aktion_id
              END AS aktion_id
        ,4 AS bezugsweg_id /*Initialisierung, im Anschluss erfolgt Ermittlung ueber MARC_1*/
        ,CASE 
           when ltrim(aktion_id) in ('0','0000000000','') and
              ((kundenkarte_id is null and kundenkarte_typ_id in (0)) or 
                kundenkarte_typ_id IN (3,4))
            then 100110
            ELSE 
             CASE 
               WHEN LTRIM(aktion_id) IN ('0','0000000000','')
                    AND kundenkarte_id IS NOT NULL
                    AND kundenkarte_typ_id IN (2)
              THEN 100111  
              ELSE CASE WHEN LTRIM(bby_aktion) IN ('0','0000000000','') 
                    AND bby_bewart = 1 
                    AND bonuskauf_id is not null  
                    AND customer_promotion_fg = 0  
                    AND trim(promotion_art) = 'COMMON'  
                    AND (((kundenkarte_id is null and kundenkarte_typ_id in (0)) or (kundenkarte_typ_id in (3,4)) or trim(kundenkarte_id) is not null) or ((kundenkarte_typ_id in (1,2) and kundenkarte_id is not null) or trim(kundenkarte_id) is not null))
              THEN 100130
              WHEN LTRIM(bby_aktion) IN ('0','0000000000','') 
                    AND bby_bewart = 1 
                    AND kundenkarte_id is not null  
                    AND kundenkarte_typ_id in (2)  
                    AND ((customer_promotion_fg = 1 and trim(promotion_art) = 'CUSTOMER') or(customer_promotion_fg = 1 and trim(promotion_art) = 'PERSONAL') or (customer_promotion_fg = 0 and trim(promotion_art) = 'COMMON'))
              THEN 100131  
              WHEN LTRIM(aktion_id) NOT IN ('0','0000000000','') and
                 ((kundenkarte_id is null and kundenkarte_typ_id in (0)) or 
                   kundenkarte_typ_id IN (3,4)) AND 
                   aktion_id_obv IS NOT NULL AND 
                  (bonuskauf_id IS NULL OR bonuskauf_id = 0)
              THEN 100210
              ELSE
                CASE 
                  WHEN LTRIM(aktion_id) NOT IN ('0','0000000000','')
                       AND kundenkarte_id IS NOT NULL
                       AND kundenkarte_typ_id IN (2)
                       AND aktion_id_obv IS NOT NULL
                       AND (( (important = 'N' or important is null) and bonuskauf_id is not null) or ( (important = 'Y' or important is null) and (bonuskauf_id is null or bonuskauf_id = 0)))
                  THEN 100211
                  ELSE
                    CASE
                      WHEN LTRIM(aktion_id) NOT IN ('0','0000000000','')
                           AND bonuskauf_id IS NOT NULL
                           and ((kundenkarte_id is null and kundenkarte_typ_id in (0)) or 
                                 kundenkarte_typ_id IN (3,4))
                           AND customer_promotion_fg = 0
                           AND promotion_art = 'COMMON'
                      THEN 100220
                      ELSE
                        CASE
                          WHEN LTRIM(aktion_id) NOT IN ('0','0000000000','')
                               AND bonuskauf_id IS NOT NULL
                               AND kundenkarte_id IS NOT NULL
                               AND kundenkarte_typ_id IN (2) 
                               AND customer_promotion_fg = 0
                               AND promotion_art = 'COMMON'
                          THEN 100221
                          ELSE
                            CASE
                              WHEN LTRIM(aktion_id) NOT IN ('0','0000000000','')
                                   AND bonuskauf_id IS NOT NULL
                                   AND customer_promotion_fg = 1
                                   AND promotion_art = 'CUSTOMER'
                              THEN 100231
                              ELSE
                                CASE
                                  WHEN LTRIM(aktion_id) NOT IN ('0','0000000000','')
                                       AND bonuskauf_id IS NOT NULL
                                       AND customer_promotion_fg = 1
                                       AND promotion_art = 'PERSONAL'
                                  THEN 100241
                                  ELSE 9999
                                END
                            END
                        END
                    END
                END
            END
        END
	END AS bewart_det_id,
    kundenkarte_id
FROM dbp_etl.bon_artbew_tmp_talon_1
where dat >= '2022-04-01' and
     (mandant_id,kl_art_id) not in (select mandant_id,floor(art_id/100) as kl_art_id
                                     from dbp_data.art_wg_zu_per_1
                                     where mandant_id = 1 and
                                           arthiertyp_id = 2 and
                                           dat_bis = '9999-12-31' and
                                           wg_id = 961)  and
      wg_id not in (822)
) p

-- Ermittlung nb_id
INNER JOIN DBP_DATA.wup_1 w
ON w.mandant_id = p.mandant_id 
  AND w.wup_id = p.wup_id

-- Ermittlung art_id
LEFT OUTER JOIN 
(
  SELECT 
     mandant_id
    ,art_id
    ,kl_art_id
    ,posten_id
    ,mwst_id 
  FROM DBP_DATA.art_1 
  QUALIFY row_number() OVER (PARTITION BY mandant_id,kl_art_id ORDER BY art_id DESC) = 1
) a
ON p.kl_art_id = a.kl_art_id
  AND p.mandant_id = a.mandant_id 

-- Ermittlung art_id für unbekannte Artikel_1 und alle Artikel_1, 
-- deren Kassen-wg nicht mit der wg_id arthiertyp_1 2 der Stammdaten übereinstimmt
LEFT OUTER JOIN DBP_ETL_PROCESS.dwh_wg_erfass_artikel_1 erf
ON p.mandant_id = erf.mandant_id 
  AND p.wg_id = erf.wg_id
  AND erf.arthiertyp_id = 2
  
-- Ermittlung MWST ID fuer Artikel_1 der WG Erfassung 
LEFT OUTER JOIN DBP_DATA.art_1 aerf
ON erf.mandant_id = aerf.mandant_id 
  AND erf.art_id = aerf.art_id 

-- Ermittlung der MWST-ID aus den Bondaten (fuehrend) 
LEFT OUTER JOIN DBP_DATA.mwst_per_1 mw
ON mw.mandant_id = p.mandant_id 
  AND p.dat BETWEEN mw.dat_von AND mw.dat_bis
  AND p.mwst_id = mw.mwst_id
  AND COALESCE(mw.mwst, 0) <> 0 

-- Ermittlung der MWST-ID aus den Stammdaten (falls in Bondaten nicht korrekt gepflegt
LEFT OUTER JOIN DBP_DATA.mwst_per_1 mws
ON mws.mandant_id = p.mandant_id 
  AND p.dat BETWEEN mws.dat_von AND mws.dat_bis
  AND COALESCE(a.mwst_id, aerf.mwst_id) = mws.mwst_id
    
-- Ermittlung des Bezugsweges (Default ist 4) aus Stammdaten
LEFT OUTER JOIN DBP_DATA.art_wup_zu_per_1  aw
ON p.mandant_id = aw.mandant_id
  AND p.wup_id = aw.wup_id
  -- Artikelnummer aus Stammdaten!!! s.o.
  AND COALESCE(a.art_id, erf.art_id, 0) = aw.art_id 
  AND p.dat BETWEEN aw.dat_von AND aw.dat_bis     

GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,16,17
HAVING (menge_ <> 0 OR umsatz_netto <> 0)
;

create or replace volatile table _snap_822 as (
select p.mandant_id
      ,'EUR' as wrg_1
      ,p.wup_id
      ,w.nb_id
      ,p.dat
      ,coalesce(a.posten_id,'') as posten_id
      ,coalesce(aw.bezugsweg_id, p.bezugsweg_id) as bezugsweg_id
      ,coalesce(a.art_id, erf.art_id, 0) as art_id
      ,coalesce(p.ean_kasse, 0) as ean_kasse 
      ,p.bewart_id
      ,coalesce(mw.mwst_id, mws.mwst_id) as mwst_id
      ,p.aktion_id
      ,sum(p.menge) as menge_
      ,sum(p.umsatz /(1 + coalesce(mw.mwst, mws.mwst) / 100)*(coalesce(mw.mwst, mws.mwst) / 100)) as umsatz_mwst_betrag
      ,sum(p.umsatz) - umsatz_mwst_betrag as umsatz_netto
      ,p.bewart_det_id
      ,'' as standard_aktion_id
      ,p.kundenkarte_id
from (select mandant_id
            ,wup_id
            ,dat
            ,kl_art_id
            ,ean_kasse
            ,wg_id
            ,cast(umsatz_brutto as float) as umsatz
            ,mwst_id
            ,menge
            ,case 
               when ltrim(aktion_id) in ('0','0000000000','') then 1001
               else 1002
             end as bewart_id
            ,case 
               when ltrim(aktion_id) in ('0','0000000000','') then ''
               else aktion_id
             end as aktion_id
            ,4 as bezugsweg_id
            ,case
               when x.bewart_det_id <> 888888 then x.bewart_det_id
               when ltrim(aktion_id) in ('0','0000000000','') and ((kundenkarte_id is null and kundenkarte_typ_id in (0)) or kundenkarte_typ_id IN (3,4)) then 100110
               when ltrim(aktion_id) in ('0','0000000000','') and kundenkarte_id is not null and kundenkarte_typ_id in (2) then 100111
               when ltrim(bby_aktion) in ('0','0000000000','') and bby_bewart = 1 and bonuskauf_id is not null  and customer_promotion_fg = 0 and trim(promotion_art) = 'COMMON' and (((kundenkarte_typ_id in (0,3,4) and kundenkarte_id is null) or trim(kundenkarte_id) is not null) or ((kundenkarte_typ_id in (1,2) and kundenkarte_id is not null) or trim(kundenkarte_id) is not null)) then 100130
               when ltrim(bby_aktion) in ('0','0000000000','') and bby_bewart = 1 and kundenkarte_id is not null  and kundenkarte_typ_id in (2)  and ((customer_promotion_fg = 1 and trim(promotion_art) = 'CUSTOMER') or(customer_promotion_fg = 1 and trim(promotion_art) = 'PERSONAL') or (customer_promotion_fg = 0 and trim(promotion_art) = 'COMMON')) then 100131  
               when ltrim(aktion_id) not in ('0','0000000000','') and ((kundenkarte_id is null and kundenkarte_typ_id in (0)) or kundenkarte_typ_id IN (3,4)) and aktion_id_obv is not null and (bonuskauf_id is null or bonuskauf_id = 0) then 100210
               when ltrim(aktion_id) not in ('0','0000000000','') and kundenkarte_id is not null and kundenkarte_typ_id in (2) and aktion_id_obv is not null and (( (important = 'N' or important is null) and bonuskauf_id is not null) or ( (important = 'Y' or important is null) and (bonuskauf_id is null or bonuskauf_id = 0))) then 100211
               when ltrim(aktion_id) not in ('0','0000000000','') and bonuskauf_id is not null and ((kundenkarte_id is null and kundenkarte_typ_id in (0)) or kundenkarte_typ_id IN (3,4)) and customer_promotion_fg = 0 and promotion_art = 'COMMON' then 100220
               when ltrim(aktion_id) not in ('0','0000000000','') and bonuskauf_id is not null and kundenkarte_id is not null and kundenkarte_typ_id in (2) and customer_promotion_fg = 0 and promotion_art = 'COMMON' then 100221
               when ltrim(aktion_id) not in ('0','0000000000','') and bonuskauf_id is not null and customer_promotion_fg = 1 and promotion_art = 'CUSTOMER' then 100231 
               when ltrim(aktion_id) not in ('0','0000000000','') and bonuskauf_id is not null and customer_promotion_fg = 1 and promotion_art = 'PERSONAL' then 100241
               else 9999
	         end as bewart_det_id
            ,kundenkarte_id
      from _artbew_822 x
      where dat >= '2022-04-01' and
            wg_id in (822)) p

join dbp_data.wup_1 w
  on w.mandant_id = p.mandant_id and
     w.wup_id = p.wup_id

left join (select mandant_id
                 ,art_id
                 ,kl_art_id
                 ,posten_id
                 ,mwst_id 
           from dbp_data.art_1 
           qualify row_number() over (partition by mandant_id,kl_art_id order by art_id desc) = 1) a
  on p.kl_art_id = a.kl_art_id and 
     p.mandant_id = a.mandant_id 

left join dbp_etl_process.dwh_wg_erfass_artikel_1 erf
  on p.mandant_id = erf.mandant_id and 
     p.wg_id = erf.wg_id and 
     erf.arthiertyp_id = 2

left join dbp_data.art_1 aerf
  on erf.mandant_id = aerf.mandant_id and
     erf.art_id = aerf.art_id 

left join dbp_data.mwst_per_1 mw
  on mw.mandant_id = p.mandant_id and 
     p.dat between mw.dat_von and mw.dat_bis and 
     p.mwst_id = mw.mwst_id and 
     coalesce(mw.mwst, 0) <> 0 

left join dbp_data.mwst_per_1 mws
  on mws.mandant_id = p.mandant_id and 
     p.dat between mws.dat_von and mws.dat_bis and 
     coalesce(a.mwst_id, aerf.mwst_id) = mws.mwst_id
    
left join dbp_data.art_wup_zu_per_1 aw
  on p.mandant_id = aw.mandant_id and 
     p.wup_id = aw.wup_id and 
     coalesce(a.art_id, erf.art_id, 0) = aw.art_id and 
     p.dat between aw.dat_von and aw.dat_bis     

group by 1,2,3,4,5,6,7,8,9,10,11,12,16,17,18
having (menge_ <> 0 or umsatz_netto <> 0)
);

INSERT INTO _artbew_tmp2
(
   mandant_id
  ,wrg_1
  ,wup_id
  ,nb_id
  ,dat
  ,posten_id
  ,bezugsweg_id
  ,art_id
  ,ean_kasse 
  ,bewart_id
  ,mwst_id
  ,aktion_id
  ,menge
  ,umsatz_mwst_betrag
  ,umsatz_netto
  ,bewart_det_id
  ,kundenkarte_id
)
select mandant_id
      ,wrg_1
      ,wup_id
      ,nb_id
      ,dat
      ,posten_id
      ,bezugsweg_id
      ,art_id
      ,ean_kasse 
      ,bewart_id
      ,mwst_id
      ,aktion_id
      ,menge_
      ,umsatz_mwst_betrag
      ,umsatz_netto
      ,bewart_det_id
      ,kundenkarte_id
from _snap_822
;

update _artbew_tmp2 set bewart_id = 1001
where bewart_det_id in (100110,100111,100121,100130,100131)
;

update _artbew_tmp2 from (

select x.mandant_id,
       x.bon_dat,
       x.wup_id,
       x.art_id
from (select a.mandant_id,
             a.bon_dat,
             a.wup_id,
             b.art_id,
             a.bon_id,
             a.bon_zeile
      from dbp_ods.ods_promotion_1 a
      join (select mandant_id
                  ,art_id
                  ,kl_art_id
            from dbp_data.art_1
            qualify row_number() over (partition by mandant_id,kl_art_id order by art_id desc) = 1) b
        on a.mandant_id = b.mandant_id and
           a.kl_art_id = b.kl_art_id
      where (a.mandant_id,a.bon_id,a.bon_zeile,a.bon_dat,a.wup_id) in (select mandant_id,
                                                                              bon_id,
                                                                              bon_zeile,
                                                                              bon_dat,
                                                                              wup_id
                                                                       from dbp_ods.ods_promotion_1
                                                                       where promotion_art in ('PERSONAL_SMP')
                                                                       group by 1,2,3,4,5)
      group by 1,2,3,4,5,6
      having count(distinct a.promotion_art) = 1) x
group by 1,2,3,4

) b

set bewart_id = 1001,
    bewart_det_id = 100121
                                    
where _artbew_tmp2.mandant_id = b.mandant_id and
      _artbew_tmp2.art_id = b.art_id and
      _artbew_tmp2.dat = b.bon_dat and
      _artbew_tmp2.wup_id = b.wup_id and
      _artbew_tmp2.bewart_det_id = 9999 and
      _artbew_tmp2.bewart_id = 1002
;

delete from _artbew_tmp2
where mandant_id = 1 and
      art_id = 2076821600
;

delete from dbp_data.crm_kartebew_1 a
where mandant_id = 1 and 
      dat in (select dat from dbp_etl.bon_artbew_dat_1) and
     (mandant_id,wup_id,dat) in (select mandant_id,wup_id,dat from _artbew_tmp2)
;

insert into dbp_data.crm_kartebew_1 (mandant_id
                                  ,wup_id
                                  ,nb_id
                                  ,kundenkarte_id
                                  ,dat
                                  ,wrg_id
                                  ,umsatz_netto_sa
                                  ,umsatz_netto_af
                                  ,umsatz_brutto_sa
                                  ,umsatz_brutto_af
                                  ,anz_bons
                                  ,td_insert
                                  ,td_update
                                  ,loyalty_berechtigt_fg)
select aktc.mandant_id,
       aktc.wup_id,
       aktc.nb_id,
       aktc.kundenkarte_id,
       aktc.dat,
       aktc.wrg_1,
       sum(case when aktc.bewart_id = 1002 then aktc.umsatz_netto else 0 end) as umsatz_netto_sa,
       sum(case when aktc.bewart_id = 1001 then aktc.umsatz_netto else 0 end) as umsatz_netto_af,
       sum(case when aktc.bewart_id = 1002 then aktc.umsatz_netto + aktc.umsatz_mwst_betrag else 0 end) as umsatz_brutto_sa,
       sum(case when aktc.bewart_id = 1001 then aktc.umsatz_netto + aktc.umsatz_mwst_betrag else 0 end) as umsatz_brutto_af,
       max(k.anz_bon) as anz_bons,
       current_timestamp,
       current_timestamp,
       9 as loyalty_berechtigt_fg
from _artbew_tmp2 aktc
join _crm_keys k
  on aktc.mandant_id = k.mandant_id and
     aktc.wup_id = k.wup_id and
     aktc.kundenkarte_id = k.kundenkarte_id and
     aktc.dat = k.dat
left join dbp_data.bewart_det_ecommerce_1 bde
  on aktc.mandant_id = bde.mandant_id and 
     aktc.kundenkarte_id = bde.kundenkarte_id
where aktc.kundenkarte_id is not null and 
      bde.kundenkarte_id is null
group by 1,2,3,4,5,6
;

update dbp_data.crm_kartebew_1
set loyalty_berechtigt_fg =
    case
        when (kundenkarte_id, mandant_id) in (
            select kundenkarte_id, mandant_id
            from(
            select kundenkarte_id, mandant_id, 1
            from dbp_data.crm_l_kundenkarte_1 
            where (kundenkarte_id, mandant_id) in (
                select kundenkarte_id, mandant_id
                from dbp_data.crm_l_kundenkarte_1
                where crm_konto_id is not null
                group by all)
            )group by all
        ) then 1
        else 0
    end
where loyalty_berechtigt_fg = 9
;

--DROP TABLE IF EXISTS dbp_etl.bon_artbew_tmp_talon_1;
DROP TABLE IF EXISTS DBP_ETL.bon_artbew_dat_1;
DROP TABLE IF EXISTS DBP_ETL.bon_artbew_tag_1;
