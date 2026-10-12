CREATE OR REPLACE VIEW dbp_msi_view_vis.mv_crm_l_status_2
AS
-- 04.06.2020 lsvi0303: Initial AP0048480, SPEC0075325
SELECT

crm_status_id
FROM dbp_view.v_crm_l_status_2;