CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_TS_AVQ_SCHWELLWERT_1 as
   SELECT
   mandant_id, avq_schwellwert, we_bestand_schwellwert
   FROM dbp_msi_view_vis.ts_avq_schwellwert_1;