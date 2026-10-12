CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_VIS_MONAT_BIG_BESTANDSKOR_DIEBSTAHL_INVENTUR_KUM_2(
        KJMO,
        MANDANT_ID,
        WUP_ID,
        NB_ID,
        ART_ID,
        WRG_ID,
        BESTANDSKORR_ZVKP_VK_NETTO_KUM,
        DIEBSTAHL_ZVKP_VK_NETTO_KUM,
        INVENTURDIFF_ZVKP_VK_NETTO_KUM,
        NATURALRABATT_PL_VK_NETTO_KUM
) AS

    -- 2024-06-20 muellerpatri : Filialumgliederung + Review [P1760-DWH]

SELECT
    v00.kjmo
    ,v00.mandant_id
    , wup.aktuell_wup_id AS wup_id
    ,v00.nb_id  
    ,v01.art_id 
    ,v00.wrg_id
    ,SUM(v01.bestandskorr_vk_netto) AS bestandskorr_zvkp_vk_netto_kum
    --,sum(test.dummy_inventur_vk_netto)
    ,SUM(v01.diebstahl_vk_netto) AS diebstahl_zvkp_vk_netto_kum
    ,SUM(v01.inventurdiff_vk_netto) AS inventurdiff_zvkp_vk_netto_kum
    ,SUM(v01.naturalrabatt_PL_vk_netto) AS naturalrabatt_PL_vk_netto_kum
FROM dbp_msi_v_view.v_vis_monat_ums_kunde_pers_wup_2 v00

LEFT JOIN
( 
    SELECT
        t1.mandant_id
        , t1.lagerbew_beleg_id
        , t1.lagerbew_beleg_pos_id
        , t1.dat_buch 
        , t11.dat_erfasst
        , COALESCE (t2.dat_plan_zaehlung_max 
        , DATE '1900-01-01') AS dat_inventur
        , t1.art_id
        , t1.wrg_id
        , t1.wup_id
        , t1.nb_id
        , t1.lager_bewart_id
        , t1.auto_fg
        , t1.menge_lagerbew_bme
        , t1.betrag_vk_netto 
        , t11.beleg_user_name
        ,v05.mwst_id 
        ,v07.vk_brutto
        ,v06.mwst
        ,(v07.vk_brutto * 100) / (100 + v06.mwst) vk_netto
        -- Mengen bewertet zum aktuellen VK_2 netto	
        , CASE WHEN t1.lager_bewart_id IN ('343', '344') AND t11.beleg_user_name = 'VBATCH' AND  t1.auto_fg = 'X' AND  t1.dat_buch > COALESCE (t2.dat_plan_zaehlung_max ,DATE '1900-01-01') THEN t1.menge_lagerbew_bme * vk_netto ELSE 0 END AS bestandskorr_vk_netto
        --, case when t1.lager_bewart_id IN ('341', '342') then t1.menge_lagerbew_bme * vk_netto  Else 0 end as dummy_inventur_vk_netto
        , CASE WHEN t1.lager_bewart_id IN ('993', '994', '190') THEN t1.menge_lagerbew_bme * vk_netto  ELSE 0 END AS diebstahl_vk_netto
        , CASE WHEN t1.lager_bewart_id IN ('701', '702') THEN t1.menge_lagerbew_bme * vk_netto  ELSE 0 END AS inventurdiff_vk_netto
        , CASE WHEN t1.lager_bewart_id IN ('951', '952') AND t1.mandant_id = 3 THEN t1.menge_lagerbew_bme * vk_netto  ELSE 0 END AS naturalrabatt_PL_vk_netto
        /*
        Original Werte
        , case when t1.lager_bewart_id in ('343', '344') and t11.beleg_user_name = 'VBATCH' and  t1.auto_fg = 'X' and  t1.dat_buch > coalesce (t2.dat_plan_zaehlung_max ,date '1900-01-01') then t1.betrag_vk_netto Else 0 end as bestandskorr_vk_netto
        --, case when t1.lager_bewart_id in ('341', '342') then t1.betrag_vk_netto Else 0 end as dummy_inventur_vk_netto
        , case when t1.lager_bewart_id in ('993', '994', '190') then t1.betrag_vk_netto Else 0 end as diebstahl_vk_netto
        , case when t1.lager_bewart_id in ('701', '702') then t1.betrag_vk_netto Else 0 end as inventurdiff_vk_netto
        */
    FROM 
    dbp_view.v_lagerbew_det_2 t1_2
    
    JOIN dbp_view.v_lagerbew_2 t11
    ON t1.lagerbew_beleg_id = t11.lagerbew_beleg_id AND
    t1.dat_buch =  t11.dat_buch AND
    t1.mandant_id = t11.mandant_id
    
    JOIN dbp_view.v_tag_2 v02
    ON t1.dat_buch = v02.dat

    LEFT OUTER JOIN
    (
        SELECT
            mandant_id
            , wup_id
            , art_id
            , MAX(dat_plan_zaehlung) dat_plan_zaehlung_max 
        FROM dbp_view.v_inventur_termin_art_wup_zu_per_2 s1
        JOIN dbp_view.v_tag_2 s2
        ON s1.dat_plan_zaehlung = s2.dat
        -- Performance nur letztze 13 Monate
        WHERE s2.akt_mo BETWEEN -12 AND -1
        GROUP BY 1,2,3
    ) t2
    ON t1.mandant_id = t2.mandant_id AND
    t1.wup_id = t2.wup_id AND
    t1.art_id = t2.art_id  
    
    JOIN dbp_view.v_art_2 v05
    ON v05.art_id = t1.art_id 
    AND v05.mandant_id = t1.mandant_id
        
    JOIN dbp_view.v_mwst_per_2 v06
    ON v05.mandant_id = v06.mandant_id
    AND v05.mwst_id = v06.mwst_id
    AND v06.dat_bis = '9999-12-31'  
        
    JOIN dbp_view.v_art_wup_vk_per_2 v07
    ON v05.mandant_id = v07.mandant_id
    AND v05.art_id = v07.art_id
    AND t1.wup_id = v07.wup_id
    AND (
            SELECT MAX(dat) dat 
            FROM dbp_view.v_tag_2 
            WHERE akt_mo = -1) BETWEEN v07.dat_von AND v07.dat_bis
    WHERE t1.mandant_id <> 1
    AND t1.lager_bewart_id IN (
    '343','344' -- Bestandskorrekturen
    ,'341','342' -- Dummy_2 Inventur_2 RO
    , '993', '994', '190' -- Diebstahl
    , '701', '702' -- Inventur_2
    , '951', '952'  -- Naturalrabatt für PL
    )
    -- Performance nur letztze 13 Monate
    AND v02.akt_mo BETWEEN -12 AND -1
) v01  
ON v00.mandant_id = v01.mandant_id
AND v00.wup_id = v01.wup_id
AND v00.wrg_id = v01.wrg_id

JOIN dbp_view.v_monat_2 v10
ON v00.kjmo = v10.kjmo 
AND v10.akt_mo = -1 -- 12 Monats kumuliert auf jed letzten Monat_2

INNER JOIN dbp_view.v_wup_2 wup_2
ON v00.mandant_id = wup.mandant_id AND v00.wup_id = wup.wup_id

WHERE v00.mandant_id <> 1

GROUP BY 
    v00.kjmo
    ,v00.mandant_id
    , wup.aktuell_wup_id
    ,v00.nb_id  
    ,v01.art_id 
    ,v00.wrg_id
;