CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_REF_WH_INTERFACE_1(	
         client_id	
       , wh_loc_sid	
       , system_key	
       , system_desc	
       , interface_key	
       , interface_desc	
       , dat_rec_start	
       , dat_rec_end	
       , load_id	
   )	
   AS	
      SELECT	
            client_id,	
      wh_loc_sid,	
      system_key,	
      system_desc,	
      interface_key,	
      interface_desc,	
      dat_rec_start,	
      dat_rec_end,	
      load_id	
     FROM p_lew_core_ac.v_wawi_ref_wh_interface_1;