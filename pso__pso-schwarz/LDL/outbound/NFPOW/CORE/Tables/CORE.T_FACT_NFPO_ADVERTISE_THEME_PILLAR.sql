/* --------------------------------------------------------------------------------
   DDL for table: t_fact_nfpo_advertise_theme_pillar
   generated from Powerdesigner on Donnerstag, 14. März 2024 14:56:12
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core.t_fact_nfpo_advertise_theme_pillar (
nfpo_adv_theme_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''Surrogate Key NFPO ADVERTISING THEME.
            CBX: CNT_PROJECT.REF_NO
            LDL: P_LEW_CORE.T_MDM_ADVERTISE_THEME.MDM_AD_THEME_SID'''),
nfpo_pillar_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''surrogate key, identifier of the pillar in CBX, alternative item grouping, groups item family groups
            CBX:Item/ldlPillar
            ESB:cbxItem/pillar'''),
nfpo_main_pillar_cd STRING(100) NOT NULL
OPTIONS(description='''code of the main pillar
            CBX: CNT_CODELIST.CODE (code list \'PRODUCT_CATEGORY\')'''),
nfpo_item_cnt BIGNUMERIC(38,0)
OPTIONS(description='Item count on granularity adv. theme, pillar and main pillar. Filled from T_FACT_NFPO_ITEM.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='''Creation timestamp of the record in the DWH.
            LDL: P_LEW_CORE.T_MDM_BUYER.DWH_CREATED'''),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='''Timestamp of the last update of the record in the DWH.
            LDL: P_LEW_CORE.T_MDM_BUYER.DWH_UPDATED'''),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_adv_theme_sid, nfpo_pillar_sid, nfpo_main_pillar_cd) NOT ENFORCED
) OPTIONS(description='This fact table holds aggregated metrics on the level advertise theme, pillar and main pillar.');