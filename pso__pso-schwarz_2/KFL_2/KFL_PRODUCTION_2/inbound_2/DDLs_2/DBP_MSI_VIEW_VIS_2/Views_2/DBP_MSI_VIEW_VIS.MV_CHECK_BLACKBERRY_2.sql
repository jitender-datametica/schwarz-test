CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_CHECK_BLACKBERRY_2 as
   -- STATUS_2 Prueftabelle - Land_2 pro Tag_2
   -- dient zur Steuerung der Anzeige von Umsatzberichten (Mobile)
   -- 20120229 INITIAL

   SELECT
   v01.mandant_id, v01.dat, v01.bb_fg, v01.check_fg, v01.lieferquote_real, v01.lieferquote_def, v01.datenquote_real, v01.datenquote_def, v01.umsatz_ist, v01.umsatz_vj, v01.umsatz_plan, v01.umsatz_vortag, v01.umsatz_vorwoche, v01.kunden_ist, v01.kunden_vj
   FROM dbp_msi_v_view.v_check_blackberry_2 v01;