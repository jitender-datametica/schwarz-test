create or replace volatile table _dedup as (
select *
from ${TEMP_TABLE}
where mbew_fg = 1
qualify row_number() over (partition by art_id,mandant_id,bewertungskreis_id order by art_id,mandant_id,bewertungskreis_id,dat_aenderung desc) = 1
);

delete from ${TEMP_TABLE}
where mbew_fg = 1
;

insert into ${TEMP_TABLE}
select *
from _dedup
;

INSERT INTO ${TEMP_TABLE} (mandant_id
                                                                  ,art_id
                                                                  ,bewertungskreis_id
                                                                  ,wrg_id
                                                                  ,dat_aenderung
                                                                  ,menge_bestand_bme
                                                                  ,wert_bestand
                                                                  ,vk_wert
                                                                  ,mbew_fg
                                                                  ,gjmo
                                                                  ,gjmo_bis
                                                                  ,bewertung_klasse_id
                                                                  ,preis_steuer_kz
                                                                  ,gld
                                                                  ,standard_preis
                                                                  ,dat_letzte_preisaenderung
                                                                  ,vk_wert_netto)
SELECT mandant_id
      ,art_id
      ,bewertungskreis_id
      ,wrg_id
      ,dat_aenderung
      ,menge_bestand_bme
      ,wert_bestand
      ,vk_wert
      ,mbew_fg
      ,gjmo
      ,gjmo_bis
      ,bewertung_klasse_id
      ,preis_steuer_kz
      ,gld
      ,standard_preis
      ,dat_letzte_preisaenderung
      ,vk_wert_netto
FROM DBP_DATA.art_bewertungskreis_periode
WHERE (mandant_id,art_id,bewertungskreis_id,gjmo_bis) IN (SELECT mandant_id,art_id,bewertungskreis_id,MAX(gjmo_bis) AS gjmo_bis 
                                                          FROM (SELECT a.mandant_id,a.art_id,a.bewertungskreis_id,a.gjmo_bis
                                                                FROM DBP_DATA.art_bewertungskreis_periode a
                                                                JOIN (SELECT mandant_id,art_id,bewertungskreis_id,MIN(gjmo_bis) AS gjmo_bis_
                                                                      FROM ${TEMP_TABLE}
	                                                              WHERE mbew_fg = 0
	                                                              GROUP BY 1,2,3) b
                                                                  ON a.mandant_id = b.mandant_id AND
                                                                     a.art_id = b.art_id AND 
                                                                     a.bewertungskreis_id = b.bewertungskreis_id AND 
                                                                     a.gjmo_bis < b.gjmo_bis_ ) x
                                                          GROUP BY 1,2,3) AND 
       mbew_fg = 0
;

/*
#------------------------------------------------------------------------------
# 4.) Loeschen bestehender Datensätze
#     das koennen entweder neue Mbew Sätze sein (diese sind bis unendlich gueltig)
#     oder bestehende mbewh Daten
#------------------------------------------------------------------------------
*/

DELETE FROM DBP_DATA.art_bewertungskreis_periode
WHERE (mandant_id,art_id,bewertungskreis_id,gjmo_bis,mbew_fg) IN (SELECT mandant_id,art_id,bewertungskreis_id,gjmo_bis,mbew_fg
                                                                  FROM ${TEMP_TABLE}
                                                                  WHERE mbew_fg = 1)
;

DELETE FROM DBP_DATA.art_bewertungskreis_periode
WHERE (mandant_id,art_id,bewertungskreis_id,gjmo_bis,mbew_fg) IN (SELECT a.mandant_id,a.art_id,a.bewertungskreis_id,a.gjmo_bis,a.mbew_fg
                                                                  FROM DBP_DATA.art_bewertungskreis_periode a
                                                                  JOIN (SELECT mandant_id,art_id,bewertungskreis_id,MIN(gjmo_bis) AS gjmo_bis_
                                                                        FROM ${TEMP_TABLE}
	                                                                WHERE mbew_fg = 0
                                                                        GROUP BY 1,2,3) b
                                                                    ON a.mandant_id = b.mandant_id AND 
                                                                       a.art_id = b.art_id AND 
                                                                       a.bewertungskreis_id = b.bewertungskreis_id AND 
                                                                       a.gjmo_bis >= b.gjmo_bis_)
;
/*
#------------------------------------------------------------------------------
# 6.) Korrigieren der Historie
#     (nur bei den MBEWH Daten erforderlich, MBEW MUSS bereits korrekt sein)
#------------------------------------------------------------------------------
*/

UPDATE ${TEMP_TABLE} 
SET gjmo = gjmo_ab_

FROM (SELECT
  mandant_id
 ,art_id
 ,bewertungskreis_id
 ,gjmo_bis
 ,TO_DATE(TO_CHAR(gjmo_bis),'YYYYMM') AS gjmo_bis_dat
 , LAG(gjmo_bis_dat,1) OVER (PARTITION BY mandant_id,art_id,bewertungskreis_id
    ORDER BY gjmo_bis_dat ASC NULLS LAST) as lag_test
 ,CASE 
    WHEN lag_test is null
    THEN TO_DATE(TO_CHAR(gjmo),'YYYYMM')
    ELSE ADD_MONTHS(lag_test, 1)
  END AS dat_ab
 , TO_NUMBER(TO_CHAR(dat_ab,'YYYYMM')) AS gjmo_ab_ 
 FROM ${TEMP_TABLE}
 WHERE mbew_fg = 0 and try_to_date(to_char(gjmo),'YYYYMM') is not null
 QUALIFY gjmo_ab_ <> gjmo) d
 WHERE ${TEMP_TABLE}.mandant_id         = d.mandant_id
  AND ${TEMP_TABLE}.art_id             = d.art_id
  AND ${TEMP_TABLE}.bewertungskreis_id = d.bewertungskreis_id
  AND ${TEMP_TABLE}.gjmo_bis           = d.gjmo_bis
  AND ${TEMP_TABLE}.gjmo              <> d.gjmo_ab_
;

/*
#------------------------------------------------------------------------------
# 7.) Aktualisieren der Artikel-Bewertungskreis Kombinationen in der Zieltabelle
#------------------------------------------------------------------------------
*/

INSERT INTO DBP_DATA.art_bewertungskreis_periode (mandant_id
                                                               ,art_id
                                                               ,bewertungskreis_id
                                                               ,wrg_id
                                                               ,dat_aenderung
                                                               ,menge_bestand_bme
                                                               ,wert_bestand
                                                               ,vk_wert
                                                               ,mbew_fg
                                                               ,gjmo
                                                               ,gjmo_bis
                                                               ,bewertung_klasse_id
                                                               ,preis_steuer_kz
                                                               ,gld
                                                               ,standard_preis
                                                               ,dat_letzte_preisaenderung
                                                               ,vk_wert_netto)
SELECT mandant_id
      ,art_id
      ,bewertungskreis_id
      ,wrg_id
      ,dat_aenderung
      ,menge_bestand_bme
      ,wert_bestand
      ,vk_wert
      ,mbew_fg
      ,gjmo
      ,gjmo_bis
      ,bewertung_klasse_id
      ,preis_steuer_kz
      ,gld
      ,standard_preis
      ,dat_letzte_preisaenderung
      ,vk_wert_netto
FROM ${TEMP_TABLE}
;

UPDATE DBP_DATA.art_bewertungskreis_periode SET gjmo = gjmo_bis
WHERE gjmo = 190001
;
