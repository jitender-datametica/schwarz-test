CREATE OR REPLACE PROCEDURE idq_production_eks_calculation.workflow_stmara_eks_item_debug()
BEGIN
DECLARE name STRING(16777216);
DECLARE cnt INT64;
BEGIN
BEGIN TRANSACTION;
TRUNCATE TABLE idq_production_eks_calculation.check_views_1;

-- SELECT count(0), 'idq_production.eks_calculation.check_views_1' INTO :cnt, :name FROM IDQ_PRODUCTION.EKS_CALCULATION.CHECK_VIEWS_1;
-- INSERT into EKS_CALCULATION.CHECK_VIEWS_1 values (:name, :cnt);

SET (cnt , name )  =  (SELECT AS STRUCT COUNT(0), 'idq_production.eks_calculation.srmara_eks_item_basicprice_casesizecalcto1_upd'
FROM idq_production_eks_calculation.srmara_eks_item_basicprice_casesizecalcto1_updsel_1);


INSERT INTO idq_production_eks_calculation.check_views_1 (view_name, record_count)
(SELECT name AS view_name, cnt AS record_count);

CALL idq_production_eks_calculation.srmara_eks_item_basicprice_casesizecalcto1_upd();

-- select count(0), 'idq_production.eks_calculation.srmara_eks_item_listingoverviewmax_del' into :cnt, :name FROM IDQ_PRODUCTION.EKS_CALCULATION.srMARA_EKS_ITEM_LISTINGOVERVIEWMAX_DelSel;
-- INSERT into EKS_CALCULATION.CHECK_VIEWS_1 values (:name, :cnt);

CALL idq_production_eks_calculation.srmara_eks_item_listingoverviewmax_del();

SET (cnt , name )  =  (SELECT AS STRUCT COUNT(0), 'idq_production.eks_calculation.stmara_eks_item_listingoverviewmax_ins'
FROM idq_production_eks_calculation.stmara_eks_item_listingoverviewmax_inssel_1);
INSERT INTO idq_production_eks_calculation.check_views_1 (view_name, record_count)
(SELECT name AS view_name, cnt AS record_count);

CALL idq_production_eks_calculation.srmara_eks_item_listingoverviewmax_ins();

SET (cnt , name )  =  (SELECT AS STRUCT COUNT(0), 'idq_production.eks_calculation.srmara_eks_item_listingoverviewmax_location_upd'
FROM idq_production_eks_calculation.srmara_eks_item_listingoverviewmax_location_updsel_1);
INSERT INTO idq_production_eks_calculation.check_views_1 (view_name, record_count)
(SELECT name AS view_name, cnt AS record_count);

CALL idq_production_eks_calculation.srmara_eks_item_listingoverviewmax_location_upd();

SET (cnt , name )  =  (SELECT AS STRUCT COUNT(0), 'idq_production.eks_calculation.srmara_eks_item_ziseahasbaupd'
FROM idq_production_eks_calculation.srmara_eks_item_ziseahasbaupdsel_1);
INSERT INTO idq_production_eks_calculation.check_views_1 (view_name, record_count)
(SELECT name AS view_name, cnt AS record_count);

CALL idq_production_eks_calculation.srmara_eks_item_ziseahasbaupd();

SET (cnt , name )  =  (SELECT AS STRUCT COUNT(0), 'idq_production.eks_calculation.srmara_eks_item_ziseahasskhasba_upd'
FROM idq_production_eks_calculation.srmara_eks_item_ziseahasskhasba_updsel_1);
INSERT INTO idq_production_eks_calculation.check_views_1 (view_name, record_count)
(SELECT name AS view_name, cnt AS record_count);

CALL idq_production_eks_calculation.srmara_eks_item_ziseahasskhasba_upd();

SET (cnt , name )  =  (SELECT AS STRUCT COUNT(0), 'idq_production.eks_calculation.srmara_eks_item_zitem_ba_article_type_baupd'
FROM idq_production_eks_calculation.srmara_eks_item_zitem_ba_article_type_baupdsel_1);
INSERT INTO idq_production_eks_calculation.check_views_1 (view_name, record_count)
(SELECT name AS view_name, cnt AS record_count);

CALL idq_production_eks_calculation.srmara_eks_item_zitem_ba_article_type_baupd();

SET (cnt , name )  =  (SELECT AS STRUCT COUNT(0), 'idq_production.eks_calculation.srmara_eks_item_zitem_ba_article_type_sk_upd'
FROM idq_production_eks_calculation.srmara_eks_item_zitem_ba_article_type_sk_updsel_1);
INSERT INTO idq_production_eks_calculation.check_views_1 (view_name, record_count)
(SELECT name AS view_name, cnt AS record_count);

CALL idq_production_eks_calculation.srmara_eks_item_zitem_ba_article_type_sk_upd();

SET (cnt , name )  =  (SELECT AS STRUCT COUNT(0), 'idq_production.eks_calculation.srmara_eks_item_zitem_ba_article_type_ea_01_upd'
FROM idq_production_eks_calculation.srmara_eks_item_zitem_ba_article_type_ea_01_updsel_1);
INSERT INTO idq_production_eks_calculation.check_views_1 (view_name, record_count)
(SELECT name AS view_name, cnt AS record_count);

CALL idq_production_eks_calculation.srmara_eks_item_zitem_ba_article_type_ea_01_upd();

SET (cnt , name )  =  (SELECT AS STRUCT COUNT(0), 'idq_production.eks_calculation.srmara_eks_item_zitem_ba_article_type_ea_02_upd'
FROM idq_production_eks_calculation.srmara_eks_item_zitem_ba_article_type_ea_02_updsel_1);
INSERT INTO idq_production_eks_calculation.check_views_1 (view_name, record_count)
(SELECT name AS view_name, cnt AS record_count);

