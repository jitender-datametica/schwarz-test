CREATE OR REPLACE TABLE DBP_ETL.art_gp_wup_zu_per_kmo_tmp_1 (
  mandant_id              BYTEINT NOT NULL,
  art_id                  INTEGER NOT NULL,
  gp_id                   INTEGER NOT NULL,
  wup_id                  INTEGER NOT NULL,
  nb_id                   SMALLINT ,
  einkaufsorganisation_id SMALLINT NOT NULL,
  dat_von                 DATE NOT NULL,
  dat_bis                 DATE,
  ek_brutto               DECIMAL(18,4),
  ek_netto                DECIMAL(18,4),
  ek_nettonetto           DECIMAL(18,4),
  ek_kal_basis            DECIMAL(18,4),
  ek_mep                  DECIMAL(18,4),
  einstandspreis          DECIMAL(18,4),
  logistikkostenzuschlag  DECIMAL(18,4),
  bezugsweg_id            BYTEINT NOT NULL,
  wrg_id                  CHAR(3),
  komponentenmenge        DECIMAL(18,4),
  ek_brutto_nrfb_rab      DECIMAL(18,4),
  bonusbasis              DECIMAL(18,4),
  bezugsnebenkosten       DECIMAL(18,4),
  zollwert                DECIMAL(9,4),
  ek_netto_bnk            DECIMAL(18,4),
  ek_netto_bnk_sachk      DECIMAL(18,4),
  ek_mep_vor_fwu          DECIMAL(18,4),
  cycle_id                INTEGER,
  ek_brutto_normal        DECIMAL(18,4)
);

DELETE FROM DBP_ETL.kmo_zekp_1
WHERE abrut = 0
;

INSERT INTO DBP_ETL.art_gp_wup_zu_per_kmo_tmp_1
(
   mandant_id
  ,art_id
  ,gp_id
  ,wup_id
  ,nb_id
  ,einkaufsorganisation_id
  ,dat_von
  ,dat_bis
  ,ek_brutto
  ,ek_netto
  ,ek_nettonetto
  ,ek_kal_basis
  ,ek_mep
  ,einstandspreis
  ,logistikkostenzuschlag
  ,bezugsweg_id
  ,wrg_id
  ,komponentenmenge
  ,ek_brutto_nrfb_rab
  ,bonusbasis
  ,bezugsnebenkosten
  ,zollwert
  ,ek_netto_bnk
  ,ek_netto_bnk_sachk
  ,ek_mep_vor_fwu
  ,cycle_id
  ,ek_brutto_normal
)
SELECT
   mandant_id
  ,art_id_
  ,gp_id
  ,wup_id
  ,nb_id
  ,einkaufsorganisation_id
  ,dat_von
  ,dat_bis
  ,ek_brutto
  ,ek_netto
  ,ek_nettonetto
  ,ek_kal_basis
  ,ek_mep
  ,einstandspreis
  ,logistikkostenzuschlag
  ,bezugsweg_id
  ,wrg_id
  ,komponentenmenge
  ,ek_brutto_nrfb_rab
  ,bonusbasis
  ,bezugsnebenkosten
  ,zollwert
  ,ek_netto_bnk
  ,ek_netto_bnk_sachk
  ,ek_mep_vor_fwu
  ,cycle_id
  ,ek_brutto_normal
