CREATE  VOLATILE TABLE _art_wup_zu_per AS 
(
SELECT  mandant_id,
        art_id,
        wup_id,
        nb_id,
        dat_von,
        dat_bis,
        listung_id
FROM DBP_DATA.art_wup_zu_per_2
WHERE listung_id = 1 
AND dat_bis >= CURRENT_DATE-3
);

CREATE  VOLATILE TABLE _art_wg_zu_per AS (
SELECT art_id,
mandant_id,
wg_id
FROM DBP_DATA.art_wg_zu_per_2
WHERE arthiertyp_id = 2 AND
dat_bis = to_date('9999-12-31','YYYY-MM_2-DD')
);

CREATE  VOLATILE TABLE _final_tmp AS 
(
SELECT  v01.mandant_id
        ,v01.art_id
        ,v04.wg_id
        ,v01.wup_id
        ,v01.nb_id
        ,v02.kjwo
        ,v03.kreistyp_gruppe_id
        ,MAX (v01.listung_id) AS listung_id
FROM _art_wup_zu_per v01

JOIN DBP_DATA.tag_2 v02
ON v02.dat BETWEEN v01.dat_von AND v01.dat_bis

JOIN DBP_DATA.wup_2 v03
ON v01.wup_id = v03.wup_id AND
v01.nb_id = v03.nb_id AND
v01.mandant_id = v03.mandant_id

JOIN _art_wg_zu_per v04
ON v01.art_id = v04.art_id AND
v01.mandant_id = v04.mandant_id

WHERE v02.dat BETWEEN CURRENT_DATE-3 AND CURRENT_DATE-1
GROUP BY 1,2,3,4,5,6,7
);

DELETE FROM DBP_DATA.art_wup_listung_kjwo_2
WHERE (mandant_id,art_id,wup_id,kjwo) IN 
(SELECT mandant_id,art_id,wup_id,kjwo FROM _final_tmp)
;

INSERT INTO DBP_DATA.art_wup_listung_kjwo_2 
(        mandant_id
        ,art_id
        ,wg_id
        ,wup_id
        ,nb_id
        ,kjwo
        ,kreistyp_gruppe_id
        ,listung_id
)
SELECT   mandant_id
        ,art_id
        ,wg_id
        ,wup_id
        ,nb_id
        ,kjwo
        ,kreistyp_gruppe_id
        ,listung_id
FROM _final_tmp
;

DELETE FROM DBP_DATA.art_kreistyp_gruppe_wup_zu_2
;

INSERT INTO DBP_DATA.art_kreistyp_gruppe_wup_zu_2 
(mandant_id
,wup_id
,nb_id
,art_id
,kreistyp_gruppe_id)
SELECT awzp.mandant_id,
awzp.wup_id,
awzp.nb_id,
awzp.art_id,
w.kreistyp_gruppe_id
FROM DBP_DATA.art_wup_zu_per_2 awzp
JOIN DBP_DATA.wup_2 w
ON awzp.mandant_id = w.mandant_id AND
awzp.nb_id = w.nb_id AND
awzp.wup_id = w.wup_id
WHERE awzp.dat_bis = to_date('9999-12-31','YYYY-MM_2-DD')
;

CREATE  VOLATILE TABLE _art_list_wup_zu_per AS 
(
SELECT a.*
FROM DBP_DATA.art_list_wup_zu_per_2 a
JOIN DBP_DATA.art_wg_zu_per_2 b
ON a.mandant_id = b.mandant_id AND
a.art_id = b.art_id AND
b.arthiertyp_id = 2 AND
b.dat_bis = to_date('9999-12-31','YYYY-MM_2-DD')
JOIN DBP_DATA.wup_2 c
ON a.mandant_id = c.mandant_id AND
a.wup_id = c.wup_id
WHERE a.mandant_id = 1 AND
CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis AND
a.list_quelle_id IN ('1','3','7','C') AND
a.art_id/100 = a.struktur_art_id AND
a.nb_id = 0 AND
c.nb_id = 0 AND
c.dat_eroeffnung <= CURRENT_DATE
);

