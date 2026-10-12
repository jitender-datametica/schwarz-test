UPDATE  DBP_DATA.wupcal_2 
   SET  ssm_umsatz_faktor = b.ssm_umsatz_faktor,
        td_update = CURRENT_TIMESTAMP

FROM (SELECT *
      FROM DBP_DATA.wupcal_zukunft_2
      WHERE dat = CURRENT_DATE) b

WHERE DBP_DATA.wupcal.mandant_id = b.mandant_id AND
      DBP_DATA.wupcal.wup_id = b.wup_id AND
      DBP_DATA.wupcal.nb_id = b.nb_id AND
      DBP_DATA.wupcal.dat = b.dat
;

DELETE FROM DBP_DATA.wupcal_zukunft_2
WHERE dat = CURRENT_DATE
;

INSERT INTO DBP_DATA.wupcal_zukunft_2 (mandant_id
                                                  ,wup_id
                                                  ,nb_id
                                                  ,dat
                                                  ,offen
                                                  ,offen_von
                                                  ,offen_bis
                                                  ,offen_theke_von
                                                  ,offen_theke_bis)
SELECT x.mandant_id,
       x.wup_id,
       x.nb_id,
       b.dat,
       x.offen,
       x.offen_von_,
       x.offen_bis_,
       x.offen_theke_von,
       x.offen_theke_bis
FROM (
SELECT a.mandant_id,
       a.wup_id,
       a.nb_id,
       1 AS offen,
       MIN(case when a.offen_von = 240000 then 0 else a.offen_von end) as offen_von_,
       MAX(case when a.offen_bis = 240000 then 0 else a.offen_bis end) as offen_bis_,
       MIN(to_time(to_char(case when a.offen_von = 240000 then 0 else a.offen_von end,'000000'),'HH24MISS')) AS offen_theke_von,
       MAX(to_time(to_char(case when a.offen_bis = 240000 then 0 else a.offen_bis end,'000000'),'HH24MISS')) AS offen_theke_bis
FROM DBP_DATA.wupcal_2 a
GROUP BY 1,2,3,4) x
JOIN DBP_DATA.tag_2 b
  ON 1 = 1
WHERE b.dat BETWEEN CURRENT_DATE+1 AND CURRENT_DATE+90 AND
     (x.mandant_id,x.wup_id,x.nb_id,b.dat) NOT IN (SELECT mandant_id,wup_id,nb_id,dat FROM DBP_DATA.wupcal_zukunft_2)
GROUP BY 1,2,3,4,5,6,7,8,9
;

UPDATE  DBP_DATA.wupcal_zukunft_2 
   SET  offen_von = b.offen_von_,
        offen_bis = b.offen_bis_,
        offen_theke_von = b.offen_theke_von,
        offen_theke_bis = b.offen_theke_bis,
        td_update = CURRENT_TIMESTAMP

  FROM (SELECT a.dat,
             a.wtag_id,
             b.mandant_id,
             b.wup_id,
             case when b.zeit_von = 240000 then 0 else b.zeit_von end as offen_von_,
             case when b.zeit_bis = 240000 then 0 else b.zeit_bis end as offen_bis_,
             to_time(to_char(case when b.zeit_von = 240000 then 0 else b.zeit_von end,'000000'),'HH24MISS') AS offen_theke_von,
             to_time(to_char(case when b.zeit_bis = 240000 then 0 else b.zeit_bis end,'000000'),'HH24MISS') AS offen_theke_bis
        FROM DBP_DATA.tag_2 a
        JOIN DBP_DATA.vaus_wup_oeffnung_zu_per_2 b
          ON a.wtag_id = b.wup_oeffnungs_typ_id
       WHERE a.dat BETWEEN CURRENT_DATE+1 AND CURRENT_DATE+90 
         AND CAST(b.zeit_von AS VARCHAR(10)) IS NOT NULL 
         AND CAST(b.zeit_bis AS VARCHAR(10)) IS NOT NULL
      GROUP BY 1,2,3,4,5,6) b

WHERE DBP_DATA.wupcal_zukunft.mandant_id = b.mandant_id AND
      DBP_DATA.wupcal_zukunft.dat = b.dat AND
      DBP_DATA.wupcal_zukunft.wup_id = b.wup_id
;

UPDATE  DBP_DATA.wupcal_zukunft_2 
   SET  offen = dt1.offen,
        td_update = CURRENT_TIMESTAMP


FROM (SELECT wez.mandant_id
            ,wez.wup_id
            ,wez.nb_id
            ,wez.dat
            ,MAX(wez.offen) AS offen
      FROM DBP_DATA.wupcal_ereignis_zu_2 wez
      GROUP BY 1,2,3,4) dt1

WHERE dt1.mandant_id = DBP_DATA.wupcal_zukunft.mandant_id
  AND dt1.wup_id = DBP_DATA.wupcal_zukunft.wup_id
  AND dt1.nb_id = DBP_DATA.wupcal_zukunft.nb_id
  AND dt1.dat = DBP_DATA.wupcal_zukunft.dat
;

