CREATE OR REPLACE PROCEDURE `dbp_macro.sp_upd_sortiment_leistung_2` (
    USER STRING
)
BEGIN
    DECLARE row_count INT64;

    SET row_count = (
        SELECT COUNT(*)
        FROM `public.input_table_ek_sort_u_2`
        WHERE user = USER
    );

    IF row_count != 0 THEN
        
        IF row_count <= 2 THEN
            
            FOR row_data IN (
                SELECT
                    matching_id,
                    art_id,
                    gtin,
                    stk_re_pflege,
                    vorschlag,
                    produktwissen_pflege,
                    lieferantenwissen_pflege,
                    listung_sst_pflege,
                    ost_basis_pflege,
                    ost_gross_pflege,
                    sued_ost_pflege,
                    sued_west_pflege,
                    west_pflege,
                    nord_pflege,
                    kjmo,
                    n_k_artikel,
                    nl_art_bez,
                    kjwo_update
                FROM `public.input_table_ek_sort_u_2`
                WHERE user = USER
                ORDER BY matching_id
            )
            DO
                CALL `dbp_macro.sp_upd_sortiment_leistung_by_row`(
                    row_data.matching_id, 
                    row_data.art_id, 
                    row_data.gtin, 
                    row_data.stk_re_pflege, 
                    row_data.vorschlag, 
                    row_data.produktwissen_pflege, 
                    row_data.lieferantenwissen_pflege, 
                    row_data.listung_sst_pflege, 
                    row_data.ost_basis_pflege, 
                    row_data.ost_gross_pflege, 
                    row_data.sued_ost_pflege, 
                    row_data.sued_west_pflege, 
                    row_data.west_pflege, 
                    row_data.nord_pflege, 
                    row_data.kjmo, 
                    row_data.n_k_artikel, 
                    row_data.nl_art_bez, 
                    row_data.kjwo_update
                );
            END FOR;

        ELSE
            CALL `dbp_macro.sp_upd_sortiment_leistung_by_batch`(USER);
        END IF;

        DELETE FROM `public.input_table_ek_sort_u_2`
        WHERE user = USER;
        
    END IF;
END;
