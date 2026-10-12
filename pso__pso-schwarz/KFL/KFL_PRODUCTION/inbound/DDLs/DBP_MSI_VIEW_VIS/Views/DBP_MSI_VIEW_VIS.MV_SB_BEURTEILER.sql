CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_SB_BEURTEILER as
   -- ZUORDNUNG/LOOKUP Beurteiler - Mitarbeiter
   -- Verknuepfung zwischen Beurteiler aus SB und Person (MA-Hierarchie)
   -- 201201 : Initial
   -- 201204 : Update

   SELECT
   v01.mandant_id, v01.beurteiler_id, COALESCE(v01.ma_id, -1) ma_id, v01.anz_sb_soll, v01.anz_sb_rot_bis, v01.anz_sb_gelb_bis, v01.operativ_fg

   FROM dbp_view.v_sb_beurteiler v01;