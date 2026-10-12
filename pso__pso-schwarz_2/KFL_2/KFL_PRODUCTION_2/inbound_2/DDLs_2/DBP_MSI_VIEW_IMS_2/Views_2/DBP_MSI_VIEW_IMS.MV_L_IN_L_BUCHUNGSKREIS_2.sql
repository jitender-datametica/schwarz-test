CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_L_IN_L_BUCHUNGSKREIS_2 AS
-- 31.05.2013 twie: Erstellung Lookup Buchungskreis

   SELECT
   v01.mandant_id,
   v01.buchungskreis_id,
   v01.kontenplan_id,
   v01.sako_fg

  FROM dbp_view.v_in_l_buchungskreis_2 v01
;