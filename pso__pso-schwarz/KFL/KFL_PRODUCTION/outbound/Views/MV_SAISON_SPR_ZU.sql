-- ZUSTAEZLICHE ABFRAGE AUF SAISON ID, WENN DIESE LEER IST SOLLTE AUCH DIE BEZEICHNUNG LEER SEIN UND NICHT DIE BEZEICHNUNG VON DER SPR_ZU VERWENDET WERDEN

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_nfmd.mv_saison_spr_zu (mandant_id, saison_id, saison_bez,
saison_bez_de, saison_bez_en, saison_bez_cz, saison_bez_sk, saison_bez_hr, saison_bez_pl, saison_bez_ro, saison_bez_bg)
AS SELECT mandant_id,
 saison_id,
 COALESCE(MAX(CASE
    WHEN saison_id = ''
    THEN ''
    WHEN spr_id = 22
    THEN saison_bez
    ELSE NULL
    END), 'N/A') AS saison_bez,
 COALESCE(MAX(CASE
    WHEN saison_id = ''
    THEN ''
    WHEN spr_id = 22
    THEN saison_bez
    ELSE NULL
    END), 'N/A') AS saison_bez_de,
 COALESCE(MAX(CASE
    WHEN saison_id = ''
    THEN ''
    WHEN spr_id = 24
    THEN saison_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN saison_id = ''
     THEN ''
     WHEN spr_id = 22
     THEN saison_bez
     ELSE NULL
     END), 'N/A')) AS saison_bez_en,
 COALESCE(MAX(CASE
    WHEN saison_id = ''
    THEN ''
    WHEN spr_id = 124
    THEN saison_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN saison_id = ''
     THEN ''
     WHEN spr_id = 24
     THEN saison_bez
     ELSE NULL
     END), COALESCE(MAX(CASE
      WHEN saison_id = ''
      THEN ''
      WHEN spr_id = 22
      THEN saison_bez
      ELSE NULL
      END), 'N/A'))) AS saison_bez_cz,
 COALESCE(MAX(CASE
    WHEN saison_id = ''
    THEN ''
    WHEN spr_id = 108
    THEN saison_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN saison_id = ''
     THEN ''
     WHEN spr_id = 24
     THEN saison_bez
     ELSE NULL
     END), COALESCE(MAX(CASE
      WHEN saison_id = ''
      THEN ''
      WHEN spr_id = 22
      THEN saison_bez
      ELSE NULL
      END), 'N/A'))) AS saison_bez_sk,
 COALESCE(MAX(CASE
    WHEN saison_id = ''
    THEN ''
    WHEN spr_id = 65
    THEN saison_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN saison_id = ''
     THEN ''
     WHEN spr_id = 24
     THEN saison_bez
     ELSE NULL
     END), COALESCE(MAX(CASE
      WHEN saison_id = ''
      THEN ''
      WHEN spr_id = 22
      THEN saison_bez
      ELSE NULL
      END), 'N/A'))) AS saison_bez_hr,
 COALESCE(MAX(CASE
    WHEN saison_id = ''
    THEN ''
    WHEN spr_id = 90
    THEN saison_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN saison_id = ''
     THEN ''
     WHEN spr_id = 24
     THEN saison_bez
     ELSE NULL
     END), COALESCE(MAX(CASE
      WHEN saison_id = ''
      THEN ''
      WHEN spr_id = 22
      THEN saison_bez
      ELSE NULL
      END), 'N/A'))) AS saison_bez_pl,
 COALESCE(MAX(CASE
    WHEN saison_id = ''
    THEN ''
    WHEN spr_id = 95
    THEN saison_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN saison_id = ''
     THEN ''
     WHEN spr_id = 24
     THEN saison_bez
     ELSE NULL
     END), COALESCE(MAX(CASE
      WHEN saison_id = ''
      THEN ''
      WHEN spr_id = 22
      THEN saison_bez
      ELSE NULL
      END), 'N/A'))) AS saison_bez_ro,
 COALESCE(MAX(CASE
    WHEN saison_id = ''
    THEN ''
    WHEN spr_id = 18
    THEN saison_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN saison_id = ''
     THEN ''
     WHEN spr_id = 24
     THEN saison_bez
     ELSE NULL
     END), COALESCE(MAX(CASE
      WHEN saison_id = ''
      THEN ''
      WHEN spr_id = 22
      THEN saison_bez
      ELSE NULL
      END), 'N/A'))) AS saison_bez_bg
FROM kfl_production_dbp_view.v_saison_spr_zu AS V01
GROUP BY mandant_id,
 saison_id;