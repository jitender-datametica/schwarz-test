/*
#-----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer        Task
#  --- ---------- ---------------  --------------------------------------------
#  1.0 2023-11-07 Pawel Wieczorek    Initial version AP0069622 demographics
#  1.1 2024-02-06 Rafal Rudnik       Adding other languages 
#------------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW p_lew_mart_lidl_digital_ac.v_ref_age_range_1
COMMENT = 'Lidlplus : age range - referenece table'
(
 age_range_cd      COMMENT 'The code for the age range.'
,age_range_descr   COMMENT 'A textual description for the age range (in default language).'
,age_range_short_desc      COMMENT 'A textual description for the age range (in default language).'
,age_range_short_desc_at   COMMENT 'A textual description for the age range (in at language).'
,age_range_short_desc_be   COMMENT 'A textual description for the age range (in be language).'
,age_range_short_desc_bg   COMMENT 'A textual description for the age range (in bg language).'
,age_range_short_desc_ch   COMMENT 'A textual description for the age range (in ch language).'
,age_range_short_desc_cs   COMMENT 'A textual description for the age range (in cs language).'
,age_range_short_desc_cy   COMMENT 'A textual description for the age range (in cy language).'
,age_range_short_desc_cz   COMMENT 'A textual description for the age range (in cz language).'
,age_range_short_desc_de   COMMENT 'A textual description for the age range (in de language).'
,age_range_short_desc_dk   COMMENT 'A textual description for the age range (in dk language).'
,age_range_short_desc_es   COMMENT 'A textual description for the age range (in es language).'
,age_range_short_desc_fi   COMMENT 'A textual description for the age range (in fi language).'
,age_range_short_desc_fr   COMMENT 'A textual description for the age range (in fr language).'
,age_range_short_desc_gb   COMMENT 'A textual description for the age range (in gb language).'
,age_range_short_desc_gr   COMMENT 'A textual description for the age range (in gr language).'
,age_range_short_desc_hr   COMMENT 'A textual description for the age range (in hr language).'
,age_range_short_desc_hu   COMMENT 'A textual description for the age range (in hu language).'
,age_range_short_desc_ie   COMMENT 'A textual description for the age range (in ie language).'
,age_range_short_desc_it   COMMENT 'A textual description for the age range (in it language).'
,age_range_short_desc_lt   COMMENT 'A textual description for the age range (in lt language).'
,age_range_short_desc_lv   COMMENT 'A textual description for the age range (in lv language).'
,age_range_short_desc_mt   COMMENT 'A textual description for the age range (in mt language).'
,age_range_short_desc_ni   COMMENT 'A textual description for the age range (in ni language).'
,age_range_short_desc_nl   COMMENT 'A textual description for the age range (in nl language).'
,age_range_short_desc_pl   COMMENT 'A textual description for the age range (in pl language).'
,age_range_short_desc_pt   COMMENT 'A textual description for the age range (in pt language).'
,age_range_short_desc_ro   COMMENT 'A textual description for the age range (in ro language).'
,age_range_short_desc_rs   COMMENT 'A textual description for the age range (in rs_1 language).'
,age_range_short_desc_se   COMMENT 'A textual description for the age range (in se language).'
,age_range_short_desc_si   COMMENT 'A textual description for the age range (in si language).'
,age_range_short_desc_sk   COMMENT 'A textual description for the age range (in sk language).'
,age_range_short_desc_us   COMMENT 'A textual description for the age range (in us language).'
,load_id           COMMENT 'Load identifier'
,dwh_created       COMMENT 'Row create time'
,dwh_updated       COMMENT 'Row update time'
)
AS
SELECT c.age_range_cd
,c.age_range_descr
,d.age_range_cd_de AS age_range_short_desc
,d.age_range_cd_de AS age_range_short_desc_at
,e.age_range_cd_en AS age_range_short_desc_be
,e.age_range_cd_en AS age_range_short_desc_bg
,e.age_range_cd_en AS age_range_short_desc_ch
,e.age_range_cd_en AS age_range_short_desc_cs
,e.age_range_cd_en AS age_range_short_desc_cy
,e.age_range_cd_en AS age_range_short_desc_cz
,d.age_range_cd_de AS age_range_short_desc_de
,e.age_range_cd_en AS age_range_short_desc_dk
,e.age_range_cd_en AS age_range_short_desc_es
,e.age_range_cd_en AS age_range_short_desc_fi
,e.age_range_cd_en AS age_range_short_desc_fr
,e.age_range_cd_en AS age_range_short_desc_gb
,e.age_range_cd_en AS age_range_short_desc_gr
,e.age_range_cd_en AS age_range_short_desc_hr
,e.age_range_cd_en AS age_range_short_desc_hu
,e.age_range_cd_en AS age_range_short_desc_ie
,e.age_range_cd_en AS age_range_short_desc_it
,e.age_range_cd_en AS age_range_short_desc_lt
,e.age_range_cd_en AS age_range_short_desc_lv
,e.age_range_cd_en AS age_range_short_desc_mt
,e.age_range_cd_en AS age_range_short_desc_ni
,e.age_range_cd_en AS age_range_short_desc_nl
,e.age_range_cd_en AS age_range_short_desc_pl
,e.age_range_cd_en AS age_range_short_desc_pt
,e.age_range_cd_en AS age_range_short_desc_ro
,e.age_range_cd_en AS age_range_short_desc_rs
,e.age_range_cd_en AS age_range_short_desc_se
,e.age_range_cd_en AS age_range_short_desc_si
,e.age_range_cd_en AS age_range_short_desc_sk
,e.age_range_cd_en AS age_range_short_desc_us
,c.load_id
,c.dwh_created
,c.dwh_updated
FROM p_lew_mart_lidl_digital.v_ref_age_range_1  AS c
INNER JOIN (SELECT
 age_range_cd
,CASE
    WHEN age_range_cd='N/A' THEN age_range_cd
    ELSE CONCAT(age_range_cd,' Jahre')
END AS age_range_cd_de
FROM p_lew_mart_lidl_digital.v_ref_age_range_1) AS d
ON c.age_range_cd=d.age_range_cd
INNER JOIN (SELECT
 age_range_cd
,CASE
    WHEN age_range_cd='N/A' THEN age_range_cd
    ELSE CONCAT(age_range_cd,' years')
END AS age_range_cd_en
FROM p_lew_mart_lidl_digital.v_ref_age_range_1) AS e
ON c.age_range_cd=e.age_range_cd
;