CREATE  VOLATILE TABLE _step0 AS (
SELECT mandant_id,
art_id
FROM DBP_DATA.sal_int_2
GROUP BY 1,2
);

CREATE  VOLATILE TABLE _step1 AS 
(
SELECT a11.art_id,
a11.mandant_id,
CASE WHEN MIN(a11.sm_id) <> 0 THEN 1 ELSE 0 END AS listung_min_1_SST_durchg_v1
FROM (SELECT lsl.art_id
,lsl.sm_id
,lsl.mandant_id
,lsl.list_durchg_fg
,lsl.anzahl_markt_soll
,ls.sternchen_id
FROM DBP_DATA.sternchen_logik_2 AS lsl
JOIN DBP_DATA.l_sternchen_2 AS ls
ON  lsl.list_durchg_fg = ls.list_durchg_fg
AND lsl.bezugsweg1_fg  = ls.bezugsweg1_fg
AND lsl.bezugsweg4_fg  = ls.bezugsweg4_fg
AND lsl.kdis0_fg       = ls.kdis0_fg
AND lsl.kdis1_fg       = ls.kdis1_fg
AND lsl.mandant_id     = ls.mandant_id
WHERE lsl.mandant_id = 1) a11
WHERE a11.mandant_id = 1 AND
a11.list_durchg_fg = 1
GROUP BY 1,2
);

CREATE  VOLATILE TABLE _step2 AS (
SELECT t1.art_id,
t1.mandant_id,
CASE
WHEN MAX(typ_ost_basis) <> 0 OR
MAX(typ_ost_gross) <> 0 OR
MAX(typ_sued_ost)  <> 0 OR
MAX(typ_sued_west) <> 0 OR
MAX(typ_west)      <> 0 OR
MAX(typ_nord)      <> 0
THEN 1
ELSE 0
END AS listung_min_1_region_durchg_v1
FROM (SELECT t1.art_id
, MAX(typ_ost_basis) AS typ_ost_basis
, MAX (typ_ost_gross) AS typ_ost_gross
, MAX (typ_sued_ost) AS typ_sued_ost
, MAX (typ_sued_west) AS typ_sued_west
, MAX (typ_west) AS typ_west
, MAX (typ_nord) AS typ_nord
, t1.mandant_id
FROM (SELECT v01.art_id
, CASE WHEN v01.kreistyp_gruppe_id = 'O' AND v01.list_durchg_fg = 1 THEN 1 ELSE 0 END AS typ_ost_basis
, CASE WHEN v01.kreistyp_gruppe_id = 'Q' AND v01.list_durchg_fg = 1 THEN 1 ELSE 0 END AS typ_ost_gross
, CASE WHEN v01.kreistyp_gruppe_id = 'G' AND v01.list_durchg_fg = 1 THEN 1 ELSE 0 END AS typ_sued_ost
, CASE WHEN v01.kreistyp_gruppe_id = 'M' AND v01.list_durchg_fg = 1 THEN 1 ELSE 0 END AS typ_sued_west
, CASE WHEN v01.kreistyp_gruppe_id = 'W' AND v01.list_durchg_fg = 1 THEN 1 ELSE 0 END AS typ_west
, CASE WHEN v01.kreistyp_gruppe_id = 'N' AND v01.list_durchg_fg = 1 THEN 1 ELSE 0 END AS typ_nord
, v01.mandant_id
FROM DBP_DATA.sternchen_logik_kreis_2 v01
WHERE v01.mandant_id = 1) t1_2
GROUP BY t1.art_id, t1.mandant_id) t1_2
WHERE t1.mandant_id = 1
GROUP BY 1,2
);

CREATE  VOLATILE TABLE _step3 AS (
SELECT a.art_id,
a.mandant_id,
a.sm_id
FROM DBP_ETL_PROCESS.art_sm_vw_zu_per_2 a
WHERE a.mandant_id = 1 AND
CURRENT_DATE BETWEEN a.dat_von AND a.dat_bis
GROUP BY 1,2,3
);

