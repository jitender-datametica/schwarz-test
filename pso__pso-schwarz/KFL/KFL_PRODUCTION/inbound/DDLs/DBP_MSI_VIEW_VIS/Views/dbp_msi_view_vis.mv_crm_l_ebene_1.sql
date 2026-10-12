CREATE OR REPLACE VIEW dbp_msi_view_vis.mv_crm_l_ebene_1
AS
-- 04.06.2020 lsvi0303: Initial AP0048480, SPEC0075325
SELECT

ebene_1_id,
MAX(number_level_1) AS number_level_1
FROM dbp_view.v_crm_l_themenbaum_lv2

GROUP BY ebene_1_id;