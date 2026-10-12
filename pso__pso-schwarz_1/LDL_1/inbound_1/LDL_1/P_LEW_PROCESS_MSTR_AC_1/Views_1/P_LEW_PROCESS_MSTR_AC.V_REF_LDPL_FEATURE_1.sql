create or replace view LDL_PRODUCTION.P_LEW_PROCESS_MSTR_AC.V_REF_LDPL_FEATURE_1(
	FEATURE_ID COMMENT 'Feature identifier',
	FEATURE_SUBGROUP_ID COMMENT 'Feature subgroup description',
	FEATURE_DESC COMMENT 'Default feature type description, which is not exactly the SCRM value from in P_LEW_PROCESS_MSTR.T_REF_LDPL_FEATURE_TYPE.feature_type_desc',
	FEATURE_DESC_AT COMMENT 'Feature description for lang_cd AT, currently not used',
	FEATURE_DESC_BE COMMENT 'Feature description for lang_cd BE',
	FEATURE_DESC_BG COMMENT 'Feature description for lang_cd BG',
	FEATURE_DESC_CH COMMENT 'Feature description for lang_cd CH, currently not used',
	FEATURE_DESC_CS COMMENT 'Feature description for lang_cd CS',
	FEATURE_DESC_CY COMMENT 'Feature description for lang_cd CY',
	FEATURE_DESC_CZ COMMENT 'Feature description for lang_cd CZ',
	FEATURE_DESC_DE COMMENT 'Feature description for lang_cd DE, currently not used',
	FEATURE_DESC_DK COMMENT 'Feature description for lang_cd DK',
	FEATURE_DESC_ES COMMENT 'Feature description for lang_cd ES',
	FEATURE_DESC_FI COMMENT 'Feature description for lang_cd FI',
	FEATURE_DESC_FR COMMENT 'Feature description for lang_cd FR',
	FEATURE_DESC_GB COMMENT 'Feature description for lang_cd GB',
	FEATURE_DESC_GR COMMENT 'Feature description for lang_cd GR',
	FEATURE_DESC_HR COMMENT 'Feature description for lang_cd HR',
	FEATURE_DESC_HU COMMENT 'Feature description for lang_cd HU',
	FEATURE_DESC_IE COMMENT 'Feature description for lang_cd IE',
	FEATURE_DESC_IT COMMENT 'Feature description for lang_cd IT',
	FEATURE_DESC_LT COMMENT 'Feature description for lang_cd LT',
	FEATURE_DESC_LV COMMENT 'Feature description for lang_cd LV',
	FEATURE_DESC_MT COMMENT 'Feature description for lang_cd MT',
	FEATURE_DESC_NI COMMENT 'Feature description for lang_cd NI',
	FEATURE_DESC_NL COMMENT 'Feature description for lang_cd NL',
	FEATURE_DESC_PL COMMENT 'Feature description for lang_cd PL',
	FEATURE_DESC_PT COMMENT 'Feature description for lang_cd PT',
	FEATURE_DESC_RO COMMENT 'Feature description for lang_cd RO',
	FEATURE_DESC_RS COMMENT 'Feature description for lang_cd RS_1',
	FEATURE_DESC_SE COMMENT 'Feature description for lang_cd SE',
	FEATURE_DESC_SI COMMENT 'Feature description for lang_cd SI',
	FEATURE_DESC_SK COMMENT 'Feature description for lang_cd SK',
	FEATURE_DESC_US COMMENT 'Feature description for lang_cd US',
	DWH_LOAD_ID COMMENT 'Load identifier',
	DWH_CREATED COMMENT 'Row insert time',
	DWH_UPDATED COMMENT 'Row update time'
) as
SELECT
 f.feature_id
