CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_L_VORGANGSART
    (
      mandant_id
     ,vorgangsart_id
     ,system_id
    )
    AS
       SELECT
         mandant_id,
       vorgangsart_id,
       7
       FROM dbp_view.v_l_vorgangsart
       WHERE mandant_id = 1
 ;