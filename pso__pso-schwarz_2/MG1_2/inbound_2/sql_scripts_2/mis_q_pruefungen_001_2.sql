
DROP TABLE IF EXISTS DBP_ETL.mis_q_umsatz_join_tag_2;


CREATE TABLE DBP_ETL.mis_q_umsatz_join_tag_2  (
      mandant_id BYTEINT NOT NULL,
      wup_id INTEGER NOT NULL,
      nb_id SMALLINT NOT NULL,
      dat DATE NOT NULL,
      dat_vgl DATE NOT NULL,
      Umsatzgleich_fg BYTEINT NOT NULL,
      UmsatzAvg_fg BYTEINT NOT NULL,
      Umsatz_fg BYTEINT NOT NULL
       )
;

INSERT INTO DBP_ETL.mis_q_umsatz_join_tag_2
(
      mandant_id
      ,wup_id
      ,nb_id
      ,dat
      ,dat_vgl
      ,Umsatzgleich_fg
      ,UmsatzAvg_fg
      ,Umsatz_fg
)
SELECT
      mandant_id
      ,wup_id
      ,nb_id
      ,dat
      ,dat_vgl
      ,SUM(Umsatzgleich_fg)
      ,SUM(UmsatzAvg_fg)
      ,SUM(Umsatz_fg)
FROM
(
    SELECT
      t3.mandant_id
      ,t3.wup_id
      ,t3.nb_id
      ,t1.dat as dat
      ,t2.dat as dat_vgl
      ,CASE WHEN (t1.dat = t2.dat) THEN 1 ELSE 0 END as Umsatz_fg
      ,CASE WHEN (t1.dat = t2.dat) THEN 0 ELSE 1 END as UmsatzAvg_fg
      ,0 as Umsatzgleich_fg
    FROM DBP_DATA.tag_2 t1_2
    INNER JOIN (SELECT *
                FROM DBP_ETL_PROCESS.artbew_wg_sum_agg_wt_2
                WHERE dat BETWEEN CURRENT_DATE-365 AND CURRENT_DATE
                ) t3
    ON t1.dat=t3.dat
    INNER JOIN       DBP_DATA.tag_2 t2
    ON       t2.dat between t1.dat-30 and t1.dat
    AND       t2.wtag_id=t1.wtag_id
    WHERE       t3.calc_fg=0
  UNION
    SELECT
      t4.mandant_id
      ,t4.wup_id
      ,t4.nb_id
      ,t4.dat
      ,t5.dat as dat_vgl
      ,0 as Umsatz_fg
      ,0 as UmsatzAvg_fg
      ,1 as Umsatzgleich_fg
    FROM
      (SELECT *
       FROM DBP_ETL_PROCESS.artbew_wg_sum_agg_wt_2
       WHERE dat BETWEEN CURRENT_DATE-365 AND CURRENT_DATE) t4
    INNER JOIN
      DBP_DATA.tag_2 t5
    ON
      t5.dat BETWEEN t4.dat-3 AND t4.dat-1
    WHERE
      t4.calc_fg=0
  GROUP BY             
    1,2,3,4,5,6,7
)dt1
WHERE
  EXISTS
  (SELECT * FROM 
    DBP_DATA.wupcal_2 t6
  WHERE
    t6.dat=dt1.dat_vgl
  AND
    t6.wup_id=dt1.wup_id
  AND
    t6.nb_id=dt1.nb_id
  AND
    t6.mandant_id=dt1.mandant_id
  AND
    t6.datenlieferung_artbew_wg_sum = 1
  AND
    t6.offen = 1
  )
AND
  EXISTS
  (SELECT * FROM 
    DBP_DATA.wupcal_2 t7
  WHERE
    t7.dat=dt1.dat
  AND
    t7.wup_id=dt1.wup_id
  AND
    t7.nb_id=dt1.nb_id
  AND
    t7.mandant_id=dt1.mandant_id
  AND
    t7.datenlieferung_artbew_wg_sum = 1
  AND
    t7.offen = 1
  )
GROUP BY
       mandant_id
      ,wup_id
      ,nb_id
      ,dat
      ,dat_vgl
;

DROP TABLE IF EXISTS DBP_ETL.mis_q_umsatz_2;


CREATE TABLE DBP_ETL.mis_q_umsatz_2  (
      mandant_id BYTEINT NOT NULL,
      wup_id INTEGER NOT NULL,
      nb_id SMALLINT NOT NULL,
      dat DATE NOT NULL,
      dat_vgl DATE NOT NULL,
      Umsatz_Netto Decimal(18,2),
      Umsatzgleich_fg BYTEINT NOT NULL,
      UmsatzAvg_fg BYTEINT NOT NULL,
      Umsatz_fg BYTEINT NOT NULL
       )
;

INSERT INTO DBP_ETL.mis_q_umsatz_2
(
      mandant_id
      ,wup_id
      ,nb_id
      ,dat
      ,dat_vgl
      ,Umsatzgleich_fg
      ,UmsatzAvg_fg
      ,Umsatz_fg
      ,Umsatz_Netto
)
SELECT
      t1.mandant_id
      ,t1.wup_id
      ,t1.nb_id
      ,t2.dat
      ,t2.dat_vgl
      ,t2.Umsatzgleich_fg
      ,t2.UmsatzAvg_fg
      ,t2.Umsatz_fg
      ,SUM(t1.Umsatz_Netto_Konz)
