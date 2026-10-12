CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_GEKU_L_DWH_ARTIKEL_2 as
   -- GEKU Lookup DWH Artikel_2
   -- 2011KW46 INITIAL
   -- 2012KW25 TB erweitert um geku_dwh_artikel_vis_id
   -- 20160229 CASE / VIS Artikel_2 entfernt!
   -- 20180625 kmr_quelle_id hinzugefuegt
   -- 20181127 twie: SPEC0046552 neues Flag für DHW Artikel_2, die auf KMR Hierarchie gemappt sind

   SELECT
   v01.geku_dwh_artikel_id, 3 AS kmr_quelle_id, v01.geku_grund_uid, v01.geku_artikel_uid, v01.geku_artikel_id, v01.fipo_pruefpunkt_id, v01.wmd_fg, v01.geku_dwh_artikel_id AS geku_dwh_artikel_vis_id, CASE WHEN v02.kmr_agm_id IS NULL THEN 0 ELSE 1 END AS geku_kmr_fg

   FROM dbp_view.v_l_geku_dwh_artikel_2 v01
   LEFT OUTER JOIN dbp_view.v_kmr_agm_unter_kategorie_zu_2 v02
   ON v01.geku_dwh_artikel_id = v02.kmr_agm_id
   AND v02.kmr_quelle_id = 3
   ;