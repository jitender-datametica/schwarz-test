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

CREATE OR REPLACE VIEW P_LEW_PROCESS_MSTR_AC.V_REF_LDPL_COUPON_TYPE
COMMENT = 'Lidl Plus Coupon Type'
(
 coupon_type_id            COMMENT 'Coupon type identifier'
,coupon_type_desc          COMMENT 'Default Coupon type description, which is not exactly the SCRM value from in P_LEW_PROCESS_MSTR.T_REF_LDPL_COUPON_TYPE.coupon_type_desc'       
,coupon_type_subgroup_id   COMMENT 'Coupon type subgroup identifier'
,coupon_type_desc_at       COMMENT 'coupon type description for lang_cd AT, currently not used'
,coupon_type_desc_be       COMMENT 'coupon type description for lang_cd BE'
,coupon_type_desc_bg       COMMENT 'coupon type description for lang_cd BG'
,coupon_type_desc_ch       COMMENT 'coupon type description for lang_cd CH, currently not used'
,coupon_type_desc_cs       COMMENT 'coupon type description for lang_cd CS'
,coupon_type_desc_cy       COMMENT 'coupon type description for lang_cd CY'
,coupon_type_desc_cz       COMMENT 'coupon type description for lang_cd CZ'
,coupon_type_desc_de       COMMENT 'coupon type description for lang_cd DE, currently not used'
,coupon_type_desc_dk       COMMENT 'coupon type description for lang_cd DK'
,coupon_type_desc_es       COMMENT 'coupon type description for lang_cd ES'
,coupon_type_desc_fi       COMMENT 'coupon type description for lang_cd FI'
,coupon_type_desc_fr       COMMENT 'coupon type description for lang_cd FR'
,coupon_type_desc_gb       COMMENT 'coupon type description for lang_cd GB'
,coupon_type_desc_gr       COMMENT 'coupon type description for lang_cd GR'
,coupon_type_desc_hr       COMMENT 'coupon type description for lang_cd HR'
,coupon_type_desc_hu       COMMENT 'coupon type description for lang_cd HU'
,coupon_type_desc_ie       COMMENT 'coupon type description for lang_cd IE'
,coupon_type_desc_it       COMMENT 'coupon type description for lang_cd IT'
,coupon_type_desc_lt       COMMENT 'coupon type description for lang_cd LT'
,coupon_type_desc_lv       COMMENT 'coupon type description for lang_cd LV'
,coupon_type_desc_mt       COMMENT 'coupon type description for lang_cd MT'
,coupon_type_desc_ni       COMMENT 'coupon type description for lang_cd NI'
,coupon_type_desc_nl       COMMENT 'coupon type description for lang_cd NL'
,coupon_type_desc_pl       COMMENT 'coupon type description for lang_cd PL'
,coupon_type_desc_pt       COMMENT 'coupon type description for lang_cd PT'
,coupon_type_desc_ro       COMMENT 'coupon type description for lang_cd RO'
,coupon_type_desc_rs       COMMENT 'coupon type description for lang_cd RS'
,coupon_type_desc_se       COMMENT 'coupon type description for lang_cd SE'
,coupon_type_desc_si       COMMENT 'coupon type description for lang_cd SI'
,coupon_type_desc_sk       COMMENT 'coupon type description for lang_cd SK'
,coupon_type_desc_us       COMMENT 'coupon type description for lang_cd US'     
,dwh_load_id               COMMENT 'Load identifier'            
,dwh_created               COMMENT 'Row insert time'           
,dwh_updated               COMMENT 'Row update time'            
)
AS
SELECT
 c.coupon_type_id
