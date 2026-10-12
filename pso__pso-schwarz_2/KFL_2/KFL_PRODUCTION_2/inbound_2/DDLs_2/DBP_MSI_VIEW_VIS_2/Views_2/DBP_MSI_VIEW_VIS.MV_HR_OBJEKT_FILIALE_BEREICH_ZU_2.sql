CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_HR_OBJEKT_FILIALE_BEREICH_ZU_2 as
   -- LOOKUP/ZUORDNUNG : hr objekt bereich / filiale bereich
   -- 2019.1008 ssch0611 : Initial

   SELECT DISTINCT
   oeb.hr_objekt_bereich_id, oeb.hr_objekt_bereich_id         AS filiale_bereich_l3_id -- alle Bereiche
   , oeb.hr_objekt_bereich_level2_id  AS filiale_bereich_l2_id -- 5 Bereiche (Theke)
   , lvl2.hr_objekt_bereich_level1_id AS filiale_bereich_l1_id -- 4 Bereiche
   FROM dbp_view.v_l_org_einheit_bereich_2 oeb

   JOIN dbp_view.v_l_org_einheit_bereich_level2_2 lvl2
   ON oeb.hr_objekt_bereich_level2_id = lvl2.hr_objekt_bereich_level2_id

   GROUP BY hr_objekt_bereich_id, filiale_bereich_l3_id, filiale_bereich_l2_id, filiale_bereich_l1_id;