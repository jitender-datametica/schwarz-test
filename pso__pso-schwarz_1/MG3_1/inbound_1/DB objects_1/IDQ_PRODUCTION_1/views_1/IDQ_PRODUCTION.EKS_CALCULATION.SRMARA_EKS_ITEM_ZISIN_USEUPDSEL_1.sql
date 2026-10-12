create or replace view IDQ_PRODUCTION.EKS_CALCULATION.SRMARA_EKS_ITEM_ZISIN_USEUPDSEL_1(
	ITEMID,
	ZISIN_USE,
	ZISIN_USENEW
) as
select distinct itemid, zISin_USE, in_use as zISIN_USENEW from EKS_CALCULATION.stmara_eks_item_1 where zisin_use is null;