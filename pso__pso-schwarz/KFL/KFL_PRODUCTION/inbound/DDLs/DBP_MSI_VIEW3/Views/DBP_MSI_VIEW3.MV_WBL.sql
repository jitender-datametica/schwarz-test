CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_WBL (
ek_flg,gf_id,wbl_dat_von,wbl_id,wbl_name,mandant_id)
AS
   SELECT
  ek_fg, gf_id, wbl_dat_von, wbl_id, wbl_name, mandant_id
   from dbp_view.v_wbl;