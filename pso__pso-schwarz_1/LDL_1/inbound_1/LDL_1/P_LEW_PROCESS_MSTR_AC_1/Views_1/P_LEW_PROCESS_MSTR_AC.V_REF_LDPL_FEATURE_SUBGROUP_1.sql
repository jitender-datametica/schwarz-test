create or replace view LDL_PRODUCTION.P_LEW_PROCESS_MSTR_AC.V_REF_LDPL_FEATURE_SUBGROUP_1(
	FEATURE_SUBGROUP_ID COMMENT 'Feature subgroup identifier',
	FEATURE_SUBGROUP_DESC COMMENT 'Feature subgroup description',
	FEATURE_GROUP_ID COMMENT 'Feature_group identifier',
	ACTIVE_FG COMMENT 'Activity Flag',
	FEATURE_SUBGROUP_DESC_AT COMMENT 'Feature subgroup description for lang_cd AT, currently not used',
	FEATURE_SUBGROUP_DESC_BE COMMENT 'Feature subgroup description for lang_cd BE',
	FEATURE_SUBGROUP_DESC_BG COMMENT 'Feature subgroup description for lang_cd BG',
	FEATURE_SUBGROUP_DESC_CH COMMENT 'Feature subgroup description for lang_cd CH, currently not used',
	FEATURE_SUBGROUP_DESC_CS COMMENT 'Feature subgroup description for lang_cd CS',
	FEATURE_SUBGROUP_DESC_CY COMMENT 'Feature subgroup description for lang_cd CY',
	FEATURE_SUBGROUP_DESC_CZ COMMENT 'Feature subgroup description for lang_cd CZ',
	FEATURE_SUBGROUP_DESC_DE COMMENT 'Feature subgroup description for lang_cd DE, currently not used',
	FEATURE_SUBGROUP_DESC_DK COMMENT 'Feature subgroup description for lang_cd DK',
	FEATURE_SUBGROUP_DESC_ES COMMENT 'Feature subgroup description for lang_cd ES',
	FEATURE_SUBGROUP_DESC_FI COMMENT 'Feature subgroup description for lang_cd FI',
	FEATURE_SUBGROUP_DESC_FR COMMENT 'Feature subgroup description for lang_cd FR',
	FEATURE_SUBGROUP_DESC_GB COMMENT 'Feature subgroup description for lang_cd GB',
	FEATURE_SUBGROUP_DESC_GR COMMENT 'Feature subgroup description for lang_cd GR',
	FEATURE_SUBGROUP_DESC_HR COMMENT 'Feature subgroup description for lang_cd HR',
	FEATURE_SUBGROUP_DESC_HU COMMENT 'Feature subgroup description for lang_cd HU',
	FEATURE_SUBGROUP_DESC_IE COMMENT 'Feature subgroup description for lang_cd IE',
	FEATURE_SUBGROUP_DESC_IT COMMENT 'Feature subgroup description for lang_cd IT',
	FEATURE_SUBGROUP_DESC_LT COMMENT 'Feature subgroup description for lang_cd LT',
	FEATURE_SUBGROUP_DESC_LV COMMENT 'Feature subgroup description for lang_cd LV',
	FEATURE_SUBGROUP_DESC_MT COMMENT 'Feature subgroup description for lang_cd MT',
	FEATURE_SUBGROUP_DESC_NI COMMENT 'Feature subgroup description for lang_cd NI',
	FEATURE_SUBGROUP_DESC_NL COMMENT 'Feature subgroup description for lang_cd NL',
	FEATURE_SUBGROUP_DESC_PL COMMENT 'Feature subgroup description for lang_cd PL',
	FEATURE_SUBGROUP_DESC_PT COMMENT 'Feature subgroup description for lang_cd PT',
	FEATURE_SUBGROUP_DESC_RO COMMENT 'Feature subgroup description for lang_cd RO',
	FEATURE_SUBGROUP_DESC_RS COMMENT 'Feature subgroup description for lang_cd RS_1',
	FEATURE_SUBGROUP_DESC_SE COMMENT 'Feature subgroup description for lang_cd SE',
	FEATURE_SUBGROUP_DESC_SI COMMENT 'Feature subgroup description for lang_cd SI',
	FEATURE_SUBGROUP_DESC_SK COMMENT 'Feature subgroup description for lang_cd SK',
	FEATURE_SUBGROUP_DESC_US COMMENT 'Feature subgroup description for lang_cd US',
	DWH_LOAD_ID COMMENT 'Load identifier',
	DWH_CREATED COMMENT 'Row insert time',
	DWH_UPDATED COMMENT 'Row update time'
) as
SELECT
 fs.feature_subgroup_id