,COALESCE(lang_desc.coupon_type_desc_de, c.coupon_type_desc) AS coupon_type_desc
,c.coupon_type_subgroup_id
,COALESCE(lang_desc.coupon_type_desc_at, lang_desc.coupon_type_desc_de, c.coupon_type_desc) AS coupon_type_desc_at
,COALESCE(lang_desc.coupon_type_desc_be, lang_desc.coupon_type_desc_de, c.coupon_type_desc) AS coupon_type_desc_be
,COALESCE(lang_desc.coupon_type_desc_bg, lang_desc.coupon_type_desc_de, c.coupon_type_desc) AS coupon_type_desc_bg
,COALESCE(lang_desc.coupon_type_desc_ch, lang_desc.coupon_type_desc_de, c.coupon_type_desc) AS coupon_type_desc_ch
,COALESCE(lang_desc.coupon_type_desc_cs, lang_desc.coupon_type_desc_de, c.coupon_type_desc) AS coupon_type_desc_cs
,COALESCE(lang_desc.coupon_type_desc_cy, lang_desc.coupon_type_desc_de, c.coupon_type_desc) AS coupon_type_desc_cy
,COALESCE(lang_desc.coupon_type_desc_cz, lang_desc.coupon_type_desc_de, c.coupon_type_desc) AS coupon_type_desc_cz
,COALESCE(lang_desc.coupon_type_desc_de, lang_desc.coupon_type_desc_de, c.coupon_type_desc) AS coupon_type_desc_de
,COALESCE(lang_desc.coupon_type_desc_dk, lang_desc.coupon_type_desc_de, c.coupon_type_desc) AS coupon_type_desc_dk
,COALESCE(lang_desc.coupon_type_desc_es, lang_desc.coupon_type_desc_de, c.coupon_type_desc) AS coupon_type_desc_es
,COALESCE(lang_desc.coupon_type_desc_fi, lang_desc.coupon_type_desc_de, c.coupon_type_desc) AS coupon_type_desc_fi
,COALESCE(lang_desc.coupon_type_desc_fr, lang_desc.coupon_type_desc_de, c.coupon_type_desc) AS coupon_type_desc_fr
,COALESCE(lang_desc.coupon_type_desc_gb, lang_desc.coupon_type_desc_de, c.coupon_type_desc) AS coupon_type_desc_gb
,COALESCE(lang_desc.coupon_type_desc_gr, lang_desc.coupon_type_desc_de, c.coupon_type_desc) AS coupon_type_desc_gr
,COALESCE(lang_desc.coupon_type_desc_hr, lang_desc.coupon_type_desc_de, c.coupon_type_desc) AS coupon_type_desc_hr
,COALESCE(lang_desc.coupon_type_desc_hu, lang_desc.coupon_type_desc_de, c.coupon_type_desc) AS coupon_type_desc_hu
,COALESCE(lang_desc.coupon_type_desc_ie, lang_desc.coupon_type_desc_de, c.coupon_type_desc) AS coupon_type_desc_ie
,COALESCE(lang_desc.coupon_type_desc_it, lang_desc.coupon_type_desc_de, c.coupon_type_desc) AS coupon_type_desc_it
,COALESCE(lang_desc.coupon_type_desc_lt, lang_desc.coupon_type_desc_de, c.coupon_type_desc) AS coupon_type_desc_lt
,COALESCE(lang_desc.coupon_type_desc_lv, lang_desc.coupon_type_desc_de, c.coupon_type_desc) AS coupon_type_desc_lv
,COALESCE(lang_desc.coupon_type_desc_mt, lang_desc.coupon_type_desc_de, c.coupon_type_desc) AS coupon_type_desc_mt
,COALESCE(lang_desc.coupon_type_desc_ni, lang_desc.coupon_type_desc_de, c.coupon_type_desc) AS coupon_type_desc_ni
,COALESCE(lang_desc.coupon_type_desc_nl, lang_desc.coupon_type_desc_de, c.coupon_type_desc) AS coupon_type_desc_nl
,COALESCE(lang_desc.coupon_type_desc_pl, lang_desc.coupon_type_desc_de, c.coupon_type_desc) AS coupon_type_desc_pl
,COALESCE(lang_desc.coupon_type_desc_pt, lang_desc.coupon_type_desc_de, c.coupon_type_desc) AS coupon_type_desc_pt
,COALESCE(lang_desc.coupon_type_desc_ro, lang_desc.coupon_type_desc_de, c.coupon_type_desc) AS coupon_type_desc_ro
,COALESCE(lang_desc.coupon_type_desc_rs, lang_desc.coupon_type_desc_de, c.coupon_type_desc) AS coupon_type_desc_rs
,COALESCE(lang_desc.coupon_type_desc_se, lang_desc.coupon_type_desc_de, c.coupon_type_desc) AS coupon_type_desc_se
,COALESCE(lang_desc.coupon_type_desc_si, lang_desc.coupon_type_desc_de, c.coupon_type_desc) AS coupon_type_desc_si
,COALESCE(lang_desc.coupon_type_desc_sk, lang_desc.coupon_type_desc_de, c.coupon_type_desc) AS coupon_type_desc_sk
,COALESCE(lang_desc.coupon_type_desc_us, lang_desc.coupon_type_desc_de, c.coupon_type_desc) AS coupon_type_desc_us
,c.dwh_load_id
,c.dwh_created
,c.dwh_updated
FROM P_LEW_PROCESS_MSTR.V_REF_LDPL_COUPON_TYPE AS c
LEFT JOIN (
    SELECT 
     coupon_type_id
    ,"'AT'" AS coupon_type_desc_at
    ,"'BE'" AS coupon_type_desc_be
    ,"'BG'" AS coupon_type_desc_bg
    ,"'CH'" AS coupon_type_desc_ch
    ,"'CS'" AS coupon_type_desc_cs
    ,"'CY'" AS coupon_type_desc_cy
    ,"'CZ'" AS coupon_type_desc_cz
    ,"'DE'" AS coupon_type_desc_de
    ,"'DK'" AS coupon_type_desc_dk
    ,"'ES'" AS coupon_type_desc_es
    ,"'FI'" AS coupon_type_desc_fi
    ,"'FR'" AS coupon_type_desc_fr
    ,"'GB'" AS coupon_type_desc_gb
    ,"'GR'" AS coupon_type_desc_gr
    ,"'HR'" AS coupon_type_desc_hr
    ,"'HU'" AS coupon_type_desc_hu
    ,"'IE'" AS coupon_type_desc_ie
    ,"'IT'" AS coupon_type_desc_it
    ,"'LT'" AS coupon_type_desc_lt
    ,"'LV'" AS coupon_type_desc_lv
    ,"'MT'" AS coupon_type_desc_mt
    ,"'NI'" AS coupon_type_desc_ni
    ,"'NL'" AS coupon_type_desc_nl
    ,"'PL'" AS coupon_type_desc_pl
    ,"'PT'" AS coupon_type_desc_pt
    ,"'RO'" AS coupon_type_desc_ro
    ,"'RS'" AS coupon_type_desc_rs
    ,"'SE'" AS coupon_type_desc_se
    ,"'SI'" AS coupon_type_desc_si
    ,"'SK'" AS coupon_type_desc_sk
    ,"'US'" AS coupon_type_desc_us
    FROM (
            SELECT 
             coupon_type_id
            ,coupon_type_desc
            ,lang_cd 
            FROM P_LEW_PROCESS_MSTR.V_REF_LDPL_COUPON_TYPE_DESC
            ) AS limited_columns
    PIVOT (
        MAX(coupon_type_desc) FOR lang_cd IN (
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
 ON lang_desc.coupon_type_id = c.coupon_type_id   
;