CALL idq_production_eks_calculation.srmara_eks_item_zitem_ba_article_type_ea_02_upd();

SET (cnt , name )  =  (SELECT AS STRUCT COUNT(0), 'idq_production.eks_calculation.srmara_eks_item_zlegacymatnrupd'
FROM idq_production_eks_calculation.srmara_eks_item_zlegacymatnrupdsel_1);
INSERT INTO idq_production_eks_calculation.check_views_1 (view_name, record_count)
(SELECT name AS view_name, cnt AS record_count);

CALL idq_production_eks_calculation.srmara_eks_item_zlegacymatnrupd();

SET (cnt , name )  =  (SELECT AS STRUCT COUNT(0), 'idq_production.eks_calculation.srmara_eks_item_zlegacymatklupd'
FROM idq_production_eks_calculation.srmara_eks_item_zlegacymatklupdsel_1);
INSERT INTO idq_production_eks_calculation.check_views_1 (view_name, record_count)
(SELECT name AS view_name, cnt AS record_count);

CALL idq_production_eks_calculation.srmara_eks_item_zlegacymatklupd();

SET (cnt , name )  =  (SELECT AS STRUCT COUNT(0), 'idq_production.eks_calculation.srmara_eks_item_matkl_article_type_eaupd'
FROM idq_production_eks_calculation.srmara_eks_item_matkl_article_type_eaupdsel_1);
INSERT INTO idq_production_eks_calculation.check_views_1 (view_name, record_count)
(SELECT name AS view_name, cnt AS record_count);

CALL idq_production_eks_calculation.srmara_eks_item_matkl_article_type_eaupd();

SET (cnt , name )  =  (SELECT AS STRUCT COUNT(0), 'idq_production.eks_calculation.srmara_eks_item_matkl_article_type_sk_upd'
FROM idq_production_eks_calculation.srmara_eks_item_matkl_article_type_sk_updsel_1);
INSERT INTO idq_production_eks_calculation.check_views_1 (view_name, record_count)
(SELECT name AS view_name, cnt AS record_count);

CALL idq_production_eks_calculation.srmara_eks_item_matkl_article_type_sk_upd();

SET (cnt , name )  =  (SELECT AS STRUCT COUNT(0), 'idq_production.eks_calculation.srmara_eks_item_matkl_article_type_ba_upd'
FROM idq_production_eks_calculation.srmara_eks_item_matkl_article_type_ba_updsel_1);
INSERT INTO idq_production_eks_calculation.check_views_1 (view_name, record_count)
(SELECT name AS view_name, cnt AS record_count);

CALL idq_production_eks_calculation.srmara_eks_item_matkl_article_type_ba_upd();

SET (cnt , name )  =  (SELECT AS STRUCT COUNT(0), 'idq_production.eks_calculation.srmara_eks_item_matklupd'
FROM idq_production_eks_calculation.srmara_eks_item_matklupdsel_1);
INSERT INTO idq_production_eks_calculation.check_views_1 (view_name, record_count)
(SELECT name AS view_name, cnt AS record_count);

CALL idq_production_eks_calculation.srmara_eks_item_matklupd();

SET (cnt , name )  =  (SELECT AS STRUCT COUNT(0), 'idq_production.eks_calculation.srmara_eks_item_znegotiatingcountryupd'
FROM idq_production_eks_calculation.srmara_eks_item_znegotiatingcountryupdsel_1);
INSERT INTO idq_production_eks_calculation.check_views_1 (view_name, record_count)
(SELECT name AS view_name, cnt AS record_count);

CALL idq_production_eks_calculation.srmara_eks_item_znegotiatingcountryupd();


CALL idq_production_eks_calculation.srmara_eks_item_zlegacymeins_upd();


CALL idq_production_eks_calculation.srmara_eks_item_meins_upd();


CALL idq_production_eks_calculation.srmara_eks_item_meins_rollupfromea_upd();


CALL idq_production_eks_calculation.srmara_eks_item_buyerid_firstname_lastname_upd();

SET (cnt , name )  =  (SELECT AS STRUCT COUNT(0), 'idq_production.eks_calculation.srmara_eks_item_znegotiatingcountry_skrollup_upd'
FROM idq_production_eks_calculation.srmara_eks_item_znegotiatingcountry_skrollup_updsel_1);
INSERT INTO idq_production_eks_calculation.check_views_1 (view_name, record_count)
(SELECT name AS view_name, cnt AS record_count);

CALL idq_production_eks_calculation.srmara_eks_item_znegotiatingcountry_skrollup_upd();


CALL idq_production_eks_calculation.srmara_eks_item_buyerid_firstname_lastname_skrollup_upd();

SET (cnt , name )  =  (SELECT AS STRUCT COUNT(0), 'idq_production.eks_calculation.srmara_eks_item_znegotiatingcountry_barollupsk_upd'
FROM idq_production_eks_calculation.srmara_eks_item_znegotiatingcountry_barollupsk_updsel_1);
INSERT INTO idq_production_eks_calculation.check_views_1 (view_name, record_count)
(SELECT name AS view_name, cnt AS record_count);

CALL idq_production_eks_calculation.srmara_eks_item_znegotiatingcountry_barollupsk_upd();


CALL idq_production_eks_calculation.srmara_eks_item_buyerid_firstname_lastname_barollupsk_upd();

SET (cnt , name )  =  (SELECT AS STRUCT COUNT(0), 'idq_production.eks_calculation.srmara_eks_item_znegotiatingcountry_barollupmk_upd'
FROM idq_production_eks_calculation.srmara_eks_item_znegotiatingcountry_barollupmk_updsel_1);
INSERT INTO idq_production_eks_calculation.check_views_1 (view_name, record_count)
(SELECT name AS view_name, cnt AS record_count);

