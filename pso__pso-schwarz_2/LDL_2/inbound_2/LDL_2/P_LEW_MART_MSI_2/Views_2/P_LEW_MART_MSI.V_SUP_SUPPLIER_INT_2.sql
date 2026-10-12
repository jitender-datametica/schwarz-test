CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_SUP_SUPPLIER_INT_2 as
                  /*	
                  #DescStart#	
                  #$Revision: 6244 $, $LastChangedBy: hwieber $	
                  #SubjectAreas#: Lieferanten	
                  #DescEnd#	
                  */	
                  SELECT	
                    client_id,	
                  sup_sid AS supplier_id,	
                  sup_sid_int AS supplier_id_int,	
                  dat_rec_start,	
                  dat_rec_end,	
                  supplier_desc_int	
     FROM p_lew_core_ac.v_wawi_sup_supplier_int_2	
     WHERE Current_Date BETWEEN dat_rec_start AND dat_rec_end;