FROM
  DBP_DATA.artbew_wg_sum_2 t1_2
INNER JOIN
  DBP_ETL.mis_q_umsatz_join_tag_2 t2
ON
  t1.mandant_id=t2.mandant_id
AND
  t1.wup_id=t2.wup_id
AND
  t1.nb_id=t2.nb_id
AND
  t1.dat=t2.dat_vgl
WHERE
  t1.wg_id > -10
GROUP BY
      t1.mandant_id
      ,t1.wup_id
      ,t1.nb_id
      ,t2.dat
      ,t2.dat_vgl
      ,t2.Umsatzgleich_fg
      ,t2.UmsatzAvg_fg
      ,t2.Umsatz_fg;


DROP TABLE IF EXISTS DBP_ETL.mis_q_umsatz_abw_avg_2;


CREATE TABLE DBP_ETL.mis_q_umsatz_abw_avg_2  (
      mandant_id BYTEINT NOT NULL,
      wup_id INTEGER NOT NULL,
      nb_id SMALLINT NOT NULL,
      dat DATE NOT NULL,
      Umsatz_Netto Decimal(18,2),
      Umsatz_Netto_AVG Decimal(18,2),
      Umsatzabweichung_prz Decimal(12,2))
;


INSERT INTO DBP_ETL.mis_q_umsatz_abw_avg_2
(
  mandant_id
  ,wup_id
  ,nb_id
  ,dat
  ,Umsatz_Netto
  ,Umsatz_Netto_AVG
  ,Umsatzabweichung_prz
)
SELECT 
  mandant_id
  ,wup_id
  ,nb_id
  ,dat
  ,Umsatz_Netto
  ,CASE 
    WHEN
      (Umsatz_Netto_AVG_SUM =0)
    THEN
      NULL
    ELSE
      Umsatz_Netto_AVG_SUM/UmsatzAvg_fg_SUM
  END AS Umsatz_Netto_AVG
  ,CASE
  WHEN
    Umsatz_Netto_AVG IS NULL
  THEN
    NULL
  ELSE
    ((Umsatz_Netto-Umsatz_Netto_AVG) /Umsatz_Netto_AVG)
  END AS Umsatzabweichung_prz
FROM
  (
  SELECT
    mandant_id
    ,wup_id
    ,nb_id
    ,dat
    ,SUM(Umsatz_Netto*Umsatz_fg) Umsatz_Netto
    ,SUM(Umsatz_Netto*UmsatzAvg_fg) Umsatz_Netto_AVG_SUM
    ,SUM(UmsatzAvg_fg) as  UmsatzAvg_fg_SUM
  FROM
    DBP_ETL.mis_q_umsatz_2
  GROUP BY
    mandant_id
    ,wup_id
    ,nb_id
    ,dat
  )dt1
WHERE
  Umsatzabweichung_prz NOT BETWEEN -0.5 AND 0.5
;


DROP TABLE IF EXISTS DBP_ETL.mis_q_umsatz_gleich_2;


CREATE TABLE DBP_ETL.mis_q_umsatz_gleich_2  (
          mandant_id BYTEINT,
          wup_id INTEGER NOT NULL,
          nb_id SMALLINT NOT NULL,
          dat DATE NOT NULL,
          dat_gleich DATE,
          Umsatz_Netto Decimal(18,2)
      )
;

INSERT INTO DBP_ETL.mis_q_umsatz_gleich_2
     (
         mandant_id
        ,wup_id
        ,nb_id
        ,dat
        ,dat_gleich
        ,Umsatz_Netto
  )
SELECT
  t1.mandant_id
  ,t1.wup_id
  ,t1.nb_id
  ,t1.dat as dat
  ,t2.dat_vgl as dat_gleich
  ,t1.umsatz_netto
FROM
  DBP_ETL.mis_q_umsatz_2 t1_2
INNER JOIN
  DBP_ETL.mis_q_umsatz_2 t2
ON  t1.mandant_id=t2.mandant_id
AND  t1.wup_id=t2.wup_id
AND  t1.nb_id=t2.nb_id
AND  t1.dat=t2.dat
AND  t1.umsatz_netto=t2.umsatz_netto
WHERE  t1.Umsatz_fg=1
AND  t2.Umsatzgleich_fg=1
;


DROP TABLE IF EXISTS DBP_ETL.mis_q_umsatz_neg_2;


CREATE TABLE DBP_ETL.mis_q_umsatz_neg_2  (
      mandant_id BYTEINT NOT NULL,
      wup_id INTEGER NOT NULL,
      nb_id SMALLINT NOT NULL,
      dat DATE,
      Umsatz_Netto Decimal(18,2)
      )
;

