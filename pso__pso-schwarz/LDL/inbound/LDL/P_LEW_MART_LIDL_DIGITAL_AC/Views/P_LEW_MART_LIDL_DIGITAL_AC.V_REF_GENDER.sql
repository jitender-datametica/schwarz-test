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


CREATE OR REPLACE VIEW p_lew_mart_lidl_digital_ac.v_ref_gender
COMMENT = 'Lidlplus : gender - referenece table'
(
 gender_cd      COMMENT 'The code for the gender'
,gender_descr   COMMENT 'A textual description for the gender (in default language)'
,gender_short_desc    COMMENT 'A textual description for the gender (in default language)'
,gender_short_desc_at    COMMENT 'A textual description for the gender (in at language)'
,gender_short_desc_be    COMMENT 'A textual description for the gender (in be language)'
,gender_short_desc_bg    COMMENT 'A textual description for the gender (in bg language)'
,gender_short_desc_ch    COMMENT 'A textual description for the gender (in ch language)'
,gender_short_desc_cs    COMMENT 'A textual description for the gender (in cs language)'
,gender_short_desc_cy    COMMENT 'A textual description for the gender (in cy language)'
,gender_short_desc_cz    COMMENT 'A textual description for the gender (in cz language)'
,gender_short_desc_de    COMMENT 'A textual description for the gender (in de language)'
,gender_short_desc_dk    COMMENT 'A textual description for the gender (in dk language)'
,gender_short_desc_es    COMMENT 'A textual description for the gender (in es language)'
,gender_short_desc_fi    COMMENT 'A textual description for the gender (in fi language)'
,gender_short_desc_fr    COMMENT 'A textual description for the gender (in fr language)'
,gender_short_desc_gb    COMMENT 'A textual description for the gender (in gb language)'
,gender_short_desc_gr    COMMENT 'A textual description for the gender (in gr language)'
,gender_short_desc_hr    COMMENT 'A textual description for the gender (in hr language)'
,gender_short_desc_hu    COMMENT 'A textual description for the gender (in hu language)'
,gender_short_desc_ie    COMMENT 'A textual description for the gender (in ie language)'
,gender_short_desc_it    COMMENT 'A textual description for the gender (in it language)'
,gender_short_desc_lt    COMMENT 'A textual description for the gender (in lt language)'
,gender_short_desc_lv    COMMENT 'A textual description for the gender (in lv language)'
,gender_short_desc_mt    COMMENT 'A textual description for the gender (in mt language)'
,gender_short_desc_ni    COMMENT 'A textual description for the gender (in ni language)'
,gender_short_desc_nl    COMMENT 'A textual description for the gender (in nl language)'
,gender_short_desc_pl    COMMENT 'A textual description for the gender (in pl language)'
,gender_short_desc_pt    COMMENT 'A textual description for the gender (in pt language)'
,gender_short_desc_ro    COMMENT 'A textual description for the gender (in ro language)'
,gender_short_desc_rs    COMMENT 'A textual description for the gender (in rs language)'
,gender_short_desc_se    COMMENT 'A textual description for the gender (in se language)'
,gender_short_desc_si    COMMENT 'A textual description for the gender (in si language)'
,gender_short_desc_sk    COMMENT 'A textual description for the gender (in sk language)'
,gender_short_desc_us    COMMENT 'A textual description for the gender (in us language)'
,load_id        COMMENT 'Load identifier'
,dwh_created    COMMENT 'Row create time'
,dwh_updated    COMMENT 'Row update time'
)
AS
SELECT
 c.gender_cd
,c.gender_descr
,d.gender_descr_de AS gender_short_desc
,d.gender_descr_de AS gender_short_desc_at
,e.gender_descr_en AS gender_short_desc_be
,e.gender_descr_en AS gender_short_desc_bg
,e.gender_descr_en AS gender_short_desc_ch
,e.gender_descr_en AS gender_short_desc_cs
,e.gender_descr_en AS gender_short_desc_cy
,e.gender_descr_en AS gender_short_desc_cz
,d.gender_descr_de AS gender_short_desc_de
,e.gender_descr_en AS gender_short_desc_dk
,e.gender_descr_en AS gender_short_desc_es
,e.gender_descr_en AS gender_short_desc_fi
,e.gender_descr_en AS gender_short_desc_fr
,e.gender_descr_en AS gender_short_desc_gb
,e.gender_descr_en AS gender_short_desc_gr
,e.gender_descr_en AS gender_short_desc_hr
,e.gender_descr_en AS gender_short_desc_hu
,e.gender_descr_en AS gender_short_desc_ie
,e.gender_descr_en AS gender_short_desc_it
,e.gender_descr_en AS gender_short_desc_lt
,e.gender_descr_en AS gender_short_desc_lv
,e.gender_descr_en AS gender_short_desc_mt
,e.gender_descr_en AS gender_short_desc_ni
,e.gender_descr_en AS gender_short_desc_nl
,e.gender_descr_en AS gender_short_desc_pl
,e.gender_descr_en AS gender_short_desc_pt
,e.gender_descr_en AS gender_short_desc_ro
,e.gender_descr_en AS gender_short_desc_rs
,e.gender_descr_en AS gender_short_desc_se
,e.gender_descr_en AS gender_short_desc_si
,e.gender_descr_en AS gender_short_desc_sk
,e.gender_descr_en AS gender_short_desc_us
,load_id
,dwh_created
,dwh_updated
FROM p_lew_mart_lidl_digital.t_ref_gender AS c
INNER JOIN (SELECT
 gender_cd
,CASE
    WHEN gender_cd='M' THEN 'Männlich'
    WHEN gender_cd='F' THEN 'Weiblich'
    WHEN gender_cd='O' THEN 'Divers'
    ELSE gender_cd
END AS gender_descr_de
FROM p_lew_mart_lidl_digital.t_ref_gender) AS d
ON c.gender_cd=d.gender_cd
INNER JOIN (SELECT
 gender_cd
,CASE
    WHEN gender_cd='N/A' THEN 'N/A'
    ELSE gender_descr
END AS gender_descr_en
FROM p_lew_mart_lidl_digital.t_ref_gender) AS e
ON c.gender_cd=e.gender_cd;