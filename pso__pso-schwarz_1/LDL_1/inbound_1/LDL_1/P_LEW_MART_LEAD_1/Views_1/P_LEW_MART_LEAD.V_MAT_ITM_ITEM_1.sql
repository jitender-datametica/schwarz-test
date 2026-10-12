/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for p_lew_mart_lead.v_mat_itm_item_1
#----------------------------------------------------------------------------
# History:
#  1.0  16.11.2020    Bialek, Aleksander     lew_mart_msi_v_mat_msi_itm_item moved to lead with fixed AF/SIG mappings
#  1.1  18.12.2020    Bachmann, Torsten      REP3-7959, PatchNo 2693: Use orig_item_nr_int (IAN) from t_itm_orig_item_1
#  1.2  23.04.2021    Bachmann, Torsten      Revert changes for orig_item_nr_int. Use old logic again.
#  1.3  30.07.2021    Marose, Christian      Patch for incidents INC3200969/INC3326448: Removed demand_plan_active_fg, field is deprecated, updated qualify, added brand_1 case statement
#  1.4  16.08.2021    Bachmann, Torsten      REP3-8664, PatchNo 2905: Add columns brand_type_id and listing_type_id
#  1.5  25.05.2022    Bachmann, Torsten      AP0130638: ADO 320075: combine t_itm_item_1 and MSI.t_itm_item_desc_1 to reduce join
#  1.6  13.03.2023    Bachmann, Torsten      NSR3560852: use most recent description for item_1 instead of config_item_sid's description
#  1.7  03.01.2024    Rekovsky, Marvin       INC7631642: remove obsolete elwis code for small performance boost
#  1.8  03.01.2025    Yeddulapalli, Bharat   AP0097106: ADO 703883: Nettogewicht
#  1.9  27.01.2025    Bachmann, Torsten      AP0252180: ADO 723523: Add mdm_cust_need_type_cd for Attribute Bedürfniswelt
#  1.10 16.05.2025    Bachmann, Torsten      AP0269439: ADO 747012: Add mdm_cust_need_subtype_cd for Attribute Bedürfniskategorie
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW p_lew_mart_lead.V_MAT_ITM_ITEM_1 COMMENT =  'materialisierte View von t_itm_item_1'
(
   brand_1                         COMMENT ''
  ,buying_list_orderset_nr       COMMENT ''
  ,case_size                     COMMENT ''
  ,client_id                     COMMENT ''
  ,country_cd                    COMMENT ''
  ,dat_valid_from                COMMENT ''
  ,item_id                       COMMENT ''
  ,orig_item_nr                  COMMENT ''
  ,orig_item_nr_int              COMMENT ''
  ,add_docs_fg                   COMMENT ''
  ,additions                     COMMENT ''
  ,age_fg                        COMMENT ''
  ,beverage_tax                  COMMENT ''
  ,buyer_id                      COMMENT ''
  ,buyer_name                    COMMENT ''
  ,buying_list_type_id           COMMENT ''
  ,buying_list_type_desc         COMMENT ''
  ,brand_type_id                 COMMENT 'the type of brand_1 of an article (1=M, 2=EM, 3=HM)'
  ,listing_type_id               COMMENT 'the type of listing article (1=Aktions-Artikel_1, 2=Ausgelistet, 3=Neu-Einlistung, 4=Normalsortiment, 5=Saison-Artikel_1, 6=Test_1-Artikel_1)'
  ,case_dd                       COMMENT ''
  ,case_depth                    COMMENT ''
  ,case_euro                     COMMENT ''
  ,case_height                   COMMENT ''
  ,case_layer                    COMMENT ''
  ,case_plu_fg                   COMMENT ''
  ,case_volume                   COMMENT ''
  ,case_weight                   COMMENT ''
  ,case_width                    COMMENT ''
  ,commodity_cd                  COMMENT ''
  ,consumption_tax_main_id       COMMENT ''
  ,consumption_tax_sub_id        COMMENT ''
  ,cont_deposit_item_nr          COMMENT ''
  ,contract_country_cd           COMMENT ''
  ,dangerous_goods_fg            COMMENT ''
  ,dat_adv                       COMMENT ''
  ,dat_delisting                 COMMENT ''
  ,dat_listing                   COMMENT ''
  ,dat_min_shelflifetest_fg      COMMENT ''
  ,delisting_fg                  COMMENT ''
  ,delivery_temp                 COMMENT ''
  ,direct_delete_mde_fg          COMMENT ''
  ,discount_fg                   COMMENT ''
  ,dualsystem_fg                 COMMENT ''
  ,dur_shelflife_day_cust        COMMENT ''
  ,dur_shelflife_day_store       COMMENT ''
  ,dur_shelflife_day_wh          COMMENT ''
  ,food_fg                       COMMENT ''
  ,forwarding_item_nr            COMMENT ''
  ,int_subitemgroup_id           COMMENT ''
  ,item_actiongroup_id           COMMENT ''
  ,item_familygroup_id           COMMENT ''
  ,item_parts                    COMMENT ''
  ,item_parts_cd                 COMMENT ''
  ,item_plu_nr                   COMMENT ''
  ,item_short_desc_1             COMMENT ''
  ,item_short_desc_2             COMMENT ''
  ,item_short_desc_3             COMMENT ''
  ,item_sub_actiongroup_id       COMMENT ''
  ,item_text_1                   COMMENT ''
  ,item_text_2                   COMMENT ''
  ,item_text_3                   COMMENT ''
  ,item_version                  COMMENT ''
  ,lidl_buying_country_cd        COMMENT ''
  ,listing_fg                    COMMENT ''
  ,logistic_unit_cd              COMMENT ''
  ,max_receive_temp              COMMENT ''
  ,mdessp_fg                     COMMENT ''
  ,mdm_cust_need_subtype_cd      COMMENT 'Code to classify the assortment by detailed customer needs.
            CBX: CNT_CODELIST.CODE (code list "LIDL_CATEGORY_NEEDS")'
  ,mdm_cust_need_type_cd         COMMENT 'Code to classify the assortment by general customer needs.
            CBX: CNT_CODELIST.CODE (code list "LIDL_FOCUS_CATEGORY")'
  ,min_case_dd                   COMMENT ''
  ,min_case_euro                 COMMENT ''
  ,min_case_layer                COMMENT ''
  ,min_case_orderunit            COMMENT ''
  ,min_receive_temp              COMMENT ''
  ,minus_fg                      COMMENT ''
  ,net_case_weight               COMMENT ''
  ,net_piece_weight              COMMENT ''
  ,order_area_cd                 COMMENT ''
  ,package_qty                   COMMENT ''
  ,packagetype_desc              COMMENT ''
  ,packing                       COMMENT ''
  ,pct_consumption_tax           COMMENT ''
  ,pct_discount                  COMMENT ''
  ,period_id_shelflife_cust      COMMENT ''
  ,period_id_shelflife_store     COMMENT ''
  ,period_id_shelflife_wh        COMMENT ''
  ,piece_depth                   COMMENT ''
  ,piece_height                  COMMENT ''
  ,piece_volume                  COMMENT ''
  ,piece_weight                  COMMENT ''
  ,piece_width                   COMMENT ''
  ,piece_net_weight              COMMENT ''
  ,poster_fg                     COMMENT ''
  ,price_sign_fg                 COMMENT ''
  ,price_strip_fg                COMMENT ''
  ,qty_consumption_tax_add       COMMENT ''
  ,res_selltime                  COMMENT ''
  ,reusable_fg                   COMMENT ''
  ,scale_fg                      COMMENT ''
  ,season_fg                     COMMENT ''
  ,smallest_orderunit            COMMENT ''
  ,smallest_unit                 COMMENT ''
  ,status_id_hq                  COMMENT ''
  ,stock_capacity                COMMENT ''
  ,subitemgroup_id               COMMENT ''
  ,tax_refund_fg                 COMMENT ''
  ,taxation                      COMMENT ''
  ,type_cd                       COMMENT ''
  ,type_receive_temp_fg          COMMENT ''
  ,unitsize                      COMMENT ''
  ,val_consumption_tax           COMMENT ''
  ,val_deposit                   COMMENT ''
  ,vat_id                        COMMENT ''
  ,wallow_nr                     COMMENT ''
  ,weight                        COMMENT ''
  ,weight_fg                     COMMENT ''
  ,wg_fg                         COMMENT ''
  ,write_off                     COMMENT ''
  ,buyer_name_int                COMMENT ''
  ,case_size_dec                 COMMENT ''
  ,dur_shelflife_timeunits_cust  COMMENT ''
  ,dur_shelflife_timeunits_store COMMENT ''
  ,dur_shelflife_timeunits_wh    COMMENT ''
  ,factor_period_cust            COMMENT ''
  ,factor_period_store           COMMENT ''
  ,factor_period_wh              COMMENT ''
  ,factor_shelflife_cust         COMMENT ''
  ,factor_shelflife_store        COMMENT ''
  ,factor_shelflife_wh           COMMENT ''
  ,qty_min_piece_ordering        COMMENT ''
  ,item_desc_AT                  COMMENT ''
  ,item_desc_BE                  COMMENT ''
  ,item_desc_BG                  COMMENT ''
  ,item_desc_CH                  COMMENT ''
  ,item_desc_CY                  COMMENT ''
  ,item_desc_CZ                  COMMENT ''
  ,item_desc                     COMMENT ''
  ,item_desc_DK                  COMMENT ''
  ,item_desc_EE                  COMMENT ''
  ,item_desc_ES                  COMMENT ''
  ,item_desc_FI                  COMMENT ''
  ,item_desc_FR                  COMMENT ''
  ,item_desc_GB                  COMMENT ''
  ,item_desc_GR                  COMMENT ''
  ,item_desc_HR                  COMMENT ''
  ,item_desc_HU                  COMMENT ''
  ,item_desc_IE                  COMMENT ''
  ,item_desc_IT                  COMMENT ''
  ,item_desc_LT                  COMMENT ''
  ,item_desc_LV                  COMMENT ''
  ,item_desc_NI                  COMMENT ''
  ,item_desc_NL                  COMMENT ''
  ,item_desc_DE                  COMMENT ''
  ,item_desc_PL                  COMMENT ''
  ,item_desc_PT                  COMMENT ''
  ,item_desc_RO                  COMMENT ''
  ,item_desc_SE                  COMMENT ''
  ,item_desc_SI                  COMMENT ''
  ,item_desc_SK                  COMMENT ''
  ,item_desc_CS                  COMMENT ''
  ,item_desc_MT                  COMMENT ''
  ,item_desc_US                  COMMENT ''
  ,item_desc_RS                  COMMENT ''
)
AS
SELECT
   -- Added case statment in v1.3 for brand_1 to get the correct brand_1 depending on WaWi or eLWIS item_1
   CASE WHEN wawi.brand_1 IS NULL AND ibr.brand_descr IS NULL THEN '--' -- nichts vorhanden
   WHEN wawi.client_id IS NOT NULL THEN COALESCE(wawi.brand_1, '--') -- WAWI Artikel_1
   ELSE COALESCE(ibr.brand_descr, '--') -- elWIS Artikel_1
   END AS brand_1   
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.buying_list_orderset_nr ELSE CAST(-1 AS INTEGER) END AS buying_list_orderset_nr
  ,CAST(COALESCE(wawi.case_size_dec,umg.conv_to_base_numerator/NULLIFZERO(umg.conv_to_base_denominator),umg2.conv_to_base_numerator,wawi.case_size) AS DECIMAL(9,4)) AS case_size
  ,a.client_id
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.country_cd ELSE c.src_country_lidl_cd END AS country_cd
  ,COALESCE(wawi.dat_valid_from, a.src_dat_valid_from, dwf1.src_dat_valid_from, dwf2.src_dat_valid_from, TO_DATE('31.12.9999', 'dd.mm.yyyy')) AS dat_valid_from /* bevorzugt DAT_VALID_FROM aus T_WAWI_ITM_ITEM_ACT_1 nehmen, damit bei Dummy_1 Artikeln (CASE_SIZE = -1) der spaetere, aktualisierte Fachschluessel hochgereicht wird */
  ,CAST(a.item_sid AS DECIMAL(18,0)) AS item_id
  ,TRY_CAST(COALESCE(a.src_orig_item_nr,a.config_item_cd,a.src_matnr) AS DECIMAL(18,0)) AS orig_item_nr
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.orig_item_nr_int ELSE COALESCE(TRY_CAST(a.item_eks_cd AS DECIMAL(9,0)),-1) END AS orig_item_nr_int
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.add_docs_fg ELSE -1 END AS add_docs_fg
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.additions ELSE '#NA#' END AS additions
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.age_fg ELSE -1 END AS age_fg    /* posc.age_rating_cd, interpretieren, wenn daten da sind, Kennzeichen haengt an loc. MIN, MAX, AVG? */
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.beverage_tax ELSE -1 END AS beverage_tax
  ,CASE WHEN wawi.client_id IS NOT NULL THEN COALESCE(wawi.buyer_id, 9999)  ELSE 1 END AS buyer_id
  ,CASE WHEN wawi.client_id IS NOT NULL THEN COALESCE(wawi.buyer_name,'--')  ELSE '#NA#' END AS buyer_name
  ,CASE
     WHEN wawi.client_id IS NOT NULL THEN CAST(wawi.buying_list_type_id AS SMALLINT)
     ELSE
       CASE
         WHEN ibr.brand_type_mark = 'EM'  AND ilt.list_type = 'A' THEN  8 /* Aktionsartikel EM              */
         WHEN ibr.brand_type_mark = 'M'   AND ilt.list_type = 'A' THEN  7 /* Aktionsartikel M               */
         WHEN ibr.brand_type_mark = 'EM'  AND ilt.list_type = 'S' THEN  2 /* Normalsortiment EM             */
         WHEN ibr.brand_type_mark = 'M'   AND ilt.list_type = 'S' THEN  1 /* Normalsortiment M              */
         WHEN ibr.brand_type_mark = 'EM'  AND ilt.list_type = '-' THEN -2 /* EM ohne Listungsart            */
         WHEN ibr.brand_type_mark = 'M'   AND ilt.list_type = '-' THEN -3 /* M ohne Listungsart             */
         WHEN ibr.brand_type_mark IS NULL AND ilt.list_type = 'A' THEN -4 /* Aktionsartikel ohne Markenart  */
         WHEN ibr.brand_type_mark IS NULL AND ilt.list_type = 'S' THEN -5 /* Normalsortiment ohne Markenart */
         ELSE                                                          -1 /* Dummy_1-Artikelart               */
       END
   END AS buying_list_type_id
  ,CASE
     WHEN wawi.client_id IS NOT NULL THEN wawi.buying_list_type_desc
     ELSE
       CASE
         WHEN ibr.brand_type_mark = 'EM'  AND ilt.list_type = 'A' THEN 'Aktionsartikel EM'
         WHEN ibr.brand_type_mark = 'M'   AND ilt.list_type = 'A' THEN 'Aktionsartikel M'
         WHEN ibr.brand_type_mark = 'EM'  AND ilt.list_type = 'S' THEN 'Normalsortiment EM'
         WHEN ibr.brand_type_mark = 'M'   AND ilt.list_type = 'S' THEN 'Normalsortiment M'
         WHEN ibr.brand_type_mark = 'EM'  AND ilt.list_type = '-' THEN 'EM ohne Listungsart'
         WHEN ibr.brand_type_mark = 'M'   AND ilt.list_type = '-' THEN 'M ohne Listungsart'
         WHEN ibr.brand_type_mark IS NULL AND ilt.list_type = 'A' THEN 'Aktionsartikel ohne Markenart'
         WHEN ibr.brand_type_mark IS NULL AND ilt.list_type = 'S' THEN 'Normalsortiment ohne Markenart'
         ELSE                                                          'Dummy_1-Artikelart'
       END
   END AS buying_list_type_desc
  ,CASE
     WHEN wawi.client_id IS NOT NULL THEN wawi.brand_type_id
     ELSE
       CASE
         WHEN ibr.brand_type_mark = 'M'   THEN  1 /* Marke               */
         WHEN ibr.brand_type_mark = 'EM'  THEN  2 /* Eigenmarke          */
         ELSE                                  -1 /* Dummy_1-Markenart     */
       END
   END AS brand_type_id
  ,CASE
     WHEN wawi.client_id IS NOT NULL THEN wawi.listing_type_id
     ELSE
       CASE
         WHEN ilt.list_type = 'A' THEN  1 /* Aktionsartikel              */
         WHEN ilt.list_type = 'S' THEN  4 /* Normalsortiment             */
         ELSE                          -1 /* Dummy_1-Listungsart           */
       END
   END AS listing_type_id
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.case_dd ELSE -1 END AS case_dd
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.case_depth ELSE -1 END AS case_depth
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.case_euro ELSE -1 END AS case_euro
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.case_height ELSE -1 END AS case_height
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.case_layer ELSE -1 END AS case_layer
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.case_plu_fg ELSE -1 END AS case_plu_fg
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.case_volume ELSE -1 END AS case_volume
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.case_weight ELSE -1 END AS case_weight
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.case_width ELSE -1 END AS case_width
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.commodity_cd ELSE '#NA#' END AS commodity_cd
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.consumption_tax_main_id ELSE -1 END AS consumption_tax_main_id
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.consumption_tax_sub_id ELSE -1 END AS consumption_tax_sub_id
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.cont_deposit_item_nr ELSE '#NA#' END AS cont_deposit_item_nr
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.contract_country_cd ELSE '#NA' END AS contract_country_cd
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.dangerous_goods_fg ELSE -1 END AS dangerous_goods_fg
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.dat_adv ELSE TO_DATE ('1900-01-01', 'yyyy-mm_1-dd') END AS dat_adv
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.dat_delisting ELSE TO_DATE ('1900-01-01', 'yyyy-mm_1-dd') END AS dat_delisting
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.dat_listing ELSE TO_DATE ('1900-01-01', 'yyyy-mm_1-dd') END AS dat_listing
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.dat_min_shelflifetest_fg ELSE -1 END AS dat_min_shelflifetest_fg
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.delisting_fg ELSE -1 END AS delisting_fg
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.delivery_temp ELSE -1 END AS delivery_temp
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.direct_delete_mde_fg ELSE -1 END AS direct_delete_mde_fg
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.discount_fg ELSE -1 END AS discount_fg
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.dualsystem_fg ELSE -1 END AS dualsystem_fg
  ,CAST(d.dur_shelflife_day_cust AS INTEGER) AS dur_shelflife_day_cust
  ,CAST(d.dur_shelflife_day_store AS INTEGER) AS dur_shelflife_day_store
  ,CAST(d.dur_shelflife_day_wh AS INTEGER) AS dur_shelflife_day_wh
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.food_fg ELSE -1 END AS food_fg
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.forwarding_item_nr ELSE -1 END AS forwarding_item_nr
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.int_subitemgroup_id ELSE COALESCE(TRY_CAST(sig.src_subitemgrp_cd AS INTEGER),-2000) END AS int_subitemgroup_id
  ,CASE WHEN wawi.client_id IS NOT NULL THEN COALESCE(wawi.item_actiongroup_id,-999) ELSE -1 END AS item_actiongroup_id
   /* 2020-02-12  tbachman   Get item_familygroup_id from WAWI-Table, if country_1 is WAWI country. Similar to other columns */
  ,COALESCE (oitm.item_familygroup_id, CASE WHEN wawi.client_id IS NOT NULL THEN wawi.item_familygroup_id ELSE COALESCE(k.src_familygrp_id, k.item_fam_grp_sid) END) AS item_familygroup_id
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.item_parts ELSE -1 END AS item_parts
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.item_parts_cd ELSE -1 END AS item_parts_cd
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.item_plu_nr ELSE '#NA#' END AS item_plu_nr
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.item_short_desc_1 ELSE '#NA#' END AS item_short_desc_1
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.item_short_desc_2 ELSE '#NA#' END AS item_short_desc_2
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.item_short_desc_3 ELSE '#NA#' END AS item_short_desc_3
  ,CASE WHEN wawi.client_id IS NOT NULL THEN COALESCE(wawi.item_sub_actiongroup_id,-999) ELSE -1 END AS item_sub_actiongroup_id
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.item_text_1 ELSE '#NA#' END AS item_text_1
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.item_text_2 ELSE '#NA#' END AS item_text_2
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.item_text_3 ELSE '#NA#' END AS item_text_3
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.item_version ELSE '#NA#' END AS item_version
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.lidl_buying_country_cd ELSE '#NA#' END AS lidl_buying_country_cd
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.listing_fg ELSE -1 END AS listing_fg
  ,COALESCE(CASE WHEN wawi.client_id IS NOT NULL THEN wawi.logistic_unit_cd ELSE uom.logistic_unit_cd END,-1) AS logistic_unit_cd
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.max_receive_temp ELSE -1 END AS max_receive_temp
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.mdessp_fg ELSE -1 END AS mdessp_fg
  ,COALESCE (mdm.mdm_cust_need_subtype_cd, '#NA#') AS mdm_cust_need_subtype_cd
  ,COALESCE (mdm_st.mdm_cust_need_type_cd, '#NA#') AS mdm_cust_need_type_cd
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.min_case_dd ELSE -1 END AS min_case_dd
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.min_case_euro ELSE -1 END AS min_case_euro
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.min_case_layer ELSE -1 END AS min_case_layer
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.min_case_orderunit ELSE -1 END AS min_case_orderunit
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.min_receive_temp ELSE -1 END AS min_receive_temp
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.minus_fg ELSE -1 END AS minus_fg
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.net_case_weight ELSE -1 END AS net_case_weight
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.net_piece_weight ELSE -1 END AS net_piece_weight
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.order_area_cd ELSE '#NA#' END AS order_area_cd
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.package_qty ELSE CAST(uom.package_qty AS DECIMAL(18,4)) END AS package_qty
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.packagetype_desc ELSE '#NA#' END AS packagetype_desc
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.packing ELSE COALESCE(uom.packing, '-1') END AS packing
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.pct_consumption_tax ELSE -1 END AS pct_consumption_tax
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.pct_discount ELSE -1 END AS pct_discount
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.period_id_shelflife_cust ELSE -1 END AS period_id_shelflife_cust
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.period_id_shelflife_store ELSE -1 END AS period_id_shelflife_store
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.period_id_shelflife_wh ELSE -1 END AS period_id_shelflife_wh
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.piece_depth ELSE -1 END AS piece_depth
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.piece_height ELSE -1 END AS piece_height
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.piece_volume ELSE -1 END AS piece_volume
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.piece_weight ELSE -1 END AS piece_weight
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.piece_width ELSE -1 END AS piece_width
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.piece_net_weight_kg_meas ELSE -1 END AS piece_net_weight
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.poster_fg ELSE -1 END AS poster_fg
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.price_sign_fg ELSE -1 END AS price_sign_fg
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.price_strip_fg ELSE -1 END AS price_strip_fg
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.qty_consumption_tax_add ELSE -1 END AS qty_consumption_tax_add
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.res_selltime ELSE -1 END AS res_selltime
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.reusable_fg ELSE -1 END AS reusable_fg
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.scale_fg ELSE -1 END AS scale_fg
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.season_fg ELSE -1 END AS season_fg
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.smallest_orderunit ELSE -1 END AS smallest_orderunit
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.smallest_unit ELSE '#NA#' END AS smallest_unit
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.status_id_hq ELSE 4  END AS status_id_hq
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.stock_capacity ELSE -1 END AS stock_capacity
  /* ,CASE WHEN cg.client_id IS NULL AND wawi.client_id IS NOT NULL THEN wawi.subitemgroup_id ELSE CAST(e.src_matkl AS INTEGER) END AS subitemgroup_id */
  /* Ermittlung der SIG seitens SAP ueber die AF und nicht direkt aus der item_1 Tabelle */
  /* COMMENT & code correction by Michael Strauch */
  ,COALESCE (oitm.subitemgroup_id, CASE WHEN wawi.client_id IS NOT NULL THEN wawi.subitemgroup_id ELSE CAST(sig.src_subitemgrp_cd AS INTEGER) END) AS subitemgroup_id
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.tax_refund_fg ELSE -1 END AS tax_refund_fg
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.taxation ELSE -1 END AS taxation
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.type_cd ELSE '#NA#' END AS type_cd
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.type_receive_temp_fg ELSE -1 END AS type_receive_temp_fg
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.unitsize ELSE uom.unitsize END AS unitsize
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.val_consumption_tax ELSE -1 END AS val_consumption_tax
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.val_deposit ELSE -1 END AS val_deposit
  ,COALESCE(h.vat_id,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.vat_id ELSE NULL END) AS vat_id
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.wallow_nr ELSE -1 END AS wallow_nr
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.weight ELSE -1 END AS weight
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.weight_fg ELSE CASE WHEN Upper(TRIM(i.src_msehi)) = 'KG' THEN 1 ELSE 0 END END AS weight_fg
  ,CAST(CASE WHEN wawi.client_id IS NOT NULL THEN wawi.wg_fg ELSE -1 END AS DECIMAL(10,0)) AS wg_fg
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.write_off ELSE -1 END AS write_off
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.buyer_name_int ELSE '#NA#' END AS buyer_name_int
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.case_size_dec ELSE -1 END AS case_size_dec
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.dur_shelflife_timeunits_cust ELSE -1 END AS dur_shelflife_timeunits_cust
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.dur_shelflife_timeunits_store ELSE -1 END AS dur_shelflife_timeunits_store
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.dur_shelflife_timeunits_wh ELSE -1 END AS dur_shelflife_timeunits_wh
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.factor_period_cust ELSE -1 END AS factor_period_cust
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.factor_period_store ELSE -1 END AS factor_period_store
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.factor_period_wh ELSE -1 END AS factor_period_wh
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.factor_shelflife_cust ELSE -1 END AS factor_shelflife_cust
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.factor_shelflife_store ELSE -1 END AS factor_shelflife_store
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.factor_shelflife_wh ELSE -1 END AS factor_shelflife_wh
  ,CASE WHEN wawi.client_id IS NOT NULL THEN wawi.qty_min_piece_ordering ELSE '  ' END AS qty_min_piece_ordering
  ,idesc.item_desc_AT
  ,idesc.item_desc_BE
  ,idesc.item_desc_BG
  ,idesc.item_desc_CH
  ,idesc.item_desc_CY
  ,idesc.item_desc_CZ
  ,idesc.item_desc
  ,idesc.item_desc_DK
  ,idesc.item_desc_EE
  ,idesc.item_desc_ES
  ,idesc.item_desc_FI
  ,idesc.item_desc_FR
  ,idesc.item_desc_GB
  ,idesc.item_desc_GR
  ,idesc.item_desc_HR
  ,idesc.item_desc_HU
  ,idesc.item_desc_IE
  ,idesc.item_desc_IT
  ,idesc.item_desc_LT
  ,idesc.item_desc_LV
  ,idesc.item_desc_NI
  ,idesc.item_desc_NL
  ,idesc.item_desc_DE
  ,idesc.item_desc_PL
  ,idesc.item_desc_PT
  ,idesc.item_desc_RO
  ,idesc.item_desc_SE
  ,idesc.item_desc_SI
  ,idesc.item_desc_SK
  ,idesc.item_desc_CS
  ,idesc.item_desc_MT
  ,idesc.item_desc_US
  ,idesc.item_desc_RS
