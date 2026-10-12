/* AW check 2021-05-10*/
INSERT INTO DBP_ETL.vis_personal_wup_tmp_1
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
erg.mandant_id
,erg.nb_id
,erg.wup_id
,erg.gj
,erg.kjmo 
,0
,0
,0
,coalesce(erg.abwesenheit_tage,0)
,coalesce (erg.anz_tage,0)
,coalesce (erg.abwesenheit_tage_kvj,0)
,coalesce (erg.anz_tage_kvj,0)
,coalesce (erg.pers_austritte,0)
,coalesce (erg.pers_anz,0)
,coalesce (erg.pers_austritte_kvj,0)
,coalesce (erg.pers_anz_kvj,0)
FROM 
(
SELECT
 t3.mandant_id
,t3.nb_id
,t3.wup_id
,b.gj
,t2.kjmo
,b.max_dat - b.min_dat + 1 AS kalendertage
/* AU-Quote*/
, SUM(CAST(t2.abwesenheit_tage_ist AS FLOAT)) abwesenheit_tage
, SUM(NULLIFZERO(CAST((t2.anz_kopf_ist * kalendertage) AS FLOAT))) AS anz_tage
/* AU-Quote VJ*/
, SUM(CAST(t2.abwesenheit_tage_vj AS FLOAT)) abwesenheit_tage_kvj
, SUM(NULLIFZERO(CAST((t2.anz_kopf_vj  * kalendertage) AS FLOAT))) AS anz_tage_kvj
/* Fluktuations-Quote*/
, SUM(CAST((t2.soll_stunden_mo_an_ist + t2.soll_stunden_mo_ag_ist) AS FLOAT)) pers_austritte
, SUM(NULLIFZERO(CAST(soll_stunden_mo_ist AS FLOAT))) pers_anz
/* Fluktuations-Quote VJ*/
, SUM(CAST((t2.soll_stunden_mo_an_vj  + t2.soll_stunden_mo_ag_vj)  AS FLOAT)) pers_austritte_kvj
, SUM(NULLIFZERO(CAST(soll_stunden_mo_vj AS FLOAT))) AS pers_anz_kvj

--FROM DBP_DATA.org_einheit_per_1 t1_1
FROM DBP_DATA.l_org_einheit_1 t1_1


INNER JOIN DBP_DATA.shr_kennzahlen_1 t2
ON t1.hr_objekt_id=t2.hr_objekt_id AND t1.mandant_id=t2.mandant_id
AND t2.shr_freigabe_fg = 1

INNER JOIN DBP_DATA.wup_1 t3
ON
/*
(CASE WHEN DBP_ETL_PROCESS.is_num(SUBSTRING(hr_objekt_bez_kurz, 3, 4)) = 1 
       THEN SUBSTRING(hr_objekt_bez_kurz, 3, 4)
       ELSE NULL
 END) = t3.wup_id AND t2.mandant_id=t3.mandant_id
*/
try_to_number(substring(hr_objekt_bez_kurz,3,4)) = t3.wup_id AND t2.mandant_id=t3.mandant_id
 INNER JOIN DBP_ETL.vis_mandant_1 vm
 ON vm.mandant_id = t3.mandant_id
 
INNER JOIN DBP_DATA.l_ma_variable_1 t4
ON t2.kjmo=t4.kjmo 
AND t2.mandant_id=t4.mandant_id

INNER JOIN DBP_DATA.monat_1 b
ON b.kjmo = t2.kjmo

WHERE
t3.nb_id IN(0,2,7,-1)
--AND t1.dat_bis = to_date('9999-12-31','YYYY-MM_1-DD')
--DE
AND (t1.mandant_id = 1 AND t1.hr_objekt_bez_kurz LIKE 'DE%'
AND t1.hr_objekt_bez_kurz <> 'DE' || TRIM(wup_id) || '70'
AND t2.hr_objekt_id NOT IN
(
 SELECT hr_objekt_ebene11_id FROM DBP_DATA.org_einheit_hierarchie_1 WHERE mandant_id = 1 AND hr_objekt_ebene1_id = 50020815
)
)

GROUP BY 1,2,3,4,5,6
)erg
;

