create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_L_BESTELLART(
	MANDANT_ID,
	BESTELLART_ID
) as
   SELECT
    mandant_id, 
    bestellart_id   
   FROM dbp_view.v_l_bestellart;