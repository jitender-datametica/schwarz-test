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

CREATE OR REPLACE VIEW P_LEW_PROCESS_MSTR_AC.V_REF_LDPL_COUPON_TYPE_GROUP
COMMENT = 'Lidl Plus Coupon Type Group'
(
 coupon_type_group_id          COMMENT 'Coupon type group identifier'
,coupon_type_group_desc        COMMENT 'Coupon type group description'   
,active_fg                     COMMENT 'Activity Flag'
,coupon_type_group_desc_at     COMMENT 'coupon type group description for lang_cd AT, currently not used'
,coupon_type_group_desc_be     COMMENT 'coupon type group description for lang_cd BE'
,coupon_type_group_desc_bg     COMMENT 'coupon type group description for lang_cd BG'
,coupon_type_group_desc_ch     COMMENT 'coupon type group description for lang_cd CH, currently not used'
,coupon_type_group_desc_cs     COMMENT 'coupon type group description for lang_cd CS'
,coupon_type_group_desc_cy     COMMENT 'coupon type group description for lang_cd CY'
,coupon_type_group_desc_cz     COMMENT 'coupon type group description for lang_cd CZ'
,coupon_type_group_desc_de     COMMENT 'coupon type group description for lang_cd DE, currently not used'
,coupon_type_group_desc_dk     COMMENT 'coupon type group description for lang_cd DK'
,coupon_type_group_desc_es     COMMENT 'coupon type group description for lang_cd ES'
,coupon_type_group_desc_fi     COMMENT 'coupon type group description for lang_cd FI'
,coupon_type_group_desc_fr     COMMENT 'coupon type group description for lang_cd FR'
,coupon_type_group_desc_gb     COMMENT 'coupon type group description for lang_cd GB'
,coupon_type_group_desc_gr     COMMENT 'coupon type group description for lang_cd GR'
,coupon_type_group_desc_hr     COMMENT 'coupon type group description for lang_cd HR'
,coupon_type_group_desc_hu     COMMENT 'coupon type group description for lang_cd HU'
,coupon_type_group_desc_ie     COMMENT 'coupon type group description for lang_cd IE'
,coupon_type_group_desc_it     COMMENT 'coupon type group description for lang_cd IT'
,coupon_type_group_desc_lt     COMMENT 'coupon type group description for lang_cd LT'
,coupon_type_group_desc_lv     COMMENT 'coupon type group description for lang_cd LV'
,coupon_type_group_desc_mt     COMMENT 'coupon type group description for lang_cd MT'
,coupon_type_group_desc_ni     COMMENT 'coupon type group description for lang_cd NI'
,coupon_type_group_desc_nl     COMMENT 'coupon type group description for lang_cd NL'
,coupon_type_group_desc_pl     COMMENT 'coupon type group description for lang_cd PL'
,coupon_type_group_desc_pt     COMMENT 'coupon type group description for lang_cd PT'
,coupon_type_group_desc_ro     COMMENT 'coupon type group description for lang_cd RO'
,coupon_type_group_desc_rs     COMMENT 'coupon type group description for lang_cd RS'
,coupon_type_group_desc_se     COMMENT 'coupon type group description for lang_cd SE'
,coupon_type_group_desc_si     COMMENT 'coupon type group description for lang_cd SI'
,coupon_type_group_desc_sk     COMMENT 'coupon type group description for lang_cd SK'
,coupon_type_group_desc_us     COMMENT 'coupon type group description for lang_cd US' 
,dwh_load_id                   COMMENT 'Load identifier'            
,dwh_created                   COMMENT 'Row insert time'           
,dwh_updated                   COMMENT 'Row update time'            
)
AS
SELECT
 ct.coupon_type_group_id  
