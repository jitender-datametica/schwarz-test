/* --------------------------------------------------------------------------------
   DDL for table: t_dim_kfl_item_1
   generated from Powerdesigner on Donnerstag, 17. August 2023 15:36:24
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core.t_dim_kfl_item_1 (
lob_cd STRING(100) NOT NULL
OPTIONS(description='line of business depends on the general source of the data, \'KFL\' if the data is taken from the Kaufland DWH, \'LDL\' if the data is taken from a Lidl DWH'),
kfl_client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''identifier of the KFL client (Mandant_1) in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.art.mandant_id
            CORE_REL: t_kfl_item.kfl_client_id'''),
kfl_item_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''identifier of the KFL item_1 (Artikel_1) in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.art.art_id
            CORE_REL: t_kfl_item.kfl_item_nr'''),
kfl_item_name STRING(200)
OPTIONS(description='''German name of the KFL item_1 (Artikel_1) in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.art_spr_zu.art_bez
            CORE_REL: t_kfl_item_name.kfl_item_name'''),
kfl_sub_item_grp_id BIGNUMERIC(38,0)
OPTIONS(description='''identifier of the sub item_1 group (Warenuntergruppe) in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.art_wg_zu_per.WUG_ID
            CORE_REL: t_kfl_item_sub_item_group.kfl_sub_item_grp_id'''),
kfl_sub_item_grp_name STRING(160) NOT NULL
OPTIONS(description='''German name of the sub item_1 group (Warenuntergruppe) in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.wug_spr_zu.WUG_BEZ
            CORE_REL: t_kfl_sub_item_group.kfl_sub_item_grp_name'''),
kfl_item_grp_id BIGNUMERIC(38,0)
OPTIONS(description='''identifier of the item_1 group (Warengruppe) in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.art_wg_zu_per.WG_ID
            CORE_REL: t_kfl_item_sub_item_group.kfl_item_grp_id'''),
kfl_item_grp_name STRING(400) NOT NULL
OPTIONS(description='''German name of the item_1 group (Warengruppe) in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.wg_spr_zu.WG_BEZ
            CORE_REL: t_kfl_item_group.kfl_item_grp_name'''),
kfl_major_item_grp_id BIGNUMERIC(38,0)
OPTIONS(description='''identifier of the major item_1 group (Oberwarengruppe) in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.wg_per.OWG_ID
            CORE_REL: t_kfl_item_group_major_item_group.kfl_major_item_grp_id'''),
kfl_major_item_grp_name STRING(400) NOT NULL
OPTIONS(description='''German name of the major item_1 group (Oberwarengruppe) in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.owg_spr_zu.OWG_BEZ
            CORE_REL: t_kfl_major_item_group.kfl_major_item_grp_name'''),
kfl_main_item_grp_id BIGNUMERIC(38,0)
OPTIONS(description='''identifier of the main item_1 group (Hauptwarengruppe) in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.owg_per.HWG_ID
            CORE_REL: t_kfl_major_item_group_main_item_group.kfl_main_item_grp_id'''),
kfl_main_item_grp_name STRING(400) NOT NULL
OPTIONS(description='''German name of the main item_1 group (Hauptwarengruppe) in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.hwg_spr_zu.HWG_BEZ
            CORE_REL: t_kfl_main_item_group.kfl_main_item_grp_name'''),
kfl_department_id BIGNUMERIC(38,0)
OPTIONS(description='''identifier of the department (Abteilung) in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.wg_per.ABT_ID
            CORE_REL: t_kfl_item_group_major_item_group.kfl_department_id'''),
kfl_department_name STRING(400)
OPTIONS(description='''German name of the department (Abteilung) in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.abt_spr_zu.ABT_BEZ
            CORE_REL: t_kfl_department.kfl_department_name'''),
kfl_home_brand_cd STRING(100) NOT NULL
OPTIONS(description='''identifier of the home brand_1 of Kaufland in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.art.eigenmarke_id
            CORE_REL: t_kfl_item.kfl_home_brand_cd'''),
kfl_home_brand_name STRING(160)
OPTIONS(description='''German name of the home brand_1 of Kaufland in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.artkz_eigenmarke.EIGENMARKE_BEZ
            CORE_REL: t_kfl_home_brand.kfl_home_brand_name'''),
kfl_season_nr STRING(100)
OPTIONS(description='''identifier of the season in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.art.saison_id
            CORE_REL: t_kfl_item.kfl_season_nr'''),
kfl_season_name STRING(100)
OPTIONS(description='''German name of the season in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.saison_spr_zu.SAISON_BEZ
            CORE_REL: t_kfl_season.kfl_season_name'''),
nfpo_season_name STRING(100)
OPTIONS(description='''Name of the season in case of a season related item.
            CBX: CNT_ITEM.SEASON
            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.SEASON_NAME
            CORE_REL: t_nfpo_item_hist.nfpo_season_name'''),
kfl_competition_type_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''identifier of the type of the competition in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.art.aldi_id
            CORE_REL: t_kfl_item.kfl_competition_type_id'''),
kfl_competition_type_txt STRING(1000)
OPTIONS(description='''name of the type of the competition in the Kaufland DWH, for example \'Aldi Süd\' or \'Aldi komplett + Lidl\'
            KFL: KFL_PRODUCTION.DBP_DATA.ARTKZ_ALDI.ALDI_BEZ
            CORE_REL: t_kfl_competition_type.kfl_competition_type_txt'''),
kfl_main_purch_mgr_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''identifier of the central purchasing manager in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.art.zek_id
            CORE_REL: t_kfl_item.kfl_main_purch_mgr_nr'''),
kfl_promo_item_type_cd STRING(100) NOT NULL
OPTIONS(description='''current type of the promotion of an item_1 in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.art.posten_kz_sap
            CORE_REL: t_kfl_item.kfl_promo_item_type_cd'''),
kfl_promo_item_type_name STRING(100) NOT NULL
OPTIONS(description='''German name of the current type of the promotion of an item_1 in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.posten_kz_sap_spr_zu.POSTEN_BEZ_SAP
            CORE_REL: t_kfl_promotion_item_type.kfl_promo_item_type_name'''),
kfl_negotiator_cd STRING(100) NOT NULL
OPTIONS(description='''identifier of the negotiator of the item_1 in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.art.verhandler_id
            CORE_REL: t_kfl_item.kfl_negotiator_cd'''),
kfl_discount_item_fg BOOL NOT NULL
OPTIONS(description='''flag in the Kaufland DWH whether the price label of the item_1 in the market is yellow or not, yellow means that the related price is on discount price level
            KFL: KFL_PRODUCTION.DBP_DATA.art.yellowprint_fg
            CORE_REL: t_kfl_item.kfl_discount_item_fg'''),
kfl_bio_label_fg BOOL NOT NULL
OPTIONS(description='''sustainability label \'Biosiegel Flag EU\' in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.art.bio_fg
            CORE_REL: t_kfl_item.kfl_bio_label_fg'''),
kfl_green_button_label_fg BOOL NOT NULL
OPTIONS(description='''sustainability label \'Grüner Knopf\' in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.art.grk_fg
            CORE_REL: t_kfl_item.kfl_green_button_label_fg'''),
kfl_client_cd STRING(100) NOT NULL
OPTIONS(description='''code of the KFL client (Mandant_1) in the Kaufland DWH, for example \'PL\'
            KFL: KFL_PRODUCTION.DBP_DATA.mandant.mandant_kbez
            CORE_REL: t_kfl_client.kfl_client_cd'''),
kfl_client_name STRING(100) NOT NULL
OPTIONS(description='''name of the KFL client (Mandant_1) in the Kaufland DWH for example \'Polen\'
            KFL: KFL_PRODUCTION.DBP_DATA.mandant.mandant_bez
            CORE_REL: t_kfl_client.kfl_client_name'''),
nfpo_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate Key NFPO ITEM_1 INSTANCE, refernces the most fitting record in the CBX based item_1 table based on separate linking algoritms for Lidl and Kaufland items'),
ldl_item_ian_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''Lidl International Item_1 Number.
            CBX: CNT_ITEM.ITEM_NO
            LDL: P_LEW_CORE.T_MDM_ITEM.ITEM_IAN
            CORE_REL: t_nfpo_item.ldl_item_ian_nr'''),
nfpo_item_sel_nr STRING(100)
OPTIONS(description='''NFPO source system internal identifier for an article.
            CBX: CNT_ITEM.LDL_SELECTION_NO
            LDL: P_LEW_CORE.T_MDM_ITEM.ITEM_SELECTION_NR
            CORE_REL: t_nfpo_item.nfpo_item_sel_nr'''),
nfpo_item_name STRING(100) NOT NULL
OPTIONS(description='''NFPO item_1 name.
            CBX: CNT_ITEM.ITEM_DESC, SHORT_DESC
            LDL: P_LEW_CORE.T_MDM_ITEM.MDM_ITEM_NAME
            CORE_REL: t_nfpo_item.nfpo_item_name'''),
nfpo_kfl_brand_sid BIGNUMERIC(38,0)
OPTIONS(description='''Surrogate Key KFL BRAND_1, identifies the brand_1 in case of being sold in a Kaufland country.
            CBX: CNT_ITEM.LDL_BRAND_KL
            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.KFL_BRAND_SID
            CORE_REL: t_nfpo_item_hist.nfpo_kfl_brand_sid'''),
nfpo_kfl_brand_name STRING(100)
OPTIONS(description='''name Kaufland home brands used in CBX
            CBX: CNT_ITEM.LDL_BRAND_KL
            LDL: P_LEW_CORE.T_KFL_BRAND.KFL_BRAND_NAME
            CORE_REL: t_nfpo_kfl_brand.nfpo_kfl_brand_name'''),
nfpo_ldl_brand_sid BIGNUMERIC(38,0)
OPTIONS(description='''Foreign Key BRAND.
            CBX: CNT_ITEM.LDL_BRAND
            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.BRAND_SID
            CORE_REL: t_nfpo_item_hist.nfpo_ldl_brand_sid'''),
nfpo_ldl_brand_name STRING(100) NOT NULL
OPTIONS(description='''name of brands used in CBX for sales_1 in the Lidl line of business
            CBX: CNT_CODELIST.NAME for CNT_CODELIST_BOOK.NAME="LIDL_BRAND"
            LDL: P_LEW_CORE.T_BRAND.BRAND_SID
            CORE_REL: t_nfpo_ldl_brand.nfpo_ldl_brand_name'''),
nfpo_ldl_brand_type_cd STRING(100) NOT NULL
OPTIONS(description='''brand_1 type code for home brands of Lidl or Kaufland and brands of certain suppliers
            LDL: P_LEW_CORE.T_REF_BRAND_TYPE.BRAND_TYPE_CD
            CORE_REL: t_nfpo_ldl_brand.nfpo_brand_type_cd'''),
nfpo_ldl_brand_type_name STRING(100) NOT NULL
OPTIONS(description='''brand_1 type name
            LDL: P_LEW_CORE.T_REF_BRAND_TYPE.BRAND_TYPE
            CORE_REL: t_nfpo_brand_type.nfpo_brand_type_name'''),
nfpo_sup_sid BIGNUMERIC(38,0)
OPTIONS(description='''Name of the NFPO supplier.
            CBX: CNT_VENDOR.BUSINESS_NAME
            LDL: P_LEW_CORE.T_MDM_SUPPLIER.SUP_NAME
            CORE_REL: t_nfpo_supplier.nfpo_sup_name'''),
nfpo_sup_name STRING(100) NOT NULL
OPTIONS(description='''Foreign Key NFPO SUPPLIER.
            CBX: CNT_ITEM.LDL_DEFAULT_VENDOR_REF
            LDL: P_LEW_CORE.T_MDM_ITEM_HIST.MDM_SUP_SID
            CORE_REL: t_nfpo_item_hist.nfpo_sup_sid'''),
nfpo_parent_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''Foreign Key related NFPO ITEM_1 INSTANCE for relation type code \'PARENT\'
            CBX: CNT_ITEM_RELATED.RELATED_ITEM_REF
            LDL: P_LEW_CORE.T_MDM_ITEM_RELATED_ITEM_HIST.MDM_ITEM_SID_RELATED
            CORE_REL: t_nfpo_item_related_item_hist.nfpo_rel_item_sid'''),
nfpo_parent_item_name STRING(100)
OPTIONS(description='''NFPO item_1 name of the parent item_1 The parent item_1 is a related NFPO ITEM_1 INSTANCE for relation type code \'PARENT\' in t_nfpo_item_related_item_hist.
            CBX: CNT_ITEM.ITEM_DESC, SHORT_DESC
            LDL: P_LEW_CORE.T_MDM_ITEM.MDM_ITEM_NAME
            CORE_REL: T_NFPO_ITEM.NFPO_ITEM_NAME'''),
ldl_parent_item_ian_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''Lidl International Item_1 Number of the parent item.
            CBX: CNT_ITEM.ITEM_NO
            LDL: P_LEW_CORE.T_MDM_ITEM.ITEM_IAN
            CORE_REL: t_nfpo_item.ldl_item_ian_nr'''),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (lob_cd, kfl_client_id, kfl_item_nr) NOT ENFORCED
)
OPTIONS(description='''Kaufland item_1
             KFL: KFL_PRODUCTION.DBP_DATA.ART_1
             CORE_REL: T_KFL_ITEM_1''');