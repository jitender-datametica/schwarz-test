CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_VF (vf_id ,vf_name,mandant_id)
AS
   SELECT vf_id, vf_name, mandant_id from dbp_view.v_vf where mandant_id=1;