CREATE  VOLATILE TABLE _step4 AS (
SELECT  a.mandant_id,
        a.art_id,
        1 AS list_region_teresa
FROM _art_list_wup_zu_per a
JOIN DBP_DATA.wup_2 b
  ON a.mandant_id = b.mandant_id 
 AND a.wup_id = b.wup_id

JOIN DBP_DATA.woche_2 c
  ON 1 = 1

WHERE a.list_quelle_id IN ('3') 
  AND a.baustein_id  IN 
(SELECT baustein_id
 FROM DBP_ETL.baustein_region_zu_2
) 
  AND b.nb_id = 0 
  AND b.dat_eroeffnung < CURRENT_DATE

GROUP BY 1,2,3
);

CREATE  VOLATILE TABLE _sal_upd AS 
(
SELECT  a.mandant_id,
        a.art_id,
        COALESCE(b.listung_min_1_SST_durchg_v1,0) AS listung_min_1_sst_durchg_fg,
        COALESCE(CASE WHEN d.sm_id > 0 THEN 1 ELSE 0 END,0) AS listung_min_1_sst_durchg_mvke_fg,
        COALESCE(c.listung_min_1_region_durchg_v1,0) AS listung_min_1_region_durchg_fg,
        COALESCE(e.list_region_teresa,0) AS listung_min_1_region_durchg_baustein_fg
FROM _step0 a
LEFT JOIN _step1 b
   ON a.mandant_id = b.mandant_id 
  AND a.art_id = b.art_id
LEFT JOIN _step2 c
   ON a.mandant_id = c.mandant_id 
  AND a.art_id = c.art_id
LEFT JOIN _step3 d
   ON a.mandant_id = d.mandant_id 
  AND a.art_id = d.art_id
LEFT JOIN _step4 e
   ON a.mandant_id = e.mandant_id 
  AND a.art_id = e.art_id
);

CREATE  VOLATILE TABLE _sal_upd2 AS (
SELECT a.mandant_id,
a.art_id,
COALESCE(b.listung_min_1_wup_fg,0) AS listung_min_1_wup_fg
FROM _sal_upd a
LEFT JOIN (     SELECT a11.art_id,
                       a11.mandant_id,
                       1 AS listung_min_1_wup_fg
                FROM DBP_DATA.art_list_wup_zu_per_2 a11
                WHERE CURRENT_DATE BETWEEN a11.dat_von AND a11.dat_bis 
                AND a11.mandant_id = 1
                GROUP BY 1,2
        ) b
ON a.mandant_id = b.mandant_id AND
a.art_id = b.art_id
);

UPDATE DBP_DATA.sal_int_2 
SET listung_min_1_sst_durchg_fg = b.listung_min_1_sst_durchg_fg,
listung_min_1_sst_durchg_mvke_fg = b.listung_min_1_sst_durchg_mvke_fg,
listung_min_1_region_durchg_fg = b.listung_min_1_region_durchg_fg,
listung_min_1_region_durchg_baustein_fg = b.listung_min_1_region_durchg_baustein_fg

FROM (SELECT mandant_id,
art_id,
MAX(listung_min_1_sst_durchg_fg) AS listung_min_1_sst_durchg_fg,
MAX(listung_min_1_sst_durchg_mvke_fg) AS listung_min_1_sst_durchg_mvke_fg,
MAX(listung_min_1_region_durchg_fg) AS listung_min_1_region_durchg_fg,
MAX(listung_min_1_region_durchg_baustein_fg) AS listung_min_1_region_durchg_baustein_fg
FROM _sal_upd
GROUP BY 1,2) b

WHERE DBP_DATA.sal_int.mandant_id = b.mandant_id 
AND DBP_DATA.sal_int.art_id = b.art_id
;

UPDATE DBP_DATA.sal_int_2 
SET listung_min_1_wup_fg = b.listung_min_1_wup_fg

