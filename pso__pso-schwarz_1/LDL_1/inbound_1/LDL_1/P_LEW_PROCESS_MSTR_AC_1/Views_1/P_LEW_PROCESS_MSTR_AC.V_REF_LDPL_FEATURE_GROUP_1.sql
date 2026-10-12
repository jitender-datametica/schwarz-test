create or replace view LDL_PRODUCTION.P_LEW_PROCESS_MSTR_AC.V_REF_LDPL_FEATURE_GROUP_1(
	LOYALTY_ID COMMENT 'Loyalty atrtibute identifier',
	FEATURE_GROUP_ID COMMENT 'Feature_group identifier',
	FEATURE_GROUP_DESC COMMENT 'Feature_group description',
	ACTIVE_FG COMMENT 'Activity Flag',
	FEATURE_GROUP_DESC_AT COMMENT 'Feature group description for lang_cd AT, currently not used',
	FEATURE_GROUP_DESC_BE COMMENT 'Feature group description for lang_cd BE',
	FEATURE_GROUP_DESC_BG COMMENT 'Feature group description for lang_cd BG',
	FEATURE_GROUP_DESC_CH COMMENT 'Feature group description for lang_cd CH, currently not used',
	FEATURE_GROUP_DESC_CS COMMENT 'Feature group description for lang_cd CS',
	FEATURE_GROUP_DESC_CY COMMENT 'Feature group description for lang_cd CY',
	FEATURE_GROUP_DESC_CZ COMMENT 'Feature group description for lang_cd CZ',
	FEATURE_GROUP_DESC_DE COMMENT 'Feature group description for lang_cd DE, currently not used',
	FEATURE_GROUP_DESC_DK COMMENT 'Feature group description for lang_cd DK',
	FEATURE_GROUP_DESC_ES COMMENT 'Feature group description for lang_cd ES',
	FEATURE_GROUP_DESC_FI COMMENT 'Feature group description for lang_cd FI',
	FEATURE_GROUP_DESC_FR COMMENT 'Feature group description for lang_cd FR',
	FEATURE_GROUP_DESC_GB COMMENT 'Feature group description for lang_cd GB',
	FEATURE_GROUP_DESC_GR COMMENT 'Feature group description for lang_cd GR',
	FEATURE_GROUP_DESC_HR COMMENT 'Feature group description for lang_cd HR',
	FEATURE_GROUP_DESC_HU COMMENT 'Feature group description for lang_cd HU',
	FEATURE_GROUP_DESC_IE COMMENT 'Feature group description for lang_cd IE',
	FEATURE_GROUP_DESC_IT COMMENT 'Feature group description for lang_cd IT',
	FEATURE_GROUP_DESC_LT COMMENT 'Feature group description for lang_cd LT',
	FEATURE_GROUP_DESC_LV COMMENT 'Feature group description for lang_cd LV',
	FEATURE_GROUP_DESC_MT COMMENT 'Feature group description for lang_cd MT',
	FEATURE_GROUP_DESC_NI COMMENT 'Feature group description for lang_cd NI',
	FEATURE_GROUP_DESC_NL COMMENT 'Feature group description for lang_cd NL',
	FEATURE_GROUP_DESC_PL COMMENT 'Feature group description for lang_cd PL',
	FEATURE_GROUP_DESC_PT COMMENT 'Feature group description for lang_cd PT',
	FEATURE_GROUP_DESC_RO COMMENT 'Feature group description for lang_cd RO',
	FEATURE_GROUP_DESC_RS COMMENT 'Feature group description for lang_cd RS_1',
	FEATURE_GROUP_DESC_SE COMMENT 'Feature group description for lang_cd SE',
	FEATURE_GROUP_DESC_SI COMMENT 'Feature group description for lang_cd SI',
	FEATURE_GROUP_DESC_SK COMMENT 'Feature group description for lang_cd SK',
	FEATURE_GROUP_DESC_US COMMENT 'Feature group description for lang_cd US',
	DWH_LOAD_ID COMMENT 'Load identifier',
	DWH_CREATED COMMENT 'Row insert time',
	DWH_UPDATED COMMENT 'Row update time'
) as
SELECT
 fs.loyalty_id