FROM
(
  SELECT
     l.mandant_id
    ,a.art_id_
    ,g.gp_id
    ,CASE WHEN werks = 0 THEN -1 ELSE w.wup_id END AS wup_id
    ,CASE WHEN werks = 0 THEN NULL ELSE w.nb_id END nb_id
    ,g.einkaufsorganisation_id
    ,datab AS dat_von
    ,datbis AS dat_bis
    ,abrut as ek_brutto
    ,aknet as ek_netto
    ,aknne as ek_nettonetto
    ,ekkba AS ek_kal_basis
    ,mepre AS ek_mep
    ,lsein AS einstandspreis
    ,COALESCE
     (
       CASE WHEN w.nb_id <> -111 OR
                (abrut = 0 AND aknet = 0 AND aknne = 0 AND ekkba = 0 AND mepre = 0 AND lsein = 0)
            THEN 0
            ELSE lokau
       END, 0
     ) AS logistikkostenzuschlag
    ,0 AS bezugsweg_id
    ,COALESCE(l.wrg_1 collate '',default_wrg collate '') AS wrg_id
    ,1 AS komponentenmenge
    ,abrna AS ek_brutto_nrfb_rab
    ,abonba AS bonusbasis
    ,bnk AS bezugsnebenkosten
    ,zollba AS zollwert
    ,aknb AS ek_netto_bnk
    ,aknbs AS ek_netto_bnk_sachk
    ,mepol AS ek_mep_vor_fwu
    ,cycle_id
    ,ebrut AS ek_brutto_normal
  FROM DBP_ETL.kmo_zekp_1 l

  INNER JOIN
  (
    SELECT
       mandant_id
      ,kl_art_id
      ,MAX(art_id) AS art_id_
    FROM DBP_DATA.art_1
    GROUP BY
       mandant_id
      ,kl_art_id
  ) a
  ON l.mandant_id = a.mandant_id
    AND l.matnr   = a.kl_art_id

  INNER JOIN DBP_DATA.gp_1 g
  ON l.mandant_id = g.mandant_id
    AND l.lifnr   = g.gp_id

  INNER JOIN DBP_DATA.mandant_1 m
  ON l.mandant_id = m.mandant_id

  LEFT OUTER JOIN DBP_DATA.wup_1 w
  ON l.mandant_id = w.mandant_id
    AND l.werks   = w.wup_id
) a
;

INSERT INTO DBP_ETL.art_gp_wup_zu_per_kmo_tmp_1
(
   mandant_id
  ,art_id
  ,gp_id
  ,wup_id
  ,nb_id
  ,einkaufsorganisation_id
  ,dat_von
  ,dat_bis
  ,ek_brutto
  ,ek_netto
  ,ek_nettonetto
  ,ek_kal_basis
  ,ek_mep
  ,einstandspreis
  ,logistikkostenzuschlag
  ,bezugsweg_id
  ,wrg_id
  ,komponentenmenge
  ,ek_brutto_nrfb_rab
  ,bonusbasis
  ,bezugsnebenkosten
  ,zollwert
  ,ek_netto_bnk
  ,ek_netto_bnk_sachk
  ,ek_mep_vor_fwu
  ,cycle_id
  ,ek_brutto_normal
)
SELECT
   a.mandant_id
  ,a.art_id
  ,a.gp_id
  ,a.wup_id
  ,a.nb_id
  ,a.einkaufsorganisation_id
  ,a.dat_von
  ,a.dat_bis
  ,a.ek_brutto
  ,a.ek_netto
  ,a.ek_nettonetto
  ,a.ek_kal_basis
  ,a.ek_mep
  ,a.einstandspreis
  ,a.logistikkostenzuschlag
  ,a.bezugsweg_id
  ,a.wrg_id
  ,a.komponentenmenge
  ,a.ek_brutto_nrfb_rab
  ,a.bonusbasis
  ,a.bezugsnebenkosten
  ,a.zollwert
  ,a.ek_netto_bnk
  ,a.ek_netto_bnk_sachk
  ,a.ek_mep_vor_fwu
  ,a.cycle_id
  ,a.ek_brutto_normal
FROM DBP_DATA.art_gp_wup_zu_per_1 a

INNER JOIN
(
  SELECT
     mandant_id
    ,art_id
    ,gp_id
    ,wup_id
    ,bezugsweg_id
    ,MIN(dat_von) AS dat_von_
  FROM DBP_ETL.art_gp_wup_zu_per_kmo_tmp_1

  GROUP BY
     mandant_id
    ,art_id
    ,gp_id
    ,wup_id
    ,bezugsweg_id
) b
ON a.mandant_id = b.mandant_id
  AND a.art_id = b.art_id
  AND a.gp_id = b.gp_id
  AND a.wup_id = b.wup_id
  AND a.bezugsweg_id = b.bezugsweg_id
  AND a.dat_bis >= b.dat_von_
  AND a.dat_von < b.dat_von_
