CREATE OR REPLACE VIEW DBP_MSI_VIEW_IVS.MV_MANDANT
   AS
      SELECT
      m.mandant_id,
      m.mandant_bez,
      m.mandant_kbez
      FROM dbp_view.v_mandant  m;