CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_FILIALE_BEREICH_L3_LU_1 as
   -- LOOKUP/Sprache : Filiale Bereich Level 3 (INT)
   -- 2019.10.08 ssch0611 : Initial. Level3 = Alle Bereiche

   SELECT DISTINCT
   hr_objekt_bereich_id                                                                      AS filiale_bereich_l3_id, Max(CASE WHEN spr_id = 22 THEN hr_objekt_bereich_bez ELSE Trim(hr_objekt_bereich_id) END) AS filiale_bereich_l3_bez       -- DE
   , Coalesce(Max(CASE WHEN spr_id = 124 THEN hr_objekt_bereich_bez END), Max(CASE WHEN spr_id = 22 THEN hr_objekt_bereich_bez ELSE Trim(hr_objekt_bereich_id) END))   AS filiale_bereich_l3_bez_cz    -- CZ
   , Coalesce(Max(CASE WHEN spr_id = 108 THEN hr_objekt_bereich_bez END), Max(CASE WHEN spr_id = 22 THEN hr_objekt_bereich_bez ELSE Trim(hr_objekt_bereich_id) END))   AS filiale_bereich_l3_bez_sk    -- SK
   , Coalesce(Max(CASE WHEN spr_id =  65 THEN hr_objekt_bereich_bez END), Max(CASE WHEN spr_id = 22 THEN hr_objekt_bereich_bez ELSE Trim(hr_objekt_bereich_id) END))   AS filiale_bereich_l3_bez_hr    -- HR
   , Coalesce(Max(CASE WHEN spr_id =  90 THEN hr_objekt_bereich_bez END), Max(CASE WHEN spr_id = 22 THEN hr_objekt_bereich_bez ELSE Trim(hr_objekt_bereich_id) END))   AS filiale_bereich_l3_bez_pl    -- PL
   , Coalesce(Max(CASE WHEN spr_id =  95 THEN hr_objekt_bereich_bez END), Max(CASE WHEN spr_id = 22 THEN hr_objekt_bereich_bez ELSE Trim(hr_objekt_bereich_id) END))   AS filiale_bereich_l3_bez_ro    -- RO
   , Coalesce(Max(CASE WHEN spr_id =  18 THEN hr_objekt_bereich_bez END), Max(CASE WHEN spr_id = 22 THEN hr_objekt_bereich_bez ELSE Trim(hr_objekt_bereich_id) END))   AS filiale_bereich_l3_bez_bg    -- BG
   , Max(CASE WHEN spr_id = 22 THEN hr_objekt_bereich_bez ELSE Trim(hr_objekt_bereich_id) END) AS hr_objekt_bereich
   FROM dbp_view.v_org_einheit_bereich_spr_zu_1  oeb

   GROUP BY hr_objekt_bereich_id;