FROM (  SELECT  mandant_id,
                art_id,
                MIN(listung_min_1_wup_fg) AS listung_min_1_wup_fg
        FROM _sal_upd2
        GROUP BY 1,2
      ) b

WHERE DBP_DATA.sal_int.mandant_id = b.mandant_id 
AND DBP_DATA.sal_int.art_id = b.art_id
;

-- 02.02.22, -dbay-
--
-- update for assortment tool for keeping it synchronized

create or replace volatile table _daily_sal_upd as (
select a.mandant_id,
       b.matching_id,
       coalesce(b.anzahl_markt_wochen_kombis_abverkauf_mit_listung,0) as tm_anz_abverkauf,
       coalesce(b.anzahl_markt_wochen_kombis_listung,0) as tm_anz_listung,
       sum(a.anz_wup_absatz) as sal_anz_abverkauf,
       sum(a.anz_wup_listung) as sal_anz_listung
from dbp_data.sal_int_2 a
join (select mandant_id,
             art_matching_id,
             art_id
      from dbp_etl.art_matching_nielsen_per_2
      group by 1,2,3) c
  on a.mandant_id = c.mandant_id and
     a.art_id = c.art_id
join dbp_etl_process.tupel_mat_etl_2 b
  on c.mandant_id = b.mandant_id and
     c.art_matching_id = b.matching_id
where a.kjwo in (select x.kjwo
                 from (select kjwo,
                              rank() over (order by kjwo desc) * (-1) as akt_wo
                       from dbp_data.art_nielsen_fakten_kjwo_2
                       where mandant_id = 1
                       group by 1) x
                 where akt_wo between -52 and -1) and
      a.mandant_id = 1 and
      b.a500_kjwo_update in (select max(a500_kjwo_update) from dbp_etl_process.tupel_mat_etl_2 where mandant_id = 1)
group by 1,2,3,4
having (tm_anz_abverkauf <> sal_anz_abverkauf or tm_anz_listung <> sal_anz_listung)
);

update dbp_etl_process.tupel_mat_etl_2 from (select *
                                           from _daily_sal_upd) b
                                           
set anzahl_markt_wochen_kombis_abverkauf_mit_listung = b.sal_anz_abverkauf,
    anzahl_markt_wochen_kombis_listung = b.sal_anz_listung
    
where dbp_etl_process.tupel_mat_etl.mandant_id = b.mandant_id and
      dbp_etl_process.tupel_mat_etl.matching_id = b.matching_id and
      dbp_etl_process.tupel_mat_etl.a500_kjwo_update in (select max(a500_kjwo_update) from dbp_etl_process.tupel_mat_etl_2 where mandant_id = 1)
;

update dbp_msi_data.tupel_mat_quarantaene_2 from (select *
                                                from _daily_sal_upd) b
                                           
set anzahl_markt_wochen_kombis_abverkauf_mit_listung = b.sal_anz_abverkauf,
    anzahl_markt_wochen_kombis_listung = b.sal_anz_listung
    
where dbp_msi_data.tupel_mat_quarantaene.mandant_id = b.mandant_id and
      dbp_msi_data.tupel_mat_quarantaene.matching_id = b.matching_id and
      dbp_msi_data.tupel_mat_quarantaene.a500_kjwo_update in (select max(a500_kjwo_update) from dbp_etl_process.tupel_mat_etl_2 where mandant_id = 1)
;

update dbp_msi_data.tupel_mat_2 from (select *
                                    from _daily_sal_upd) b
                                           
set anzahl_markt_wochen_kombis_abverkauf_mit_listung = b.sal_anz_abverkauf,
    anzahl_markt_wochen_kombis_listung = b.sal_anz_listung
    
where dbp_msi_data.tupel_mat.mandant_id = b.mandant_id and
      dbp_msi_data.tupel_mat.matching_id = b.matching_id and
      dbp_msi_data.tupel_mat.a500_kjwo_update in (select max(a500_kjwo_update) from dbp_etl_process.tupel_mat_etl_2 where mandant_id = 1)
;
