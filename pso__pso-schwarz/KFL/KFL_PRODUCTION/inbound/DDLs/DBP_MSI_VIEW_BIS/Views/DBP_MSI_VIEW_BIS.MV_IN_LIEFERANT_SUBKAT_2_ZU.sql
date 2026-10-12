CREATE OR REPLACE VIEW DBP_MSI_VIEW_BIS.MV_IN_LIEFERANT_SUBKAT_2_ZU
   -- 11.12.2012 AL initial
   (
   in_lief_id
   ,mandant_id
   ,subkategorie_2_id


   )
   AS
      SELECT                 in_lief_id,
      mandant_id,
      subkategorie_2_id
      FROM dbp_view.v_in_lieferant_subkat_2_zu ;