CALL idq_production_eks_calculation.srmara_eks_item_znegotiatingcountry_barollupmk_upd();


CALL idq_production_eks_calculation.srmara_eks_item_buyerid_firstname_lastname_barollupmk_upd();


CALL idq_production_eks_calculation.srmara_eks_item_buyershortsign_upd();

SET (cnt , name )  =  (SELECT AS STRUCT COUNT(0), 'idq_production.eks_calculation.srmara_eks_item_begru_upd'
FROM idq_production_eks_calculation.srmara_eks_item_begru_updsel_1);
INSERT INTO idq_production_eks_calculation.check_views_1 (view_name, record_count)
(SELECT name AS view_name, cnt AS record_count);

CALL idq_production_eks_calculation.srmara_eks_item_begru_upd();

SET (cnt , name )  =  (SELECT AS STRUCT COUNT(0), 'idq_production.eks_calculation.srmara_eks_item_zarticletypeupd'
FROM idq_production_eks_calculation.srmara_eks_item_zarticletypeupdsel_1);
INSERT INTO idq_production_eks_calculation.check_views_1 (view_name, record_count)
(SELECT name AS view_name, cnt AS record_count);

CALL idq_production_eks_calculation.srmara_eks_item_zarticletypeupd();

SET (cnt , name )  =  (SELECT AS STRUCT COUNT(0), 'idq_production.eks_calculation.srmara_eks_item_listingoverviewmax_zitem_ba_upd'
FROM idq_production_eks_calculation.srmara_eks_item_listingoverviewmax_zitem_ba_updsel_1);
INSERT INTO idq_production_eks_calculation.check_views_1 (view_name, record_count)
(SELECT name AS view_name, cnt AS record_count);

CALL idq_production_eks_calculation.srmara_eks_item_listingoverviewmax_zitem_ba_upd();

SET (cnt , name )  =  (SELECT AS STRUCT COUNT(0), 'idq_production.eks_calculation.srmara_eks_item_listingoverviewmax_zactive_ea_upd'
FROM idq_production_eks_calculation.srmara_eks_item_listingoverviewmax_zactive_ea_updsel_1);
INSERT INTO idq_production_eks_calculation.check_views_1 (view_name, record_count)
(SELECT name AS view_name, cnt AS record_count);

CALL idq_production_eks_calculation.srmara_eks_item_listingoverviewmax_zactive_ea_upd();

SET (cnt , name )  =  (SELECT AS STRUCT COUNT(0), 'idq_production.eks_calculation.srmara_eks_item_listingoverviewmax_zactive_sk_upd'
FROM idq_production_eks_calculation.srmara_eks_item_listingoverviewmax_zactive_sk_updsel_1);
INSERT INTO idq_production_eks_calculation.check_views_1 (view_name, record_count)
(SELECT name AS view_name, cnt AS record_count);

CALL idq_production_eks_calculation.srmara_eks_item_listingoverviewmax_zactive_sk_upd();

-- select count(0), 'idq_production.eks_calculation.srmara_eks_item_listingoverviewmax_zactive_del' into :cnt, :name FROM IDQ_PRODUCTION.EKS_CALCULATION.srMARA_EKS_ITEM_LISTINGOVERVIEWMAX_zActive_DelSel;
-- INSERT into EKS_CALCULATION.CHECK_VIEWS_1 values (:name, :cnt);

CALL idq_production_eks_calculation.srmara_eks_item_listingoverviewmax_zactive_del();

-- select count(0), 'idq_production.eks_calculation.srmara_eks_item_xteks_basicinfo_reccountryall_del' into :cnt, :name FROM IDQ_PRODUCTION.EKS_CALCULATION.SRMARA_EKS_ITEM_XTEKS_BASICINFO_RECCOUNTRYALL_DELSel;
-- INSERT into EKS_CALCULATION.CHECK_VIEWS_1 values (:name, :cnt);

CALL idq_production_eks_calculation.srmara_eks_item_xteks_basicinfo_reccountryall_del();

-- select count(0), 'idq_production.eks_calculation.srmara_eks_item_xteks_basicinfo_reccountryall_ins' into :cnt, :name FROM IDQ_PRODUCTION.EKS_CALCULATION.SRMARA_EKS_ITEM_XTEKS_BASICINFO_RECCOUNTRYALL_INSSel_1;
-- INSERT into EKS_CALCULATION.CHECK_VIEWS_1 values (:name, :cnt);

CALL idq_production_eks_calculation.srmara_eks_item_xteks_basicinfo_reccountryall_ins();

SET (cnt , name )  =  (SELECT AS STRUCT COUNT(0), 'idq_production.eks_calculation.srmara_eks_item_zisvalidbitflagupdsel_1'
FROM idq_production_eks_calculation.srmara_eks_item_zisvalidbitflagupdsel_1);
INSERT INTO idq_production_eks_calculation.check_views_1 (view_name, record_count)
(SELECT name AS view_name, cnt AS record_count);

CALL idq_production_eks_calculation.srmara_eks_item_zisvalidbitflagupdsel_1();

SET (cnt , name )  =  (SELECT AS STRUCT COUNT(0), 'idq_production.eks_calculation.srmara_eks_item_zisin_useupd'
FROM idq_production_eks_calculation.srmara_eks_item_zisin_useupdsel_1);
INSERT INTO idq_production_eks_calculation.check_views_1 (view_name, record_count)
(SELECT name AS view_name, cnt AS record_count);

CALL idq_production_eks_calculation.srmara_eks_item_zisin_useupd();