INSERT INTO DBP_ETL.mis_q_umsatz_neg_2
     (
         mandant_id
        ,wup_id
        ,nb_id
        ,dat
        ,Umsatz_Netto
  )

  SELECT
    t1.mandant_id
    ,t1.wup_id
    ,t1.nb_id
    ,t1.dat
    ,t1.umsatz_netto
  FROM
    DBP_ETL.mis_q_umsatz_2 t1_2
  WHERE t1.Umsatz_fg=1
  AND   t1.Umsatz_Netto<0
;


UPDATE DBP_DATA.wupcal_2
SET
   pruef_grund_id_umsatz = dt1.pruef_grund_id_umsatz_
  ,pruef_status_id_umsatz = CASE WHEN pruef_status_id_umsatz IS NULL THEN dt1.pruef_status_id_umsatz_ ELSE dt1.pruef_status_id_umsatz_reload_ END

FROM
(
SELECT
  t1.mandant_id mandant_id_
  ,t1.wup_id wup_id_
  ,t1.nb_id nb_id_
  ,t1.dat dat_
  ,CASE WHEN t2.wup_id IS NULL THEN ' ' ELSE 'D' END ||
   CASE WHEN t3.wup_id IS NULL THEN ' ' ELSE 'G' END ||
   CASE WHEN t4.wup_id IS NULL THEN ' ' ELSE 'N' END AS pruef_grund_id_umsatz_
,CASE WHEN pruef_grund_id_umsatz_= '   ' THEN 1 ELSE 0 END AS pruef_status_id_umsatz_
,CASE WHEN pruef_grund_id_umsatz_= '   ' THEN 2 ELSE -1 END AS pruef_status_id_umsatz_reload_
,max(t1.dat_lief) dat_lief_
FROM
  (SELECT *
   FROM DBP_ETL_PROCESS.artbew_wg_sum_agg_wt_2
   WHERE dat BETWEEN CURRENT_DATE-365 AND CURRENT_DATE
   ) t1_2
LEFT OUTER JOIN   DBP_ETL.mis_q_umsatz_abw_avg_2 t2
ON    t1.dat=t2.dat
AND   t1.mandant_id=t2.mandant_id
AND   t1.wup_id=t2.wup_id
AND   t1.nb_id=t2.nb_id
LEFT OUTER JOIN  DBP_ETL.mis_q_umsatz_gleich_2 t3
ON    t1.dat=t3.dat
AND   t1.mandant_id=t3.mandant_id
AND   t1.wup_id=t3.wup_id
AND   t1.nb_id=t3.nb_id
LEFT OUTER JOIN   DBP_ETL.mis_q_umsatz_neg_2 t4
ON    t1.dat=t4.dat
AND   t1.mandant_id=t4.mandant_id
AND   t1.wup_id=t4.wup_id
AND   t1.nb_id=t4.nb_id
WHERE t1.calc_fg = 0
GROUP BY   1,2,3,4,5,6,7
)dt1 WHERE   mandant_id = dt1.mandant_id_
AND     wup_id = dt1.wup_id_
AND     nb_id = dt1.nb_id_
AND     dat = dt1.dat_
;

/*BB optimierung */
drop table if exists dbp_etl.bb_check_wupcal_update_2;

create table dbp_etl.bb_check_wupcal_update_2  (
      mandant_id byteint not null,
      dat date not null,
      wup_id integer not null,
      offen smallint,
      bonanzahl_sug number(38,0),
      nb_id smallint not null,
      umsatz_brutto_ods_verkauf number(18,4),
      umsatz_brutto_ods_kassenabschluss number(18,4),
      diff_wert number(18,4),
      diff_proz number(18,4),
      pruef_status_id_umsatz number(38,0),
      pruef_grund_id_umsatz varchar(3)
 )
;


insert into dbp_etl.bb_check_wupcal_update_2
select 
  mandant_id,
  dat, 
  wup_id,
  offen, 
  bonanzahl_sug,
  nb_id, 
  umsatz_brutto_ods_verkauf, 
  umsatz_brutto_ods_kassenabschluss, 
  umsatz_brutto_ods_verkauf-umsatz_brutto_ods_kassenabschluss as diff_wert,
  (umsatz_brutto_ods_verkauf-umsatz_brutto_ods_kassenabschluss) / nullifzero(umsatz_brutto_ods_kassenabschluss) * 100 as diff_proz,
  case when diff_proz not between -${limit} and ${limit} then -1 else 1 end as pruef_status_id_umsatz,
  pruef_grund_id_umsatz 
from dbp_data.wupcal_2 
where dat = current_date-1   
      and offen = 1
      and nb_id = 0
      and  umsatz_brutto_ods_kassenabschluss <> 0
;

drop table if exists dbp_etl.bb_check_wupcal_2;

create table dbp_etl.bb_check_wupcal_2 as select * from dbp_data.wupcal_2 where dat = current_date - 1;

update dbp_data.wupcal_2 t1_2
set t1.pruef_status_id_umsatz = dt1.pruef_status_id_umsatz
from (
      select * from dbp_etl.bb_check_wupcal_update_2
      ) dt1
where  
   t1.mandant_id = dt1.mandant_id
   and t1.wup_id = dt1.wup_id
   and t1.nb_id = dt1.nb_id
   and t1.dat = dt1.dat
;

