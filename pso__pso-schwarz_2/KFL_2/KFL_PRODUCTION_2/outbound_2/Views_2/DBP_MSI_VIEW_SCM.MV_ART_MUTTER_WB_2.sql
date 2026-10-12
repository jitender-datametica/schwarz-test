CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_art_mutter_wb_2 (mandant_id, art_id, art_mutter_wb_id,
art_mutter_display_id, mwb_basismenge_einh_id, mwb_verpart_id, art_mutter_wb_nr, art_mutter_wb_fg, art_mutter_saison_id
, posten_id, posten_fg, art_mutter_wb_bez, art_mutter_wb_bez_de, art_mutter_wb_bez_cz, art_mutter_wb_bez_sk,
art_mutter_wb_bez_hr, art_mutter_wb_bez_pl, art_mutter_wb_bez_ro, art_mutter_wb_bez_bg) AS SELECT TRIM(CAST(ABS(CASE
     WHEN A.mandant_id = 1
     THEN COALESCE(A.mutter_wb_id, A.art_id) / 100
     ELSE COALESCE(A.mutter_wb_id, A.art_id) / 10
     END) AS STRING FORMAT '00000000')) AS mandant_id,
 COALESCE(A.mutter_wb_id, A.art_id) AS art_id,
 COALESCE(A.mutter_wb_id, A.art_id) AS art_mutter_wb_id,
  CASE
  WHEN MWB.artikeltyp_id = 12
  THEN MWB.artikeltyp_id
  ELSE MWB.display_id
  END AS art_mutter_display_id,
 MWB.basismenge_einh_id AS mwb_basismenge_einh_id,
 COALESCE(MWB.verpart_id, ' ') AS mwb_verpart_id,
 TRIM(CAST(ABS(CASE
     WHEN A.mandant_id = 1
     THEN COALESCE(A.mutter_wb_id, A.art_id) / 100
     ELSE COALESCE(A.mutter_wb_id, A.art_id) / 10
     END) AS STRING FORMAT '00000000')) AS art_mutter_wb_nr,
 CAST(CASE
   WHEN A.mutter_wb_id IS NULL
   THEN 0
   ELSE 1
   END AS BIGNUMERIC) AS art_mutter_wb_fg,
 MWB.saison_id AS art_mutter_saison_id,
 MWB.posten_id,
  CASE
  WHEN A.posten_kz_sap <> ''
  THEN 1
  ELSE 0
  END AS posten_fg,
 MAX(CASE
   WHEN MSZ.spr_id = 22
   THEN MSZ.art_bez
   ELSE NULL
   END) AS art_mutter_wb_bez,
 MAX(CASE
   WHEN MSZ.spr_id = 22
   THEN MSZ.art_bez
   ELSE NULL
   END) AS art_mutter_wb_bez_de,
 COALESCE(MAX(CASE
    WHEN MSZ.spr_id = 124
    THEN MSZ.art_bez
    ELSE NULL
    END), MAX(CASE
    WHEN MSZ.spr_id = 22
    THEN MSZ.art_bez
    ELSE NULL
    END)) AS art_mutter_wb_bez_cz,
 COALESCE(MAX(CASE
    WHEN MSZ.spr_id = 108
    THEN MSZ.art_bez
    ELSE NULL
    END), MAX(CASE
    WHEN MSZ.spr_id = 22
    THEN MSZ.art_bez
    ELSE NULL
    END)) AS art_mutter_wb_bez_bez_sk,
 COALESCE(MAX(CASE
    WHEN MSZ.spr_id = 65
    THEN MSZ.art_bez
    ELSE NULL
    END), MAX(CASE
    WHEN MSZ.spr_id = 22
    THEN MSZ.art_bez
    ELSE NULL
    END)) AS art_mutter_wb_bez_bez_hr,
 COALESCE(MAX(CASE
    WHEN MSZ.spr_id = 90
    THEN MSZ.art_bez
    ELSE NULL
    END), MAX(CASE
    WHEN MSZ.spr_id = 22
    THEN MSZ.art_bez
    ELSE NULL
    END)) AS art_mutter_wb_bez_bez_pl,
 COALESCE(MAX(CASE
    WHEN MSZ.spr_id = 95
    THEN MSZ.art_bez
    ELSE NULL
    END), MAX(CASE
    WHEN MSZ.spr_id = 22
    THEN MSZ.art_bez
    ELSE NULL
    END)) AS art_mutter_wb_bez_bez_ro,
 COALESCE(MAX(CASE
    WHEN MSZ.spr_id = 18
    THEN MSZ.art_bez
    ELSE NULL
    END), MAX(CASE
    WHEN MSZ.spr_id = 22
    THEN MSZ.art_bez
    ELSE NULL
    END)) AS art_mutter_wb_bez_bez_bg
FROM kfl_production_dbp_view.v_art_2 AS A
 INNER JOIN kfl_production_dbp_view.v_art_spr_zu_2 AS MSZ ON A.mandant_id = MSZ.mandant_id AND MSZ.art_id = COALESCE(A.mutter_wb_id
    , A.art_id)
 INNER JOIN kfl_production_dbp_view.v_art_2 AS MWB ON A.mandant_id = MWB.mandant_id AND MWB.art_id = COALESCE(A.mutter_wb_id
     , A.art_id) AND MWB.dat_bis = DATE '9999-12-31'
GROUP BY A.mandant_id,
 A.art_id,
 art_mutter_wb_id,
 art_mutter_display_id,
 mwb_basismenge_einh_id,
 mwb_verpart_id,
 art_mutter_wb_nr,
 art_mutter_wb_fg,
 art_mutter_saison_id,
 MWB.posten_id,
 posten_fg;