CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_CPR_PROJEKT_SPR_ZU as
   SELECT
   v111.projekt_id, v111.projekt_nr, MAX(CASE WHEN spr_id =  22 THEN v111.cpr_projekt_bez ELSE NULL END) AS cpr_projekt_bez                 -- standard == DE
   , COALESCE(MAX(CASE WHEN spr_id = 124 THEN v111.cpr_projekt_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN v111.cpr_projekt_bez ELSE NULL END)) AS cpr_projekt_bez_cz    -- CZ
   , COALESCE(MAX(CASE WHEN spr_id = 108 THEN v111.cpr_projekt_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN v111.cpr_projekt_bez ELSE NULL END)) AS cpr_projekt_bez_sk    -- SK
   , COALESCE(MAX(CASE WHEN spr_id = 65 THEN v111.cpr_projekt_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN v111.cpr_projekt_bez ELSE NULL END)) AS cpr_projekt_bez_hr    -- HR
   , COALESCE(MAX(CASE WHEN spr_id = 90 THEN v111.cpr_projekt_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN v111.cpr_projekt_bez ELSE NULL END)) AS cpr_projekt_bez_pl    -- PL
   , COALESCE(MAX(CASE WHEN spr_id = 95 THEN v111.cpr_projekt_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN v111.cpr_projekt_bez ELSE NULL END)) AS cpr_projekt_bez_ro    -- RO
   , COALESCE(MAX(CASE WHEN spr_id = 24 THEN v111.cpr_projekt_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN v111.cpr_projekt_bez ELSE NULL END)) AS cpr_projekt_bez_en    -- EN
   , COALESCE(MAX(CASE WHEN spr_id = 18 THEN v111.cpr_projekt_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN v111.cpr_projekt_bez ELSE NULL END)) AS cpr_projekt_bez_bg    -- BG
   , MAX(CASE WHEN spr_id =  22 THEN v111.cpr_projekt_langtext ELSE NULL END) AS cpr_projekt_langtext                 -- standard == DE
   , COALESCE(MAX(CASE WHEN spr_id = 124 THEN v111.cpr_projekt_langtext ELSE NULL END),MAX(CASE WHEN spr_id =  22 THEN v111.cpr_projekt_langtext ELSE NULL END)) AS cpr_projekt_langtext_cz    -- CZ
   , COALESCE(MAX(CASE WHEN spr_id = 108 THEN v111.cpr_projekt_langtext ELSE NULL END),MAX(CASE WHEN spr_id =  22 THEN v111.cpr_projekt_langtext ELSE NULL END)) AS cpr_projekt_langtext_sk    -- SK
   , COALESCE(MAX(CASE WHEN spr_id = 65 THEN v111.cpr_projekt_langtext ELSE NULL END),MAX(CASE WHEN spr_id =  22 THEN v111.cpr_projekt_langtext ELSE NULL END)) AS cpr_projekt_langtext_hr    -- HR
   , COALESCE(MAX(CASE WHEN spr_id = 90 THEN v111.cpr_projekt_langtext ELSE NULL END),MAX(CASE WHEN spr_id =  22 THEN v111.cpr_projekt_langtext ELSE NULL END)) AS cpr_projekt_langtext_pl    -- PL
   , COALESCE(MAX(CASE WHEN spr_id = 95 THEN v111.cpr_projekt_langtext ELSE NULL END),MAX(CASE WHEN spr_id =  22 THEN v111.cpr_projekt_langtext ELSE NULL END)) AS cpr_projekt_langtext_ro    -- RO
   , COALESCE(MAX(CASE WHEN spr_id = 24 THEN v111.cpr_projekt_langtext ELSE NULL END),MAX(CASE WHEN spr_id =  22 THEN v111.cpr_projekt_langtext ELSE NULL END)) AS cpr_projekt_langtext_en    -- EN
   , COALESCE(MAX(CASE WHEN spr_id = 18 THEN v111.cpr_projekt_langtext ELSE NULL END),MAX(CASE WHEN spr_id =  22 THEN v111.cpr_projekt_langtext ELSE NULL END)) AS cpr_projekt_langtext_bg    -- BG
   , MAX(CASE WHEN spr_id =  22 THEN v111.projekt_kbez ELSE NULL END) AS projekt_kbez                 -- standard == DE
   , COALESCE(MAX(CASE WHEN spr_id = 124 THEN v111.projekt_kbez ELSE NULL END),MAX(CASE WHEN spr_id =  22 THEN v111.projekt_kbez ELSE NULL END)) AS projekt_kbez_cz    -- CZ
   , COALESCE(MAX(CASE WHEN spr_id = 108 THEN v111.projekt_kbez ELSE NULL END),MAX(CASE WHEN spr_id =  22 THEN v111.projekt_kbez ELSE NULL END)) AS projekt_kbez_sk    -- SK
   , COALESCE(MAX(CASE WHEN spr_id = 65 THEN v111.projekt_kbez ELSE NULL END),MAX(CASE WHEN spr_id =  22 THEN v111.projekt_kbez ELSE NULL END)) AS projekt_kbez_hr    -- HR
   , COALESCE(MAX(CASE WHEN spr_id = 90 THEN v111.projekt_kbez ELSE NULL END),MAX(CASE WHEN spr_id =  22 THEN v111.projekt_kbez ELSE NULL END)) AS projekt_kbez_pl    -- PL
   , COALESCE(MAX(CASE WHEN spr_id = 95 THEN v111.projekt_kbez ELSE NULL END),MAX(CASE WHEN spr_id =  22 THEN v111.projekt_kbez ELSE NULL END)) AS projekt_kbez_ro    -- RO
   , COALESCE(MAX(CASE WHEN spr_id = 24 THEN v111.projekt_kbez ELSE NULL END),MAX(CASE WHEN spr_id =  22 THEN v111.projekt_kbez ELSE NULL END)) AS projekt_kbez_en    -- EN
   , COALESCE(MAX(CASE WHEN spr_id = 18 THEN v111.projekt_kbez ELSE NULL END),MAX(CASE WHEN spr_id =  22 THEN v111.projekt_kbez ELSE NULL END)) AS projekt_kbez_bg    -- BG
   , v111.mandant_id, v111.mandant_sort_id AS mandant_sort, v111.mandant_sort_id
   FROM
   (
   SELECT
   v02.projekt_id, v04.cpr_ext_id AS projekt_nr, v02.spr_id, v02.cpr_projekt_bez, COALESCE(SUBSTR(v02.cpr_projekt_bez ,4,80),'')::VARCHAR(80)  AS projekt_kbez, COALESCE(v02.cpr_projekt_langtext,'') AS cpr_projekt_langtext, v04.mandant_id, v07.mandant_sort_id

   FROM dbp_view.v_cpr_projekt_per v04
   LEFT JOIN dbp_view.v_cpr_projekt_spr_zu_per  v02
   ON  v02.projekt_id = v04.projekt_id
   LEFT JOIN dbp_view.v_mandant v07
   ON v04.mandant_id= v07.mandant_id
   LEFT JOIN dbp_view.v_cpr_projekt_spr_zu_per  v03
   ON v02.projekt_id = v03.projekt_id
   AND v03.spr_id =v02.spr_id
   -- AND v03.spr_id<>22

   WHERE
   --v02.spr_id = 22 AND
   (v02.dat_bis = '9999-12-31' OR v02.dat_bis IS NULL)
   AND (v03.dat_bis = '9999-12-31' OR v03.dat_bis IS NULL)
   AND v04.dat_bis = '9999-12-31'
   )
   v111
   GROUP BY
   projekt_id
   ,projekt_nr
   --,22 AS spr_i
   ,mandant_id
   ,mandant_sort
   ,mandant_sort_id;