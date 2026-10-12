CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_GEKU_L_GRUND_VIS_2 as
   -- GEKU Lookup/Zuordnung Grund VIS - Bereich
   -- 2012KW25 INITIAL
   -- 20160229 UNION / VIS Grund entfernt!

   SELECT
   geku_grund_uid    AS geku_grund_vis_id, geku_grund_id     AS geku_grund_vis_nr, geku_bereich_uid  AS geku_bereich_uid

   FROM dbp_view.v_l_geku_grund_2

--  UNION ALL
-- SELECT
--    -99  AS geku_grund_vis_id
--    ,''     AS geku_grund_vis_nr
--    ,1047645    AS geku_bereich_uid
-- FROM dbp_view.v_tag_2
-- WHERE dat = DATE
;