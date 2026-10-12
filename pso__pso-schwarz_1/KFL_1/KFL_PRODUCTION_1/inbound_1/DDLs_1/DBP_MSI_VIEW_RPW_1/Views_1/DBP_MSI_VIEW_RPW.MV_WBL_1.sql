CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_WBL_1
 (
   wbl_id
   ,mandant_id
   ,wbl_dat_von
   ,wbl_name
   ,gf_id
   ,ek_fg
   ,system_id
 )
 AS
    SELECT
       wbl_id,
    mandant_id,
    wbl_dat_von,
    wbl_name,
    gf_id,
    ek_fg,
    7
    FROM dbp_view.v_wbl_1
    WHERE mandant_id = 1
 ;