;

UPDATE DBP_ETL.art_gp_wup_zu_per_kmo_tmp_1
SET   dat_bis = dt1.dat_bis_

FROM
(
SELECT x.*
FROM (
SELECT
     l.mandant_id
    ,l.wup_id
    ,l.nb_id
    ,l.art_id
    ,l.dat_von
    ,l.gp_id
    ,l.bezugsweg_id
    ,CASE
	   WHEN (SUM(to_number(to_char(DAT_VON,'YYYYMMDD'))) OVER (PARTITION BY mandant_id, wup_id, nb_id, art_id, gp_id, bezugsweg_id ORDER BY dat_von DESC NULLS LAST ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) - to_number(to_char(dat_von,'YYYYMMDD'))) = 0 
       THEN to_date('9999-12-31','YYYY-MM_1-DD')
	   ELSE dateadd(day,-1,to_date(to_char((SUM(to_number(to_char(DAT_VON,'YYYYMMDD'))) OVER (PARTITION BY mandant_id, wup_id, nb_id, art_id, gp_id, bezugsweg_id ORDER BY DAT_VON DESC NULLS LAST ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) - to_number(to_char(dat_von,'YYYYMMDD')))),'YYYYMMDD'))
     END AS dat_bis_
  FROM DBP_ETL.art_gp_wup_zu_per_kmo_tmp_1 l
  group by 1,2,3,4,5,6,7) x
WHERE x.dat_von <= x.dat_bis_
) dt1
WHERE DBP_ETL.art_gp_wup_zu_per_kmo_tmp.mandant_id              = dt1.mandant_id
  AND DBP_ETL.art_gp_wup_zu_per_kmo_tmp.wup_id                  = dt1.wup_id
  AND DBP_ETL.art_gp_wup_zu_per_kmo_tmp.art_id                  = dt1.art_id
  AND DBP_ETL.art_gp_wup_zu_per_kmo_tmp.dat_von                 = dt1.dat_von
  AND DBP_ETL.art_gp_wup_zu_per_kmo_tmp.gp_id                   = dt1.gp_id
  AND DBP_ETL.art_gp_wup_zu_per_kmo_tmp.bezugsweg_id            = dt1.bezugsweg_id
  AND DBP_ETL.art_gp_wup_zu_per_kmo_tmp.dat_bis                <> dt1.dat_bis_
;

DELETE FROM DBP_DATA.art_gp_wup_zu_per_1
WHERE
  (
     mandant_id
    ,art_id
    ,gp_id
    ,wup_id
    ,dat_von
    ,bezugsweg_id
  ) IN
  (
    SELECT
       a.mandant_id
      ,a.art_id
      ,a.gp_id
      ,a.wup_id
      ,a.dat_von
      ,a.bezugsweg_id
    FROM DBP_DATA.art_gp_wup_zu_per_1 a

    INNER JOIN
    (
      SELECT
         mandant_id
        ,art_id
        ,gp_id
        ,wup_id
        ,bezugsweg_id
        ,MIN(dat_von) AS dat_von_
      FROM DBP_ETL.art_gp_wup_zu_per_kmo_tmp_1

      GROUP BY
         mandant_id
        ,art_id
        ,gp_id
        ,wup_id
        ,bezugsweg_id
    ) b
    ON a.mandant_id = b.mandant_id
      AND a.art_id = b.art_id
      AND a.gp_id = b.gp_id
      AND a.wup_id = b.wup_id
      AND a.bezugsweg_id = b.bezugsweg_id
      AND a.dat_von >= b.dat_von_
  )
;

