CREATE OR REPLACE VIEW DBP_VIEW.V_TUPEL_MAT_SUBSTITUTE_2 AS 
    SELECT 
        tupel_mat_substitute_id,
        mandant_id,
        kjwo_update,
        matching_id_parent,
        matching_id_substitute,
        rank_substitute

FROM DBP_DATA.TUPEL_MAT_SUBSTITUTE_2 ;