FROM P_LEW_CORE_AC.v_item_1 AS a

  
INNER JOIN P_LEW_CORE_AC.v_item_hist_1 AS b
ON b.client_id = a.client_id
  AND b.item_sid = a.item_sid
  AND CURRENT_DATE BETWEEN b.dwh_valid_from AND b.dwh_valid_to

LEFT OUTER JOIN
(
  SELECT
    a.client_id
    ,a.item_sid
    ,b.src_dat_valid_from
  FROM P_LEW_CORE_AC.v_item_1 AS a
  INNER JOIN P_LEW_CORE_AC.v_item_1 AS b
  ON b.client_id = a.client_id
    AND b.item_sid_config = COALESCE(a.item_sid_config,a.item_sid)
    AND b.src_dat_valid_from IS NOT NULL
    AND NOT EXISTS
    ( SELECT
        1
      FROM P_LEW_CORE_AC.v_item_1 AS c
      WHERE c.client_id = a.client_id
      AND c.item_sid_config = COALESCE(a.item_sid_config,a.item_sid)
      AND (c.src_dat_valid_from > b.src_dat_valid_from OR (c.src_dat_valid_from = b.src_dat_valid_from AND c.item_sid > b.item_sid))
    )
) AS dwf1
ON dwf1.client_id = a.client_id
AND dwf1.item_sid = a.item_sid

