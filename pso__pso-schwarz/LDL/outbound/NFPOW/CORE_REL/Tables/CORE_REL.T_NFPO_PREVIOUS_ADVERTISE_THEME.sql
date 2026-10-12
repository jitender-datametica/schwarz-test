/* --------------------------------------------------------------------------------
   DDL for table: t_nfpo_previous_advertise_theme
   generated from Powerdesigner on Dienstag, 24. Oktober 2023 13:10:42
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_nfpo_previous_advertise_theme (
nfpo_adv_theme_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate Key NFPO ADVERTISING THEME.            CBX: CNT_PROJECT.REF_NO            LDL: P_LEW_CORE.T_MDM_ADVERTISE_THEME.MDM_AD_THEME_SID'),
nfpo_prev_adv_theme_lvl_nr BIGNUMERIC(38,0) NOT NULL,
nfpo_prev_adv_theme_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate Key NFPO ADVERTISING THEME.            CBX: CNT_PROJECT.REF_NO            LDL: P_LEW_CORE.T_MDM_ADVERTISE_THEME.MDM_AD_THEME_SID'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Creation timestamp of the record in the DWH.            LDL: P_LEW_CORE.T_MDM_ITEM.DWH_CREATED'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last update of the record in the DWH.            LDL: P_LEW_CORE.T_MDM_ITEM.DWH_UPDATED'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_adv_theme_sid, nfpo_prev_adv_theme_lvl_nr) NOT ENFORCED
) OPTIONS(description='NFPO previous (predecessor) advertise themes, all levels available.');