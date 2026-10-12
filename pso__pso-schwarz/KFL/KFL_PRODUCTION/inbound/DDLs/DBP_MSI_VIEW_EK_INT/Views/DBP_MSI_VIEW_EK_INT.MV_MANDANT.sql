CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_INT.MV_MANDANT
AS
   SELECT
   v01.mandant_sort_id, v01.mandant_id, v01.mandant_bez, v01.mandant_kbez, v01.default_wrg, v01.mandant_sap_id, v01.spaet_lief_tage

   FROM dbp_view.v_mandant v01;