LEFT OUTER JOIN
(
  SELECT
    client_id
    ,TRY_CAST(src_orig_item_nr AS INTEGER) AS origi
    ,MAX(src_dat_valid_from) AS src_dat_valid_from
    FROM P_LEW_CORE_AC.v_item_1 AS c
    WHERE src_dat_valid_from IS NOT NULL
    AND origi IS NOT NULL
    AND src_case_size >= 0
  GROUP BY 1,2
) AS dwf2
ON dwf2.client_id = a.client_id
AND dwf2.origi = TRY_CAST(COALESCE(a.src_orig_item_nr,a.config_item_cd,a.src_matnr) AS DECIMAL(18,0))
AND a.log_var_cd IS NOT NULL

LEFT OUTER JOIN
(
  SELECT
    um.client_id
   ,um.item_sid
   ,um.log_var_cd
   ,umh.conv_to_base_numerator
   ,umh.conv_to_base_denominator
  FROM P_LEW_CORE_AC.v_item_unit_of_measurement_1 AS um
  INNER JOIN P_LEW_CORE_AC.v_item_unit_of_measurement_hist_1 AS umh
  ON umh.client_id = um.client_id
  AND umh.item_sid = um.item_sid
  AND umh.uom_sid = um.uom_sid
  AND CURRENT_DATE BETWEEN umh.dwh_valid_from AND umh.dwh_valid_to
  AND umh.deleted_fg = 0
  WHERE um.log_var_cd IS NOT NULL
  QUALIFY ROW_NUMBER () Over (PARTITION BY um.client_id, um.item_sid, um.log_var_cd ORDER BY umh.conv_to_base_numerator ASC, umh.conv_to_base_denominator ASC)=1
) AS umg
ON umg.client_id = a.client_id
  AND umg.item_sid = a.item_sid
  AND umg.log_var_cd = a.log_var_cd
  AND (a.log_var_cd <> '1' OR a.config_item_cd IS NOT NULL)

 LEFT OUTER JOIN
