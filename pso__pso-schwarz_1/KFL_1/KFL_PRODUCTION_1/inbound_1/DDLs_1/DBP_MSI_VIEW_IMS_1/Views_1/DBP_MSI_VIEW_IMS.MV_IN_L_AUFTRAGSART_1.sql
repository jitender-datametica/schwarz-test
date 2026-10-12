CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_IN_L_AUFTRAGSART_1 AS
-- 10.06.2013 AL init

   SELECT auftragsart_id
   FROM dbp_view.v_in_l_auftragsart_1
   GROUP BY auftragsart_id;