CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_MONDPHASE_SPR_ZU_1 as
   SELECT
   v01.mondphase_id, MAX(CASE WHEN v01.spr_id =  22 THEN v01.mondphase_bez END) AS mondphase_bez   --standard=deutsch
   , MAX(CASE WHEN v01.spr_id =  22 THEN v01.mondphase_bez END) AS mondphase_bez_de      --DE
   , COALESCE(MAX(CASE WHEN v01.spr_id = 24 THEN v01.mondphase_bez END), mondphase_bez_de) AS mondphase_bez_cz    -- CZ
   , COALESCE(MAX(CASE WHEN v01.spr_id = 24 THEN v01.mondphase_bez END), mondphase_bez_de) AS mondphase_bez_sk    -- SK
   , COALESCE(MAX(CASE WHEN v01.spr_id = 24 THEN v01.mondphase_bez END), mondphase_bez_de) AS mondphase_bez_hr    -- HR
   , COALESCE(MAX(CASE WHEN v01.spr_id = 24 THEN v01.mondphase_bez END), mondphase_bez_de) AS mondphase_bez_pl    -- PL
   , COALESCE(MAX(CASE WHEN v01.spr_id = 24 THEN v01.mondphase_bez END), mondphase_bez_de) AS mondphase_bez_ro    -- RO
   , COALESCE(MAX(CASE WHEN v01.spr_id = 24 THEN v01.mondphase_bez END), mondphase_bez_de) AS mondphase_bez_bg    -- BG
   FROM dbp_view.v_mondphase_spr_zu_1 v01
   GROUP BY
   v01.mondphase_id;