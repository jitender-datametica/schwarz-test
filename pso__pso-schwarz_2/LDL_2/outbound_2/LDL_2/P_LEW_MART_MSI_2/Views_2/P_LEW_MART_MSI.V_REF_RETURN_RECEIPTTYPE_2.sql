CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_ref_return_receipttype_2 (return_receipttype_id
OPTIONS(description='Return_k Bez. Einheit id'), return_receipttype_desc_at
OPTIONS(description='Return_k Landesspezifische Bezeichnung Einheit AT'), return_receipttype_desc_be
OPTIONS(description='Return_k Landesspezifische Bezeichnung Einheit BE'), return_receipttype_desc_be_fr
OPTIONS(description='Return_k Landesspezifische Bezeichnung Einheit BE_FR'), return_receipttype_desc_bg
OPTIONS(description='Return_k Landesspezifische Bezeichnung Einheit BG'), return_receipttype_desc_ch
OPTIONS(description='Return_k Landesspezifische Bezeichnung Einheit CH'), return_receipttype_desc_cy
OPTIONS(description='Return_k Landesspezifische Bezeichnung Einheit CY'), return_receipttype_desc_cz
OPTIONS(description='Return_k Landesspezifische Bezeichnung Einheit CZ'), return_receipttype_desc
OPTIONS(description='Return_k Bez. Einheit desc'), return_receipttype_desc_dk
OPTIONS(description='Return_k Landesspezifische Bezeichnung Einheit DK'), return_receipttype_desc_ee
OPTIONS(description='Return_k Landesspezifische Bezeichnung Einheit EE'), return_receipttype_desc_es
OPTIONS(description='Return_k Landesspezifische Bezeichnung Einheit ES'), return_receipttype_desc_fi
OPTIONS(description='Return_k Landesspezifische Bezeichnung Einheit FI'), return_receipttype_desc_fr
OPTIONS(description='Return_k Landesspezifische Bezeichnung Einheit FR'), return_receipttype_desc_gb
OPTIONS(description='Return_k Landesspezifische Bezeichnung Einheit GB'), return_receipttype_desc_gr
OPTIONS(description='Return_k Landesspezifische Bezeichnung Einheit GR'), return_receipttype_desc_hr
OPTIONS(description='Return_k Landesspezifische Bezeichnung Einheit HR'), return_receipttype_desc_hu
OPTIONS(description='Return_k Landesspezifische Bezeichnung Einheit HU'), return_receipttype_desc_ie
OPTIONS(description='Return_k Landesspezifische Bezeichnung Einheit IE'), return_receipttype_desc_it
OPTIONS(description='Return_k Landesspezifische Bezeichnung Einheit IT'), return_receipttype_desc_lt
OPTIONS(description='Return_k Landesspezifische Bezeichnung Einheit LT'), return_receipttype_desc_lv
OPTIONS(description='Return_k Landesspezifische Bezeichnung Einheit LV'), return_receipttype_desc_ni
OPTIONS(description='Return_k Landesspezifische Bezeichnung Einheit NI'), return_receipttype_desc_nl
OPTIONS(description='Return_k Landesspezifische Bezeichnung Einheit NL'), return_receipttype_desc_de
OPTIONS(description='Return_k Landesspezifische Bezeichnung Einheit DE'), return_receipttype_desc_pl
OPTIONS(description='Return_k Landesspezifische Bezeichnung Einheit PL'), return_receipttype_desc_pt
OPTIONS(description='Return_k Landesspezifische Bezeichnung Einheit PT'), return_receipttype_desc_ro
OPTIONS(description='Return_k Landesspezifische Bezeichnung Einheit RO'), return_receipttype_desc_se
OPTIONS(description='Return_k Landesspezifische Bezeichnung Einheit SE'), return_receipttype_desc_si
OPTIONS(description='Return_k Landesspezifische Bezeichnung Einheit SI'), return_receipttype_desc_sk
OPTIONS(description='Return_k Landesspezifische Bezeichnung Einheit SK'), return_receipttype_desc_cs
OPTIONS(description='Return_k Landesspezifische Bezeichnung Einheit CS'), return_receipttype_desc_mt
OPTIONS(description='Return_k Landesspezifische Bezeichnung Einheit MT'), return_receipttype_desc_us
OPTIONS(description='Return_k Landesspezifische Bezeichnung Einheit US'), return_receipttype_desc_rs
OPTIONS(description='Return_k Landesspezifische Bezeichnung Einheit RS_2'))
OPTIONS(DESCRIPTION = `MULTI LANGUAGE RETURN RECEIPT TYPE REFERENCE`) AS SELECT return_receipttype_id,
 MAX(CASE
   WHEN language_id = 1
   THEN return_receipttype_desc
   ELSE NULL
   END) AS return_receipttype_desc_at,
 MAX(CASE
   WHEN language_id = 2
   THEN return_receipttype_desc
   ELSE NULL
   END) AS return_receipttype_desc_be,
 MAX(CASE
   WHEN language_id = 12
   THEN return_receipttype_desc
   ELSE NULL
   END) AS return_receipttype_desc_be_fr,
 MAX(CASE
   WHEN language_id = 3
   THEN return_receipttype_desc
   ELSE NULL
   END) AS return_receipttype_desc_bg,
 MAX(CASE
   WHEN language_id = 4
   THEN return_receipttype_desc
   ELSE NULL
   END) AS return_receipttype_desc_ch,
 MAX(CASE
   WHEN language_id = 5
   THEN return_receipttype_desc
   ELSE NULL
   END) AS return_receipttype_desc_cy,
 MAX(CASE
   WHEN language_id = 6
   THEN return_receipttype_desc
   ELSE NULL
   END) AS return_receipttype_desc_cz,
 MAX(CASE
   WHEN language_id = 7
   THEN return_receipttype_desc
   ELSE NULL
   END) AS return_receipttype_desc,
 MAX(CASE
   WHEN language_id = 8
   THEN return_receipttype_desc
   ELSE NULL
   END) AS return_receipttype_desc_dk,
 MAX(CASE
   WHEN language_id = 9
   THEN return_receipttype_desc
   ELSE NULL
   END) AS return_receipttype_desc_ee,
 MAX(CASE
   WHEN language_id IN (10, 31)
   THEN return_receipttype_desc
   ELSE NULL
   END) AS return_receipttype_desc_es,
 MAX(CASE
   WHEN language_id = 11
   THEN return_receipttype_desc
   ELSE NULL
   END) AS return_receipttype_desc_fi,
 MAX(CASE
   WHEN language_id = 12
   THEN return_receipttype_desc
   ELSE NULL
   END) AS return_receipttype_desc_fr,
 MAX(CASE
   WHEN language_id = 13
   THEN return_receipttype_desc
   ELSE NULL
   END) AS return_receipttype_desc_gb,
 MAX(CASE
   WHEN language_id IN (14, 5)
   THEN return_receipttype_desc
   ELSE NULL
   END) AS return_receipttype_desc_gr,
 MAX(CASE
   WHEN language_id = 15
   THEN return_receipttype_desc
   ELSE NULL
   END) AS return_receipttype_desc_hr,
 MAX(CASE
   WHEN language_id = 16
   THEN return_receipttype_desc
   ELSE NULL
   END) AS return_receipttype_desc_hu,
 MAX(CASE
   WHEN language_id IN (17, 21)
   THEN return_receipttype_desc
   ELSE NULL
   END) AS return_receipttype_desc_ie,
 MAX(CASE
   WHEN language_id IN (18, 32)
   THEN return_receipttype_desc
   ELSE NULL
   END) AS return_receipttype_desc_it,
 MAX(CASE
   WHEN language_id = 19
   THEN return_receipttype_desc
   ELSE NULL
   END) AS return_receipttype_desc_lt,
 MAX(CASE
   WHEN language_id = 20
   THEN return_receipttype_desc
   ELSE NULL
   END) AS return_receipttype_desc_lv,
 MAX(CASE
   WHEN language_id = 21
   THEN return_receipttype_desc
   ELSE NULL
   END) AS return_receipttype_desc_ni,
 MAX(CASE
   WHEN language_id = 22
   THEN return_receipttype_desc
   ELSE NULL
   END) AS return_receipttype_desc_nl,
 MAX(CASE
   WHEN language_id = 23
   THEN return_receipttype_desc
   ELSE NULL
   END) AS return_receipttype_desc_de,
 MAX(CASE
   WHEN language_id = 24
   THEN return_receipttype_desc
   ELSE NULL
   END) AS return_receipttype_desc_pl,
 MAX(CASE
   WHEN language_id = 25
   THEN return_receipttype_desc
   ELSE NULL
   END) AS return_receipttype_desc_pt,
 MAX(CASE
   WHEN language_id = 26
   THEN return_receipttype_desc
   ELSE NULL
   END) AS return_receipttype_desc_ro,
 MAX(CASE
   WHEN language_id = 27
   THEN return_receipttype_desc
   ELSE NULL
   END) AS return_receipttype_desc_se,
 MAX(CASE
   WHEN language_id = 28
   THEN return_receipttype_desc
   ELSE NULL
   END) AS return_receipttype_desc_si,
 MAX(CASE
   WHEN language_id = 29
   THEN return_receipttype_desc
   ELSE NULL
   END) AS return_receipttype_desc_sk,
 MAX(CASE
   WHEN language_id = 31
   THEN return_receipttype_desc
   ELSE NULL
   END) AS return_receipttype_desc_cs,
 MAX(CASE
   WHEN language_id = 32
   THEN return_receipttype_desc
   ELSE NULL
   END) AS return_receipttype_desc_mt,
 MAX(CASE
   WHEN language_id = 33
   THEN return_receipttype_desc
   ELSE NULL
   END) AS return_receipttype_desc_us,
 MAX(CASE
   WHEN language_id = 34
   THEN return_receipttype_desc
   ELSE NULL
   END) AS return_receipttype_desc_rs
FROM ldl_p_lew_core_ac.v_wawi_ref_return_receipttype_2
GROUP BY return_receipttype_id;