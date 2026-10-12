DROP TABLE IF EXISTS DBP_ETL.artbew_mis_dat;
CREATE TABLE DBP_ETL.artbew_mis_dat (
  dat DATE NOT NULL
);

INSERT INTO DBP_ETL.artbew_mis_dat (dat)
SELECT dat
FROM DBP_ETL.artbew_mis
GROUP BY dat
;

DELETE FROM DBP_ETL.artbew_mis
WHERE (mandant_id,wg_id,arthiertyp_id) in 
        (SELECT mandant_id, wg_id, arthiertyp_id 
         FROM DBP_DATA.wg_filter_zu 
         WHERE wg_filter_id = 38  
        )
AND umsatz_mwst_betrag = 0
;

delete from dbp_etl.artbew_mis
where (mandant_id,wg_id,arthiertyp_id) in (select mandant_id,wg_id,arthiertyp_id from dbp_data.wg_filter_zu where wg_filter_id = 49)
;

DELETE FROM DBP_ETL.artbew_mis
WHERE mandant_id = 1 
  AND art_id in (590006700,590006900) 
;

-- 22.10.2024,-dba-
-- Absatz raus fuer 823|002-004

update dbp_etl.artbew_mis from (select *
                                from dbp_data.art_wg_zu_per
                                where arthiertyp_id = 2 and
                                      dat_bis = '9999-12-31' and
                                      wg_id = 823 and
                                      wug_id in (2,3,4)) b

set menge = 0

where dbp_etl.artbew_mis.mandant_id = b.mandant_id and
      dbp_etl.artbew_mis.art_id = b.art_id
;

DELETE FROM DBP_DATA.artbew_wg_sum
WHERE (mandant_id,wup_id,dat) IN (SELECT mandant_id,wup_id,dat FROM DBP_ETL.artbew_mis) AND 
       dat IN (SELECT dat FROM DBP_ETL.artbew_mis_dat)
;

INSERT INTO DBP_DATA.artbew_wg_sum
(
   mandant_id
  ,wup_id
  ,nb_id
  ,wg_id
  ,arthiertyp_id
  ,bewart_id
  ,dat
  ,umsatz_brutto
  ,umsatz_netto
  ,umsatz_wrg
  ,umsatz_brutto_konz
  ,umsatz_netto_konz
  ,menge
  ,kjmo
  ,quelle
  ,umrechnungskurs_hist
)
SELECT
   mandant_id
  ,wup_id
  ,nb_id
  ,wg_id
  ,arthiertyp_id
  ,1001 AS bewart_id_
  ,dat
  ,SUM(umsatz_netto + umsatz_mwst_betrag) AS umsatz_brutto
  ,SUM(umsatz_netto)
  ,wrg AS umsatz_wrg
  ,SUM(umsatz_netto + umsatz_mwst_betrag + diff_umsatz_netto_konz + diff_umsatz_mwst_betrag_konz) AS umsatz_brutto_konz
  ,SUM(umsatz_netto + diff_umsatz_netto_konz) AS umsatz_netto_konz
  ,SUM(menge) AS menge_
  ,CAST(to_varchar(dat, 'YYYYMM') AS INTEGER) AS kjmo 
  ,1 AS quelle
  ,1 as umrechnungskurs_hist
FROM DBP_ETL.artbew_mis
WHERE wg_id is not null
GROUP BY mandant_id,wup_id,nb_id,wg_id,arthiertyp_id,bewart_id_,dat,umsatz_wrg,kjmo,quelle
;

UPDATE DBP_DATA.wupcal
SET datenlieferung_artbew_wg_sum = 1
,dat_extrakt_umsatz = CURRENT_DATE
WHERE (mandant_id,wup_id,dat) IN (SELECT mandant_id,wup_id,dat FROM DBP_ETL.artbew_mis WHERE nb_id IN (0,2,7))
;

INSERT INTO DBP_ETL_PROCESS.artbew_wg_sum_agg_wt (mandant_id
                                                 ,wup_id
                                                 ,nb_id
                                                 ,dat
                                                 ,calc_fg
                                                 ,dat_lief)
SELECT mandant_id
      ,wup_id
      ,nb_id
      ,dat
      ,0 AS calc_fg
      ,CURRENT_DATE as dat_lief
FROM DBP_ETL.artbew_mis
WHERE (mandant_id,wup_id,nb_id,dat) NOT IN (SELECT mandant_id,wup_id,nb_id,dat FROM DBP_ETL_PROCESS.artbew_wg_sum_agg_wt)
GROUP BY 1,2,3,4,5,6
;

DELETE FROM DBP_ETL.artbew_mis;
