CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_VF_1 (vf_id ,vf_name,mandant_id)
AS
   SELECT vf_id, vf_name, mandant_id from dbp_view.v_vf_1 where mandant_id=1;