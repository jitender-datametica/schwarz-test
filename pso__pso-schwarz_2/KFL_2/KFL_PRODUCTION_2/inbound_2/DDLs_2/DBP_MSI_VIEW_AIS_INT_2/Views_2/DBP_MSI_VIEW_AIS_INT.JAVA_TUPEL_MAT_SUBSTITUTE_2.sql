CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.JAVA_TUPEL_MAT_SUBSTITUTE_2
(
TUPEL_MAT_SUBSTITUTE_ID,
MANDANT_ID,
KJWO_UPDATE,
MATCHING_ID_PARENT,
MATCHING_ID_SUBSTITUTE,
RANK_SUBSTITUTE
) 
AS
SELECT
 tupel_mat_substitute_id
,mandant_id
,kjwo_update
,matching_id_parent
,matching_id_substitute
,rank_substitute
FROM dbp_view.v_tupel_mat_substitute_2
WHERE rank_substitute BETWEEN 1 AND 20;