,fs.feature_subgroup_desc
,fs.feature_group_id
,fs.active_fg
,COALESCE(lang_desc.feature_subgroup_desc_at, fs.feature_subgroup_desc) AS feature_subgroup_desc_at
,COALESCE(lang_desc.feature_subgroup_desc_be, fs.feature_subgroup_desc) AS feature_subgroup_desc_be
,COALESCE(lang_desc.feature_subgroup_desc_bg, fs.feature_subgroup_desc) AS feature_subgroup_desc_bg
,COALESCE(lang_desc.feature_subgroup_desc_ch, fs.feature_subgroup_desc) AS feature_subgroup_desc_ch
,COALESCE(lang_desc.feature_subgroup_desc_cs, fs.feature_subgroup_desc) AS feature_subgroup_desc_cs
,COALESCE(lang_desc.feature_subgroup_desc_cy, fs.feature_subgroup_desc) AS feature_subgroup_desc_cy
,COALESCE(lang_desc.feature_subgroup_desc_cz, fs.feature_subgroup_desc) AS feature_subgroup_desc_cz
,COALESCE(lang_desc.feature_subgroup_desc_de, fs.feature_subgroup_desc) AS feature_subgroup_desc_de
,COALESCE(lang_desc.feature_subgroup_desc_dk, fs.feature_subgroup_desc) AS feature_subgroup_desc_dk
,COALESCE(lang_desc.feature_subgroup_desc_es, fs.feature_subgroup_desc) AS feature_subgroup_desc_es
,COALESCE(lang_desc.feature_subgroup_desc_fi, fs.feature_subgroup_desc) AS feature_subgroup_desc_fi
,COALESCE(lang_desc.feature_subgroup_desc_fr, fs.feature_subgroup_desc) AS feature_subgroup_desc_fr
,COALESCE(lang_desc.feature_subgroup_desc_gb, fs.feature_subgroup_desc) AS feature_subgroup_desc_gb
,COALESCE(lang_desc.feature_subgroup_desc_gr, fs.feature_subgroup_desc) AS feature_subgroup_desc_gr
,COALESCE(lang_desc.feature_subgroup_desc_hr, fs.feature_subgroup_desc) AS feature_subgroup_desc_hr
,COALESCE(lang_desc.feature_subgroup_desc_hu, fs.feature_subgroup_desc) AS feature_subgroup_desc_hu
,COALESCE(lang_desc.feature_subgroup_desc_ie, fs.feature_subgroup_desc) AS feature_subgroup_desc_ie
,COALESCE(lang_desc.feature_subgroup_desc_it, fs.feature_subgroup_desc) AS feature_subgroup_desc_it
,COALESCE(lang_desc.feature_subgroup_desc_lt, fs.feature_subgroup_desc) AS feature_subgroup_desc_lt
,COALESCE(lang_desc.feature_subgroup_desc_lv, fs.feature_subgroup_desc) AS feature_subgroup_desc_lv
,COALESCE(lang_desc.feature_subgroup_desc_mt, fs.feature_subgroup_desc) AS feature_subgroup_desc_mt
,COALESCE(lang_desc.feature_subgroup_desc_ni, fs.feature_subgroup_desc) AS feature_subgroup_desc_ni
,COALESCE(lang_desc.feature_subgroup_desc_nl, fs.feature_subgroup_desc) AS feature_subgroup_desc_nl
,COALESCE(lang_desc.feature_subgroup_desc_pl, fs.feature_subgroup_desc) AS feature_subgroup_desc_pl
,COALESCE(lang_desc.feature_subgroup_desc_pt, fs.feature_subgroup_desc) AS feature_subgroup_desc_pt
,COALESCE(lang_desc.feature_subgroup_desc_ro, fs.feature_subgroup_desc) AS feature_subgroup_desc_ro
,COALESCE(lang_desc.feature_subgroup_desc_rs, fs.feature_subgroup_desc) AS feature_subgroup_desc_rs
,COALESCE(lang_desc.feature_subgroup_desc_se, fs.feature_subgroup_desc) AS feature_subgroup_desc_se
,COALESCE(lang_desc.feature_subgroup_desc_si, fs.feature_subgroup_desc) AS feature_subgroup_desc_si
,COALESCE(lang_desc.feature_subgroup_desc_sk, fs.feature_subgroup_desc) AS feature_subgroup_desc_sk
,COALESCE(lang_desc.feature_subgroup_desc_us, fs.feature_subgroup_desc) AS feature_subgroup_desc_us
,fs.dwh_load_id
,fs.dwh_created
,fs.dwh_updated
FROM P_LEW_PROCESS_MSTR.V_REF_LDPL_FEATURE_SUBGROUP_1 AS FS
LEFT JOIN (
    SELECT 
     feature_subgroup_id
    ,""'AT'"" AS feature_subgroup_desc_at
    ,""'BE'"" AS feature_subgroup_desc_be
    ,""'BG'"" AS feature_subgroup_desc_bg
    ,""'CH'"" AS feature_subgroup_desc_ch
    ,""'CS'"" AS feature_subgroup_desc_cs
    ,""'CY'"" AS feature_subgroup_desc_cy
    ,""'CZ'"" AS feature_subgroup_desc_cz
    ,""'DE'"" AS feature_subgroup_desc_de
    ,""'DK'"" AS feature_subgroup_desc_dk
    ,""'ES'"" AS feature_subgroup_desc_es
    ,""'FI'"" AS feature_subgroup_desc_fi
    ,""'FR'"" AS feature_subgroup_desc_fr
    ,""'GB'"" AS feature_subgroup_desc_gb
    ,""'GR'"" AS feature_subgroup_desc_gr
    ,""'HR'"" AS feature_subgroup_desc_hr
    ,""'HU'"" AS feature_subgroup_desc_hu
    ,""'IE'"" AS feature_subgroup_desc_ie
    ,""'IT'"" AS feature_subgroup_desc_it
    ,""'LT'"" AS feature_subgroup_desc_lt
    ,""'LV'"" AS feature_subgroup_desc_lv
    ,""'MT'"" AS feature_subgroup_desc_mt
    ,""'NI'"" AS feature_subgroup_desc_ni
    ,""'NL'"" AS feature_subgroup_desc_nl
    ,""'PL'"" AS feature_subgroup_desc_pl
    ,""'PT'"" AS feature_subgroup_desc_pt
    ,""'RO'"" AS feature_subgroup_desc_ro
    ,""'RS_1'"" AS feature_subgroup_desc_rs
    ,""'SE'"" AS feature_subgroup_desc_se
    ,""'SI'"" AS feature_subgroup_desc_si
    ,""'SK'"" AS feature_subgroup_desc_sk
    ,""'US'"" AS feature_subgroup_desc_us
    FROM (
            SELECT 
             feature_subgroup_id
            ,feature_subgroup_desc
            ,lang_cd 
            FROM P_LEW_PROCESS_MSTR.V_REF_LDPL_FEATURE_SUBGROUP_DESC_1
            ) AS limited_columns
    PIVOT (
        MAX(feature_subgroup_desc) FOR lang_cd IN (
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
 ON lang_desc.feature_subgroup_id = fs.feature_subgroup_id   
;