,f.feature_subgroup_id
,COALESCE(lang_desc.feature_desc_de,f.feature_desc) AS feature_desc
,COALESCE(lang_desc.feature_desc_at,lang_desc.feature_desc_de, f.feature_desc) AS feature_desc_at
,COALESCE(lang_desc.feature_desc_be,lang_desc.feature_desc_de, f.feature_desc) AS feature_desc_be
,COALESCE(lang_desc.feature_desc_bg,lang_desc.feature_desc_de, f.feature_desc) AS feature_desc_bg
,COALESCE(lang_desc.feature_desc_ch,lang_desc.feature_desc_de, f.feature_desc) AS feature_desc_ch
,COALESCE(lang_desc.feature_desc_cs,lang_desc.feature_desc_de, f.feature_desc) AS feature_desc_cs
,COALESCE(lang_desc.feature_desc_cy,lang_desc.feature_desc_de, f.feature_desc) AS feature_desc_cy
,COALESCE(lang_desc.feature_desc_cz,lang_desc.feature_desc_de, f.feature_desc) AS feature_desc_cz
,COALESCE(lang_desc.feature_desc_de,lang_desc.feature_desc_de, f.feature_desc) AS feature_desc_de
,COALESCE(lang_desc.feature_desc_dk,lang_desc.feature_desc_de, f.feature_desc) AS feature_desc_dk
,COALESCE(lang_desc.feature_desc_es,lang_desc.feature_desc_de, f.feature_desc) AS feature_desc_es
,COALESCE(lang_desc.feature_desc_fi,lang_desc.feature_desc_de, f.feature_desc) AS feature_desc_fi
,COALESCE(lang_desc.feature_desc_fr,lang_desc.feature_desc_de, f.feature_desc) AS feature_desc_fr
,COALESCE(lang_desc.feature_desc_gb,lang_desc.feature_desc_de, f.feature_desc) AS feature_desc_gb
,COALESCE(lang_desc.feature_desc_gr,lang_desc.feature_desc_de, f.feature_desc) AS feature_desc_gr
,COALESCE(lang_desc.feature_desc_hr,lang_desc.feature_desc_de, f.feature_desc) AS feature_desc_hr
,COALESCE(lang_desc.feature_desc_hu,lang_desc.feature_desc_de, f.feature_desc) AS feature_desc_hu
,COALESCE(lang_desc.feature_desc_ie,lang_desc.feature_desc_de, f.feature_desc) AS feature_desc_ie
,COALESCE(lang_desc.feature_desc_it,lang_desc.feature_desc_de, f.feature_desc) AS feature_desc_it
,COALESCE(lang_desc.feature_desc_lt,lang_desc.feature_desc_de, f.feature_desc) AS feature_desc_lt
,COALESCE(lang_desc.feature_desc_lv,lang_desc.feature_desc_de, f.feature_desc) AS feature_desc_lv
,COALESCE(lang_desc.feature_desc_mt,lang_desc.feature_desc_de, f.feature_desc) AS feature_desc_mt
,COALESCE(lang_desc.feature_desc_ni,lang_desc.feature_desc_de, f.feature_desc) AS feature_desc_ni
,COALESCE(lang_desc.feature_desc_nl,lang_desc.feature_desc_de, f.feature_desc) AS feature_desc_nl
,COALESCE(lang_desc.feature_desc_pl,lang_desc.feature_desc_de, f.feature_desc) AS feature_desc_pl
,COALESCE(lang_desc.feature_desc_pt,lang_desc.feature_desc_de, f.feature_desc) AS feature_desc_pt
,COALESCE(lang_desc.feature_desc_ro,lang_desc.feature_desc_de, f.feature_desc) AS feature_desc_ro
,COALESCE(lang_desc.feature_desc_rs,lang_desc.feature_desc_de, f.feature_desc) AS feature_desc_rs
,COALESCE(lang_desc.feature_desc_se,lang_desc.feature_desc_de, f.feature_desc) AS feature_desc_se
,COALESCE(lang_desc.feature_desc_si,lang_desc.feature_desc_de, f.feature_desc) AS feature_desc_si
,COALESCE(lang_desc.feature_desc_sk,lang_desc.feature_desc_de, f.feature_desc) AS feature_desc_sk
,COALESCE(lang_desc.feature_desc_us,lang_desc.feature_desc_de, f.feature_desc) AS feature_desc_us
,f.dwh_load_id
,f.dwh_created
,f.dwh_updated
FROM P_LEW_PROCESS_MSTR.V_REF_LDPL_FEATURE_1 AS f
LEFT JOIN (
    SELECT 
     feature_id
    ,""'AT'"" AS feature_desc_at
    ,""'BE'"" AS feature_desc_be
    ,""'BG'"" AS feature_desc_bg
    ,""'CH'"" AS feature_desc_ch
    ,""'CS'"" AS feature_desc_cs
    ,""'CY'"" AS feature_desc_cy
    ,""'CZ'"" AS feature_desc_cz
    ,""'DE'"" AS feature_desc_de
    ,""'DK'"" AS feature_desc_dk
    ,""'ES'"" AS feature_desc_es
    ,""'FI'"" AS feature_desc_fi
    ,""'FR'"" AS feature_desc_fr
    ,""'GB'"" AS feature_desc_gb
    ,""'GR'"" AS feature_desc_gr
    ,""'HR'"" AS feature_desc_hr
    ,""'HU'"" AS feature_desc_hu
    ,""'IE'"" AS feature_desc_ie
    ,""'IT'"" AS feature_desc_it
    ,""'LT'"" AS feature_desc_lt
    ,""'LV'"" AS feature_desc_lv
    ,""'MT'"" AS feature_desc_mt
    ,""'NI'"" AS feature_desc_ni
    ,""'NL'"" AS feature_desc_nl
    ,""'PL'"" AS feature_desc_pl
    ,""'PT'"" AS feature_desc_pt
    ,""'RO'"" AS feature_desc_ro
    ,""'RS_1'"" AS feature_desc_rs
    ,""'SE'"" AS feature_desc_se
    ,""'SI'"" AS feature_desc_si
    ,""'SK'"" AS feature_desc_sk
    ,""'US'"" AS feature_desc_us
    FROM (
            SELECT 
             feature_id
            ,feature_desc
            ,lang_cd 
            FROM p_lew_process_mstr.v_ref_ldpl_feature_desc_1 
          ) AS limited_columns
    PIVOT (
        MAX(feature_desc) FOR lang_cd IN (
                     'AT'
                    ,'BE'
                    ,'BG'
                    ,'CH'
                    ,'CS'
                    ,'CY'
                    ,'CZ'
                    ,'DE'
                    ,'DK'
                    ,'ES'
                    ,'FI'
                    ,'FR'
                    ,'GB'
                    ,'GR'
                    ,'HR'
                    ,'HU'
                    ,'IE'
                    ,'IT'
                    ,'LT'
                    ,'LV'
                    ,'MT'
                    ,'NI'
                    ,'NL'
                    ,'PL'
                    ,'PT'
                    ,'RO'
                    ,'RS_1'
                    ,'SE'
                    ,'SI'
                    ,'SK'
                    ,'US'          
                )
          )
  ) lang_desc
 ON lang_desc.feature_id = f.feature_id
;