SET (cnt , name )  =  (SELECT AS STRUCT COUNT(0), 'idq_production.eks_calculation.srmara_eks_item_zisfoodupd'
FROM idq_production_eks_calculation.srmara_eks_item_zisfoodupdsel_1);
INSERT INTO idq_production_eks_calculation.check_views_1 (view_name, record_count)
(SELECT name AS view_name, cnt AS record_count);

CALL idq_production_eks_calculation.srmara_eks_item_zisfoodupd();

SET (cnt , name )  =  (SELECT AS STRUCT COUNT(0), 'idq_production.eks_calculation.srmara_eks_item_ziseahasskupd'
FROM idq_production_eks_calculation.srmara_eks_item_ziseahasskupdsel_1);
INSERT INTO idq_production_eks_calculation.check_views_1 (view_name, record_count)
(SELECT name AS view_name, cnt AS record_count);

CALL idq_production_eks_calculation.srmara_eks_item_ziseahasskupd();

SET (cnt , name )  =  (SELECT AS STRUCT COUNT(0), 'idq_production.eks_calculation.srmara_eks_item_zisskhasbaupd'
FROM idq_production_eks_calculation.srmara_eks_item_zisskhasbaupdsel_1);
INSERT INTO idq_production_eks_calculation.check_views_1 (view_name, record_count)
(SELECT name AS view_name, cnt AS record_count);

CALL idq_production_eks_calculation.srmara_eks_item_zisskhasbaupd();

SET (cnt , name )  =  (SELECT AS STRUCT COUNT(0), 'idq_production.eks_calculation.srmara_eks_item_zisvalidconstructupd'
FROM idq_production_eks_calculation.srmara_eks_item_zisvalidconstructupdsel_1);
INSERT INTO idq_production_eks_calculation.check_views_1 (view_name, record_count)
(SELECT name AS view_name, cnt AS record_count);

CALL idq_production_eks_calculation.srmara_eks_item_zisvalidconstructupd();

SET (cnt , name )  =  (SELECT AS STRUCT COUNT(0), 'idq_production.eks_calculation.srmara_eks_item_zhasvalidmaxlu_upd'
FROM idq_production_eks_calculation.srmara_eks_item_zhasvalidmaxlu_updsel_1);
INSERT INTO idq_production_eks_calculation.check_views_1 (view_name, record_count)
(SELECT name AS view_name, cnt AS record_count);

CALL idq_production_eks_calculation.srmara_eks_item_zhasvalidmaxlu_upd();

SET (cnt , name )  =  (SELECT AS STRUCT COUNT(0), 'idq_production.eks_calculation.srmara_eks_item_zhasvalidtimelinelu_upd'
FROM idq_production_eks_calculation.srmara_eks_item_zhasvalidtimelinelu_updsel_1);
INSERT INTO idq_production_eks_calculation.check_views_1 (view_name, record_count)
(SELECT name AS view_name, cnt AS record_count);

CALL idq_production_eks_calculation.srmara_eks_item_zhasvalidtimelinelu_upd();

SET (cnt , name )  =  (SELECT AS STRUCT COUNT(0), 'idq_production.eks_calculation.srmara_eks_item_zhasvalidcontractdate_zhasvalidadsflg_ea_upd'
FROM idq_production_eks_calculation.srmara_eks_item_zhasvalidcontractdate_zhasvalidadsflg_ea_updsel_1);
INSERT INTO idq_production_eks_calculation.check_views_1 (view_name, record_count)
(SELECT name AS view_name, cnt AS record_count);

CALL idq_production_eks_calculation.srmara_eks_item_zhasvalidcontractdate_zhasvalidadsflg_ea_upd();

SET (cnt , name )  =  (SELECT AS STRUCT COUNT(0), 'idq_production.eks_calculation.srmara_eks_item_zhasvalidcontractdate_zhasvalidadsflg_sk_upd'
FROM idq_production_eks_calculation.srmara_eks_item_zhasvalidcontractdate_zhasvalidadsflg_sk_updsel_1);
INSERT INTO idq_production_eks_calculation.check_views_1 (view_name, record_count)
(SELECT name AS view_name, cnt AS record_count);

CALL idq_production_eks_calculation.srmara_eks_item_zhasvalidcontractdate_zhasvalidadsflg_sk_upd();

SET (cnt , name )  =  (SELECT AS STRUCT COUNT(0), 'idq_production.eks_calculation.srmara_eks_item_ziscurrentcontractupd'
FROM idq_production_eks_calculation.srmara_eks_item_ziscurrentcontractupdsel_1);
INSERT INTO idq_production_eks_calculation.check_views_1 (view_name, record_count)
(SELECT name AS view_name, cnt AS record_count);

CALL idq_production_eks_calculation.srmara_eks_item_ziscurrentcontractupd();

SET (cnt , name )  =  (SELECT AS STRUCT COUNT(0), 'idq_production.eks_calculation.srmara_eks_item_ziscurrentcontractfromsk_upd'
FROM idq_production_eks_calculation.srmara_eks_item_ziscurrentcontractfromsk_updsel_1);
INSERT INTO idq_production_eks_calculation.check_views_1 (view_name, record_count)
(SELECT name AS view_name, cnt AS record_count);

CALL idq_production_eks_calculation.srmara_eks_item_ziscurrentcontractfromsk_upd();

SET (cnt , name )  =  (SELECT AS STRUCT COUNT(0), 'idq_production.eks_calculation.srmara_eks_item_xteks_basicinfo_reccountry_zisvalidcontract_ea_upd'
FROM idq_production_eks_calculation.srmara_eks_item_xteks_basicinfo_reccountry_zisvalidcontract_ea_updsel_1);
INSERT INTO idq_production_eks_calculation.check_views_1 (view_name, record_count)
(SELECT name AS view_name, cnt AS record_count);

CALL idq_production_eks_calculation.srmara_eks_item_xteks_basicinfo_reccountry_zisvalidcontract_ea_upd();

