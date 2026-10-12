CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_GEKU_L_DWH_ARTIKEL_VIS as
   -- GEKU Lookup DWH Artikel (VIS)
   -- 2012KW25 TB INITIAL
   -- 20160229 UNION / VIS Artikel entfernt!

   SELECT
   geku_dwh_artikel_id AS geku_dwh_artikel_vis_id, geku_artikel_id     AS geku_dwh_artikel_vis_nr, geku_grund_uid      AS geku_grund_vis_id

   FROM dbp_view.v_l_geku_dwh_artikel

-- WHERE geku_dwh_artikel_id NOT IN (655, 1214, 1215, 2011, 2012, 2013)
-- UNION ALL
-- SELECT -99  AS geku_dwh_artikel_vis_id
--   ,''     AS geku_dwh_artikel_vis_nr
--   ,-99    AS geku_grund_vis_id
-- FROM dbp_view.v_tag
-- WHERE dat = DATE
;