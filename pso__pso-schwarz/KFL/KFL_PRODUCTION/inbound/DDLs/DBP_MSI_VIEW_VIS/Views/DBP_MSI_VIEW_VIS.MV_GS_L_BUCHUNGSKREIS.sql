CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_GS_L_BUCHUNGSKREIS as
   -- LOOKUP Buchungskreis (Geschenk-Karten)
   -- 2011KW46 Initial
   -- 2019.0520 ssch0611 : Added Moldau

   SELECT
   v01.mandant_id, v01.buchungskreis_id, v01.system_id
   FROM dbp_view.v_l_buchungskreis  v01
   WHERE (v01.mandant_id = 1 AND v01.system_id = 2)
   OR (v01.mandant_id = 2 AND v01.system_id = 53)
   OR (v01.mandant_id = 5 AND v01.system_id = 51)
   OR (v01.mandant_id = 6 AND v01.system_id = 54)
   OR (v01.mandant_id = 3 AND v01.system_id = 55)
   OR (v01.mandant_id = 7 AND v01.system_id = 13)
   OR (v01.mandant_id = 8 AND v01.system_id = 12)
   OR (v01.mandant_id = 4 AND v01.system_id = 13) -- Moldau

   UNION ALL
   SELECT
   v01.mandant_id, 0::SMALLINT  AS buchungskreis_id, CASE
   WHEN v01.mandant_id = 1 THEN 2
   WHEN v01.mandant_id = 2 THEN 53
   WHEN v01.mandant_id = 5 THEN 51
   WHEN v01.mandant_id = 6 THEN 54
   WHEN v01.mandant_id = 3 THEN 55
   WHEN v01.mandant_id = 7 THEN 13
   WHEN v01.mandant_id = 8 THEN 12
   WHEN v01.mandant_id = 4 THEN 13
   END::SMALLINT  AS system_id
   FROM dbp_view.v_mandant  v01;