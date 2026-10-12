CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_EK_GF_1
(gf_id , gf_name, mandant_id,ek_flg )
AS
   SELECT gf_id, gf_name, mandant_id, ek_fg from dbp_view.v_gf_1 where mandant_id=1 and ek_fg = 1;