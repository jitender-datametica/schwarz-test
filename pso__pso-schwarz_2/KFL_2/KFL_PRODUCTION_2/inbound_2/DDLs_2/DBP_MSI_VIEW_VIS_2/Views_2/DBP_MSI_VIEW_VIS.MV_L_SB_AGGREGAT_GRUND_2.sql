CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_L_SB_AGGREGAT_GRUND_2 as
   -- LOOKUP Gruende fuer Filiale/Gesamt - Bereich - Detail
   -- Denormaliserte Variante (= komplette Tabelle)
   -- 20120213 Initial

   SELECT
   v01.mandant_id, v01.sb_grund_id
   FROM dbp_view.v_l_sb_grund_2 v01
   UNION ALL
   SELECT
   v01.mandant_id, -1::INTEGER AS sb_grund_id
   FROM dbp_view.v_mandant_2 v01
   WHERE v01.mandant_id <> 4;