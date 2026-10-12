CREATE OR REPLACE VIEW DBP_MSI_VIEW_NFMD.MV_TAG AS
SELECT  
  dat, 
  wtag_id
FROM dbp_view.v_tag  
   ;