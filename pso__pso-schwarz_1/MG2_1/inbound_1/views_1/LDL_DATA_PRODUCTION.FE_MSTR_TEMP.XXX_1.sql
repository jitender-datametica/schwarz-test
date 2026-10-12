create or replace view LDL_DATA_PRODUCTION.FE_MSTR_TEMP.XXX_1(
	ITEMNO,
	LEVEL,
	ITEMNO_2,
	LEVEL_2,
	ITEMNO_3,
	LEVEL_3,
	PROD_NUM,
	PROD_SEQID
) as
select * from eval.eks_prod_hier_1 ;