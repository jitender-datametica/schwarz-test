/*
#-----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer        Task
#  --- ---------- ---------------  --------------------------------------------
#  1.0 2023-11-07 Pawel Wieczorek    Initial version AP0069622 demographics
#  1.1 2024-02-05 Rafal Rudnik       Adding DE translation for vizualization.
#------------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital_ac.v_ref_gender_1 (gender_cd
OPTIONS(description='The code for the gender'), gender_descr
OPTIONS(description='A textual description for the gender (in default language)'), gender_short_desc
OPTIONS(description='A textual description for the gender (in default language)'), gender_short_desc_at
OPTIONS(description='A textual description for the gender (in at language)'), gender_short_desc_be
OPTIONS(description='A textual description for the gender (in be language)'), gender_short_desc_bg
OPTIONS(description='A textual description for the gender (in bg language)'), gender_short_desc_ch
OPTIONS(description='A textual description for the gender (in ch language)'), gender_short_desc_cs
OPTIONS(description='A textual description for the gender (in cs language)'), gender_short_desc_cy
OPTIONS(description='A textual description for the gender (in cy language)'), gender_short_desc_cz
OPTIONS(description='A textual description for the gender (in cz language)'), gender_short_desc_de
OPTIONS(description='A textual description for the gender (in de language)'), gender_short_desc_dk
OPTIONS(description='A textual description for the gender (in dk language)'), gender_short_desc_es
OPTIONS(description='A textual description for the gender (in es language)'), gender_short_desc_fi
OPTIONS(description='A textual description for the gender (in fi language)'), gender_short_desc_fr
OPTIONS(description='A textual description for the gender (in fr language)'), gender_short_desc_gb
OPTIONS(description='A textual description for the gender (in gb language)'), gender_short_desc_gr
OPTIONS(description='A textual description for the gender (in gr language)'), gender_short_desc_hr
OPTIONS(description='A textual description for the gender (in hr language)'), gender_short_desc_hu
OPTIONS(description='A textual description for the gender (in hu language)'), gender_short_desc_ie
OPTIONS(description='A textual description for the gender (in ie language)'), gender_short_desc_it
OPTIONS(description='A textual description for the gender (in it language)'), gender_short_desc_lt
OPTIONS(description='A textual description for the gender (in lt language)'), gender_short_desc_lv
OPTIONS(description='A textual description for the gender (in lv language)'), gender_short_desc_mt
OPTIONS(description='A textual description for the gender (in mt language)'), gender_short_desc_ni
OPTIONS(description='A textual description for the gender (in ni language)'), gender_short_desc_nl
OPTIONS(description='A textual description for the gender (in nl language)'), gender_short_desc_pl
OPTIONS(description='A textual description for the gender (in pl language)'), gender_short_desc_pt
OPTIONS(description='A textual description for the gender (in pt language)'), gender_short_desc_ro
OPTIONS(description='A textual description for the gender (in ro language)'), gender_short_desc_rs
OPTIONS(description='A textual description for the gender (in rs_1 language)'), gender_short_desc_se
OPTIONS(description='A textual description for the gender (in se language)'), gender_short_desc_si
OPTIONS(description='A textual description for the gender (in si language)'), gender_short_desc_sk
OPTIONS(description='A textual description for the gender (in sk language)'), gender_short_desc_us
OPTIONS(description='A textual description for the gender (in us language)'), load_id
OPTIONS(description='Load identifier'), dwh_created OPTIONS(description='Row create time'), dwh_updated
OPTIONS(description='Row update time')) OPTIONS(DESCRIPTION = `LIDLPLUS : GENDER - REFERENECE TABLE`) AS SELECT C.gender_cd
 ,
 C.gender_descr,
 d.gender_descr_de AS gender_short_desc,
 d.gender_descr_de AS gender_short_desc_at,
 e.gender_descr_en AS gender_short_desc_be,
 e.gender_descr_en AS gender_short_desc_bg,
 e.gender_descr_en AS gender_short_desc_ch,
 e.gender_descr_en AS gender_short_desc_cs,
 e.gender_descr_en AS gender_short_desc_cy,
 e.gender_descr_en AS gender_short_desc_cz,
 d.gender_descr_de AS gender_short_desc_de,
 e.gender_descr_en AS gender_short_desc_dk,
 e.gender_descr_en AS gender_short_desc_es,
 e.gender_descr_en AS gender_short_desc_fi,
 e.gender_descr_en AS gender_short_desc_fr,
 e.gender_descr_en AS gender_short_desc_gb,
 e.gender_descr_en AS gender_short_desc_gr,
 e.gender_descr_en AS gender_short_desc_hr,
 e.gender_descr_en AS gender_short_desc_hu,
 e.gender_descr_en AS gender_short_desc_ie,
 e.gender_descr_en AS gender_short_desc_it,
 e.gender_descr_en AS gender_short_desc_lt,
 e.gender_descr_en AS gender_short_desc_lv,
 e.gender_descr_en AS gender_short_desc_mt,
 e.gender_descr_en AS gender_short_desc_ni,
 e.gender_descr_en AS gender_short_desc_nl,
 e.gender_descr_en AS gender_short_desc_pl,
 e.gender_descr_en AS gender_short_desc_pt,
 e.gender_descr_en AS gender_short_desc_ro,
 e.gender_descr_en AS gender_short_desc_rs,
 e.gender_descr_en AS gender_short_desc_se,
 e.gender_descr_en AS gender_short_desc_si,
 e.gender_descr_en AS gender_short_desc_sk,
 e.gender_descr_en AS gender_short_desc_us,
 C.load_id,
 C.dwh_created,
 C.dwh_updated
FROM ldl_p_lew_mart_lidl_digital.t_ref_gender_1 AS C
 INNER JOIN (SELECT gender_cd,
    CASE
    WHEN gender_cd = 'M'
    THEN 'Männlich'
    WHEN gender_cd = 'F'
    THEN 'Weiblich'
    WHEN gender_cd = 'O'
    THEN 'Divers'
    ELSE gender_cd
    END AS gender_descr_de
  FROM ldl_p_lew_mart_lidl_digital.t_ref_gender_1) AS d ON C.gender_cd = d.gender_cd
 INNER JOIN (SELECT gender_cd,
    CASE
    WHEN gender_cd = 'N/A'
    THEN 'N/A'
    ELSE gender_descr
    END AS gender_descr_en
  FROM ldl_p_lew_mart_lidl_digital.t_ref_gender_1) AS e ON C.gender_cd = e.gender_cd;