,ct.coupon_type_group_desc
,ct.active_fg             
,COALESCE(lang_desc.coupon_type_group_desc_at, ct.coupon_type_group_desc) AS coupon_type_group_desc_at
,COALESCE(lang_desc.coupon_type_group_desc_be, ct.coupon_type_group_desc) AS coupon_type_group_desc_be
,COALESCE(lang_desc.coupon_type_group_desc_bg, ct.coupon_type_group_desc) AS coupon_type_group_desc_bg
,COALESCE(lang_desc.coupon_type_group_desc_ch, ct.coupon_type_group_desc) AS coupon_type_group_desc_ch
,COALESCE(lang_desc.coupon_type_group_desc_cs, ct.coupon_type_group_desc) AS coupon_type_group_desc_cs
,COALESCE(lang_desc.coupon_type_group_desc_cy, ct.coupon_type_group_desc) AS coupon_type_group_desc_cy
,COALESCE(lang_desc.coupon_type_group_desc_cz, ct.coupon_type_group_desc) AS coupon_type_group_desc_cz
,COALESCE(lang_desc.coupon_type_group_desc_de, ct.coupon_type_group_desc) AS coupon_type_group_desc_de
,COALESCE(lang_desc.coupon_type_group_desc_dk, ct.coupon_type_group_desc) AS coupon_type_group_desc_dk
,COALESCE(lang_desc.coupon_type_group_desc_es, ct.coupon_type_group_desc) AS coupon_type_group_desc_es
,COALESCE(lang_desc.coupon_type_group_desc_fi, ct.coupon_type_group_desc) AS coupon_type_group_desc_fi
,COALESCE(lang_desc.coupon_type_group_desc_fr, ct.coupon_type_group_desc) AS coupon_type_group_desc_fr
,COALESCE(lang_desc.coupon_type_group_desc_gb, ct.coupon_type_group_desc) AS coupon_type_group_desc_gb
,COALESCE(lang_desc.coupon_type_group_desc_gr, ct.coupon_type_group_desc) AS coupon_type_group_desc_gr
,COALESCE(lang_desc.coupon_type_group_desc_hr, ct.coupon_type_group_desc) AS coupon_type_group_desc_hr
,COALESCE(lang_desc.coupon_type_group_desc_hu, ct.coupon_type_group_desc) AS coupon_type_group_desc_hu
,COALESCE(lang_desc.coupon_type_group_desc_ie, ct.coupon_type_group_desc) AS coupon_type_group_desc_ie
,COALESCE(lang_desc.coupon_type_group_desc_it, ct.coupon_type_group_desc) AS coupon_type_group_desc_it
,COALESCE(lang_desc.coupon_type_group_desc_lt, ct.coupon_type_group_desc) AS coupon_type_group_desc_lt
,COALESCE(lang_desc.coupon_type_group_desc_lv, ct.coupon_type_group_desc) AS coupon_type_group_desc_lv
,COALESCE(lang_desc.coupon_type_group_desc_mt, ct.coupon_type_group_desc) AS coupon_type_group_desc_mt
,COALESCE(lang_desc.coupon_type_group_desc_ni, ct.coupon_type_group_desc) AS coupon_type_group_desc_ni
,COALESCE(lang_desc.coupon_type_group_desc_nl, ct.coupon_type_group_desc) AS coupon_type_group_desc_nl
,COALESCE(lang_desc.coupon_type_group_desc_pl, ct.coupon_type_group_desc) AS coupon_type_group_desc_pl
,COALESCE(lang_desc.coupon_type_group_desc_pt, ct.coupon_type_group_desc) AS coupon_type_group_desc_pt
,COALESCE(lang_desc.coupon_type_group_desc_ro, ct.coupon_type_group_desc) AS coupon_type_group_desc_ro
,COALESCE(lang_desc.coupon_type_group_desc_rs, ct.coupon_type_group_desc) AS coupon_type_group_desc_rs
,COALESCE(lang_desc.coupon_type_group_desc_se, ct.coupon_type_group_desc) AS coupon_type_group_desc_se
,COALESCE(lang_desc.coupon_type_group_desc_si, ct.coupon_type_group_desc) AS coupon_type_group_desc_si
,COALESCE(lang_desc.coupon_type_group_desc_sk, ct.coupon_type_group_desc) AS coupon_type_group_desc_sk
,COALESCE(lang_desc.coupon_type_group_desc_us, ct.coupon_type_group_desc) AS coupon_type_group_desc_us
,ct.dwh_load_id
,ct.dwh_created
,ct.dwh_updated
FROM P_LEW_PROCESS_MSTR.V_REF_LDPL_COUPON_TYPE_GROUP AS ct
LEFT JOIN (
    SELECT 
     coupon_type_group_id
    ,"'AT'" AS coupon_type_group_desc_at
    ,"'BE'" AS coupon_type_group_desc_be
    ,"'BG'" AS coupon_type_group_desc_bg
    ,"'CH'" AS coupon_type_group_desc_ch
    ,"'CS'" AS coupon_type_group_desc_cs
    ,"'CY'" AS coupon_type_group_desc_cy
    ,"'CZ'" AS coupon_type_group_desc_cz
    ,"'DE'" AS coupon_type_group_desc_de
    ,"'DK'" AS coupon_type_group_desc_dk
    ,"'ES'" AS coupon_type_group_desc_es
    ,"'FI'" AS coupon_type_group_desc_fi
    ,"'FR'" AS coupon_type_group_desc_fr
    ,"'GB'" AS coupon_type_group_desc_gb
    ,"'GR'" AS coupon_type_group_desc_gr
    ,"'HR'" AS coupon_type_group_desc_hr
    ,"'HU'" AS coupon_type_group_desc_hu
    ,"'IE'" AS coupon_type_group_desc_ie
    ,"'IT'" AS coupon_type_group_desc_it
    ,"'LT'" AS coupon_type_group_desc_lt
    ,"'LV'" AS coupon_type_group_desc_lv
    ,"'MT'" AS coupon_type_group_desc_mt
    ,"'NI'" AS coupon_type_group_desc_ni
    ,"'NL'" AS coupon_type_group_desc_nl
    ,"'PL'" AS coupon_type_group_desc_pl
    ,"'PT'" AS coupon_type_group_desc_pt
    ,"'RO'" AS coupon_type_group_desc_ro
    ,"'RS'" AS coupon_type_group_desc_rs
    ,"'SE'" AS coupon_type_group_desc_se
    ,"'SI'" AS coupon_type_group_desc_si
    ,"'SK'" AS coupon_type_group_desc_sk
    ,"'US'" AS coupon_type_group_desc_us
    FROM (
            SELECT 
             coupon_type_group_id
            ,coupon_type_group_desc
            ,lang_cd 
            FROM P_LEW_PROCESS_MSTR.V_REF_LDPL_COUPON_TYPE_GROUP_DESC
            ) AS limited_columns
    PIVOT (
        MAX(coupon_type_group_desc) FOR lang_cd IN (
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
                    ,'RS'
                    ,'SE'
                    ,'SI'
                    ,'SK'
                    ,'US'          
                )
          )
  ) lang_desc
 ON lang_desc.coupon_type_group_id = ct.coupon_type_group_id   
;
