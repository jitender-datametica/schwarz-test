UPDATE DBP_ETL.vis_personal_wup_tmp


SET wup_id = wup_id_

FROM
(
SELECT
  t1.mandant_id as mandant_id_
 ,t1.nb_id AS nb_id_
 ,t2.wup_id AS wup_id_
 ,t1.wup_id AS wup_id_alt_
 FROM DBP_DATA.wup t1
 INNER JOIN DBP_DATA.wup t2
 ON t2.wup_id_alt = t1.wup_id
 AND t2.nb_id = t1.nb_id
 AND t2.mandant_id = t1.mandant_id
 AND t2.dat_von <= CURRENT_DATE) x1
 WHERE mandant_id = mandant_id_
AND nb_id = nb_id_
AND wup_id = wup_id_alt_
;

INSERT INTO DBP_ETL.vis_personal_wup_tmp1
(
mandant_id
,nb_id
,wup_id
,gj
,kjmo 
,pers_std
,pers_std_kvj
,pers_std_plan
,abwesenheit_tage
,anz_tage
,abwesenheit_tage_kvj
,anz_tage_kvj
,pers_austritte
,pers_anz
,pers_austritte_kvj
,pers_anz_kvj
)
SELECT
 mandant_id
,nb_id
,wup_id
,gj
,kjmo 
,sum(pers_std)
,sum(pers_std_kvj)
,sum(pers_std_plan)
,sum(abwesenheit_tage)
,sum(anz_tage)
,sum(abwesenheit_tage_kvj)
,sum(anz_tage_kvj)
,sum(pers_austritte)
,sum(pers_anz)
,sum(pers_austritte_kvj)
,sum(pers_anz_kvj)
FROM DBP_ETL.vis_personal_wup_tmp
GROUP BY 1,2,3,4,5
;