,fs.feature_group_id
,fs.feature_group_desc
,fs.active_fg
,COALESCE(lang_desc.feature_group_desc_at, fs.feature_group_desc) AS feature_group_desc_at
,COALESCE(lang_desc.feature_group_desc_be, fs.feature_group_desc) AS feature_group_desc_be
,COALESCE(lang_desc.feature_group_desc_bg, fs.feature_group_desc) AS feature_group_desc_bg
,COALESCE(lang_desc.feature_group_desc_ch, fs.feature_group_desc) AS feature_group_desc_ch
,COALESCE(lang_desc.feature_group_desc_cs, fs.feature_group_desc) AS feature_group_desc_cs
,COALESCE(lang_desc.feature_group_desc_cy, fs.feature_group_desc) AS feature_group_desc_cy
,COALESCE(lang_desc.feature_group_desc_cz, fs.feature_group_desc) AS feature_group_desc_cz
,COALESCE(lang_desc.feature_group_desc_de, fs.feature_group_desc) AS feature_group_desc_de
,COALESCE(lang_desc.feature_group_desc_dk, fs.feature_group_desc) AS feature_group_desc_dk
,COALESCE(lang_desc.feature_group_desc_es, fs.feature_group_desc) AS feature_group_desc_es
,COALESCE(lang_desc.feature_group_desc_fi, fs.feature_group_desc) AS feature_group_desc_fi
,COALESCE(lang_desc.feature_group_desc_fr, fs.feature_group_desc) AS feature_group_desc_fr
,COALESCE(lang_desc.feature_group_desc_gb, fs.feature_group_desc) AS feature_group_desc_gb
,COALESCE(lang_desc.feature_group_desc_gr, fs.feature_group_desc) AS feature_group_desc_gr
,COALESCE(lang_desc.feature_group_desc_hr, fs.feature_group_desc) AS feature_group_desc_hr
,COALESCE(lang_desc.feature_group_desc_hu, fs.feature_group_desc) AS feature_group_desc_hu
,COALESCE(lang_desc.feature_group_desc_ie, fs.feature_group_desc) AS feature_group_desc_ie
,COALESCE(lang_desc.feature_group_desc_it, fs.feature_group_desc) AS feature_group_desc_it
,COALESCE(lang_desc.feature_group_desc_lt, fs.feature_group_desc) AS feature_group_desc_lt
,COALESCE(lang_desc.feature_group_desc_lv, fs.feature_group_desc) AS feature_group_desc_lv
,COALESCE(lang_desc.feature_group_desc_mt, fs.feature_group_desc) AS feature_group_desc_mt
,COALESCE(lang_desc.feature_group_desc_ni, fs.feature_group_desc) AS feature_group_desc_ni
,COALESCE(lang_desc.feature_group_desc_nl, fs.feature_group_desc) AS feature_group_desc_nl
,COALESCE(lang_desc.feature_group_desc_pl, fs.feature_group_desc) AS feature_group_desc_pl
,COALESCE(lang_desc.feature_group_desc_pt, fs.feature_group_desc) AS feature_group_desc_pt
,COALESCE(lang_desc.feature_group_desc_ro, fs.feature_group_desc) AS feature_group_desc_ro
,COALESCE(lang_desc.feature_group_desc_rs, fs.feature_group_desc) AS feature_group_desc_rs
,COALESCE(lang_desc.feature_group_desc_se, fs.feature_group_desc) AS feature_group_desc_se
,COALESCE(lang_desc.feature_group_desc_si, fs.feature_group_desc) AS feature_group_desc_si
,COALESCE(lang_desc.feature_group_desc_sk, fs.feature_group_desc) AS feature_group_desc_sk
,COALESCE(lang_desc.feature_group_desc_us, fs.feature_group_desc) AS feature_group_desc_us
,fs.dwh_load_id
,fs.dwh_created
,fs.dwh_updated
FROM P_LEW_PROCESS_MSTR.V_REF_LDPL_FEATURE_GROUP_1 AS FS
LEFT JOIN (
    SELECT 
     feature_group_id
    ,""'AT'"" AS feature_group_desc_at
    ,""'BE'"" AS feature_group_desc_be
    ,""'BG'"" AS feature_group_desc_bg
    ,""'CH'"" AS feature_group_desc_ch
    ,""'CS'"" AS feature_group_desc_cs
    ,""'CY'"" AS feature_group_desc_cy
    ,""'CZ'"" AS feature_group_desc_cz
    ,""'DE'"" AS feature_group_desc_de
    ,""'DK'"" AS feature_group_desc_dk
    ,""'ES'"" AS feature_group_desc_es
    ,""'FI'"" AS feature_group_desc_fi
    ,""'FR'"" AS feature_group_desc_fr
    ,""'GB'"" AS feature_group_desc_gb
    ,""'GR'"" AS feature_group_desc_gr
    ,""'HR'"" AS feature_group_desc_hr
    ,""'HU'"" AS feature_group_desc_hu
    ,""'IE'"" AS feature_group_desc_ie
    ,""'IT'"" AS feature_group_desc_it
    ,""'LT'"" AS feature_group_desc_lt
    ,""'LV'"" AS feature_group_desc_lv
    ,""'MT'"" AS feature_group_desc_mt
    ,""'NI'"" AS feature_group_desc_ni
    ,""'NL'"" AS feature_group_desc_nl
    ,""'PL'"" AS feature_group_desc_pl
    ,""'PT'"" AS feature_group_desc_pt
    ,""'RO'"" AS feature_group_desc_ro
    ,""'RS_1'"" AS feature_group_desc_rs
    ,""'SE'"" AS feature_group_desc_se
    ,""'SI'"" AS feature_group_desc_si
    ,""'SK'"" AS feature_group_desc_sk
    ,""'US'"" AS feature_group_desc_us
    FROM (
            SELECT 
             feature_group_id
            ,feature_group_desc
            ,lang_cd 
            FROM P_LEW_PROCESS_MSTR.V_REF_LDPL_FEATURE_GROUP_DESC_1
            ) AS limited_columns
    PIVOT (
        MAX(feature_group_desc) FOR lang_cd IN (
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
 ON lang_desc.feature_group_id = fs.feature_group_id   
;