SET (cnt , name )  =  (SELECT AS STRUCT COUNT(0), 'idq_production.eks_calculation.srmara_eks_item_xteks_basicinfo_reccountry_zisvalidcontract_sk_upd'
FROM idq_production_eks_calculation.srmara_eks_item_xteks_basicinfo_reccountry_zisvalidcontract_sk_updsel_1);
INSERT INTO idq_production_eks_calculation.check_views_1 (view_name, record_count)
(SELECT name AS view_name, cnt AS record_count);

CALL idq_production_eks_calculation.srmara_eks_item_xteks_basicinfo_reccountry_zisvalidcontract_sk_upd();

SET (cnt , name )  =  (SELECT AS STRUCT COUNT(0), 'idq_production.eks_calculation.srmara_eks_item_xteks_basicinfo_reccountry_removeduplicateea_upd'
FROM idq_production_eks_calculation.srmara_eks_item_xteks_basicinfo_reccountry_removeduplicateea_updsel_1);
INSERT INTO idq_production_eks_calculation.check_views_1 (view_name, record_count)
(SELECT name AS view_name, cnt AS record_count);

CALL idq_production_eks_calculation.srmara_eks_item_xteks_basicinfo_reccountry_removeduplicateea_upd();

SET (cnt , name )  =  (SELECT AS STRUCT COUNT(0), 'idq_production.eks_calculation.srmara_eks_item_xteks_basicinfo_reccountry_removeduplicatesk_upd'
FROM idq_production_eks_calculation.srmara_eks_item_xteks_basicinfo_reccountry_removeduplicatesk_updsel_1);
INSERT INTO idq_production_eks_calculation.check_views_1 (view_name, record_count)
(SELECT name AS view_name, cnt AS record_count);

CALL idq_production_eks_calculation.srmara_eks_item_xteks_basicinfo_reccountry_removeduplicatesk_upd();

SET (cnt , name )  =  (SELECT AS STRUCT COUNT(0), 'idq_production.eks_calculation.srmara_eks_item_xteks_basicinfo_reccountry_zisvalidcontract_resetzisfoodzisvalidconstruct_upd'
FROM idq_production_eks_calculation.srmara_eks_item_xteks_basicinfo_reccountry_zisvalidcontract_resetzisfoodzisvalidconstruct_updsel_1);
INSERT INTO idq_production_eks_calculation.check_views_1 (view_name, record_count)
(SELECT name AS view_name, cnt AS record_count);

CALL idq_production_eks_calculation.srmara_eks_item_xteks_basicinfo_reccountry_zisvalidcontract_resetzisfoodzisvalidconstruct_upd();


CALL idq_production_eks_calculation.srmara_eks_item_zz_quant_pack_cont_article_type_eaupd();


CALL idq_production_eks_calculation.srmara_eks_item_zz_pack_cont_uom_article_type_ea_upd();


CALL idq_production_eks_calculation.srmara_eks_zzz_pack_cont_uom_fromxtt006upd();


CALL idq_production_eks_calculation.srmara_eks_item_zz_pack_type_article_type_eaupd();


CALL idq_production_eks_calculation.srmara_eks_zzz_pack_type_fromxtzlax008_cust4upd();


CALL idq_production_eks_calculation.srmara_eks_item_wawirelevance_zrelevantmdm_upd();

-- select count(0), 'idq_production.eks_calculation.srmara_eks_item_wawirelevance_zrelevantmdm_upd' into :cnt, :name FROM IDQ_PRODUCTION.EKS_CALCULATION.STMARA_EKS_ITEM_1 where zRelevantMDM = 1;
-- INSERT into EKS_CALCULATION.CHECK_VIEWS_1 values (:name, :cnt);
SET (cnt , name )  =  (SELECT AS STRUCT COUNT(0), 'idq_production.eks_calculation.srmara_eks_item_wawirelevance_ziscurrentcontract_upd'
FROM idq_production_eks_calculation.srmara_eks_item_wawirelevance_ziscurrentcontract_updsel_1);
INSERT INTO idq_production_eks_calculation.check_views_1 (view_name, record_count)
(SELECT name AS view_name, cnt AS record_count);

CALL idq_production_eks_calculation.srmara_eks_item_wawirelevance_ziscurrentcontract_upd();

SET (cnt , name )  =  (SELECT AS STRUCT COUNT(0), 'idq_production.eks_calculation.srmara_eks_item_wawirelevance_ziscurrentcontractfromsk_upd'
FROM idq_production_eks_calculation.srmara_eks_item_wawirelevance_ziscurrentcontractfromsk_updsel_1);
INSERT INTO idq_production_eks_calculation.check_views_1 (view_name, record_count)
(SELECT name AS view_name, cnt AS record_count);

CALL idq_production_eks_calculation.srmara_eks_item_wawirelevance_ziscurrentcontractfromsk_upd();

SET (cnt , name )  =  (SELECT AS STRUCT COUNT(0), 'idq_production.eks_calculation.srmara_eks_item_wawirelevancy_listingoverviewmax_ins'
FROM idq_production_eks_calculation.srmara_eks_item_wawirelevancy_listingoverviewmax_inssel_1);
INSERT INTO idq_production_eks_calculation.check_views_1 (view_name, record_count)
(SELECT name AS view_name, cnt AS record_count);

CALL idq_production_eks_calculation.srmara_eks_item_wawirelevancy_listingoverviewmax_ins();

SET (cnt , name )  =  (SELECT AS STRUCT COUNT(0), 'idq_production.eks_calculation.srmara_eks_item_wawirelevancy_listingoverviewmax_upd'
FROM idq_production_eks_calculation.srmara_eks_item_wawirelevancy_listingoverviewmax_updsel_1);
INSERT INTO idq_production_eks_calculation.check_views_1 (view_name, record_count)
(SELECT name AS view_name, cnt AS record_count);

