CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_article_set AS SELECT *
FROM ldl_dig_fe_mstr_lidldigital.t_dim_article_set
UNION ALL
SELECT '-1' AS dm__operand0;