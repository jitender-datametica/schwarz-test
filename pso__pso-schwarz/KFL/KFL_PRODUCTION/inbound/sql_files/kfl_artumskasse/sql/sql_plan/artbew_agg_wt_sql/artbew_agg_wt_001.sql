INSERT INTO DBP_DATA.artbew_agg_wt (mandant_id
                                   ,wup_id
                                   ,nb_id
                                   ,dat)
SELECT mandant_id
      ,wup_id
      ,nb_id
      ,dat
FROM DBP_DATA.artbew
WHERE dat BETWEEN (SELECT MIN(dat) FROM DBP_DATA.tag WHERE akt_mo = -1) AND CURRENT_DATE AND
     (mandant_id,wup_id,nb_id,dat) NOT IN (SELECT mandant_id,wup_id,nb_id,dat FROM DBP_DATA.artbew_agg_wt)
GROUP BY 1,2,3,4
;
