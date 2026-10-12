CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_AIS_INT.MV_ART_WUP_LIST_ZU_1
/*SPEC0049888 kdis-->kdis_kz 05.02.2019 dhoe0404*/
--SPEC0152531 Erweiterung um Left Join, sowie Auspraegung 'war nie gelistet' analog AIS_DE/ sschuecke 26.04.2022
(
 mandant_id
,wup_id
,nb_id
,art_id
,bezugsweg_id
,kdis_kz
,listung_id
,listung_markt
,listung_fct
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_INT
AS
SELECT
 v01.mandant_id
,v01.wup_id
,v01.nb_id
,v01.art_id
,v01.bezugsweg_id
,CASE WHEN v01.kdis = 0 OR v01.kdis IS NULL THEN ' ' ELSE 'K' END kdis_kz
,v01.listung_id
,CASE WHEN v02.art_id IS NULL THEN 'war nie gelistet' ELSE 
 CASE WHEN v01.listung_id = 1 THEN (CASE WHEN v01.bezugsweg_id = 1 
 							  THEN (CASE WHEN v01.kdis = 0 THEN '1' ELSE '5' END)
	  						  WHEN v01.bezugsweg_id = 4 
							  THEN (CASE WHEN v01.kdis = 0 THEN '4' ELSE '8' END)
	  						  ELSE 'ausgelistet' END)
	  						  ELSE 'ausgelistet' END END AS listung_markt
,CASE WHEN listung_markt = 'ausgelistet' THEN NULL ELSE listung_markt END listung_fct

FROM dbp_view.v_art_wup_zu_per_1 v01
LEFT JOIN 
(SELECT
 mandant_id
,art_id
,wup_id
FROM dbp_view.v_art_list_wup_zu_per_1	   
GROUP BY 1,2,3) v02
ON  v01.mandant_id = v02.mandant_id
AND v01.art_id = v02.art_id
AND v01.wup_id = v02.wup_id

--SPEC0152531 Anpassung um Filter analog mv_wup_1 /sschuecke 31.05.2022
JOIN dbp_view.v_wup_1 v03
ON  v01.mandant_id = v03.MANDANT_ID 
AND v01.wup_id = v03.WUP_ID 
AND v01.nb_id = v03.nb_id  
	
WHERE v01.dat_bis = '9999-12-31' 										 								 
AND v01.nb_id <> 99
AND  (((v03.DAT_EROEFFNUNG < CURRENT_DATE OR v03.DAT_EROEFFNUNG< CURRENT_DATE +45) AND v03.DAT_VON IS NOT NULL)
       OR v03.NB_ID <> 0
       OR v03.WUP_ID = 9203)-- Filterung von Zentralfilialen
	   AND NOT v03.WUP_ID BETWEEN 1 AND 999;