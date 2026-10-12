CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_ARTIKELTYP_SPR_ZU_1 as
   SELECT
   mandant_id, artikeltyp_id, MAX(CASE WHEN spr_id=22 THEN artikeltyp_bez END ) AS artikeltyp_bez                                         -- standard == DE
   , MAX(CASE WHEN spr_id=22 THEN artikeltyp_bez END) AS artikeltyp_bez_de                                 -- DE
   , COALESCE(MAX(CASE WHEN spr_id = 124 THEN artikeltyp_bez END), artikeltyp_bez_de) AS artikeltyp_bez_cz    -- CZ
   , COALESCE(MAX(CASE WHEN spr_id = 108 THEN artikeltyp_bez END), artikeltyp_bez_de) AS artikeltyp_bez_sk    -- SK
   , COALESCE(MAX(CASE WHEN spr_id =  65 THEN artikeltyp_bez END), artikeltyp_bez_de) AS artikeltyp_bez_hr     -- HR
   , COALESCE(MAX(CASE WHEN spr_id =  90 THEN artikeltyp_bez END), artikeltyp_bez_de) AS artikeltyp_bez_pl      -- PL
   , COALESCE(MAX(CASE WHEN spr_id =  95 THEN artikeltyp_bez END), artikeltyp_bez_de) AS artikeltyp_bez_ro     -- RO
   , COALESCE(MAX(CASE WHEN spr_id =  18 THEN artikeltyp_bez END), artikeltyp_bez_de) AS artikeltyp_bez_bg    -- BG
   FROM dbp_view.v_artikeltyp_spr_zu_1
   GROUP BY
   mandant_id
   , artikeltyp_id;