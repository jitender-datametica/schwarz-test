CREATE OR REPLACE VIEW dbp_msi_view_vis.mv_crm_l_ebene_2
-- 04.06.2020 lsvi0303: Initial AP0048480, SPEC0075325
AS
SELECT

ebene_2_id,
MAX(number_level_2) AS number_level_2,
MAX(ebene_1_id) AS ebene_1_id
FROM dbp_view.v_crm_l_themenbaum_lv2

GROUP BY ebene_2_id;