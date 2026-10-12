CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_FILIALE_BEREICH_L2_OBJEKT_ZU_1 AS
   -- LOOKUP/ZUORDNUNG : hr objekt bereich / filiale bereich
   -- 2019.1115 ssch0611 : Initial (Special Theke)
   -- INC3936925 Initial falsch angelegt

   SELECT DISTINCT
   oeb.hr_objekt_bereich_id
   , oeb.hr_objekt_bereich_level2_id  AS filiale_bereich_l2_id -- 5 Bereiche (Theke)
   FROM dbp_view.v_l_org_einheit_bereich_1 oeb

   JOIN dbp_view.v_l_org_einheit_bereich_level2_1 lvl2
   ON oeb.hr_objekt_bereich_level2_id = lvl2.hr_objekt_bereich_level2_id

   UNION ALL
   SELECT -- Doppelte Zuordnung Theke
   hr_objekt_bereich_level2_id::BYTEINT hr_objekt_bereich_id
   , hr_objekt_bereich_level1_id AS hr_objekt_bereich_level2_id
   FROM dbp_view.v_l_org_einheit_bereich_level2_1
   WHERE hr_objekt_bereich_level2_id = 31
   ;