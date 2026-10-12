CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_IN_AUFTRAGSART_SPR_ZU AS
-- 10.06.2013 AL init

   SELECT
   auftragsart_id,
   auftragsart_bez
  FROM dbp_view.v_in_auftragsart_spr_zu
  WHERE spr_id=22
  QUALIFY RANK() OVER (PARTITION BY auftragsart_id ORDER BY mandant_id) =1;