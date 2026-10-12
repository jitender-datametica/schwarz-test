CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_GS_BUCHUNGSKREIS as
   -- SPRACHE Geschenk-Karten Buchungskreis
   -- Bezeichnungen in 'Landessprache'
   -- 2010KW17 GSS Redesign + Rollout KMO
   -- 2011KW46 Anpassung system_id + Dummy (Union)
   -- 2019.0520 ssch0611 : Added Moldau

   SELECT
   v01.mandant_id, v01.system_id, v01.buchungskreis_id, MAX(v01.buchungskreis_bez) AS buchungskreis_bez, CASE
   WHEN v01.mandant_id = 1 THEN 22
   WHEN v01.mandant_id = 2 THEN 124
   WHEN v01.mandant_id = 5 THEN 108
   WHEN v01.mandant_id = 6 THEN 65
   WHEN v01.mandant_id = 3 THEN 90
   WHEN v01.mandant_id = 7 THEN 95
   WHEN v01.mandant_id = 8 THEN 18
   WHEN v01.mandant_id = 4 THEN 95 -- Moldau (rumaenisch)
   END::SMALLINT  AS spr_id
   FROM dbp_view.v_buchungskreis_spr_zu v01
   WHERE (mandant_id = 1 AND system_id = 2)
   OR (mandant_id = 2 AND system_id = 53)
   OR (mandant_id = 5 AND system_id = 51)
   OR (mandant_id = 6 AND system_id = 54)
   OR (mandant_id = 3 AND system_id = 55)
   OR (mandant_id = 7 AND system_id = 13)
   OR (mandant_id = 8 AND system_id = 12)
   OR (mandant_id = 4 AND system_id = 13) -- Moldau
   GROUP BY
   v01.mandant_id
   , v01.system_id
   , v01.buchungskreis_id

   UNION ALL
   SELECT
   v01.mandant_id, CASE
   WHEN mandant_id = 1 THEN 2
   WHEN mandant_id = 2 THEN 53
   WHEN mandant_id = 5 THEN 51
   WHEN mandant_id = 6 THEN 54
   WHEN mandant_id = 3 THEN 55
   WHEN mandant_id = 7 THEN 13
   WHEN mandant_id = 8 THEN 12
   WHEN mandant_id = 4 THEN 13 -- Moldau
   END::SMALLINT  AS system_id, 0::SMALLINT    AS buchungskreis_id, 'nicht zugeordnet'::VARCHAR(30) AS buchungskreis_bez, CASE
   WHEN mandant_id = 1 THEN 22
   WHEN mandant_id = 2 THEN 124
   WHEN mandant_id = 5 THEN 108
   WHEN mandant_id = 6 THEN 65
   WHEN mandant_id = 3 THEN 90
   WHEN mandant_id = 7 THEN 95
   WHEN mandant_id = 8 THEN 18
   WHEN mandant_id = 4 THEN 95 -- Moldau (rumaenisch)
   END::SMALLINT  AS spr_id
   FROM dbp_view.v_mandant v01;