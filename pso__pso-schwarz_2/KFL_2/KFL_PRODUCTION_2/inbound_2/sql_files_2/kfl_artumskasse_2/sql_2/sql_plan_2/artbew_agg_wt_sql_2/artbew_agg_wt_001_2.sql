INSERT INTO DBP_DATA.artbew_agg_wt_2 (mandant_id
                                   ,wup_id
                                   ,nb_id
                                   ,dat)
SELECT mandant_id
      ,wup_id
      ,nb_id
      ,dat
FROM DBP_DATA.artbew_2
WHERE dat BETWEEN (SELECT MIN(dat) FROM DBP_DATA.tag_2 WHERE akt_mo = -1) AND CURRENT_DATE AND
     (mandant_id,wup_id,nb_id,dat) NOT IN (SELECT mandant_id,wup_id,nb_id,dat FROM DBP_DATA.artbew_agg_wt_2)
GROUP BY 1,2,3,4
;