(
  SELECT
    um.client_id
   ,um.item_sid
   ,0 AS conv_to_base_numerator
  FROM P_LEW_CORE_AC.v_item_unit_of_measurement_1 AS um
  INNER JOIN P_LEW_CORE_AC.v_item_unit_of_measurement_hist_1 AS umh
  ON umh.client_id = um.client_id
  AND umh.item_sid = um.item_sid
  AND umh.uom_sid = um.uom_sid
  AND CURRENT_DATE BETWEEN umh.dwh_valid_from AND umh.dwh_valid_to
  AND umh.deleted_fg = 0
  WHERE um.log_var_cd IS NOT NULL
  GROUP BY 1,2
) AS umg2
ON umg2.client_id = a.client_id
  AND umg2.item_sid = a.item_sid
  
INNER JOIN P_LEW_CORE_AC.v_item_map_key_1 mkey 
ON a.client_id = mkey.client_id 
  AND a.item_sid = mkey.item_sid 

LEFT OUTER JOIN P_LEW_CORE_AC.v_wawi_itm_item_act_1 AS wawi
ON wawi.client_id = mkey.client_id
  AND wawi.item_sid = mkey.item_sid_map

LEFT OUTER JOIN
(
  SELECT
    client_id
    ,item_sid
    ,brand_sid
    ,brand_type_mark
    ,brand_descr
  FROM
  (
    SELECT
      a.client_id
      ,a.item_sid
      ,a.brand_sid
      ,a.brand_type_mark
      ,d.brand_descr
      ,COUNT(*) AS counti
    FROM P_LEW_CORE_AC.v_item_location_brand_hist_1 AS a
    INNER JOIN P_LEW_CORE_AC.v_location_1 AS b
    ON b.loc_sid=a.loc_sid
    AND b.wh_store_mark = 'A'
    AND b.global_loc_type_cd='0'
    INNER JOIN P_LEW_CORE_AC.v_location_hist_1 AS c
    ON c.loc_sid=b.loc_sid
    /* AND c.demand_plan_active_fg = 1  Removed in version 1.3 */
    AND CURRENT_DATE BETWEEN c.dwh_valid_from AND c.dwh_valid_to
    AND c.deleted_fg = 0
    LEFT OUTER JOIN P_LEW_CORE_AC.v_brand_1 AS dx
    ON dx.client_id = a.client_id
    AND dx.brand_sid=a.brand_sid
    LEFT OUTER JOIN P_LEW_CORE_AC.v_client_1 AS cli
    ON cli.client_id = a.client_id
    LEFT OUTER JOIN P_LEW_CORE_AC.v_country_1 AS ctry
    ON cli.country_sid = ctry.country_sid
    LEFT OUTER JOIN P_LEW_CORE_AC.v_brand_descr_1 AS d
    ON d.client_id = a.client_id
    AND d.brand_sid=a.brand_sid
    AND d.lang_sid =ctry.lang_sid
    WHERE CURRENT_DATE BETWEEN a.dwh_valid_from AND a.dwh_valid_to
    AND a.deleted_fg = 0
    GROUP BY 1,2,3,4,5
  ) AS x
  QUALIFY ROW_NUMBER() OVER (PARTITION BY client_id,item_sid ORDER BY counti DESC NULLS LAST, CASE WHEN brand_descr='-' THEN 2 ELSE 1 END ASC) = 1
) AS ibr
ON a.client_id = ibr.client_id
  AND a.item_sid = ibr.item_sid

