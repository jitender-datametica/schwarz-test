CREATE OR REPLACE VIEW dbp_msi_view_ek_sort.java_tupel_mat_substitute_1
AS
SELECT
    tupel_mat_substitute_id
    ,mandant_id
    ,kjwo_update
    ,matching_id_parent
    ,matching_id_substitute
    ,rank_substitute
FROM dbp_view.v_tupel_mat_substitute_1
WHERE rank_substitute BETWEEN 1 AND 20;