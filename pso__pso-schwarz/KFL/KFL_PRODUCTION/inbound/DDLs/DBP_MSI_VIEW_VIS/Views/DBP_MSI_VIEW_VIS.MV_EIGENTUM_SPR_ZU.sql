CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_EIGENTUM_SPR_ZU as
   -- AL 18.01.2012 Tankstelle Eigen, Fremd
   -- AL 10.05.2012  Wegen Datequalität keine Anziege in KMO (eigentumg_fg -1)
   SELECT
   CASE WHEN dat = current_date -1 THEN  1
   WHEN dat= current_date-2  THEN -1
   ELSE 0 END eigentum_fg, CASE WHEN dat = current_date -1 THEN 'Eigentum'
   WHEN dat = current_date -2 THEN ''
   ELSE 'Miete' END eigentum_bez

   FROM dbp_view.v_tag
   WHERE dat between current_date -2 and current_date;