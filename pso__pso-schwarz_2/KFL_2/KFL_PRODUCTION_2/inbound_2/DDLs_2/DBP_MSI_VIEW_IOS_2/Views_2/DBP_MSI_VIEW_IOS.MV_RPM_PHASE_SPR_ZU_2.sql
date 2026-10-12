CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_RPM_PHASE_SPR_ZU_2 as

   SELECT
   rpm_phase_id, rpm_projekt_typ_id, MAX(CASE WHEN spr_id =  22 THEN rpm_phase_bez ELSE NULL END) AS rpm_phase_bez                 -- standard == DE
   , COALESCE(MAX(CASE WHEN spr_id = 124 THEN rpm_phase_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN rpm_phase_bez ELSE NULL END)) AS rpm_phase_bez_cz    -- CZ
   , COALESCE(MAX(CASE WHEN spr_id = 108 THEN rpm_phase_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN rpm_phase_bez ELSE NULL END)) AS rpm_phase_bez_sk    -- SK
   , COALESCE(MAX(CASE WHEN spr_id = 65 THEN rpm_phase_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN rpm_phase_bez ELSE NULL END)) AS rpm_phase_bez_hr    -- HR
   , COALESCE(MAX(CASE WHEN spr_id = 90 THEN rpm_phase_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN rpm_phase_bez ELSE NULL END)) AS rpm_phase_bez_pl    -- PL
   , COALESCE(MAX(CASE WHEN spr_id = 95 THEN rpm_phase_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN rpm_phase_bez ELSE NULL END)) AS rpm_phase_bez_ro    -- RO
   , COALESCE(MAX(CASE WHEN spr_id = 24 THEN rpm_phase_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN rpm_phase_bez ELSE NULL END)) AS rpm_phase_bez_en    -- EN
   , COALESCE(MAX(CASE WHEN spr_id = 18 THEN rpm_phase_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN rpm_phase_bez ELSE NULL END)) AS rpm_phase_bez_bg    -- BG


   FROM dbp_view.v_rpm_phase_spr_zu_2
   GROUP BY 1,2;