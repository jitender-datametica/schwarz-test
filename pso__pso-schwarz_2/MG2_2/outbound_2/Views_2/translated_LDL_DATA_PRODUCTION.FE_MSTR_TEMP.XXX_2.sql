CREATE OR REPLACE VIEW ldl_data_production_fe_mstr_temp.xxx_2 (itemno, level, itemno_2, level_2, itemno_3, level_3,
prod_num, prod_seqid) AS SELECT *
FROM ldl_data_production_eval.eks_prod_hier_2;