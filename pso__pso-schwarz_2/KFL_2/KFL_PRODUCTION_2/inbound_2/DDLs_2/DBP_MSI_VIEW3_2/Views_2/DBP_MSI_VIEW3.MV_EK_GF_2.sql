CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_EK_GF_2
(gf_id , gf_name, mandant_id,ek_flg )
AS
   SELECT gf_id, gf_name, mandant_id, ek_fg
   from dbp_view.v_gf_2
   where ek_fg = 1;