LEFT OUTER JOIN
(
  SELECT
    client_id
   ,item_sid
   ,list_type
  FROM
  (
    SELECT
      a.client_id
     ,a.item_sid
     ,COALESCE(a.list_type_mark,'-') AS list_type
     ,COUNT(*) AS counti
    FROM P_LEW_CORE_AC.v_item_listing_type_hist_1 AS a
    INNER JOIN P_LEW_CORE_AC.v_location_1 AS b
    ON b.loc_sid=a.loc_sid
    AND b.wh_store_mark = 'A'
    AND b.global_loc_type_cd='0'
    INNER JOIN P_LEW_CORE_AC.v_location_hist_1 AS c
    ON c.loc_sid=b.loc_sid
    /* AND c.demand_plan_active_fg = 1  Removed in version 1.3 */
    AND CURRENT_DATE BETWEEN c.dwh_valid_from AND c.dwh_valid_to
    AND c.deleted_fg = 0
    WHERE CURRENT_DATE BETWEEN a.dwh_valid_from AND a.dwh_valid_to
    AND a.deleted_fg = 0
    GROUP BY 1,2,3
  ) AS x
  QUALIFY ROW_NUMBER() OVER (PARTITION BY client_id,item_sid ORDER BY counti DESC NULLS LAST) = 1
) AS ilt
ON a.client_id = ilt.client_id
  AND a.item_sid = ilt.item_sid

