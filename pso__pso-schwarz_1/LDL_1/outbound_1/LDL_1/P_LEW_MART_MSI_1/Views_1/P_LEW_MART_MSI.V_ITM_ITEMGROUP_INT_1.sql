CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_itm_itemgroup_int_1 (itemgroup_int_id OPTIONS(description='Artikelgruppe ID'),
itemgroup_int_remark OPTIONS(description='Artikelgruppe Kommentar'), itemgroup_int_desc_at
OPTIONS(description='Artikelgruppe Landesspezifische Bezeichnung AT'), itemgroup_int_desc_be
OPTIONS(description='Artikelgruppe Landesspezifische Bezeichnung BE'), itemgroup_int_desc_be_fr
OPTIONS(description='Artikelgruppe Landesspezifische Bezeichnung BE_FR'), itemgroup_int_desc_bg
OPTIONS(description='Artikelgruppe Landesspezifische Bezeichnung BG'), itemgroup_int_desc_ch
OPTIONS(description='Artikelgruppe Landesspezifische Bezeichnung CH'), itemgroup_int_desc_cy
OPTIONS(description='Artikelgruppe Landesspezifische Bezeichnung CY'), itemgroup_int_desc_cz
OPTIONS(description='Artikelgruppe Landesspezifische Bezeichnung CZ'), itemgroup_int_desc
OPTIONS(description='Artikelgruppe Generische Bezeichnung'), itemgroup_int_desc_dk
OPTIONS(description='Artikelgruppe Landesspezifische Bezeichnung DK'), itemgroup_int_desc_ee
OPTIONS(description='Artikelgruppe Landesspezifische Bezeichnung EE'), itemgroup_int_desc_es
OPTIONS(description='Artikelgruppe Landesspezifische Bezeichnung ES'), itemgroup_int_desc_fi
OPTIONS(description='Artikelgruppe Landesspezifische Bezeichnung FI'), itemgroup_int_desc_fr
OPTIONS(description='Artikelgruppe Landesspezifische Bezeichnung FR'), itemgroup_int_desc_gb
OPTIONS(description='Artikelgruppe Landesspezifische Bezeichnung GB'), itemgroup_int_desc_gr
OPTIONS(description='Artikelgruppe Landesspezifische Bezeichnung GR'), itemgroup_int_desc_hr
OPTIONS(description='Artikelgruppe Landesspezifische Bezeichnung HR'), itemgroup_int_desc_hu
OPTIONS(description='Artikelgruppe Landesspezifische Bezeichnung HU'), itemgroup_int_desc_ie
OPTIONS(description='Artikelgruppe Landesspezifische Bezeichnung IE'), itemgroup_int_desc_it
OPTIONS(description='Artikelgruppe Landesspezifische Bezeichnung IT'), itemgroup_int_desc_lt
OPTIONS(description='Artikelgruppe Landesspezifische Bezeichnung LT'), itemgroup_int_desc_lv
OPTIONS(description='Artikelgruppe Landesspezifische Bezeichnung LV'), itemgroup_int_desc_ni
OPTIONS(description='Artikelgruppe Landesspezifische Bezeichnung NI'), itemgroup_int_desc_nl
OPTIONS(description='Artikelgruppe Landesspezifische Bezeichnung NL'), itemgroup_int_desc_de
OPTIONS(description='Artikelgruppe Landesspezifische Bezeichnung DE'), itemgroup_int_desc_pl
OPTIONS(description='Artikelgruppe Landesspezifische Bezeichnung PL'), itemgroup_int_desc_pt
OPTIONS(description='Artikelgruppe Landesspezifische Bezeichnung PT'), itemgroup_int_desc_ro
OPTIONS(description='Artikelgruppe Landesspezifische Bezeichnung RO'), itemgroup_int_desc_se
OPTIONS(description='Artikelgruppe Landesspezifische Bezeichnung SE'), itemgroup_int_desc_si
OPTIONS(description='Artikelgruppe Landesspezifische Bezeichnung SI'), itemgroup_int_desc_sk
OPTIONS(description='Artikelgruppe Landesspezifische Bezeichnung SK'), itemgroup_int_desc_cs
OPTIONS(description='Artikelgruppe Landesspezifische Bezeichnung CS'), itemgroup_int_desc_mt
OPTIONS(description='Artikelgruppe Landesspezifische Bezeichnung MT'), itemgroup_int_desc_us
OPTIONS(description='Artikelgruppe Landesspezifische Bezeichnung US'), itemgroup_int_desc_rs
OPTIONS(description='Artikelgruppe Landesspezifische Bezeichnung RS_1'))
OPTIONS(DESCRIPTION = `MULTI LANGUAGE INTERNATIONAL ITEM_1 GROUP DESCRIPTIONS`) AS SELECT itemgroup_int_id,
 itemgroup_int_remark,
 itemgroup_int_desc_at,
 itemgroup_int_desc_be,
 itemgroup_int_desc_fr AS itemgroup_int_desc_be_fr,
 itemgroup_int_desc_bg,
 itemgroup_int_desc_ch,
 itemgroup_int_desc_cy,
 itemgroup_int_desc_cz,
 itemgroup_int_desc,
 itemgroup_int_desc_dk,
 itemgroup_int_desc_ee,
 itemgroup_int_desc_es,
 itemgroup_int_desc_fi,
 itemgroup_int_desc_fr,
 itemgroup_int_desc_gb,
 itemgroup_int_desc_gr,
 itemgroup_int_desc_hr,
 itemgroup_int_desc_hu,
 itemgroup_int_desc_ie,
 itemgroup_int_desc_it,
 itemgroup_int_desc_lt,
 itemgroup_int_desc_lv,
 itemgroup_int_desc_ni,
 itemgroup_int_desc_nl,
 itemgroup_int_desc_de,
 itemgroup_int_desc_pl,
 itemgroup_int_desc_pt,
 itemgroup_int_desc_ro,
 itemgroup_int_desc_se,
 itemgroup_int_desc_si,
 itemgroup_int_desc_sk,
 itemgroup_int_desc_cs,
 itemgroup_int_desc_mt,
 itemgroup_int_desc_us,
 itemgroup_int_desc_rs
FROM ldl_p_lew_mart_msi.t_itm_itemgroup_int_1;