CALL idq_production_eks_calculation.srmara_eks_item_wawirelevancy_listingoverviewmax_upd();

SET (cnt , name )  =  (SELECT AS STRUCT COUNT(0), 'idq_production.eks_calculation.srmara_eks_item_wawirelevancy_xteks_basicinfo_reccountry_ins'
FROM idq_production_eks_calculation.srmara_eks_item_wawirelevancy_xteks_basicinfo_reccountry_inssel_1);
INSERT INTO idq_production_eks_calculation.check_views_1 (view_name, record_count)
(SELECT name AS view_name, cnt AS record_count);

CALL idq_production_eks_calculation.srmara_eks_item_wawirelevancy_xteks_basicinfo_reccountry_ins();

SET (cnt , name )  =  (SELECT AS STRUCT COUNT(0), 'idq_production.eks_calculation.srmara_eks_item_xteks_basicinfo_reccountry_removeduplicateea_afterwawirel_upd'
FROM idq_production_eks_calculation.srmara_eks_item_xteks_basicinfo_reccountry_removeduplicateea_afterwawirel_updsel_1);
INSERT INTO idq_production_eks_calculation.check_views_1 (view_name, record_count)
(SELECT name AS view_name, cnt AS record_count);

CALL idq_production_eks_calculation.srmara_eks_item_xteks_basicinfo_reccountry_removeduplicateea_afterwawirel_upd();

SET (cnt , name )  =  (SELECT AS STRUCT COUNT(0), 'idq_production.eks_calculation.srmara_eks_item_xteks_basicinfo_reccountry_removeduplicatesk_afterwawirel_upd'
FROM idq_production_eks_calculation.srmara_eks_item_xteks_basicinfo_reccountry_removeduplicatesk_afterwawirel_updsel_1);
INSERT INTO idq_production_eks_calculation.check_views_1 (view_name, record_count)
(SELECT name AS view_name, cnt AS record_count);

CALL idq_production_eks_calculation.srmara_eks_item_xteks_basicinfo_reccountry_removeduplicatesk_afterwawirel_upd();

-- select count(0), 'idq_production.eks_calculation.srmara_eks_item_xteks_basicinfo_union_del' into :cnt, :name FROM IDQ_PRODUCTION.EKS_CALCULATION.SRMARA_EKS_ITEM_XTEKS_BASICINFO_UNION_DELSel;
-- INSERT into EKS_CALCULATION.CHECK_VIEWS_1 values (:name, :cnt);

CALL idq_production_eks_calculation.srmara_eks_item_xteks_basicinfo_union_del();

-- select count(0), 'idq_production.eks_calculation.srmara_eks_item_xteks_basicinfo_union_ins' into :cnt, :name FROM IDQ_PRODUCTION.EKS_CALCULATION.SRMARA_EKS_ITEM_XTEKS_BASICINFO_UNION_INSSel_1;
-- INSERT into EKS_CALCULATION.CHECK_VIEWS_1 values (:name, :cnt);

CALL idq_production_eks_calculation.srmara_eks_item_xteks_basicinfo_union_ins();

SET (cnt , name )  =  (SELECT AS STRUCT COUNT(0), 'idq_production.eks_calculation.srmara_eks_item_zforcerelevant_upd'
FROM idq_production_eks_calculation.srmara_eks_item_zforcerelevant_updsel_1);
INSERT INTO idq_production_eks_calculation.check_views_1 (view_name, record_count)
(SELECT name AS view_name, cnt AS record_count);

CALL idq_production_eks_calculation.srmara_eks_item_zforcerelevant_upd();

SET (cnt , name )  =  (SELECT AS STRUCT COUNT(0), 'idq_production.eks_calculation.srmara_eks_item_zforcenotrelevant_upd'
FROM idq_production_eks_calculation.srmara_eks_item_zforcenotrelevant_updsel_1);
INSERT INTO idq_production_eks_calculation.check_views_1 (view_name, record_count)
(SELECT name AS view_name, cnt AS record_count);

CALL idq_production_eks_calculation.srmara_eks_item_zforcenotrelevant_upd();

SET (cnt , name )  =  (SELECT AS STRUCT COUNT(0), 'idq_production.eks_calculation.srmara_eks_item_zforcenotrelevant_rolluptosk_upd'
FROM idq_production_eks_calculation.srmara_eks_item_zforcenotrelevant_rolluptosk_updsel_1);
INSERT INTO idq_production_eks_calculation.check_views_1 (view_name, record_count)
(SELECT name AS view_name, cnt AS record_count);

CALL idq_production_eks_calculation.srmara_eks_item_zforcenotrelevant_rolluptosk_upd();

SET (cnt , name )  =  (SELECT AS STRUCT COUNT(0), 'idq_production.eks_calculation.srmara_eks_item_ziscurrentcontract_resetduplicates_upd'
FROM idq_production_eks_calculation.srmara_eks_item_ziscurrentcontract_resetduplicates_updsel_1);
INSERT INTO idq_production_eks_calculation.check_views_1 (view_name, record_count)
(SELECT name AS view_name, cnt AS record_count);

CALL idq_production_eks_calculation.srmara_eks_item_ziscurrentcontract_resetduplicates_upd();

SET (cnt , name )  =  (SELECT AS STRUCT COUNT(0), 'idq_production.eks_calculation.srmara_eks_item_ziscurrentcontractfromsk_reset_upd'
FROM idq_production_eks_calculation.srmara_eks_item_ziscurrentcontractfromsk_reset_updsel_1);
INSERT INTO idq_production_eks_calculation.check_views_1 (view_name, record_count)
(SELECT name AS view_name, cnt AS record_count);

