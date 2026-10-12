CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_RPM_ELEMENT_SPR_ZU_2 as
   SELECT
   v02.rpm_element_id, v02.dat_von, MAX(CASE WHEN v02.spr_id =  22 THEN v02.rpm_element_bez ELSE NULL END) AS rpm_element_bez                 -- standard == DE
   , COALESCE(MAX(CASE WHEN v02.spr_id = 124 THEN v02.rpm_element_bez ELSE NULL END), MAX(CASE WHEN v02.spr_id =  22 THEN v02.rpm_element_bez ELSE NULL END)) AS rpm_element_bez_cz    -- CZ
   , COALESCE(MAX(CASE WHEN v02.spr_id = 108 THEN v02.rpm_element_bez ELSE NULL END), MAX(CASE WHEN v02.spr_id =  22 THEN v02.rpm_element_bez ELSE NULL END)) AS rpm_element_bez_sk    -- SK
   , COALESCE(MAX(CASE WHEN v02.spr_id = 65 THEN v02.rpm_element_bez ELSE NULL END), MAX(CASE WHEN v02.spr_id =  22 THEN v02.rpm_element_bez ELSE NULL END)) AS rpm_element_bez_hr    -- HR
   , COALESCE(MAX(CASE WHEN v02.spr_id = 90 THEN v02.rpm_element_bez ELSE NULL END), MAX(CASE WHEN v02.spr_id =  22 THEN v02.rpm_element_bez ELSE NULL END)) AS rpm_element_bez_pl    -- PL
   , COALESCE(MAX(CASE WHEN v02.spr_id = 95 THEN v02.rpm_element_bez ELSE NULL END), MAX(CASE WHEN v02.spr_id =  22 THEN v02.rpm_element_bez ELSE NULL END)) AS rpm_element_bez_ro    -- RO
   , COALESCE(MAX(CASE WHEN v02.spr_id = 24 THEN v02.rpm_element_bez ELSE NULL END), MAX(CASE WHEN v02.spr_id =  22 THEN v02.rpm_element_bez ELSE NULL END)) AS rpm_element_bez_en    -- EN
   , COALESCE(MAX(CASE WHEN v02.spr_id = 18 THEN v02.rpm_element_bez ELSE NULL END), MAX(CASE WHEN v02.spr_id =  22 THEN v02.rpm_element_bez ELSE NULL END)) AS rpm_element_bez_bg    -- BG
   , MAX(CASE WHEN v02.spr_id =  22 THEN v02.rpm_element_langtext ELSE NULL END) AS rpm_element_langtext                 -- standard == DE
   , COALESCE(MAX(CASE WHEN v02.spr_id = 124 THEN v02.rpm_element_langtext ELSE NULL END), MAX(CASE WHEN v02.spr_id =  22 THEN v02.rpm_element_langtext ELSE NULL END)) AS rpm_element_langtext_cz    -- CZ
   , COALESCE(MAX(CASE WHEN v02.spr_id = 108 THEN v02.rpm_element_langtext ELSE NULL END), MAX(CASE WHEN v02.spr_id =  22 THEN v02.rpm_element_langtext ELSE NULL END)) AS rpm_element_langtext_sk    -- SK
   , COALESCE(MAX(CASE WHEN v02.spr_id = 65 THEN v02.rpm_element_langtext ELSE NULL END), MAX(CASE WHEN v02.spr_id =  22 THEN v02.rpm_element_langtext ELSE NULL END)) AS rpm_element_langtext_hr    -- HR
   , COALESCE(MAX(CASE WHEN v02.spr_id = 90 THEN v02.rpm_element_langtext ELSE NULL END), MAX(CASE WHEN v02.spr_id =  22 THEN v02.rpm_element_langtext ELSE NULL END)) AS rpm_element_langtext_pl    -- PL
   , COALESCE(MAX(CASE WHEN v02.spr_id = 95 THEN v02.rpm_element_langtext ELSE NULL END), MAX(CASE WHEN v02.spr_id =  22 THEN v02.rpm_element_langtext ELSE NULL END)) AS rpm_element_langtext_ro    -- RO
   , COALESCE(MAX(CASE WHEN v02.spr_id = 24 THEN v02.rpm_element_langtext ELSE NULL END), MAX(CASE WHEN v02.spr_id =  22 THEN v02.rpm_element_langtext ELSE NULL END)) AS rpm_element_langtext_en    -- EN
   , COALESCE(MAX(CASE WHEN v02.spr_id = 18 THEN v02.rpm_element_langtext ELSE NULL END), MAX(CASE WHEN v02.spr_id =  22 THEN v02.rpm_element_langtext ELSE NULL END)) AS rpm_element_langtext_bg    -- BG
   , MAX(CASE WHEN rfasz.spr_id =  22 THEN rfasz.rpm_feld_auspr_bez ELSE NULL END) AS eigentum_bez                -- standard == DE
   , COALESCE(MAX(CASE WHEN rfasz.spr_id = 124 THEN rfasz.rpm_feld_auspr_bez ELSE NULL END), MAX(CASE WHEN rfasz.spr_id=  22 THEN rfasz.rpm_feld_auspr_bez ELSE NULL END)) AS eigentum_bez_cz    -- CZ
   , COALESCE(MAX(CASE WHEN rfasz.spr_id = 108 THEN rfasz.rpm_feld_auspr_bez ELSE NULL END), MAX(CASE WHEN rfasz.spr_id=  22 THEN rfasz.rpm_feld_auspr_bez ELSE NULL END)) AS eigentum_bez_sk    -- SK
   , COALESCE(MAX(CASE WHEN rfasz.spr_id = 65 THEN rfasz.rpm_feld_auspr_bez ELSE NULL END), MAX(CASE WHEN rfasz.spr_id =  22 THEN rfasz.rpm_feld_auspr_bez ELSE NULL END)) AS eigentum_bez_hr    -- HR
   , COALESCE(MAX(CASE WHEN rfasz.spr_id = 90 THEN rfasz.rpm_feld_auspr_bez ELSE NULL END), MAX(CASE WHEN rfasz.spr_id =  22 THEN rfasz.rpm_feld_auspr_bez ELSE NULL END)) AS eigentum_bez_pl    -- PL
   , COALESCE(MAX(CASE WHEN rfasz.spr_id = 95 THEN rfasz.rpm_feld_auspr_bez ELSE NULL END), MAX(CASE WHEN rfasz.spr_id=  22 THEN rfasz.rpm_feld_auspr_bez ELSE NULL END)) AS eigentum_bez_ro    -- RO
   , COALESCE(MAX(CASE WHEN rfasz.spr_id = 24 THEN rfasz.rpm_feld_auspr_bez ELSE NULL END), MAX(CASE WHEN rfasz.spr_id =  22 THEN rfasz.rpm_feld_auspr_bez ELSE NULL END)) AS eigentum_bez_en    -- EN
   , COALESCE(MAX(CASE WHEN rfasz.spr_id = 18 THEN rfasz.rpm_feld_auspr_bez ELSE NULL END), MAX(CASE WHEN rfasz.spr_id =  22 THEN rfasz.rpm_feld_auspr_bez ELSE NULL END)) AS eigentum_bez_bg    -- BG

   FROM dbp_view.v_rpm_element_per_2 v22
   LEFT JOIN dbp_view.v_rpm_element_spr_zu_2 v02
   ON v02.rpm_element_id=v22.rpm_hierarchie_id
   LEFT OUTER JOIN dbp_view.v_rpm_feld_zu_per_2 rfzp
   ON  rfzp.rpm_hierarchie_id = v02.rpm_element_id
   AND rfzp.rpm_tab_id = 1      -- '/RPM/ITEM_D'
   AND rfzp.rpm_feld_id = 8     -- ZPPM_BESITZVERH Besitzverhaeltnis
   AND rfzp.dat_bis = '9999-12-31'
   LEFT OUTER JOIN dbp_view.v_rpm_feld_auspr_spr_zu_2 rfasz
   ON rfasz.rpm_feld_auspr_id = rfzp.rpm_feld_auspr_id
   AND rfasz.rpm_tab_id = 1      -- '/RPM/ITEM_D'
   AND rfasz.rpm_feld_id = 8     -- ZPPM_BESITZVERH Besitzverhaeltnis


   WHERE v22.dat_bis='9999-12-31'
   GROUP BY
   v02.rpm_element_id
   ,v02.dat_von;