CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_WUP_ZEIT_1 as
   SELECT
   dat, wup_id, mandant_id, nb_id, bonanzahl, zeit_stunde, zeit_minute, umsatz_brutto
   FROM dbp_view.v_wup_zeit_1;