CALL idq_production_eks_calculation.srmara_eks_item_ziscurrentcontractfromsk_reset_upd();

SET (cnt , name )  =  (SELECT AS STRUCT COUNT(0), 'idq_production.eks_calculation.srmara_eks_item_zactive_upd'
FROM idq_production_eks_calculation.srmara_eks_item_zactive_updsel_1);
INSERT INTO idq_production_eks_calculation.check_views_1 (view_name, record_count)
(SELECT name AS view_name, cnt AS record_count);

CALL idq_production_eks_calculation.srmara_eks_item_zactive_upd();

SET (cnt , name )  =  (SELECT AS STRUCT COUNT(0), 'idq_production.eks_calculation.srmara_eks_item_zactive_zisrelevantbyassociationeaba_upd'
FROM idq_production_eks_calculation.srmara_eks_item_zactive_zisrelevantbyassociationeaba_updsel_1);
INSERT INTO idq_production_eks_calculation.check_views_1 (view_name, record_count)
(SELECT name AS view_name, cnt AS record_count);

CALL idq_production_eks_calculation.srmara_eks_item_zactive_zisrelevantbyassociationeaba_upd();

SET (cnt , name )  =  (SELECT AS STRUCT COUNT(0), 'idq_production.eks_calculation.srmara_eks_item_zactive_zisrelevantbyassociationskba_upd'
FROM idq_production_eks_calculation.srmara_eks_item_zactive_zisrelevantbyassociationskba_updsel_1);
INSERT INTO idq_production_eks_calculation.check_views_1 (view_name, record_count)
(SELECT name AS view_name, cnt AS record_count);

CALL idq_production_eks_calculation.srmara_eks_item_zactive_zisrelevantbyassociationskba_upd();

SET (cnt , name )  =  (SELECT AS STRUCT COUNT(0), 'idq_production.eks_calculation.srmara_eks_item_zactive_zisrelevantbyassociationeaskba_upd'
FROM idq_production_eks_calculation.srmara_eks_item_zactive_zisrelevantbyassociationeaskba_updsel_1);
INSERT INTO idq_production_eks_calculation.check_views_1 (view_name, record_count)
(SELECT name AS view_name, cnt AS record_count);

CALL idq_production_eks_calculation.srmara_eks_item_zactive_zisrelevantbyassociationeaskba_upd();


CALL idq_production_eks_calculation.srmara_eks_item_zz_pack_content_upd();

SET (cnt , name )  =  (SELECT AS STRUCT COUNT(0), 'idq_production.eks_calculation.srmara_eks_item_constructskfromea_ins'
FROM idq_production_eks_calculation.srmara_eks_item_constructskfromea_inssel_1);
INSERT INTO idq_production_eks_calculation.check_views_1 (view_name, record_count)
(SELECT name AS view_name, cnt AS record_count);

CALL idq_production_eks_calculation.srmara_eks_item_constructskfromea_ins();

SET (cnt , name )  =  (SELECT AS STRUCT COUNT(0), 'idq_production.eks_calculation.srmara_eks_item_constructbafromea_ins'
FROM idq_production_eks_calculation.srmara_eks_item_constructbafromea_inssel_1);
INSERT INTO idq_production_eks_calculation.check_views_1 (view_name, record_count)
(SELECT name AS view_name, cnt AS record_count);

CALL idq_production_eks_calculation.srmara_eks_item_constructbafromea_ins();

SET (cnt , name )  =  (SELECT AS STRUCT COUNT(0), 'idq_production.eks_calculation.srmara_eks_item_zitem_ba_constructedbaforea_upd'
FROM idq_production_eks_calculation.srmara_eks_item_zitem_ba_constructedbaforea_updsel_1);
INSERT INTO idq_production_eks_calculation.check_views_1 (view_name, record_count)
(SELECT name AS view_name, cnt AS record_count);

CALL idq_production_eks_calculation.srmara_eks_item_zitem_ba_constructedbaforea_upd();

SET (cnt , name )  =  (SELECT AS STRUCT COUNT(0), 'idq_production.eks_calculation.srmara_eks_item_articlefamily_ea_upd'
FROM idq_production_eks_calculation.srmara_eks_item_articlefamily_ea_updsel_1);
INSERT INTO idq_production_eks_calculation.check_views_1 (view_name, record_count)
(SELECT name AS view_name, cnt AS record_count);

CALL idq_production_eks_calculation.srmara_eks_item_articlefamily_ea_upd();

SET (cnt , name )  =  (SELECT AS STRUCT COUNT(0), 'idq_production.eks_calculation.srmara_eks_item_articlefamily_bask_upd'
FROM idq_production_eks_calculation.srmara_eks_item_articlefamily_bask_updsel_1);
INSERT INTO idq_production_eks_calculation.check_views_1 (view_name, record_count)
(SELECT name AS view_name, cnt AS record_count);

CALL idq_production_eks_calculation.srmara_eks_item_articlefamily_bask_upd();


CALL idq_production_eks_calculation.srmara_eks_item_xteks_basicinfo_reccountry_novalidcontract_del();

-- select count(0), 'idq_production.eks_calculation.srmara_eks_item_relevancychecksdetail_del' into :cnt, :name FROM IDQ_PRODUCTION.EKS_CALCULATION.SRMARA_EKS_ITEM_RELEVANCYCHECKSDETAIL_DELSel;
-- INSERT into EKS_CALCULATION.CHECK_VIEWS_1 values (:name, :cnt);

CALL idq_production_eks_calculation.srmara_eks_item_relevancychecksdetail_del();

