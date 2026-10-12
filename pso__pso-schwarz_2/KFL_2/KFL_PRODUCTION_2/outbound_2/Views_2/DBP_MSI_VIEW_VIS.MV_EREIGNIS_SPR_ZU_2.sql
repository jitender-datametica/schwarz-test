CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_ereignis_spr_zu_2 AS SELECT ereignis_id,
 ereignistyp_id,
 mandant_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN ereignis_bez_lang
   ELSE NULL
   END) AS ereignis_bez_lang,
 MAX(CASE
   WHEN spr_id = 22
   THEN ereignis_bez_mittel
   ELSE NULL
   END) AS ereignis_bez_mittel,
 MAX(CASE
   WHEN spr_id = 22
   THEN ereignis_bez_lang
   ELSE NULL
   END) AS ereignis_bez_kurz,
 MAX(CASE
   WHEN spr_id = 22
   THEN ereignis_bez_lang
   ELSE NULL
   END) AS ereignis_bez_lang_de,
 MAX(CASE
   WHEN spr_id = 22
   THEN ereignis_bez_mittel
   ELSE NULL
   END) AS ereignis_bez_mittel_de,
 MAX(CASE
   WHEN spr_id = 22
   THEN ereignis_bez_lang
   ELSE NULL
   END) AS ereignis_bez_kurz_de,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 124
    THEN ereignis_bez_lang
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 124
    THEN ereignis_bez_lang
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN ereignis_bez_lang
    ELSE NULL
    END)
  END AS ereignis_bez_lang_cz,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 124
    THEN ereignis_bez_mittel
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 124
    THEN ereignis_bez_mittel
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN ereignis_bez_mittel
    ELSE NULL
    END)
  END AS ereignis_bez_mittel_cz,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 124
    THEN ereignis_bez_kurz
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 124
    THEN ereignis_bez_kurz
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN ereignis_bez_kurz
    ELSE NULL
    END)
  END AS ereignis_bez_kurz_cz,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 90
    THEN ereignis_bez_lang
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 90
    THEN ereignis_bez_lang
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN ereignis_bez_lang
    ELSE NULL
    END)
  END AS ereignis_bez_lang_pl,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 90
    THEN ereignis_bez_mittel
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 90
    THEN ereignis_bez_mittel
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN ereignis_bez_mittel
    ELSE NULL
    END)
  END AS ereignis_bez_mittel_pl,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 90
    THEN ereignis_bez_kurz
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 90
    THEN ereignis_bez_kurz
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN ereignis_bez_kurz
    ELSE NULL
    END)
  END AS ereignis_bez_kurz_pl,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 108
    THEN ereignis_bez_lang
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 108
    THEN ereignis_bez_lang
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN ereignis_bez_lang
    ELSE NULL
    END)
  END AS ereignis_bez_lang_sk,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 108
    THEN ereignis_bez_mittel
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 108
    THEN ereignis_bez_mittel
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN ereignis_bez_mittel
    ELSE NULL
    END)
  END AS ereignis_bez_mittel_sk,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 108
    THEN ereignis_bez_kurz
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 108
    THEN ereignis_bez_kurz
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN ereignis_bez_kurz
    ELSE NULL
    END)
  END AS ereignis_bez_kurz_sk,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 65
    THEN ereignis_bez_lang
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 65
    THEN ereignis_bez_lang
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN ereignis_bez_lang
    ELSE NULL
    END)
  END AS ereignis_bez_lang_hr,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 65
    THEN ereignis_bez_mittel
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 65
    THEN ereignis_bez_mittel
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN ereignis_bez_mittel
    ELSE NULL
    END)
  END AS ereignis_bez_mittel_hr,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 65
    THEN ereignis_bez_kurz
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 65
    THEN ereignis_bez_kurz
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN ereignis_bez_kurz
    ELSE NULL
    END)
  END AS ereignis_bez_kurz_hr,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 95
    THEN ereignis_bez_lang
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 95
    THEN ereignis_bez_lang
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN ereignis_bez_lang
    ELSE NULL
    END)
  END AS ereignis_bez_lang_ro,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 95
    THEN ereignis_bez_mittel
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 95
    THEN ereignis_bez_mittel
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN ereignis_bez_mittel
    ELSE NULL
    END)
  END AS ereignis_bez_mittel_ro,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 95
    THEN ereignis_bez_kurz
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 95
    THEN ereignis_bez_kurz
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN ereignis_bez_kurz
    ELSE NULL
    END)
  END AS ereignis_bez_kurz_ro,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 18
    THEN ereignis_bez_lang
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 18
    THEN ereignis_bez_lang
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN ereignis_bez_lang
    ELSE NULL
    END)
  END AS ereignis_bez_lang_bg,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 18
    THEN ereignis_bez_mittel
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 18
    THEN ereignis_bez_mittel
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN ereignis_bez_mittel
    ELSE NULL
    END)
  END AS ereignis_bez_mittel_bg,
  CASE
  WHEN MAX(CASE
    WHEN spr_id = 18
    THEN ereignis_bez_kurz
    ELSE NULL
    END) IS NOT NULL
  THEN MAX(CASE
    WHEN spr_id = 18
    THEN ereignis_bez_kurz
    ELSE NULL
    END)
  ELSE MAX(CASE
    WHEN spr_id = 22
    THEN ereignis_bez_kurz
    ELSE NULL
    END)
  END AS ereignis_bez_kurz_bg
FROM kfl_production_dbp_view.v_ereignis_spr_zu_2 AS V01
GROUP BY ereignis_id,
 ereignistyp_id,
 mandant_id;