INNER JOIN P_LEW_CORE_AC.v_client_1 AS c
ON c.client_id = a.client_id

LEFT OUTER JOIN P_LEW_BIL_AC.v_item_shelflife_1 AS d
ON d.client_id = a.client_id
  AND d.item_sid = a.item_sid

LEFT OUTER JOIN P_LEW_CORE_AC.v_item_group_1 AS e
ON e.client_id = b.client_id
  AND e.item_grp_sid = b.item_grp_sid

LEFT OUTER JOIN P_LEW_CORE_AC.v_packaging_type_1 AS f
ON f.client_id = b.client_id
  AND f.pack_type_sid = b.pack_type_sid

LEFT OUTER JOIN (SELECT vat_id
                        ,client_id
                        ,item_sid 
                 FROM P_LEW_BIL_AC.v_item_vat_1 
                 WHERE dat_calendar = CURRENT_DATE 
                 GROUP BY 1,2,3) AS h
ON h.client_id = a.client_id
  AND h.item_sid = a.item_sid

LEFT OUTER JOIN P_LEW_CORE_AC.v_unit_of_measurement_1 AS i
ON i.client_id = b.client_id
  AND i.uom_sid = b.uom_sid_base

LEFT OUTER JOIN P_LEW_CORE_AC.v_map_mis_logistic_unit_1 AS j
ON j.client_id = b.client_id
  AND j.uom_cd = b.uom_cd_packaging

LEFT OUTER JOIN P_LEW_CORE_AC.v_item_hist_1 AS bb
ON bb.client_id = a.client_id
  AND bb.item_sid = COALESCE(a.item_sid_config, a.item_sid)
  AND CURRENT_DATE BETWEEN bb.dwh_valid_from AND bb.dwh_valid_to
  /*AND bb.deleted_fg = 0*/

LEFT OUTER JOIN P_LEW_CORE_AC.v_item_familygroup_1 AS k
ON k.client_id = bb.client_id
  AND k.item_fam_grp_sid = bb.item_fam_grp_sid

LEFT OUTER JOIN P_LEW_CORE_AC.v_item_familygroup_hist_1 AS kh
ON kh.client_id = bb.client_id
  AND kh.item_fam_grp_sid = bb.item_fam_grp_sid
  AND CURRENT_DATE BETWEEN kh.dwh_valid_from AND kh.dwh_valid_to
  /*AND kh.deleted_fg=0*/

LEFT OUTER JOIN P_LEW_CORE_AC.v_subitemgroup_1 AS sig
ON sig.client_id = kh.client_id
  AND sig.sub_item_grp_sid = kh.sub_item_grp_sid

