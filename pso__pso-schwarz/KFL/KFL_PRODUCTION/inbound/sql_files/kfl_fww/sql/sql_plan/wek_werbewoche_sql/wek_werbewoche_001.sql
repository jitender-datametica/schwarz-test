/* AW check 2021-05-17*/
DELETE FROM DBP_DATA.werbewoche_kl_vvt;

INSERT INTO DBP_DATA.werbewoche_kl_vvt (mandant_id
						, dat
						, akt_kjwo_ww
						, akt_kjwo_ww_komplett
						, kjwo_ww)
SELECT mandant_id
, dat
, akt_kjwo_ww
, akt_kjwo_ww_komplett
, kjwo_ww 
FROM DBP_DATA.werbewoche_kl;

DELETE FROM DBP_DATA.werbewoche_kl;

INSERT INTO DBP_DATA.werbewoche_kl (mandant_id
                                    ,dat
                                    ,akt_kjwo_ww
                                    ,akt_kjwo_ww_komplett
                                    ,kjwo_ww)
SELECT x.mandant_id,
       x.dat,
       x.akt_wo_ AS akt_kjwo_ww,
       x.akt_wo_komplett AS akt_kjwo_ww_komplett,
       y.kjwo AS kjwo_ww
FROM (SELECT b.mandant_id,
             a.dat,
             CASE
               WHEN b.mandant_id = 8 AND a.wtag_id BETWEEN 1 AND 7 THEN akt_wo
               WHEN b.mandant_id IN (2) AND a.wtag_id BETWEEN 1 AND 2 AND kjwo >= 201909 THEN akt_wo-1
               WHEN b.mandant_id IN (2) AND a.wtag_id BETWEEN 1 AND 3 AND kjwo <= 201908 THEN akt_wo-1
               WHEN b.mandant_id IN (6) AND a.wtag_id BETWEEN 1 AND 3 AND kjwo <= 202204 THEN akt_wo-1      
               WHEN b.mandant_id IN (6) AND a.wtag_id BETWEEN 1 AND 2 AND kjwo >= 202205 THEN akt_wo-1
               WHEN b.mandant_id IN (4) AND a.wtag_id BETWEEN 1 AND 2 AND kjwo <= 202330 THEN akt_wo-1
               WHEN b.mandant_id IN (4) AND a.wtag_id BETWEEN 1 AND 3 AND kjwo  = 202331 THEN akt_wo-1
               WHEN b.mandant_id IN (4) AND a.wtag_id BETWEEN 1 AND 3 AND kjwo >= 202332 THEN akt_wo-1
               WHEN b.mandant_id IN (7) AND a.wtag_id BETWEEN 1 AND 2 THEN akt_wo-1
               WHEN b.mandant_id IN (1,3,5) AND a.wtag_id BETWEEN 1 AND 3 THEN akt_wo-1
               ELSE a.akt_wo
             END AS akt_wo_,
             CASE
               WHEN akt_wo_ NOT IN (-1,0) 
               THEN akt_wo_ 
               ELSE 0
             END AS akt_wo_komplett
      FROM DBP_DATA.tag a
      JOIN DBP_DATA.mandant b
        ON 1 = 1) x
JOIN DBP_DATA.woche y
  ON x.akt_wo_ = y.akt_wo
JOIN DBP_DATA.tag z
  ON x.dat = z.dat
;

