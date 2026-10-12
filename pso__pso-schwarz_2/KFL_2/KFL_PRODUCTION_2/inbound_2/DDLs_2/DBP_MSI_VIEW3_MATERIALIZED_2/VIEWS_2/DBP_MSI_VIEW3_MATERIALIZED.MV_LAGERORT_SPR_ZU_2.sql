create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_LAGERORT_SPR_ZU_2(
	MANDANT_ID,
	LAGERORT_ID,
	WUP_ID,
	NB_ID,
	SPR_ID,
	LAGERORT_BEZ,
	LAGERORT_BEZ_SHORT,
	LAGERORT_BEZ_SAP,
	LAGERORT_BEZ_ALTN
) as 
-- AP0016637, srom0404, TRIM in lagerort_bez eingefügt 
-- AP0014173, Join auf user_spr_zu_2 hat es seit 2011 nur in Produktion gegeben, hier nachgezogen 
-- AP0013450, 10.07.2017, srom0404, Erweiterung um Anbindung Pflegetabelle für alternative Texte 
-- 20230717 staeblern Umstellung auf Session Variable
SELECT t1.mandant_id 
     , t1.lagerort_id 
     , t1.wup_id 
     , t1.nb_id 
     , t1.spr_id -- lt. AP, soll der alternative Text genommen weerden, wenn dort einer vorhanden ist 
     , TRIM(t1.wup_id)||' '||COALESCE(t2.lagerort_bez, t1.lagerort_bez) AS lagerort_bez 
     , COALESCE(t2.lagerort_bez, t1.lagerort_bez) AS lagerort_bez_short 
     , t1.lagerort_bez AS lagerort_bez_sap 
     , CASE WHEN LENGTH(TRIM(t2.lagerort_bez)) = 0 THEN '_BLANK' ELSE t2.lagerort_bez END AS lagerort_bez_altn 
FROM (--t1_2 
        SELECT v01.mandant_id 
              , v01.lagerort_id 
              , v01.wup_id 
              , v01.nb_id 
              , v01.spr_id 
              , v01.lagerort_bez
        FROM dbp_view.v_lagerort_spr_zu_2 v01 
        INNER JOIN DBP_MSI_VIEW3_MATERIALIZED.MV_USER_SPR_ZU_2 v02 
            ON v01.spr_id = v02.spr_id 
        WHERE v01.lagerort_id NOT IN ('-1', '-2', '-3') ) t1_2 
LEFT JOIN (-- t2 
          SELECT v04.mandant_id 
                  , v04.lagerort_id 
                  , v04.wup_id 
                  , v04.nb_id 
                  , v04.spr_id 
                  , v04.lagerort_bez
            FROM DBP_MSI_VIEW3_MATERIALIZED.ts_lagerort_altn_spr_zu_2 v04 
            INNER JOIN DBP_MSI_VIEW3_MATERIALIZED.MV_USER_SPR_ZU_2 v05 
                ON v04.spr_id = v05.spr_id ) t2 
    ON t1.mandant_id = t2.mandant_id 
    AND t1.wup_id = t2.wup_id 
    AND t1.nb_id = t2.nb_id 
    AND t1.lagerort_id = t2.lagerort_id;