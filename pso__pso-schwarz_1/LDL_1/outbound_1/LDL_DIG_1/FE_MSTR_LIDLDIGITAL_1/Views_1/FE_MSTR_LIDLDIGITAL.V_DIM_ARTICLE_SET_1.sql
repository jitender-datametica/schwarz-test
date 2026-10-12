CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_article_set_1 AS SELECT *
FROM ldl_dig_fe_mstr_lidldigital.t_dim_article_set_1
UNION ALL
SELECT '-1' AS dm__operand0;