LEFT OUTER JOIN
(
  SELECT
      client_id
      ,item_sid
      ,package_qty
      ,packing
      ,logistic_unit_cd
      ,unitsize
  FROM
  (
    SELECT
       u.dwh_load_id 
        ,a.client_id
        ,a.item_sid
        ,d.gross_content_val * d.pack_cont_qty AS package_qty
        ,h.pack_type_descr AS packing
        ,e.mis_logistic_unit_cd AS logistic_unit_cd
        ,CASE
          WHEN d.gross_content_val <> 1
          THEN TRIM(CAST(d.gross_content_val AS DECIMAL(18,2))) ||'x'|| TRIM(CAST(d.pack_cont_qty AS DECIMAL(18,2))) || CAST(u.src_msehi AS VARCHAR(10))
          ELSE TRIM(CAST(d.pack_cont_qty AS DECIMAL(18,2)))|| CAST(u.src_msehi AS VARCHAR(10))
        END AS unitsize
        ,COUNT(*) OVER (PARTITION BY a.client_id, a.item_sid, package_qty) AS cnt_package_qty
    FROM P_LEW_CORE_AC.v_item_sort_box_hist_1 AS a
    INNER JOIN P_LEW_CORE_AC.v_item_hist_1 AS b
       ON b.client_id = a.client_id
      AND b.item_sid = a.item_sid
      AND CURRENT_DATE BETWEEN b.dwh_valid_from AND b.dwh_valid_to
    /*AND b.deleted_fg = 0*/
    INNER JOIN P_LEW_CORE_AC.v_item_bom_1 AS m
       ON m.client_id = a.client_id
      AND m.item_sid = a.item_sid_sort_box
    INNER JOIN P_LEW_CORE_AC.v_item_bom_pos_hist_1 AS c
       ON c.client_id = m.client_id
      AND c.item_bom_sid = m.item_bom_sid
    INNER JOIN P_LEW_CORE_AC.v_item_hist_1 AS d
       ON d.client_id = c.client_id
      AND d.item_sid = c.item_sid
      AND CURRENT_DATE BETWEEN d.dwh_valid_from AND d.dwh_valid_to
    /*AND d.deleted_fg = 0*/
    LEFT OUTER JOIN P_LEW_CORE_AC.v_unit_of_measurement_1 AS u
      ON u.client_id = d.client_id
     AND u.uom_sid = d.uom_sid_packaging
    LEFT OUTER JOIN P_LEW_CORE_AC.v_map_mis_logistic_unit_1 AS e
      ON e.client_id = d.client_id
     AND e.uom_cd = d.uom_cd_packaging
    INNER JOIN P_LEW_CORE_AC.v_client_1 AS f
       ON f.client_id = d.client_id
    INNER JOIN P_LEW_CORE_AC.v_country_1 AS g
       ON g.country_sid = f.country_sid
    LEFT OUTER JOIN P_LEW_CORE_AC.v_packaging_type_descr_1 AS h
      ON h.client_id = d.client_id
     AND h.pack_type_sid = d.pack_type_sid
     AND h.lang_sid = g.lang_sid
    WHERE CURRENT_DATE BETWEEN a.dwh_valid_from AND a.dwh_valid_to
  ) z
  QUALIFY ROW_NUMBER() OVER (PARTITION BY z.client_id, z.item_sid ORDER BY z.cnt_package_qty DESC NULLS LAST, z.package_qty DESC NULLS LAST,z.dwh_load_id DESC NULLS LAST) = 1 
) uom
ON uom.client_id = a.client_id
AND uom.item_sid = a.item_sid
/* Join to take proper AF/SIG mappings */
LEFT OUTER JOIN P_LEW_MART_LEAD_AC.v_itm_orig_item_1 oitm
 ON a.client_id = oitm.client_id
AND COALESCE(wawi.dat_valid_from, a.src_dat_valid_from, dwf1.src_dat_valid_from, dwf2.src_dat_valid_from, TO_DATE('31.12.9999', 'dd.mm.yyyy')) = oitm.dat_valid_from
AND TRY_CAST(COALESCE(a.src_orig_item_nr,a.config_item_cd,a.src_matnr) AS DECIMAL(18,0)) = oitm.orig_item_nr

