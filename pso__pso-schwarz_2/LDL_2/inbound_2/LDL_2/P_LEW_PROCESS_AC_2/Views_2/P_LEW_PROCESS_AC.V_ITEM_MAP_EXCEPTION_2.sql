CREATE OR REPLACE VIEW P_LEW_PROCESS_AC.V_ITEM_MAP_EXCEPTION_2
            /*
            #DescStart#
            #$Revision: 13500 $
            #SubjectAreas#: Access Layer
            #DescEnd#
            */
            (
                client_id
                , orig_item_nr
                , case_size
                , dat_valid_from
                , item_sid
                , map_client_id
                , map_orig_item_nr
                , map_case_size
                , map_dat_valid_from
                , map_item_sid
                , dwh_load_id
                , dwh_created
                , dwh_updated
            )
            AS
               SELECT
                   client_id
                ,orig_item_nr
                ,case_size
                ,dat_valid_from
                ,item_sid
                ,map_client_id
                ,map_orig_item_nr
                ,map_case_size
                ,map_dat_valid_from
                ,map_item_sid
                ,dwh_load_id
                ,dwh_created
                ,dwh_updated
              FROM p_lew_process.t_item_map_exception_2
;