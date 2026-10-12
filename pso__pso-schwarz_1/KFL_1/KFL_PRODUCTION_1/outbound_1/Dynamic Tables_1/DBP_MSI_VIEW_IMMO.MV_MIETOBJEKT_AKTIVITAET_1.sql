CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_immo.mv_mietobjekt_aktivitaet_1 AS
SELECT
  mandant_id AS mandant_id,
  mo_intreno AS mo_intreno,
  MAX(
    CASE
      WHEN dat_akqu_vor_ort >= DATE_SUB(CURRENT_DATE, INTERVAL '45' DAY)
      THEN '(1) ' || FORMAT_DATE('%d.%m.%Y', dat_akqu_vor_ort) || '    '
      ELSE NULL
    END
  ) AS aktivitaet1,
  MAX(
    CASE
      WHEN dat_akqu_wettbewerber >= DATE_SUB(CURRENT_DATE, INTERVAL '45' DAY)
      THEN '(2) ' || FORMAT_DATE('%d.%m.%Y', dat_akqu_wettbewerber) || '    '
      ELSE NULL
    END
  ) AS aktivitaet2,
  MAX(
    CASE
      WHEN dat_akqu_ansprache_filialist >= DATE_SUB(CURRENT_DATE, INTERVAL '45' DAY)
      THEN '(3) ' || FORMAT_DATE('%d.%m.%Y', dat_akqu_ansprache_filialist) || '    '
      ELSE NULL
    END
  ) AS aktivitaet3,
  MAX(
    CASE
      WHEN dat_akqu_ansprache_mieter >= DATE_SUB(CURRENT_DATE, INTERVAL '45' DAY)
      THEN '(4) ' || FORMAT_DATE('%d.%m.%Y', dat_akqu_ansprache_mieter) || '    '
      ELSE NULL
    END
  ) AS aktivitaet4,
  MAX(
    CASE
      WHEN dat_akqu_info_hl_ma_praemie >= DATE_SUB(CURRENT_DATE, INTERVAL '45' DAY)
      THEN '(5) ' || FORMAT_DATE('%d.%m.%Y', dat_akqu_info_hl_ma_praemie) || '    '
      ELSE NULL
    END
  ) AS aktivitaet5,
  MAX(
    CASE
      WHEN dat_akqu_flaeche_verblendung >= DATE_SUB(CURRENT_DATE, INTERVAL '45' DAY)
      THEN '(6) ' || FORMAT_DATE('%d.%m.%Y', dat_akqu_flaeche_verblendung) || '    '
      ELSE NULL
    END
  ) AS aktivitaet6,
  MAX(
    CASE
      WHEN dat_akqu_teambesprechung >= DATE_SUB(CURRENT_DATE, INTERVAL '45' DAY)
      THEN '(7) ' || FORMAT_DATE('%d.%m.%Y', dat_akqu_teambesprechung) || '    '
      ELSE NULL
    END
  ) AS aktivitaet7,
  MAX(
    CASE
      WHEN dat_akqu_angebot_homepage >= DATE_SUB(CURRENT_DATE, INTERVAL '45' DAY)
      THEN '(8) ' || FORMAT_DATE('%d.%m.%Y', dat_akqu_angebot_homepage) || '    '
      ELSE NULL
    END
  ) AS aktivitaet8,
  MAX(
    CASE
      WHEN dat_akqu_internetrecherche >= DATE_SUB(CURRENT_DATE, INTERVAL '45' DAY)
      THEN '(9) ' || FORMAT_DATE('%d.%m.%Y', dat_akqu_internetrecherche) || '    '
      ELSE NULL
    END
  ) AS aktivitaet9,
  MAX(
    CASE
      WHEN dat_akqu_spanntranspar_geb >= DATE_SUB(CURRENT_DATE, INTERVAL '45' DAY)
      THEN '(10) ' || FORMAT_DATE('%d.%m.%Y', dat_akqu_spanntranspar_geb) || '    '
      ELSE NULL
    END
  ) AS aktivitaet10,
  MAX(
    CASE
      WHEN dat_akqu_inserat_tageszeitung >= DATE_SUB(CURRENT_DATE, INTERVAL '45' DAY)
      THEN '(11) ' || FORMAT_DATE('%d.%m.%Y', dat_akqu_inserat_tageszeitung) || '    '
      ELSE NULL
    END
  ) AS aktivitaet11,
  MAX(
    CASE
      WHEN dat_akqu_inserat_tip >= DATE_SUB(CURRENT_DATE, INTERVAL '45' DAY)
      THEN '(12) ' || FORMAT_DATE('%d.%m.%Y', dat_akqu_inserat_tip) || '    '
      ELSE NULL
    END
  ) AS aktivitaet12,
  MAX(
    CASE
      WHEN dat_akqu_telefon >= DATE_SUB(CURRENT_DATE, INTERVAL '45' DAY)
      THEN '(13) ' || FORMAT_DATE('%d.%m.%Y', dat_akqu_telefon) || '    '
      ELSE NULL
    END
  ) AS aktivitaet13,
  MAX(
    CASE
      WHEN dat_akqu_amt_wirtschaftsfoerderung >= DATE_SUB(CURRENT_DATE, INTERVAL '45' DAY)
      THEN '(14) ' || FORMAT_DATE('%d.%m.%Y', dat_akqu_amt_wirtschaftsfoerderung) || '    '
      ELSE NULL
    END
  ) AS aktivitaet14,
  MAX(
    CASE
      WHEN dat_akqu_suche_biete >= DATE_SUB(CURRENT_DATE, INTERVAL '45' DAY)
      THEN '(15) ' || FORMAT_DATE('%d.%m.%Y', dat_akqu_suche_biete) || '    '
      ELSE NULL
    END
  ) AS aktivitaet15,
  MAX(
    CASE
      WHEN dat_akqu_internetauktion >= DATE_SUB(CURRENT_DATE, INTERVAL '45' DAY)
      THEN '(16) ' || FORMAT_DATE('%d.%m.%Y', dat_akqu_internetauktion) || '    '
      ELSE NULL
    END
  ) AS aktivitaet16,
  MAX(
    CASE
      WHEN dat_akqu_sonstige >= DATE_SUB(CURRENT_DATE, INTERVAL '45' DAY)
      THEN '(17) ' || FORMAT_DATE('%d.%m.%Y', dat_akqu_sonstige) || '    '
      ELSE NULL
    END
  ) AS aktivitaet17,
  COALESCE(
    MAX(
      CASE
        WHEN dat_akqu_vor_ort >= DATE_SUB(CURRENT_DATE, INTERVAL '45' DAY)
        THEN '(1) ' || FORMAT_DATE('%d.%m.%Y', dat_akqu_vor_ort) || '    '
        ELSE NULL
      END
    ),
    ''
  ) || COALESCE(
    MAX(
      CASE
        WHEN dat_akqu_wettbewerber >= DATE_SUB(CURRENT_DATE, INTERVAL '45' DAY)
        THEN '(2) ' || FORMAT_DATE('%d.%m.%Y', dat_akqu_wettbewerber) || '    '
        ELSE NULL
      END
    ),
    ''
  ) || COALESCE(
    MAX(
      CASE
        WHEN dat_akqu_ansprache_filialist >= DATE_SUB(CURRENT_DATE, INTERVAL '45' DAY)
        THEN '(3) ' || FORMAT_DATE('%d.%m.%Y', dat_akqu_ansprache_filialist) || '    '
        ELSE NULL
      END
    ),
    ''
  ) || COALESCE(
    MAX(
      CASE
        WHEN dat_akqu_ansprache_mieter >= DATE_SUB(CURRENT_DATE, INTERVAL '45' DAY)
        THEN '(4) ' || FORMAT_DATE('%d.%m.%Y', dat_akqu_ansprache_mieter) || '    '
        ELSE NULL
      END
    ),
    ''
  ) || COALESCE(
    MAX(
      CASE
        WHEN dat_akqu_info_hl_ma_praemie >= DATE_SUB(CURRENT_DATE, INTERVAL '45' DAY)
        THEN '(5) ' || FORMAT_DATE('%d.%m.%Y', dat_akqu_info_hl_ma_praemie) || '    '
        ELSE NULL
      END
    ),
    ''
  ) || COALESCE(
    MAX(
      CASE
        WHEN dat_akqu_flaeche_verblendung >= DATE_SUB(CURRENT_DATE, INTERVAL '45' DAY)
        THEN '(6) ' || FORMAT_DATE('%d.%m.%Y', dat_akqu_flaeche_verblendung) || '    '
        ELSE NULL
      END
    ),
    ''
  ) || COALESCE(
    MAX(
      CASE
        WHEN dat_akqu_teambesprechung >= DATE_SUB(CURRENT_DATE, INTERVAL '45' DAY)
        THEN '(7) ' || FORMAT_DATE('%d.%m.%Y', dat_akqu_teambesprechung) || '    '
        ELSE NULL
      END
    ),
    ''
  ) || COALESCE(
    MAX(
      CASE
        WHEN dat_akqu_angebot_homepage >= DATE_SUB(CURRENT_DATE, INTERVAL '45' DAY)
        THEN '(8) ' || FORMAT_DATE('%d.%m.%Y', dat_akqu_angebot_homepage) || '    '
        ELSE NULL
      END
    ),
    ''
  ) || COALESCE(
    MAX(
      CASE
        WHEN dat_akqu_internetrecherche >= DATE_SUB(CURRENT_DATE, INTERVAL '45' DAY)
        THEN '(9) ' || FORMAT_DATE('%d.%m.%Y', dat_akqu_internetrecherche) || '    '
        ELSE NULL
      END
    ),
    ''
  ) || COALESCE(
    MAX(
      CASE
        WHEN dat_akqu_spanntranspar_geb >= DATE_SUB(CURRENT_DATE, INTERVAL '45' DAY)
        THEN '(10) ' || FORMAT_DATE('%d.%m.%Y', dat_akqu_spanntranspar_geb) || '    '
        ELSE NULL
      END
    ),
    ''
  ) || COALESCE(
    MAX(
      CASE
        WHEN dat_akqu_inserat_tageszeitung >= DATE_SUB(CURRENT_DATE, INTERVAL '45' DAY)
        THEN '(11) ' || FORMAT_DATE('%d.%m.%Y', dat_akqu_inserat_tageszeitung) || '    '
        ELSE NULL
      END
    ),
    ''
  ) || COALESCE(
    MAX(
      CASE
        WHEN dat_akqu_inserat_tip >= DATE_SUB(CURRENT_DATE, INTERVAL '45' DAY)
        THEN '(12) ' || FORMAT_DATE('%d.%m.%Y', dat_akqu_inserat_tip) || '    '
        ELSE NULL
      END
    ),
    ''
  ) || COALESCE(
    MAX(
      CASE
        WHEN dat_akqu_telefon >= DATE_SUB(CURRENT_DATE, INTERVAL '45' DAY)
        THEN '(13) ' || FORMAT_DATE('%d.%m.%Y', dat_akqu_telefon) || '    '
        ELSE NULL
      END
    ),
    ''
  ) || COALESCE(
    MAX(
      CASE
        WHEN dat_akqu_amt_wirtschaftsfoerderung >= DATE_SUB(CURRENT_DATE, INTERVAL '45' DAY)
        THEN '(14) ' || FORMAT_DATE('%d.%m.%Y', dat_akqu_amt_wirtschaftsfoerderung) || '    '
        ELSE NULL
      END
    ),
    ''
  ) || COALESCE(
    MAX(
      CASE
        WHEN dat_akqu_suche_biete >= DATE_SUB(CURRENT_DATE, INTERVAL '45' DAY)
        THEN '(15) ' || FORMAT_DATE('%d.%m.%Y', dat_akqu_suche_biete) || '    '
        ELSE NULL
      END
    ),
    ''
  ) || COALESCE(
    MAX(
      CASE
        WHEN dat_akqu_internetauktion >= DATE_SUB(CURRENT_DATE, INTERVAL '45' DAY)
        THEN '(16) ' || FORMAT_DATE('%d.%m.%Y', dat_akqu_internetauktion) || '    '
        ELSE NULL
      END
    ),
    ''
  ) || COALESCE(
    MAX(
      CASE
        WHEN dat_akqu_sonstige >= DATE_SUB(CURRENT_DATE, INTERVAL '45' DAY)
        THEN '(17) ' || FORMAT_DATE('%d.%m.%Y', dat_akqu_sonstige) || '    '
        ELSE NULL
      END
    ),
    ''
  ) AS aktivitaeten_gesamt,
  MAX(akqu_ergebnis) AS ergebniss
FROM kfl_production_dbp_view.v_immo_mietobjekt_1 AS mo
GROUP BY
  mandant_id,
  mo_intreno;
