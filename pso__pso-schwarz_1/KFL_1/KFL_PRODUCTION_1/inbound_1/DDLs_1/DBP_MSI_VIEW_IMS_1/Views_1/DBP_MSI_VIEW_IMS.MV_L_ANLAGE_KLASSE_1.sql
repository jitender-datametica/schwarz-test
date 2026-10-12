CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_L_ANLAGE_KLASSE_1 AS
-- 22.03.2013 twie: Lookup für Anlageklassen

   SELECT
   mandant_id,
   anlage_klasse_id,
   gesperrt_fg

   FROM dbp_view.v_l_anlage_klasse_1;