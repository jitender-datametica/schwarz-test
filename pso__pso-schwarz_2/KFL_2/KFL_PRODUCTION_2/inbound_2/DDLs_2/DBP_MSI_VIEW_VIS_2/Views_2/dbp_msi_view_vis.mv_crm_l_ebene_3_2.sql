CREATE OR REPLACE VIEW dbp_msi_view_vis.mv_crm_l_ebene_3_2
AS
-- 04.06.2020 lsvi0303: Initial AP0048480, SPEC0075325
SELECT

ebene_3_id,
MAX(number_level_3) AS number_level_3,
MAX(ebene_2_id) AS ebene_2_id
FROM dbp_view.v_crm_l_themenbaum_lv2_2

GROUP BY ebene_3_id;