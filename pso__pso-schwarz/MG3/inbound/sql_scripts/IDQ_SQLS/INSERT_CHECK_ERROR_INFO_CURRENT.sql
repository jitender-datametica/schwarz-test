Insert into CHECK_ERROR_INFO_CURRENT
        (scope_id
        ,test_object_id
        ,rule_id
        ,invalid_content
        ,additional_info_de
        ,additional_info_en)
values
        (:scope_id,
         :test_object_id,
         :rule_id,
         :invalid_content,
         :additional_info_de,
         :additional_info_en);