/* Version 1.5: added description columns */
LEFT OUTER JOIN
(
  SELECT   client_id
         , item_id
         , MAX (CASE WHEN language_iso_cd = 'AT'          THEN item_desc ELSE NULL END) AS item_desc_AT
         , MAX (CASE WHEN language_iso_cd = 'BE'          THEN item_desc ELSE NULL END) AS item_desc_BE
         , MAX (CASE WHEN language_iso_cd = 'BG'          THEN item_desc ELSE NULL END) AS item_desc_BG
         , MAX (CASE WHEN language_iso_cd = 'CH'          THEN item_desc ELSE NULL END) AS item_desc_CH
         , MAX (CASE WHEN language_iso_cd = 'CY'          THEN item_desc ELSE NULL END) AS item_desc_CY
         , MAX (CASE WHEN language_iso_cd = 'CZ'          THEN item_desc ELSE NULL END) AS item_desc_CZ
         , MAX (CASE WHEN language_iso_cd = 'INT'         THEN item_desc ELSE NULL END) AS item_desc
         , MAX (CASE WHEN language_iso_cd = 'DK'          THEN item_desc ELSE NULL END) AS item_desc_DK
         , MAX (CASE WHEN language_iso_cd = 'EE'          THEN item_desc ELSE NULL END) AS item_desc_EE
         , MAX (CASE WHEN language_iso_cd IN ('ES', 'CS') THEN item_desc ELSE NULL END) AS item_desc_ES
         , MAX (CASE WHEN language_iso_cd = 'FI'          THEN item_desc ELSE NULL END) AS item_desc_FI
         , MAX (CASE WHEN language_iso_cd = 'FR'          THEN item_desc ELSE NULL END) AS item_desc_FR
         , MAX (CASE WHEN language_iso_cd = 'GB'          THEN item_desc ELSE NULL END) AS item_desc_GB
         , MAX (CASE WHEN language_iso_cd IN ('GR', 'CY') THEN item_desc ELSE NULL END) AS item_desc_GR
         , MAX (CASE WHEN language_iso_cd = 'HR'          THEN item_desc ELSE NULL END) AS item_desc_HR
         , MAX (CASE WHEN language_iso_cd = 'HU'          THEN item_desc ELSE NULL END) AS item_desc_HU
         , MAX (CASE WHEN language_iso_cd IN ('IE', 'NI') THEN item_desc ELSE NULL END) AS item_desc_IE
         , MAX (CASE WHEN language_iso_cd IN ('IT', 'MT') THEN item_desc ELSE NULL END) AS item_desc_IT
         , MAX (CASE WHEN language_iso_cd = 'LT'          THEN item_desc ELSE NULL END) AS item_desc_LT
         , MAX (CASE WHEN language_iso_cd = 'LV'          THEN item_desc ELSE NULL END) AS item_desc_LV
         , MAX (CASE WHEN language_iso_cd = 'NI'          THEN item_desc ELSE NULL END) AS item_desc_NI
         , MAX (CASE WHEN language_iso_cd = 'NL'          THEN item_desc ELSE NULL END) AS item_desc_NL
         , MAX (CASE WHEN language_iso_cd = 'DE'          THEN item_desc ELSE NULL END) AS item_desc_DE
         , MAX (CASE WHEN language_iso_cd = 'PL'          THEN item_desc ELSE NULL END) AS item_desc_PL
         , MAX (CASE WHEN language_iso_cd = 'PT'          THEN item_desc ELSE NULL END) AS item_desc_PT
         , MAX (CASE WHEN language_iso_cd = 'RO'          THEN item_desc ELSE NULL END) AS item_desc_RO
         , MAX (CASE WHEN language_iso_cd = 'SE'          THEN item_desc ELSE NULL END) AS item_desc_SE
         , MAX (CASE WHEN language_iso_cd = 'SI'          THEN item_desc ELSE NULL END) AS item_desc_SI
         , MAX (CASE WHEN language_iso_cd = 'SK'          THEN item_desc ELSE NULL END) AS item_desc_SK
         , MAX (CASE WHEN language_iso_cd = 'CS'          THEN item_desc ELSE NULL END) AS item_desc_CS
         , MAX (CASE WHEN language_iso_cd = 'MT'          THEN item_desc ELSE NULL END) AS item_desc_MT
         , MAX (CASE WHEN language_iso_cd = 'US'          THEN item_desc ELSE NULL END) AS item_desc_US
         , MAX (CASE WHEN language_iso_cd = 'RS_1'          THEN item_desc ELSE NULL END) AS item_desc_RS
   FROM (
         SELECT   itm.client_id
                , itm.item_sid AS item_id
                /* , COALESCE(descr_sammel.item_descr, descr.item_descr) AS item_desc */
                , CASE WHEN descr_sammel.dwh_updated >= descr.dwh_updated
                       THEN COALESCE(descr_sammel.item_descr, descr.item_descr)
                       ELSE COALESCE(descr.item_descr, descr_sammel.item_descr)
                  END AS item_desc
                , lang.language_iso_cd  /* Sprachschluessel analog zu WAWI Definition (z.B. AT fuer Oesterreich DE Sprache)    */
           FROM P_LEW_CORE_AC.v_item_1 itm
          INNER JOIN P_LEW_CORE_AC.v_client_1      AS cli
             ON cli.client_id = itm.client_id
          INNER JOIN P_LEW_CORE_AC.v_country_1     AS ctry
             ON cli.country_sid             = ctry.country_sid
                OR ctry.src_country_lidl_cd = 'INT'               /* Stiftung     */
          INNER JOIN P_LEW_CORE_AC.v_report_language_1 AS rlang
             ON ctry.lang_sid = rlang.lang_sid
          INNER JOIN P_LEW_CORE_AC.v_map_lang_spras_1  AS lang
             ON TRIM(lang.sap_lang_cd)         = TRIM(rlang.iso_cd)
            AND TRIM(ctry.src_country_lidl_cd) = TRIM(language_iso_cd)
           LEFT OUTER JOIN P_LEW_CORE_AC.v_item_descr_1 AS descr
             ON itm.client_id  = descr.client_id
            AND itm.item_sid   = descr.item_sid
            AND rlang.lang_sid = descr.lang_sid
           LEFT OUTER JOIN P_LEW_CORE_AC.v_item_descr_1 AS descr_sammel
             ON itm.client_id       = descr_sammel.client_id
            AND itm.item_sid_config = descr_sammel.item_sid
            AND rlang.lang_sid      = descr_sammel.lang_sid
   WHERE TRY_CAST(itm.src_matnr AS DECIMAL(20)) IS NOT NULL
     OR itm.src_matnr IS NULL
  ) a
  GROUP BY   client_id
           , item_id
) idesc
  ON a.client_id = idesc.client_id
 AND a.item_sid  = idesc.item_id

/* Version 1.10 */
  LEFT OUTER JOIN
(
  SELECT client_id, item_sid, mdm_cust_need_subtype_cd
  FROM
  (
    SELECT
      link.client_id
    , link.item_sid
    , COALESCE (mdm_hist.mdm_cust_need_subtype_cd, '#NA# - ' || TRIM (mdm_hist.mdm_cust_need_type_cd)) AS mdm_cust_need_subtype_cd
    , MAX(mdm_hist.dwh_valid_from)         AS last_valid_from
    , MAX(mdm_hist.cbx_item_created_tmsp)  AS last_cbx_created
    FROM p_lew_core.T_item_mdm_link_1 link
      LEFT OUTER JOIN p_lew_core.T_mdm_item_hist_1 mdm_hist
        ON link.mdm_item_sid = mdm_hist.mdm_item_sid
       AND CURRENT_DATE BETWEEN mdm_hist.dwh_valid_from AND mdm_hist.dwh_valid_to
    WHERE mdm_hist.mdm_cust_need_type_cd IS NOT NULL
       OR mdm_hist.mdm_cust_need_subtype_cd IS NOT NULL
    GROUP BY 1,2,3
  ) tmp
  QUALIFY ROW_NUMBER() OVER (PARTITION BY client_id, item_sid ORDER BY last_valid_from DESC, last_cbx_created DESC, mdm_cust_need_subtype_cd) = 1
) mdm
   ON a.client_id = mdm.client_id
  AND a.item_sid  = mdm.item_sid
  LEFT OUTER JOIN
  ( /* same logic as in P_LEW_MART_LEAD_AC.V_REF_MDM_CUSTOMER_NEED_SUBTYPE_1 */
   SELECT
     mdm_cust_need_subtype_cd
   , mdm_cust_need_subtype_name
   , mdm_cust_need_type_cd
   FROM P_LEW_CORE_AC.v_ref_mdm_customer_need_subtype_1
     UNION ALL
   SELECT
     '#NA# - ' || mdm_cust_need_type_cd               AS mdm_cust_need_subtype_cd
   , 'nicht zugeordnet - ' || mdm_cust_need_type_name AS mdm_cust_need_subtype_name
   , mdm_cust_need_type_cd
   FROM P_LEW_CORE_AC.v_ref_mdm_customer_need_type_1
     UNION
   SELECT '#NA#', 'nicht zugeordnet', '#NA#'
  ) mdm_st
    ON mdm.mdm_cust_need_subtype_cd = mdm_st.mdm_cust_need_subtype_cd

WHERE TRY_CAST(COALESCE(a.src_orig_item_nr,a.config_item_cd,a.src_matnr) AS DECIMAL(18,0)) IS NOT NULL
;