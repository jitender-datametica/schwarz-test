CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_itm_item_desc_2 (client_id OPTIONS(description='Landes ID'), item_id
OPTIONS(description='System intern Artikelschlüssel'), orig_item_nr OPTIONS(description='Originale Artikelnummer'),
item_desc_at OPTIONS(description='Artikel_2 Landesspezifische Bezeichnung AT'), item_desc_be
OPTIONS(description='Artikel_2 Landesspezifische Bezeichnung BE'), item_desc_be_fr
OPTIONS(description='Artikel_2 Landesspezifische Bezeichnung BE_FR'), item_desc_bg
OPTIONS(description='Artikel_2 Landesspezifische Bezeichnung BG'), item_desc_ch
OPTIONS(description='Artikel_2 Landesspezifische Bezeichnung CH'), item_desc_cy
OPTIONS(description='Artikel_2 Landesspezifische Bezeichnung CY'), item_desc_cz
OPTIONS(description='Artikel_2 Landesspezifische Bezeichnung CZ'), item_desc
OPTIONS(description='Generische Artikel_2 Bezeichnung'), item_desc_dk
OPTIONS(description='Artikel_2 Landesspezifische Bezeichnung DK'), item_desc_ee
OPTIONS(description='Artikel_2 Landesspezifische Bezeichnung EE'), item_desc_es
OPTIONS(description='Artikel_2 Landesspezifische Bezeichnung ES'), item_desc_fi
OPTIONS(description='Artikel_2 Landesspezifische Bezeichnung FI'), item_desc_fr
OPTIONS(description='Artikel_2 Landesspezifische Bezeichnung FR'), item_desc_gb
OPTIONS(description='Artikel_2 Landesspezifische Bezeichnung GB'), item_desc_gr
OPTIONS(description='Artikel_2 Landesspezifische Bezeichnung GR'), item_desc_hr
OPTIONS(description='Artikel_2 Landesspezifische Bezeichnung HR'), item_desc_hu
OPTIONS(description='Artikel_2 Landesspezifische Bezeichnung HU'), item_desc_ie
OPTIONS(description='Artikel_2 Landesspezifische Bezeichnung IE'), item_desc_it
OPTIONS(description='Artikel_2 Landesspezifische Bezeichnung IT'), item_desc_lt
OPTIONS(description='Artikel_2 Landesspezifische Bezeichnung LT'), item_desc_lv
OPTIONS(description='Artikel_2 Landesspezifische Bezeichnung LV'), item_desc_ni
OPTIONS(description='Artikel_2 Landesspezifische Bezeichnung NI'), item_desc_nl
OPTIONS(description='Artikel_2 Landesspezifische Bezeichnung NL'), item_desc_de
OPTIONS(description='Artikel_2 Landesspezifische Bezeichnung DE'), item_desc_pl
OPTIONS(description='Artikel_2 Landesspezifische Bezeichnung PL'), item_desc_pt
OPTIONS(description='Artikel_2 Landesspezifische Bezeichnung PT'), item_desc_ro
OPTIONS(description='Artikel_2 Landesspezifische Bezeichnung RO'), item_desc_se
OPTIONS(description='Artikel_2 Landesspezifische Bezeichnung SE'), item_desc_si
OPTIONS(description='Artikel_2 Landesspezifische Bezeichnung SI'), item_desc_sk
OPTIONS(description='Artikel_2 Landesspezifische Bezeichnung SK'), item_desc_cs
OPTIONS(description='Artikel_2 Landesspezifische Bezeichnung CS'), item_desc_mt
OPTIONS(description='Artikel_2 Landesspezifische Bezeichnung MT'), item_desc_us
OPTIONS(description='Artikel_2 Landesspezifische Bezeichnung US'), item_desc_rs
OPTIONS(description='Artikel_2 Landesspezifische Bezeichnung RS_2'))
OPTIONS(DESCRIPTION = `MULTI LANGUAGE ITEM_2 DESCRIPTIONS`) AS SELECT client_id,
 item_id,
 orig_item_nr,
 item_desc_at,
 item_desc_be,
 item_desc_be AS item_desc_be_fr,
 item_desc_bg,
 item_desc_ch,
 item_desc_cy,
 item_desc_cz,
 item_desc,
 item_desc_dk,
 item_desc_ee,
 item_desc_es,
 item_desc_fi,
 item_desc_fr,
 item_desc_gb,
 item_desc_gr,
 item_desc_hr,
 item_desc_hu,
 item_desc_ie,
 item_desc_it,
 item_desc_lt,
 item_desc_lv,
 item_desc_ni,
 item_desc_nl,
 item_desc_de,
 item_desc_pl,
 item_desc_pt,
 item_desc_ro,
 item_desc_se,
 item_desc_si,
 item_desc_sk,
 item_desc_cs,
 item_desc_mt,
 item_desc_us,
 item_desc_rs
FROM ldl_p_lew_mart_msi.t_itm_item_desc_2;