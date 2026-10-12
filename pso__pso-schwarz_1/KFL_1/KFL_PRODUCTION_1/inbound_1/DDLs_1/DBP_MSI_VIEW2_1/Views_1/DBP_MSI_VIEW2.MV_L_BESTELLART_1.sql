CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_L_BESTELLART_1 as
   SELECT
   mandant_id, bestellart_id, bestellart_bez
   FROM dbp_view.v_bestellart_spr_zu_1
   WHERE mandant_id =1;