CREATE OR REPLACE VIEW FE_MSTR_EKPSNF.V_FACT_NFPO_ADVERTISE_THEME_PILLAR_1(
     nfpo_adv_theme_sid
    ,nfpo_pillar_sid
    ,nfpo_main_pillar_cd
    ,nfpo_item_cnt
    ,dwh_created_tmsp
    ,dwh_updated_tmsp
    ,dwh_src_tmsp
	
) AS
(SELECT
     nfpo_adv_theme_sid
    ,nfpo_pillar_sid
    ,nfpo_main_pillar_cd
    ,nfpo_item_cnt
    ,dwh_created_tmsp
    ,dwh_updated_tmsp
    ,dwh_src_tmsp

FROM CORE.T_FACT_NFPO_ADVERTISE_THEME_PILLAR_1
);