INSERT INTO DBP_DATA.art_gp_wup_zu_per_1
(
   cycle_id
  ,mandant_id
  ,art_id
  ,gp_id
  ,wup_id
  ,nb_id
  ,einkaufsorganisation_id
  ,dat_von
  ,dat_bis
  ,ek_brutto
  ,ek_netto
  ,ek_nettonetto
  ,ek_kal_basis
  ,ek_mep
  ,einstandspreis
  ,logistikkostenzuschlag
  ,bezugsweg_id
  ,wrg_id
  ,komponentenmenge
  ,ek_brutto_nrfb_rab
  ,bonusbasis
  ,bezugsnebenkosten
  ,zollwert
  ,ek_netto_bnk
  ,ek_netto_bnk_sachk
  ,ek_mep_vor_fwu
  ,ek_brutto_normal
  ,td_insert
  ,td_update
)
SELECT
   cycle_id
  ,mandant_id
  ,art_id
  ,gp_id
  ,wup_id
  ,nb_id
  ,einkaufsorganisation_id
  ,dat_von
  ,dat_bis
  ,ek_brutto
  ,ek_netto
  ,ek_nettonetto
  ,ek_kal_basis
  ,ek_mep
  ,einstandspreis
  ,logistikkostenzuschlag
  ,bezugsweg_id
  ,wrg_id
  ,komponentenmenge
  ,ek_brutto_nrfb_rab
  ,bonusbasis
  ,bezugsnebenkosten
  ,zollwert
  ,ek_netto_bnk
  ,ek_netto_bnk_sachk
  ,ek_mep_vor_fwu
  ,ek_brutto_normal
  ,CURRENT_TIMESTAMP
  ,CURRENT_TIMESTAMP
FROM DBP_ETL.art_gp_wup_zu_per_kmo_tmp_1
;

/**************** SPEC0243147 - Hrvoje **********/

DELETE FROM DBP_MSI_DATA.ART_GP_WUP_RUECKBEWERTUNG_MO_1 
 WHERE DAT_ABZUG= CURRENT_DATE
;
 
INSERT INTO DBP_MSI_DATA.ART_GP_WUP_RUECKBEWERTUNG_MO_1
(MANDANT_ID,
 KJMO,
 ART_ID,
 GP_ID,
 WUP_ID,
 NB_ID,
 DAT_GUELTIG_VON,
 DAT_GUELTIG_BIS,
 DAT_ABZUG,
 WRG_ID,
 PREIS_EK_MEP,
 PREIS_EK_NETTO_BNK,
 PREIS_EK_EINSTANDSPREIS,
 PREIS_EK_NETTONETTO,
 PREIS_KMEP_EINH_O_FWU,
 TD_UPDATE,
 TD_INSERT,
 PREIS_EK_MEP_VOR_FWU
)
/* ogas0311: Berechnung des 2-ten Arbeitstages in Monat_1, Feiertage und Sonntage sind ausgeschloessen */
WITH arbeitstag_berechnung as (
select year(dat)*100+month(dat) as jahr_monat,
 case when min(erste)+min(zweite) =2 then 2
      when min(erste)+min(zweite)+min(dritte)=2 then 3
      when min(erste)+min(zweite)+min(dritte)+min(vierte) =2 then 4
      when min(erste)+min(zweite)+min(dritte)+min(vierte)+min(fuenfte) =2 then 5 END as tag_ausfuerung
 
 FROM
 (    SELECT dat,
             case when day(dat) = 1 then erste else 1 end as erste,
             case when day(dat) = 2 then zweite else 1 end as zweite,
             case when day(dat) = 3 then dritte else 1 end as dritte,
             case when day(dat) = 4 then vierte else 1 end as vierte,
             case when day(dat) = 5 then fuenfte else 1 end as fuenfte
FROM (
select  tag.dat as dat,    
 case when COALESCE(day(a.dat), -1) =1 or tag.WTAG_ID =7 then 0 else 1 end as erste,
  case when COALESCE(day(a.dat), -1) =2 or tag.WTAG_ID =7 then 0 else 1 end as zweite, 
   case when COALESCE(day(a.dat), -1) =3 or tag.WTAG_ID =7 then 0 else 1 end as dritte,
    case when COALESCE(day(a.dat), -1) =4 or tag.WTAG_ID =7 then 0 else 1 end as vierte,
     case when COALESCE(day(a.dat), -1) =5 or tag.WTAG_ID =7 then 0 else 1 end as fuenfte 
 from  DBP_DATA.tag_1
   LEFT JOIN
   (
  SELECT
        t1.Land_id as land_id
        ,t3.dat as dat
        ,SUM(CASE WHEN t4.offen=0 THEN 1 ELSE 0 END) AS geschlossen
FROM    DBP_DATA.wup_1 t1_1
 
LEFT OUTER JOIN DBP_DATA.region_1 t2
        ON      t1.region_id=t2.region_id
        AND     t1.mandant_id=t2.mandant_id
        AND     t1.land_id = t2.land_id
 
INNER JOIN DBP_DATA.tag_1 t3
        ON t3.dat between t1.dat_von AND t1.dat_bis
 
LEFT OUTER JOIN DBP_DATA.wupcal_ereignis_zu_1 t4
        ON t4.wup_id=t1.wup_id 
        AND t4.nb_id=t1.nb_id
        AND t4.mandant_id=t1.mandant_id
        AND t4.dat = t3.dat
        AND t4.ereignistyp_id <> 2
 
WHERE t1.nb_id=0 
AND t1.Land_id = 'DE'  
GROUP BY 1,2 
  ) a  
   on a.dat = tag.dat   
  AND a.geschlossen >300
  WHERE DAY(tag.dat) between 1 and 5   
    
  ) b
  where  year(dat)*100+month(dat) = year(CURRENT_DATE)*100+month(CURRENT_DATE)
  )
  group by 1
)

