CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_L_BESTELLART_1
AS
   SELECT
    mandant_id, 
    bestellart_id   
   FROM dbp_view.v_l_bestellart_1;