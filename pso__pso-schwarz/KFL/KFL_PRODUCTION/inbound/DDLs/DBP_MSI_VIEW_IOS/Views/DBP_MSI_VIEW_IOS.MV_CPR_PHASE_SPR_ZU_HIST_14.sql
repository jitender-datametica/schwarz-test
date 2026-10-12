CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_CPR_PHASE_SPR_ZU_HIST_14 as

   SELECT
   v111.projekt_phase_id, v111.mandant_id, v111.dat_von, v111.dat_bis, "CURRENT_DATE" -14 AS dat_extrakt, MAX(CASE WHEN v111.spr_id =  22 THEN v111.cpr_phase_bez ELSE NULL END) AS cpr_phase_bez                 -- standard == DE
   , COALESCE(MAX(CASE WHEN v111.spr_id = 124 THEN v111.cpr_phase_bez ELSE NULL END), MAX(CASE WHEN v111.spr_id =  22 THEN v111.cpr_phase_bez ELSE NULL END)) AS cpr_phase_bez_cz    -- CZ
   , COALESCE(MAX(CASE WHEN v111.spr_id = 108 THEN v111.cpr_phase_bez ELSE NULL END), MAX(CASE WHEN v111.spr_id =  22 THEN v111.cpr_phase_bez ELSE NULL END)) AS cpr_phase_bez_sk    -- SK
   , COALESCE(MAX(CASE WHEN v111.spr_id =  65 THEN v111.cpr_phase_bez ELSE NULL END), MAX(CASE WHEN v111.spr_id =  22 THEN v111.cpr_phase_bez ELSE NULL END)) AS cpr_phase_bez_hr    -- HR
   , COALESCE(MAX(CASE WHEN v111.spr_id =  90 THEN v111.cpr_phase_bez ELSE NULL END), MAX(CASE WHEN v111.spr_id =  22 THEN v111.cpr_phase_bez ELSE NULL END)) AS cpr_phase_bez_pl    -- PL
   , COALESCE(MAX(CASE WHEN v111.spr_id =  95 THEN v111.cpr_phase_bez ELSE NULL END), MAX(CASE WHEN v111.spr_id =  22 THEN v111.cpr_phase_bez ELSE NULL END)) AS cpr_phase_bez_ro    -- RO
   , COALESCE(MAX(CASE WHEN v111.spr_id =  24 THEN v111.cpr_phase_bez ELSE NULL END), MAX(CASE WHEN v111.spr_id =  22 THEN v111.cpr_phase_bez ELSE NULL END)) AS cpr_phase_bez_en    -- EN
   , COALESCE(MAX(CASE WHEN v111.spr_id =  18 THEN v111.cpr_phase_bez ELSE NULL END), MAX(CASE WHEN v111.spr_id =  22 THEN v111.cpr_phase_bez ELSE NULL END)) AS cpr_phase_bez_bg    -- BG
   , MAX(CASE WHEN v111.spr_id =  22 THEN v111.cpr_phase_langtext ELSE NULL END) AS cpr_phase_langtext                 -- standard == DE
   , COALESCE(MAX(CASE WHEN v111.spr_id = 124 THEN v111.cpr_phase_langtext ELSE NULL END), MAX(CASE WHEN v111.spr_id =  22 THEN v111.cpr_phase_langtext ELSE NULL END)) AS cpr_phase_langtext_cz    -- CZ
   , COALESCE(MAX(CASE WHEN v111.spr_id = 108 THEN v111.cpr_phase_langtext ELSE NULL END), MAX(CASE WHEN v111.spr_id =  22 THEN v111.cpr_phase_langtext ELSE NULL END)) AS cpr_phase_langtext_sk    -- SK
   , COALESCE(MAX(CASE WHEN v111.spr_id =  65 THEN v111.cpr_phase_langtext ELSE NULL END), MAX(CASE WHEN v111.spr_id =  22 THEN v111.cpr_phase_langtext ELSE NULL END)) AS cpr_phase_langtext_hr    -- HR
   , COALESCE(MAX(CASE WHEN v111.spr_id =  90 THEN v111.cpr_phase_langtext ELSE NULL END), MAX(CASE WHEN v111.spr_id =  22 THEN v111.cpr_phase_langtext ELSE NULL END)) AS cpr_phase_langtext_pl    -- PL
   , COALESCE(MAX(CASE WHEN v111.spr_id =  95 THEN v111.cpr_phase_langtext ELSE NULL END), MAX(CASE WHEN v111.spr_id =  22 THEN v111.cpr_phase_langtext ELSE NULL END)) AS cpr_phase_langtext_ro    -- RO
   , COALESCE(MAX(CASE WHEN v111.spr_id =  24 THEN v111.cpr_phase_langtext ELSE NULL END), MAX(CASE WHEN v111.spr_id =  22 THEN v111.cpr_phase_langtext ELSE NULL END)) AS cpr_phase_langtext_en    -- EN
   , COALESCE(MAX(CASE WHEN v111.spr_id =  18 THEN v111.cpr_phase_langtext ELSE NULL END), MAX(CASE WHEN v111.spr_id =  22 THEN v111.cpr_phase_langtext ELSE NULL END)) AS cpr_phase_langtext_bg    -- BG

   FROM
   (
   SELECT
   v02.projekt_phase_id, v02.spr_id, v02.cpr_phase_bez, COALESCE(v02.cpr_phase_langtext,'')  AS cpr_phase_langtext, v04.mandant_id, v02.dat_von, v02.dat_bis
   FROM dbp_view.v_cpr_phase_spr_zu_per  v02
   INNER JOIN dbp_view.v_cpr_phase_per v03
   ON  v02.projekt_phase_id = v03.projekt_phase_id
   INNER JOIN dbp_view.v_cpr_projekt_per  v04
   ON  v03.projekt_id = v04.projekt_id

   /*  LEFT JOIN dbp_view.v_mandant_spr_zu v06
   ON v04.mandant_id = v06.mandant_id


   LEFT JOIN dbp_view.v_cpr_phase_spr_zu_per  v05
   ON v02.projekt_phase_id = v05.projekt_phase_id
   AND v05.spr_id=v06.spr_id
   */


   WHERE
   CURRENT_DATE -14 BETWEEN v02.dat_von AND v02.dat_bis
   AND CURRENT_DATE -14 BETWEEN v03.dat_von AND v03.dat_bis
   AND CURRENT_DATE -14 BETWEEN v04.dat_von AND v04.dat_bis
   --AND (DATE-14 BETWEEN v05.dat_von AND v05.dat_bis
   --       OR v05.dat_von IS NULL)
   )
   v111
   --WHERE v111.spr_id = 22;


   GROUP BY   v111.projekt_phase_id
   ,v111.mandant_id
   ,v111.dat_von
   ,v111.dat_bis
   ,dat_extrakt;