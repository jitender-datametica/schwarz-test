CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_INT.MV_ART_USER_ZU
(
mandant_id
,user_id
,art_id
)
AS
   SELECT
   u_r.mandant_id,
   u_r.user_id,
   a_vhd.art_id
   FROM dbp_security.user_rolle_ek_int_zu u_r
   JOIN (
   SELECT a.mandant_id, a.art_id, a.zek_id AS zek_id, ekl.wbl_id, gf.gf_id FROM dbp_view.v_art a
   LEFT JOIN dbp_view.v_zek ekl
   ON (a.mandant_id = ekl.mandant_id AND a.zek_id = ekl.zek_id)
   LEFT JOIN dbp_view.v_wbl gf
   ON (ekl.mandant_id = gf.mandant_id AND ekl.wbl_id = gf.wbl_id))  a_vhd
   ON (u_r.mandant_id = a_vhd.mandant_id AND COALESCE(u_r.zek_id,a_vhd.zek_id) = a_vhd.zek_id AND COALESCE(u_r.wbl_id,a_vhd.wbl_id) = a_vhd.wbl_id AND COALESCE(u_r.gf_id,a_vhd.gf_id) = a_vhd.gf_id)
   WHERE u_r.rolle_id IN (1,2,3)
   UNION
   SELECT
   u_r.mandant_id,
   u_r.user_id,
   a_vat.art_id
   FROM dbp_security.user_rolle_ek_int_zu u_r
   JOIN (
   SELECT a.mandant_id, a.art_id, a.zek_vat_id AS zek_id, ekl.wbl_id, gf.gf_id FROM dbp_view.v_art a
   LEFT JOIN dbp_view.v_zek ekl
   ON (a.mandant_id = ekl.mandant_id AND a.zek_vat_id = ekl.zek_id)
   LEFT JOIN dbp_view.v_wbl gf
   ON (ekl.mandant_id = gf.mandant_id AND ekl.wbl_id = gf.wbl_id)) a_vat
   ON (u_r.mandant_id = a_vat.mandant_id AND COALESCE(u_r.zek_id,a_vat.zek_id) = a_vat.zek_id AND COALESCE(u_r.wbl_id,a_vat.wbl_id) = a_vat.wbl_id AND COALESCE(u_r.gf_id,a_vat.gf_id) = a_vat.gf_id)
   --ON (u_r.mandant_id = a_vat.mandant_id AND (u_r.zek_id = a_vat.zek_id OR u_r.wbl_id = a_vat.wbl_id OR u_r.gf_id = a_vat.gf_id))
   WHERE u_r.rolle_id IN (1,2,3)
   UNION
   --SELECT
   --	u_r.mandant_id,
   --	u_r.user_id,
   --	art.art_id
   --FROM dbp_msi_view_ek_int.mv_user_rolle_ek_int_zu u_r
   --JOIN  dbp_msi_view_ek_int.mv_art art
   --	ON (u_r.mandant_id = art.mandant_id)
   --WHERE u_r.rolle_id = 4
   SELECT
   art.mandant_id,
   'Superuser',
   art.art_id
   FROM dbp_view.v_art art;