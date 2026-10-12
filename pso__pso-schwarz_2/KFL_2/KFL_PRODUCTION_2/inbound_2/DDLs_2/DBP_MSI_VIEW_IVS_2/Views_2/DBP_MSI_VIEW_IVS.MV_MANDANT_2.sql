CREATE OR REPLACE VIEW DBP_MSI_VIEW_IVS.MV_MANDANT_2
   AS
      SELECT
      m.mandant_id,
      m.mandant_bez,
      m.mandant_kbez
      FROM dbp_view.v_mandant_2  m;