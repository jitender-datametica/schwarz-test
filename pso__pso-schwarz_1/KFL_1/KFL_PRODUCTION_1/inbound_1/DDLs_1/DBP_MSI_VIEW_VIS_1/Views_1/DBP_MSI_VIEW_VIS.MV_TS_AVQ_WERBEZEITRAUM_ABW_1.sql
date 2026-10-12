CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_TS_AVQ_WERBEZEITRAUM_ABW_1 as
   SELECT
   mandant_id,
   werbe_typ_id,
   dat_von,
   dat_bis,
   kommentar
   FROM dbp_view.v_ts_avq_werbezeitraum_abw_1;