SELECT DISTINCT
       art.MANDANT_ID,
       CAST(to_varchar(ADD_MONTHS(CURRENT_DATE,-1), 'YYYYMM') AS INTEGER) AS  KJMO,
       art.ART_ID,       
       art.GP_ID,
       art.WUP_ID,
       COALESCE(art.NB_ID, -199) as NB_ID,      
       ums.DAT_VON as DAT_GUELTIG_VON,
       ums.DAT_BIS as DAT_GUELTIG_BIS,
       CURRENT_DATE as DAT_ABZUG,
       art.WRG_ID,
       art.EK_MEP as PREIS_EK_MEP,
       art.EK_NETTO_BNK as PREIS_EK_NETTO_BNK,
       art.EINSTANDSPREIS as PREIS_EK_EINSTANDSPREIS,
       art.EK_NETTONETTO as PREIS_EK_NETTONETTO,
       ums.BETRAG_KMEP_EINH_O_FWU as PREIS_KMEP_EINH_O_FWU,
       CURRENT_TIMESTAMP as TD_UPDATE,
       CURRENT_TIMESTAMP as TD_INSERT,
        art.EK_MEP_VOR_FWU as PREIS_EK_MEP_VOR_FWU
  FROM DBP_DATA.ART_GP_WUP_ZU_PER_1 art_1
  JOIN arbeitstag_berechnung
    ON 1=1
  LEFT JOIN DBP_DATA.ART_UMSATZ_KMEP_ZU_PER_1 ums
    ON art.MANDANT_ID = ums.MANDANT_ID
   AND art.ART_ID = ums.ART_ID
 WHERE CURRENT_DATE between art.dat_von and art.dat_bis
   AND ums.ZEITRAUM_KZ='KM'
   --AND CURRENT_DATE between ums.dat_von and ums.dat_bis
   AND CAST(to_varchar(ums.dat_von, 'YYYYMM') AS INTEGER) >= CAST(to_varchar(ADD_MONTHS(CURRENT_DATE,-1), 'YYYYMM') AS INTEGER)
   AND CAST(to_varchar(ums.dat_bis, 'YYYYMM') AS INTEGER) <= CAST(to_varchar(ADD_MONTHS(CURRENT_DATE,-1), 'YYYYMM') AS INTEGER)
   AND arbeitstag_berechnung.jahr_monat = year(CURRENT_DATE)*100+month(CURRENT_DATE)  --202407 fuer Test_1
   AND arbeitstag_berechnung.tag_ausfuerung = day(CURRENT_DATE)  --2 fuer Test_1
;
