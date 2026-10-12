CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_ARTKZ_LOESCH_2 as
   SELECT
   v01.mandant_id, v01.loesch_id, MAX(CASE WHEN (spr_id =  22 AND NOT loesch_id='') THEN loesch_bez WHEN (spr_id =  22 AND loesch_id='') THEN 'leer/empty' END) AS loesch_bez                 -- standard == DE
   , MAX(CASE WHEN (spr_id =  22 AND NOT loesch_id='') THEN loesch_bez WHEN (spr_id =  22 AND loesch_id='') THEN 'leer/empty' END) AS loesch_bez_de                          -- DE
   , COALESCE(MAX(CASE WHEN (spr_id = 124 AND NOT loesch_id='') THEN loesch_bez WHEN (spr_id = 124 AND loesch_id='') THEN 'leer/empty' END), loesch_bez_de) AS loesch_bez_cz    -- CZ
   , COALESCE(MAX(CASE WHEN (spr_id = 108 AND NOT loesch_id='') THEN loesch_bez WHEN (spr_id =  108 AND loesch_id='') THEN 'leer/empty' END), loesch_bez_de) AS loesch_bez_sk    -- SK
   , COALESCE(MAX(CASE WHEN (spr_id = 65 AND NOT loesch_id='') THEN loesch_bez WHEN (spr_id =  65 AND loesch_id='') THEN 'leer/empty'  END), loesch_bez_de) AS loesch_bez_hr    -- HR
   , COALESCE(MAX(CASE WHEN (spr_id = 90 AND NOT loesch_id='') THEN loesch_bez WHEN (spr_id =  90 AND loesch_id='') THEN 'leer/empty' END), loesch_bez_de) AS loesch_bez_pl    -- PL
   , COALESCE(MAX(CASE WHEN (spr_id = 95 AND NOT loesch_id='') THEN loesch_bez WHEN (spr_id =  95 AND loesch_id='') THEN 'leer/empty' END), loesch_bez_de) AS loesch_bez_ro    -- RO
   , COALESCE(MAX(CASE WHEN (spr_id = 18 AND NOT loesch_id='') THEN loesch_bez WHEN (spr_id =  18 AND loesch_id='') THEN 'leer/empty' END), loesch_bez_de) AS loesch_bez_bg    -- BG
   FROM dbp_view.v_artkz_loesch_2  v01
   GROUP BY
   v01.mandant_id
   , v01.loesch_id
   UNION ALL
   SELECT
   v02.mandant_id, '' AS loesch_id, 'leer/empty' AS loesch_bez                 -- standard == DE
   , 'leer/empty' AS loesch_bez_de, 'leer/empty' AS loesch_bez_cz    -- CZ
   , 'leer/empty' AS loesch_bez_sk    -- SK
   , 'leer/empty' AS loesch_bez_hr     -- HR
   , 'leer/empty' AS loesch_bez_pl      -- PL
   , 'leer/empty' AS loesch_bez_ro     -- RO
   , 'leer/empty' AS loesch_bez_bg    -- BG
   FROM dbp_view.v_mandant_2 v02
   WHERE v02.mandant_id <> 1
   GROUP BY
   v02.mandant_id;