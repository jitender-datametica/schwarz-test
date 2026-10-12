/*
#----------------------------------------------------------------------------
# Coupon Type
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2021-12-15 Pawel Wieczorek          SD-2524 Initial version
#  1.1 2022-02-08 Marcin Kikola	           Add translation
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_PROCESS_MSTR_AC.V_REF_LDPL_COUPON_TYPE_SUBGROUP_1
COMMENT = 'Lidl Plus Coupon Type Subgroup'
(
 coupon_type_subgroup_id       COMMENT 'Coupon type subgroup identifier'
,coupon_type_subgroup_desc     COMMENT 'Coupon type subgroup description'                  
,coupon_type_group_id          COMMENT 'Coupon type group description' 
,active_fg                     COMMENT 'Activity Flag'
,coupon_type_subgroup_desc_at  COMMENT 'coupon subgroup description for lang_cd AT, currently not used'
,coupon_type_subgroup_desc_be  COMMENT 'coupon subgroup description for lang_cd BE'
,coupon_type_subgroup_desc_bg  COMMENT 'coupon subgroup description for lang_cd BG'
,coupon_type_subgroup_desc_ch  COMMENT 'coupon subgroup description for lang_cd CH, currently not used'
,coupon_type_subgroup_desc_cs  COMMENT 'coupon subgroup description for lang_cd CS'
,coupon_type_subgroup_desc_cy  COMMENT 'coupon subgroup description for lang_cd CY'
,coupon_type_subgroup_desc_cz  COMMENT 'coupon subgroup description for lang_cd CZ'
,coupon_type_subgroup_desc_de  COMMENT 'coupon subgroup description for lang_cd DE, currently not used'
,coupon_type_subgroup_desc_dk  COMMENT 'coupon subgroup description for lang_cd DK'
,coupon_type_subgroup_desc_es  COMMENT 'coupon subgroup description for lang_cd ES'
,coupon_type_subgroup_desc_fi  COMMENT 'coupon subgroup description for lang_cd FI'
,coupon_type_subgroup_desc_fr  COMMENT 'coupon subgroup description for lang_cd FR'
,coupon_type_subgroup_desc_gb  COMMENT 'coupon subgroup description for lang_cd GB'
,coupon_type_subgroup_desc_gr  COMMENT 'coupon subgroup description for lang_cd GR'
,coupon_type_subgroup_desc_hr  COMMENT 'coupon subgroup description for lang_cd HR'
,coupon_type_subgroup_desc_hu  COMMENT 'coupon subgroup description for lang_cd HU'
,coupon_type_subgroup_desc_ie  COMMENT 'coupon subgroup description for lang_cd IE'
,coupon_type_subgroup_desc_it  COMMENT 'coupon subgroup description for lang_cd IT'
,coupon_type_subgroup_desc_lt  COMMENT 'coupon subgroup description for lang_cd LT'
,coupon_type_subgroup_desc_lv  COMMENT 'coupon subgroup description for lang_cd LV'
,coupon_type_subgroup_desc_mt  COMMENT 'coupon subgroup description for lang_cd MT'
,coupon_type_subgroup_desc_ni  COMMENT 'coupon subgroup description for lang_cd NI'
,coupon_type_subgroup_desc_nl  COMMENT 'coupon subgroup description for lang_cd NL'
,coupon_type_subgroup_desc_pl  COMMENT 'coupon subgroup description for lang_cd PL'
,coupon_type_subgroup_desc_pt  COMMENT 'coupon subgroup description for lang_cd PT'
,coupon_type_subgroup_desc_ro  COMMENT 'coupon subgroup description for lang_cd RO'
,coupon_type_subgroup_desc_rs  COMMENT 'coupon subgroup description for lang_cd RS_1'
,coupon_type_subgroup_desc_se  COMMENT 'coupon subgroup description for lang_cd SE'
,coupon_type_subgroup_desc_si  COMMENT 'coupon subgroup description for lang_cd SI'
,coupon_type_subgroup_desc_sk  COMMENT 'coupon subgroup description for lang_cd SK'
,coupon_type_subgroup_desc_us  COMMENT 'coupon subgroup description for lang_cd US' 
,dwh_load_id                   COMMENT 'Load identifier'            
,dwh_created                   COMMENT 'Row insert time'           
,dwh_updated                   COMMENT 'Row update time'            
)
AS
SELECT
 cs.coupon_type_subgroup_id  
,cs.coupon_type_subgroup_desc
,cs.coupon_type_group_id
,active_fg     
,COALESCE(lang_desc.coupon_type_subgroup_at, cs.coupon_type_subgroup_desc) AS coupon_type_subgroup_desc_at
,COALESCE(lang_desc.coupon_type_subgroup_be, cs.coupon_type_subgroup_desc) AS coupon_type_subgroup_desc_be
,COALESCE(lang_desc.coupon_type_subgroup_bg, cs.coupon_type_subgroup_desc) AS coupon_type_subgroup_desc_bg
,COALESCE(lang_desc.coupon_type_subgroup_ch, cs.coupon_type_subgroup_desc) AS coupon_type_subgroup_desc_ch
,COALESCE(lang_desc.coupon_type_subgroup_cs, cs.coupon_type_subgroup_desc) AS coupon_type_subgroup_desc_cs
,COALESCE(lang_desc.coupon_type_subgroup_cy, cs.coupon_type_subgroup_desc) AS coupon_type_subgroup_desc_cy
,COALESCE(lang_desc.coupon_type_subgroup_cz, cs.coupon_type_subgroup_desc) AS coupon_type_subgroup_desc_cz
,COALESCE(lang_desc.coupon_type_subgroup_de, cs.coupon_type_subgroup_desc) AS coupon_type_subgroup_desc_de
,COALESCE(lang_desc.coupon_type_subgroup_dk, cs.coupon_type_subgroup_desc) AS coupon_type_subgroup_desc_dk
,COALESCE(lang_desc.coupon_type_subgroup_es, cs.coupon_type_subgroup_desc) AS coupon_type_subgroup_desc_es
,COALESCE(lang_desc.coupon_type_subgroup_fi, cs.coupon_type_subgroup_desc) AS coupon_type_subgroup_desc_fi
,COALESCE(lang_desc.coupon_type_subgroup_fr, cs.coupon_type_subgroup_desc) AS coupon_type_subgroup_desc_fr
,COALESCE(lang_desc.coupon_type_subgroup_gb, cs.coupon_type_subgroup_desc) AS coupon_type_subgroup_desc_gb
,COALESCE(lang_desc.coupon_type_subgroup_gr, cs.coupon_type_subgroup_desc) AS coupon_type_subgroup_desc_gr
,COALESCE(lang_desc.coupon_type_subgroup_hr, cs.coupon_type_subgroup_desc) AS coupon_type_subgroup_desc_hr
,COALESCE(lang_desc.coupon_type_subgroup_hu, cs.coupon_type_subgroup_desc) AS coupon_type_subgroup_desc_hu
,COALESCE(lang_desc.coupon_type_subgroup_ie, cs.coupon_type_subgroup_desc) AS coupon_type_subgroup_desc_ie
,COALESCE(lang_desc.coupon_type_subgroup_it, cs.coupon_type_subgroup_desc) AS coupon_type_subgroup_desc_it
,COALESCE(lang_desc.coupon_type_subgroup_lt, cs.coupon_type_subgroup_desc) AS coupon_type_subgroup_desc_lt
,COALESCE(lang_desc.coupon_type_subgroup_lv, cs.coupon_type_subgroup_desc) AS coupon_type_subgroup_desc_lv
,COALESCE(lang_desc.coupon_type_subgroup_mt, cs.coupon_type_subgroup_desc) AS coupon_type_subgroup_desc_mt
,COALESCE(lang_desc.coupon_type_subgroup_ni, cs.coupon_type_subgroup_desc) AS coupon_type_subgroup_desc_ni
,COALESCE(lang_desc.coupon_type_subgroup_nl, cs.coupon_type_subgroup_desc) AS coupon_type_subgroup_desc_nl
,COALESCE(lang_desc.coupon_type_subgroup_pl, cs.coupon_type_subgroup_desc) AS coupon_type_subgroup_desc_pl
,COALESCE(lang_desc.coupon_type_subgroup_pt, cs.coupon_type_subgroup_desc) AS coupon_type_subgroup_desc_pt
,COALESCE(lang_desc.coupon_type_subgroup_ro, cs.coupon_type_subgroup_desc) AS coupon_type_subgroup_desc_ro
,COALESCE(lang_desc.coupon_type_subgroup_rs, cs.coupon_type_subgroup_desc) AS coupon_type_subgroup_desc_rs
,COALESCE(lang_desc.coupon_type_subgroup_se, cs.coupon_type_subgroup_desc) AS coupon_type_subgroup_desc_se
,COALESCE(lang_desc.coupon_type_subgroup_si, cs.coupon_type_subgroup_desc) AS coupon_type_subgroup_desc_si
,COALESCE(lang_desc.coupon_type_subgroup_sk, cs.coupon_type_subgroup_desc) AS coupon_type_subgroup_desc_sk
,COALESCE(lang_desc.coupon_type_subgroup_us, cs.coupon_type_subgroup_desc) AS coupon_type_subgroup_desc_us
,cs.dwh_load_id
,cs.dwh_created
,cs.dwh_updated
FROM P_LEW_PROCESS_MSTR.V_REF_LDPL_COUPON_TYPE_SUBGROUP_1 AS cs
LEFT JOIN (
    SELECT 
     coupon_type_subgroup_id
    ,"'AT'" AS coupon_type_subgroup_at
    ,"'BE'" AS coupon_type_subgroup_be
    ,"'BG'" AS coupon_type_subgroup_bg
    ,"'CH'" AS coupon_type_subgroup_ch
    ,"'CS'" AS coupon_type_subgroup_cs
    ,"'CY'" AS coupon_type_subgroup_cy
    ,"'CZ'" AS coupon_type_subgroup_cz
    ,"'DE'" AS coupon_type_subgroup_de
    ,"'DK'" AS coupon_type_subgroup_dk
    ,"'ES'" AS coupon_type_subgroup_es
    ,"'FI'" AS coupon_type_subgroup_fi
    ,"'FR'" AS coupon_type_subgroup_fr
    ,"'GB'" AS coupon_type_subgroup_gb
    ,"'GR'" AS coupon_type_subgroup_gr
    ,"'HR'" AS coupon_type_subgroup_hr
    ,"'HU'" AS coupon_type_subgroup_hu
    ,"'IE'" AS coupon_type_subgroup_ie
    ,"'IT'" AS coupon_type_subgroup_it
    ,"'LT'" AS coupon_type_subgroup_lt
    ,"'LV'" AS coupon_type_subgroup_lv
    ,"'MT'" AS coupon_type_subgroup_mt
    ,"'NI'" AS coupon_type_subgroup_ni
    ,"'NL'" AS coupon_type_subgroup_nl
    ,"'PL'" AS coupon_type_subgroup_pl
    ,"'PT'" AS coupon_type_subgroup_pt
    ,"'RO'" AS coupon_type_subgroup_ro
    ,"'RS_1'" AS coupon_type_subgroup_rs
    ,"'SE'" AS coupon_type_subgroup_se
    ,"'SI'" AS coupon_type_subgroup_si
    ,"'SK'" AS coupon_type_subgroup_sk
    ,"'US'" AS coupon_type_subgroup_us
    FROM (
            SELECT 
             coupon_type_subgroup_id
            ,coupon_type_subgroup_desc
            ,lang_cd 
            FROM P_LEW_PROCESS_MSTR.V_REF_LDPL_COUPON_TYPE_SUBGROUP_DESC_1
            ) AS limited_columns
    PIVOT (
        MAX(coupon_type_subgroup_desc) FOR lang_cd IN (
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
 ON lang_desc.coupon_type_subgroup_id = cs.coupon_type_subgroup_id   
;

