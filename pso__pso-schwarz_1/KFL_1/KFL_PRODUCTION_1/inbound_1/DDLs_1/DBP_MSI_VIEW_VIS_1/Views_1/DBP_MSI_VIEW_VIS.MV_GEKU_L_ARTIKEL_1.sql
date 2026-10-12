CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_GEKU_L_ARTIKEL_1 as
   -- GEKU Lookup Artikel_1
   -- 2011KW46 INITIAL
   --  25.06.2018 lsvi0303: Analog KMR SPEC0038139 Schlüssel für DWH Artikel_1 um kmr_quelle_id ergänzt für Zusammenführung Hierarchie

   SELECT
   v01.geku_artikel_uid, v01.geku_artikel_id, v01.geku_grund_uid, v01.land_iso, v01.geku_dwh_artikel_id,  3 AS kmr_quelle_id

   FROM dbp_view.v_l_geku_artikel_1 v01
;