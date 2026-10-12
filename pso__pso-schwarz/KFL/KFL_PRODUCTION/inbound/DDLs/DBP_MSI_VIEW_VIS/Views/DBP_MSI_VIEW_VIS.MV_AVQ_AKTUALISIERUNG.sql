CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_AVQ_AKTUALISIERUNG as
   SELECT
   v01.mandant_id, v01.kjwo, v01.dat_letzte_aktualisierung
   FROM dbp_view.v_avq_aktualisierung v01;