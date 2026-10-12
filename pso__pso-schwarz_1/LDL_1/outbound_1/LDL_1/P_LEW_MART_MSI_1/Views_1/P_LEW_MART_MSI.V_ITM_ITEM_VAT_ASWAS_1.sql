/* #DescStart#	
      #$Revision: 6244 $, $LastChangedBy: hwieber $	
      #SubjectAreas#: Artikelstamm	
      #DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_itm_item_vat_aswas_1 AS SELECT client_id,
 item_sid AS item_id,
 dat_calendar AS dat_valid,
 vat_id,
 vat_value AS pct_vat
FROM ldl_p_lew_bil_ac.v_item_vat_1;