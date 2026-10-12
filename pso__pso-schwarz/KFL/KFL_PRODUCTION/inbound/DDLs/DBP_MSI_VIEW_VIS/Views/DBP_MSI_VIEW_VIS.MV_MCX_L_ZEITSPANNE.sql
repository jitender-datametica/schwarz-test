CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_MCX_L_ZEITSPANNE
AS
-- 20200624 - snik1809

SELECT 
 zeitspanne_id
 ,zeitspanne_sort_key
      
FROM dbp_data.mcx_l_zeitspanne;