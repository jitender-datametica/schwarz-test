CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_DREHKLASSE_SPR_ZU_1 as
   SELECT
   mandant_id, drehklasse_kz, MAX(CASE WHEN spr_id=22 THEN drehklasse_bez ELSE NULL END) AS drehklasse_bez, MAX(CASE WHEN spr_id=22 THEN drehklasse_bez ELSE NULL END) AS drehklasse_bez_de --DE
   , COALESCE(MAX(CASE WHEN spr_id = 124 THEN drehklasse_bez ELSE NULL END), drehklasse_bez_de) AS drehklasse_bez_cz    -- CZ
   , COALESCE(MAX(CASE WHEN spr_id = 108 THEN drehklasse_bez ELSE NULL END), drehklasse_bez_de) AS drehklasse_bez_sk    -- SK
   , COALESCE(MAX(CASE WHEN spr_id =  65 THEN drehklasse_bez ELSE NULL END), drehklasse_bez_de) AS drehklasse_bez_hr    -- HR
   , COALESCE(MAX(CASE WHEN spr_id =  90 THEN drehklasse_bez ELSE NULL END), drehklasse_bez_de) AS drehklasse_bez_pl    -- PL
   , COALESCE(MAX(CASE WHEN spr_id =  95 THEN drehklasse_bez ELSE NULL END), drehklasse_bez_de) AS drehklasse_bez_ro    -- RO
   , COALESCE(MAX(CASE WHEN spr_id =  18 THEN drehklasse_bez ELSE NULL END), drehklasse_bez_de) AS drehklasse_bez_bg    -- BG

   FROM dbp_view.v_drehklasse_spr_zu_1
   GROUP BY
   mandant_id
   , drehklasse_kz;