CREATE  VOLATILE TABLE _avg_ist AS (
SELECT t1.mandant_id,
       t1.wup_id,
       t1.wtag_id,
       AVG(t1.ums_netto) AS umsatz_netto
FROM DBP_MSI_DATA.vis_tag_umsatz_kunde_wup_2 t1_2 
JOIN DBP_DATA.mandant_2 t2 
  ON t1.mandant_id = t2.mandant_id AND 
     t1.wrg_id = t2.default_wrg 
WHERE t1.akt_wo BETWEEN -10 AND -1
GROUP BY 1,2,3
);

CREATE  VOLATILE TABLE _plan AS (
SELECT t1.mandant_id,
       t1.wup_id,
       t1.dat,
       t2.wtag_id,
       t1.wrg_id,
       COALESCE(t1.ums_netto_plan_man_meldeschluss_plus2, t1.ums_netto_plan_man) umsatz_plan_hl
FROM DBP_DATA.wup_stunden_tag_2 t1_2 
JOIN DBP_DATA.tag_2 t2 
  ON t1.dat = t2.dat 
WHERE t2.akt_wo BETWEEN 0 AND 16
);

CREATE  VOLATILE TABLE _umsatz_hebel AS (
SELECT a.mandant_id,
       a.wup_id,
       a.dat,
       a.wrg_id,
       COALESCE(Cast(a.umsatz_plan_hl AS DECIMAL(24,10))/NullIfZero(Cast(b.umsatz_netto AS DECIMAL(24,10))),1.0000) AS umsatz_hebel
FROM _plan a
JOIN _avg_ist b
  ON a.mandant_id = b.mandant_id AND
     a.wup_id = b.wup_id AND
     a.wtag_id = b.wtag_id
);

UPDATE  DBP_DATA.wupcal_zukunft_2 
   SET  ssm_umsatz_faktor = b.umsatz_hebel,
        td_update = CURRENT_TIMESTAMP

FROM (SELECT *
      FROM _umsatz_hebel) b
                                  
WHERE DBP_DATA.wupcal_zukunft.mandant_id = b.mandant_id AND
      DBP_DATA.wupcal_zukunft.wup_id = b.wup_id AND
      DBP_DATA.wupcal_zukunft.dat = b.dat AND
      DBP_DATA.wupcal_zukunft.dat > CURRENT_DATE+55
;

UPDATE  DBP_DATA.wupcal_2 
   SET  ssm_umsatz_faktor = b.ssm_umsatz_faktor,
        td_update = CURRENT_TIMESTAMP


FROM (SELECT *
      FROM DBP_DATA.wupcal_zukunft_2
      WHERE dat = CURRENT_DATE) b

WHERE DBP_DATA.wupcal.mandant_id = b.mandant_id AND
      DBP_DATA.wupcal.wup_id = b.wup_id AND
      DBP_DATA.wupcal.nb_id = b.nb_id AND
      DBP_DATA.wupcal.dat = b.dat
;

update dbp_data.wupcal_2 from (select a.mandant_id,
                                    a.wup_id,
                                    a.dat,
                                    max(c.zeit_von) as offen_von,
                                    max(c.zeit_bis) as offen_bis
                             from dbp_data.wupcal_2 a
                             join dbp_data.tag_2 b
                               on a.dat = b.dat
                             join dbp_data.vaus_wup_oeffnung_zu_per_2 c
                               on a.mandant_id = c.mandant_id and
                                  a.wup_id = c.wup_id and
                                  a.dat between c.dat_von and c.dat_bis and
                                  b.wtag_id = c.wup_oeffnungs_typ_id
                             where a.nb_id = 0 and
                                   a.offen_von is null and
                                   a.dat >= '2024-01-01' and
                                   a.offen = 1
                             group by 1,2,3) b
                                   
set offen_von = b.offen_von,
    offen_bis = b.offen_bis
    
where dbp_data.wupcal.mandant_id = b.mandant_id and
      dbp_data.wupcal.wup_id = b.wup_id and
      dbp_data.wupcal.dat = b.dat and
      dbp_data.wupcal.offen_von is null and
      dbp_data.wupcal.offen = 1 and
      dbp_data.wupcal.nb_id = 0
;

update dbp_data.wupcal_zukunft_2 from (select a.mandant_id,
                                            a.wup_id,
                                            a.dat,
                                            max(c.zeit_von) as offen_von,
                                            max(c.zeit_bis) as offen_bis
                                     from dbp_data.wupcal_zukunft_2 a
                                     join dbp_data.tag_2 b
                                       on a.dat = b.dat
                                     join dbp_data.vaus_wup_oeffnung_zu_per_2 c
                                       on a.mandant_id = c.mandant_id and
                                          a.wup_id = c.wup_id and
                                          a.dat between c.dat_von and c.dat_bis and
                                          b.wtag_id = c.wup_oeffnungs_typ_id
                                     where a.nb_id = 0 and
                                           a.offen_von is null and
                                           a.dat >= '2024-01-01' and
                                           a.offen = 1
                                     group by 1,2,3) b
                                   
set offen_von = b.offen_von,
    offen_bis = b.offen_bis
    
where dbp_data.wupcal_zukunft.mandant_id = b.mandant_id and
      dbp_data.wupcal_zukunft.wup_id = b.wup_id and
      dbp_data.wupcal_zukunft.dat = b.dat and
      dbp_data.wupcal_zukunft.offen_von is null and
      dbp_data.wupcal_zukunft.offen = 1 and
      dbp_data.wupcal_zukunft.nb_id = 0
;
