CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_ref_itm_list_type_buylist_gr_2 (buying_list_type_group_id
OPTIONS(description='Gruppe_2 der Art_2 des Artikels ( Saison, ... )'), buying_list_type_group_desc_at
OPTIONS(description='Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels AT'), buying_list_type_group_desc_be
OPTIONS(description='Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels BE'), buying_list_type_group_desc_be_fr
OPTIONS(description='Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels BE_FR'), buying_list_type_group_desc_bg
OPTIONS(description='Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels BG'), buying_list_type_group_desc_ch
OPTIONS(description='Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels CH'), buying_list_type_group_desc_cy
OPTIONS(description='Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels CY'), buying_list_type_group_desc_cz
OPTIONS(description='Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels CZ'), buying_list_type_group_desc
OPTIONS(description='Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels ( Saison, ... )'),
buying_list_type_group_desc_dk OPTIONS(description='Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels DK'),
buying_list_type_group_desc_ee OPTIONS(description='Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels EE'),
buying_list_type_group_desc_es OPTIONS(description='Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels ES'),
buying_list_type_group_desc_fi OPTIONS(description='Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels FI'),
buying_list_type_group_desc_fr OPTIONS(description='Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels FR'),
buying_list_type_group_desc_gb OPTIONS(description='Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels GB'),
buying_list_type_group_desc_gr OPTIONS(description='Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels DG'),
buying_list_type_group_desc_hr OPTIONS(description='Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels HR'),
buying_list_type_group_desc_hu OPTIONS(description='Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels HU'),
buying_list_type_group_desc_ie OPTIONS(description='Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels IE'),
buying_list_type_group_desc_it OPTIONS(description='Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels IT'),
buying_list_type_group_desc_lt OPTIONS(description='Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels LT'),
buying_list_type_group_desc_lv OPTIONS(description='Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels LV'),
buying_list_type_group_desc_ni OPTIONS(description='Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels NI'),
buying_list_type_group_desc_nl OPTIONS(description='Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels NL'),
buying_list_type_group_desc_de OPTIONS(description='Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels DE'),
buying_list_type_group_desc_pl OPTIONS(description='Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels PL'),
buying_list_type_group_desc_pt OPTIONS(description='Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels PT'),
buying_list_type_group_desc_ro OPTIONS(description='Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels RO'),
buying_list_type_group_desc_se OPTIONS(description='Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels SE'),
buying_list_type_group_desc_si OPTIONS(description='Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels SI'),
buying_list_type_group_desc_sk OPTIONS(description='Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels SK'),
buying_list_type_group_desc_cs OPTIONS(description='Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels CS'),
buying_list_type_group_desc_mt OPTIONS(description='Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels MT'),
buying_list_type_group_desc_us OPTIONS(description='Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels US'),
buying_list_type_group_desc_rs OPTIONS(description='Landesspezifische Bezeichnung Gruppe_2 der Art_2 des Artikels RS_2'))
OPTIONS(DESCRIPTION = `MULTISPRACHE GRUPPEN DER ARTIKELARTEN REFERENZ`) AS SELECT buying_list_type_group_id,
 MAX(CASE
   WHEN language_id = 1
   THEN buying_list_type_group_desc
   ELSE NULL
   END) AS buying_list_type_group_desc_at,
 MAX(CASE
   WHEN language_id = 2
   THEN buying_list_type_group_desc
   ELSE NULL
   END) AS buying_list_type_group_desc_be,
 MAX(CASE
   WHEN language_id = 12
   THEN buying_list_type_group_desc
   ELSE NULL
   END) AS buying_list_type_group_desc_be_fr,
 MAX(CASE
   WHEN language_id = 3
   THEN buying_list_type_group_desc
   ELSE NULL
   END) AS buying_list_type_group_desc_bg,
 MAX(CASE
   WHEN language_id = 4
   THEN buying_list_type_group_desc
   ELSE NULL
   END) AS buying_list_type_group_desc_ch,
 MAX(CASE
   WHEN language_id = 5
   THEN buying_list_type_group_desc
   ELSE NULL
   END) AS buying_list_type_group_desc_cy,
 MAX(CASE
   WHEN language_id = 6
   THEN buying_list_type_group_desc
   ELSE NULL
   END) AS buying_list_type_group_desc_cz,
 MAX(CASE
   WHEN language_id = 7
   THEN buying_list_type_group_desc
   ELSE NULL
   END) AS buying_list_type_group_desc,
 MAX(CASE
   WHEN language_id = 8
   THEN buying_list_type_group_desc
   ELSE NULL
   END) AS buying_list_type_group_desc_dk,
 MAX(CASE
   WHEN language_id = 9
   THEN buying_list_type_group_desc
   ELSE NULL
   END) AS buying_list_type_group_desc_ee,
 MAX(CASE
   WHEN language_id IN (10, 31)
   THEN buying_list_type_group_desc
   ELSE NULL
   END) AS buying_list_type_group_desc_es,
 MAX(CASE
   WHEN language_id = 11
   THEN buying_list_type_group_desc
   ELSE NULL
   END) AS buying_list_type_group_desc_fi,
 MAX(CASE
   WHEN language_id = 12
   THEN buying_list_type_group_desc
   ELSE NULL
   END) AS buying_list_type_group_desc_fr,
 MAX(CASE
   WHEN language_id = 13
   THEN buying_list_type_group_desc
   ELSE NULL
   END) AS buying_list_type_group_desc_gb,
 MAX(CASE
   WHEN language_id IN (14, 5)
   THEN buying_list_type_group_desc
   ELSE NULL
   END) AS buying_list_type_group_desc_gr,
 MAX(CASE
   WHEN language_id = 15
   THEN buying_list_type_group_desc
   ELSE NULL
   END) AS buying_list_type_group_desc_hr,
 MAX(CASE
   WHEN language_id = 16
   THEN buying_list_type_group_desc
   ELSE NULL
   END) AS buying_list_type_group_desc_hu,
 MAX(CASE
   WHEN language_id IN (17, 21)
   THEN buying_list_type_group_desc
   ELSE NULL
   END) AS buying_list_type_group_desc_ie,
 MAX(CASE
   WHEN language_id IN (18, 32)
   THEN buying_list_type_group_desc
   ELSE NULL
   END) AS buying_list_type_group_desc_it,
 MAX(CASE
   WHEN language_id = 19
   THEN buying_list_type_group_desc
   ELSE NULL
   END) AS buying_list_type_group_desc_lt,
 MAX(CASE
   WHEN language_id = 20
   THEN buying_list_type_group_desc
   ELSE NULL
   END) AS buying_list_type_group_desc_lv,
 MAX(CASE
   WHEN language_id = 21
   THEN buying_list_type_group_desc
   ELSE NULL
   END) AS buying_list_type_group_desc_ni,
 MAX(CASE
   WHEN language_id = 22
   THEN buying_list_type_group_desc
   ELSE NULL
   END) AS buying_list_type_group_desc_nl,
 MAX(CASE
   WHEN language_id = 23
   THEN buying_list_type_group_desc
   ELSE NULL
   END) AS buying_list_type_group_desc_de,
 MAX(CASE
   WHEN language_id = 24
   THEN buying_list_type_group_desc
   ELSE NULL
   END) AS buying_list_type_group_desc_pl,
 MAX(CASE
   WHEN language_id = 25
   THEN buying_list_type_group_desc
   ELSE NULL
   END) AS buying_list_type_group_desc_pt,
 MAX(CASE
   WHEN language_id = 26
   THEN buying_list_type_group_desc
   ELSE NULL
   END) AS buying_list_type_group_desc_ro,
 MAX(CASE
   WHEN language_id = 27
   THEN buying_list_type_group_desc
   ELSE NULL
   END) AS buying_list_type_group_desc_se,
 MAX(CASE
   WHEN language_id = 28
   THEN buying_list_type_group_desc
   ELSE NULL
   END) AS buying_list_type_group_desc_si,
 MAX(CASE
   WHEN language_id = 29
   THEN buying_list_type_group_desc
   ELSE NULL
   END) AS buying_list_type_group_desc_sk,
 MAX(CASE
   WHEN language_id = 31
   THEN buying_list_type_group_desc
   ELSE NULL
   END) AS buying_list_type_group_desc_cs,
 MAX(CASE
   WHEN language_id = 32
   THEN buying_list_type_group_desc
   ELSE NULL
   END) AS buying_list_type_group_desc_mt,
 MAX(CASE
   WHEN language_id = 33
   THEN buying_list_type_group_desc
   ELSE NULL
   END) AS buying_list_type_group_desc_us,
 MAX(CASE
   WHEN language_id = 34
   THEN buying_list_type_group_desc
   ELSE NULL
   END) AS buying_list_type_group_desc_rs
FROM ldl_p_lew_core_ac.v_wawi_ref_itm_list_type_2
GROUP BY buying_list_type_group_id;