-- select count(0), 'idq_production.eks_calculation.srmara_eks_item_relevancychecksdetail_ins' into :cnt, :name FROM IDQ_PRODUCTION.EKS_CALCULATION.SRMARA_EKS_ITEM_RELEVANCYCHECKSDETAIL_INSSel_1;
-- INSERT into EKS_CALCULATION.CHECK_VIEWS_1 values (:name, :cnt);

CALL idq_production_eks_calculation.srmara_eks_item_relevancychecksdetail_ins();

SET (cnt , name )  =  (SELECT AS STRUCT COUNT(0), 'idq_production.eks_calculation.srmara_eks_item_relevancychecksdetail_zhidecontract_upd'
FROM idq_production_eks_calculation.srmara_eks_item_relevancychecksdetail_zhidecontract_updsel_1);
INSERT INTO idq_production_eks_calculation.check_views_1 (view_name, record_count)
(SELECT name AS view_name, cnt AS record_count);

CALL idq_production_eks_calculation.srmara_eks_item_relevancychecksdetail_zhidecontract_upd();

SET (cnt , name )  =  (SELECT AS STRUCT COUNT(0), 'idq_production.eks_calculation.srmara_eks_item_relevancychecksdetail_zhideskflag_upd'
FROM idq_production_eks_calculation.srmara_eks_item_relevancychecksdetail_zhideskflag_updsel_1);
INSERT INTO idq_production_eks_calculation.check_views_1 (view_name, record_count)
(SELECT name AS view_name, cnt AS record_count);

CALL idq_production_eks_calculation.srmara_eks_item_relevancychecksdetail_zhideskflag_upd();

SET (cnt , name )  =  (SELECT AS STRUCT COUNT(0), 'idq_production.eks_calculation.srmara_eks_item_relevancychecksdetail_zhiderow_upd'
FROM idq_production_eks_calculation.srmara_eks_item_relevancychecksdetail_zhiderow_updsel_1);
INSERT INTO idq_production_eks_calculation.check_views_1 (view_name, record_count)
(SELECT name AS view_name, cnt AS record_count);

CALL idq_production_eks_calculation.srmara_eks_item_relevancychecksdetail_zhiderow_upd();

SET (cnt , name )  =  (SELECT AS STRUCT COUNT(0), 'idq_production.eks_calculation.srmara_eks_item_relevancychecksdetail_zhiderowduplicates_upd'
FROM idq_production_eks_calculation.srmara_eks_item_relevancychecksdetail_zhiderowduplicates_updsel_1);
INSERT INTO idq_production_eks_calculation.check_views_1 (view_name, record_count)
(SELECT name AS view_name, cnt AS record_count);

CALL idq_production_eks_calculation.srmara_eks_item_relevancychecksdetail_zhiderowduplicates_upd();

--New 15.02 by Loeh
-- select count(0), 'idq_production.eks_calculation.srwrf_matgrp_sku_eks_item_constructbaskfrommara_ins' into :cnt, :name FROM IDQ_PRODUCTION.EKS_CALCULATION.srWRF_MATGRP_SKU_EKS_ITEM_ConstructBASKfromMARA_InsSel_1;
-- INSERT into EKS_CALCULATION.CHECK_VIEWS_1 values (:name, :cnt);

CALL idq_production_eks_calculation.srwrf_matgrp_sku_eks_item_constructbaskfrommara_ins();

SET (cnt , name )  =  (SELECT AS STRUCT COUNT(0), 'idq_production.eks_calculation.srwrf_matgrp_sku_eks_item_zlegacynode_ea_upd'
FROM idq_production_eks_calculation.srwrf_matgrp_sku_eks_item_zlegacynode_ea_updsel_1);
INSERT INTO idq_production_eks_calculation.check_views_1 (view_name, record_count)
(SELECT name AS view_name, cnt AS record_count);

CALL idq_production_eks_calculation.srwrf_matgrp_sku_eks_item_zlegacynode_ea_upd();

SET (cnt , name )  =  (SELECT AS STRUCT COUNT(0), 'idq_production.eks_calculation.srwrf_matgrp_sku_eks_item_zlegacynode_bask_upd'
FROM idq_production_eks_calculation.srwrf_matgrp_sku_eks_item_zlegacynode_bask_updsel_1);
INSERT INTO idq_production_eks_calculation.check_views_1 (view_name, record_count)
(SELECT name AS view_name, cnt AS record_count);

CALL idq_production_eks_calculation.srwrf_matgrp_sku_eks_item_zlegacynode_bask_upd();

SET (cnt , name )  =  (SELECT AS STRUCT COUNT(0), 'idq_production.eks_calculation.srwrf_matgrp_sku_eks_item_zlegacynode_constructed_upd'
FROM idq_production_eks_calculation.srwrf_matgrp_sku_eks_item_zlegacynode_constructed_updsel_1);
INSERT INTO idq_production_eks_calculation.check_views_1 (view_name, record_count)
(SELECT name AS view_name, cnt AS record_count);

CALL idq_production_eks_calculation.srwrf_matgrp_sku_eks_item_zlegacynode_constructed_upd();

SET (cnt , name )  =  (SELECT AS STRUCT COUNT(0), 'idq_production.eks_calculation.srwrf_matgrp_sku_eks_item_node_upd'
FROM idq_production_eks_calculation.srwrf_matgrp_sku_eks_item_node_updsel_1);
INSERT INTO idq_production_eks_calculation.check_views_1 (view_name, record_count)
(SELECT name AS view_name, cnt AS record_count);

CALL idq_production_eks_calculation.srwrf_matgrp_sku_eks_item_node_upd();

--
COMMIT TRANSACTION;
-- res := (EXECUTE IMMEDIATE 'select * from IDQ_PRODUCTION.EKS_CALCULATION.CHECK_VIEWS_1;');
-- COMMIT;
-- RETURN TABLE(res);
END;
END;
