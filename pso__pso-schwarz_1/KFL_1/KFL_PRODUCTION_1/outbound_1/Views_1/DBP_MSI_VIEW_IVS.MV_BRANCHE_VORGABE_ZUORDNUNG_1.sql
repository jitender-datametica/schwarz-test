CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ivs.mv_branche_vorgabe_zuordnung_1 AS
-- Vorgabe Immo-Verwaltungskosten
 -- Techn. Platz Kaufland Baecker
 SELECT MVF.mandant_id,
 MVF.immo_objekt_id,
 IMR.miet_region_id,
 IMR.bl_id,
 MVF.flaeche_id,
 MVF.mietvertrag_id,
 MVF.dat_flaeche_uebergabe,
 MVF.dat_flaeche_rueckgabe,
 MVF.branche_id,
 MV.konzessionaer_id,
 FP.flaeche_groesse,
 wcm.bonanzahl_jahr AS kunden_anzahl_jahr,
 BV.branche_mix,
 BV.vorgabe_prozent -- Vorgabe Umsatzmiete%
,
 BV.vorgabe_betrag -- Vorgabe durchs. EK
,
 BV.vorgabe_prodvt -- Vorgabe Produktivit‰t
,
 BV.vorgabe_miete -- Vorgabe Miete pro m2
,
 BV.vorgabe_achsen_abschnitt,
 BV.vorgabe_steigung,
 CAST(CASE
   WHEN MVF.mandant_id = 1
   THEN CASE
    WHEN FP.flaeche_groesse BETWEEN 0 AND 50
    THEN 77
    WHEN FP.flaeche_groesse BETWEEN 50.01 AND 249.99
    THEN 100
    WHEN FP.flaeche_groesse BETWEEN 250 AND 999999
    THEN 120
    ELSE NULL
    END
   ELSE CASE
    WHEN MVF.branche_id <> '120'
    THEN 65 -- irrelevant, da 120 = Bankomat in KMO

    ELSE NULL
    END
   END AS NUMERIC) AS vorgabe_immo_vw,
  BV.vorgabe_betrag * 0.7 AS temp_einkauf,
 ROUND(CAST(wcm.bonanzahl_jahr * BV.vorgabe_steigung + BV.vorgabe_achsen_abschnitt AS NUMERIC), 4) AS kalk_einkauf,
 ROUND(CAST(CASE
    WHEN BV.mandant_id = 1
    THEN CASE
     WHEN COALESCE(ROUND(CAST(wcm.bonanzahl_jahr * BV.vorgabe_steigung + BV.vorgabe_achsen_abschnitt AS NUMERIC), 4), 0
       ) < COALESCE(BV.vorgabe_betrag * 0.7, 0)
     THEN BV.vorgabe_betrag * 0.7
     ELSE ROUND(CAST(wcm.bonanzahl_jahr * BV.vorgabe_steigung + BV.vorgabe_achsen_abschnitt AS NUMERIC), 4)
     END
    ELSE BV.vorgabe_betrag
    END AS NUMERIC), 4) AS wsa_opt_einkauf,
  wcm.bonanzahl_jahr * ROUND(CAST(CASE
     WHEN BV.mandant_id = 1
     THEN CASE
      WHEN COALESCE(ROUND(CAST(wcm.bonanzahl_jahr * BV.vorgabe_steigung + BV.vorgabe_achsen_abschnitt AS NUMERIC), 4), 0
        ) < COALESCE(BV.vorgabe_betrag * 0.7, 0)
      THEN BV.vorgabe_betrag * 0.7
      ELSE ROUND(CAST(wcm.bonanzahl_jahr * BV.vorgabe_steigung + BV.vorgabe_achsen_abschnitt AS NUMERIC), 4)
      END
     ELSE BV.vorgabe_betrag
     END AS NUMERIC), 4) AS wsa_zielumsatz,
  BV.vorgabe_prodvt * 1.2 AS wsa_opt_prodvt,
  CASE
  WHEN BV.vorgabe_prodvt * 1.2 <> 0
  THEN TRUNC(wcm.bonanzahl_jahr * ROUND(CAST(CASE
        WHEN BV.mandant_id = 1
        THEN CASE
         WHEN COALESCE(ROUND(CAST(wcm.bonanzahl_jahr * BV.vorgabe_steigung + BV.vorgabe_achsen_abschnitt AS NUMERIC), 4
            ), 0) < COALESCE(BV.vorgabe_betrag * 0.7, 0)
         THEN BV.vorgabe_betrag * 0.7
         ELSE ROUND(CAST(wcm.bonanzahl_jahr * BV.vorgabe_steigung + BV.vorgabe_achsen_abschnitt AS NUMERIC), 4)
         END
        ELSE BV.vorgabe_betrag
        END AS NUMERIC), 4) / (BV.vorgabe_prodvt * 1.2))
  ELSE 0
  END AS wsa_opt_flaeche,
   wcm.bonanzahl_jahr * ROUND(CAST(CASE
      WHEN BV.mandant_id = 1
      THEN CASE
       WHEN COALESCE(ROUND(CAST(wcm.bonanzahl_jahr * BV.vorgabe_steigung + BV.vorgabe_achsen_abschnitt AS NUMERIC), 4),
         0) < COALESCE(BV.vorgabe_betrag * 0.7, 0)
       THEN BV.vorgabe_betrag * 0.7
       ELSE ROUND(CAST(wcm.bonanzahl_jahr * BV.vorgabe_steigung + BV.vorgabe_achsen_abschnitt AS NUMERIC), 4)
       END
      ELSE BV.vorgabe_betrag
      END AS NUMERIC), 4) * BV.vorgabe_prozent AS wsa_umsatzmiete_jahr,
 TRUNC(wcm.bonanzahl_jahr * ROUND(CAST(CASE
        WHEN BV.mandant_id = 1
        THEN CASE
         WHEN COALESCE(ROUND(CAST(wcm.bonanzahl_jahr * BV.vorgabe_steigung + BV.vorgabe_achsen_abschnitt AS NUMERIC), 4
            ), 0) < COALESCE(BV.vorgabe_betrag * 0.7, 0)
         THEN BV.vorgabe_betrag * 0.7
         ELSE ROUND(CAST(wcm.bonanzahl_jahr * BV.vorgabe_steigung + BV.vorgabe_achsen_abschnitt AS NUMERIC), 4)
         END
        ELSE BV.vorgabe_betrag
        END AS NUMERIC), 4) * BV.vorgabe_prozent / 12) AS wsa_umsatzmiete,
  BV.vorgabe_miete * FP.flaeche_groesse AS wsa_mindestmiete,
  CASE
  WHEN COALESCE(BV.vorgabe_miete * FP.flaeche_groesse, 0) > COALESCE(TRUNC(wcm.bonanzahl_jahr * ROUND(CAST(CASE
           WHEN BV.mandant_id = 1
           THEN CASE
            WHEN COALESCE(ROUND(CAST(wcm.bonanzahl_jahr * BV.vorgabe_steigung + BV.vorgabe_achsen_abschnitt AS NUMERIC)
               , 4), 0) < COALESCE(BV.vorgabe_betrag * 0.7, 0)
            THEN BV.vorgabe_betrag * 0.7
            ELSE ROUND(CAST(wcm.bonanzahl_jahr * BV.vorgabe_steigung + BV.vorgabe_achsen_abschnitt AS NUMERIC), 4)
            END
           ELSE BV.vorgabe_betrag
           END AS NUMERIC), 4) * BV.vorgabe_prozent / 12), 0)
  THEN CAST(BV.vorgabe_miete * FP.flaeche_groesse AS FLOAT64)
  ELSE TRUNC(wcm.bonanzahl_jahr * ROUND(CAST(CASE
         WHEN BV.mandant_id = 1
         THEN CASE
          WHEN COALESCE(ROUND(CAST(wcm.bonanzahl_jahr * BV.vorgabe_steigung + BV.vorgabe_achsen_abschnitt AS NUMERIC), 4
             ), 0) < COALESCE(BV.vorgabe_betrag * 0.7, 0)
          THEN BV.vorgabe_betrag * 0.7
          ELSE ROUND(CAST(wcm.bonanzahl_jahr * BV.vorgabe_steigung + BV.vorgabe_achsen_abschnitt AS NUMERIC), 4)
          END
         ELSE BV.vorgabe_betrag
         END AS NUMERIC), 4) * BV.vorgabe_prozent / 12)
  END AS wsa_miete,
  t6.konz_umsatz_monat * TRUNC(CAST(ROUND(CAST(MVF.miete_umsatz_prozent AS NUMERIC), 2) / 100 AS BIGNUMERIC)) AS
 kalk_umsatzmiete,
  CASE
  WHEN BV.mandant_id = 3
  THEN CASE
   WHEN t6.konz_umsatz_monat * TRUNC(CAST(ROUND(CAST(MVF.miete_umsatz_prozent AS NUMERIC), 2) / 100 AS BIGNUMERIC)) >
    MVF.miete_betrag
   THEN t6.konz_umsatz_monat * TRUNC(CAST(ROUND(CAST(MVF.miete_umsatz_prozent AS NUMERIC), 2) / 100 AS BIGNUMERIC)) -
    MVF.miete_betrag
   ELSE NULL
   END
  ELSE NULL
  END AS kalk_umsatzmiete_abschlag,
 BV.wrg_id,
 BV.wrg_typ_id
FROM kfl_production_dbp_msi_v_view.v_ivs_mietvtg_fl_zu_per_msi_1 AS MVF
 INNER JOIN kfl_production_dbp_view.v_ivs_mietvertrag_per_1 AS MV ON MVF.mietvertrag_id = MV.mietvertrag_id AND MVF.mandant_id
     = MV.mandant_id AND MV.dat_bis = DATE '9999-12-31'
 INNER JOIN kfl_production_dbp_view.v_ivs_flaeche_per_1 AS FP ON MVF.flaeche_id = FP.flaeche_id AND MVF.mandant_id = FP.mandant_id
     AND FP.dat_bis = DATE '9999-12-31'
 INNER JOIN kfl_production_dbp_view.v_ivs_immo_obj_miet_region_zu_1 AS IMR ON MVF.immo_objekt_id = IMR.immo_objekt_id AND
   MVF.mandant_id = IMR.mandant_id
 LEFT JOIN (SELECT WCM0.mandant_id,
   I.immo_objekt_id,
    AVG(WCM0.bonanzahl) * 12 AS bonanzahl_jahr
  FROM kfl_production_dbp_view.v_wupcal_mo_sum_1 AS WCM0
   INNER JOIN kfl_production_dbp_view.v_ivs_immo_objekt_per_1 AS I ON WCM0.mandant_id = I.mandant_id AND WCM0.wup_id = I.immo_objekt_bez
       AND I.dat_bis = DATE '9999-12-31'
   INNER JOIN kfl_production_dbp_view.v_monat_1 AS ZEIT0 ON WCM0.kjmo = ZEIT0.kjmo
  WHERE WCM0.nb_id = 0
   AND ZEIT0.akt_mo_komplett BETWEEN - 11 AND 0
  GROUP BY WCM0.mandant_id,
   I.immo_objekt_id) AS wcm ON MVF.immo_objekt_id = wcm.immo_objekt_id AND MVF.mandant_id = wcm.mandant_id
 LEFT JOIN (SELECT TP0.techn_platz_id,
   TP0.mandant_id,
   I0.immo_objekt_id,
   TP2.frische_baecker,
   TP2.discount_backshop,
   CAST(CASE
     WHEN STRPOS(TP2.frische_baecker, 'J') <> 0
     THEN 1
     WHEN STRPOS(TP2.discount_backshop, 'J') <> 0
     THEN 1
     WHEN STRPOS(TP2.frische_baecker, 'N') <> 0
     THEN 2
     ELSE 2
     END AS BIGNUMERIC) AS kaufland_baecker_fg
  FROM kfl_production_dbp_view.v_techn_platz_per_1 AS TP0
   LEFT JOIN kfl_production_dbp_view.v_techn_platz_ebene_2_per_1 AS TP2 ON TP0.techn_platz_id = TP2.techn_platz_id
   INNER JOIN kfl_production_dbp_view.v_ivs_immo_objekt_per_1 AS I0 ON TP0.mandant_id = I0.mandant_id AND TP0.wup_id = I0
      .immo_objekt_bez AND I0.dat_bis = DATE '9999-12-31'
  WHERE TP0.techn_platz_ebene_id = 2
   AND TP0.dat_bis = DATE '9999-12-31'
   AND TP2.dat_bis = DATE '9999-12-31') AS tp ON MVF.immo_objekt_id = tp.immo_objekt_id AND MVF.mandant_id = tp.mandant_id
   
 LEFT JOIN kfl_production_dbp_msi_view_ivs.mv_branche_vorgabe_1 AS BV ON MVF.mandant_id = BV.mandant_id AND MVF.branche_id
          = BV.branche_id AND (BV.konzessionaer_id = '0' OR MV.konzessionaer_id = BV.konzessionaer_id) AND IMR.miet_region_id
        = BV.miet_region_id AND IMR.bl_id = BV.bl_id AND FP.flaeche_groesse BETWEEN BV.flaeche_groesse_von AND BV.flaeche_groesse_bis
      AND wcm.bonanzahl_jahr BETWEEN BV.kunden_anzahl_von AND BV.kunden_anzahl_bis AND BV.kaufland_baecker_fg = CASE
    WHEN BV.kaufland_baecker_fg > 0
    THEN tp.kaufland_baecker_fg
    ELSE 0
    END
 LEFT JOIN (SELECT KU0.mandant_id,
   KU0.mietvertrag_id,
   KU0.konzessionaer_id,
   KU0.immo_objekt_id,
   AVG(KU0.betrag_umsatz) AS konz_umsatz_monat
  FROM kfl_production_dbp_view.v_ivs_konzessionaer_umsatz_1 AS KU0
   INNER JOIN kfl_production_dbp_view.v_monat_1 AS ZEIT00 ON KU0.kjmo = ZEIT00.kjmo
  WHERE ZEIT00.akt_kj = - 1
  GROUP BY KU0.mandant_id,
   KU0.konzessionaer_id,
   KU0.immo_objekt_id,
   KU0.mietvertrag_id) AS t6 ON MVF.mietvertrag_id = t6.mietvertrag_id AND MV.konzessionaer_id = t6.konzessionaer_id AND
    MVF.immo_objekt_id = t6.immo_objekt_id AND MVF.mandant_id = t6.mandant_id
WHERE MVF.dat_flaeche_uebergabe BETWEEN DATE '2011-01-01' AND (CURRENT_DATE)
 AND MVF.dat_flaeche_rueckgabe BETWEEN CURRENT_DATE AND DATE '9999-12-31';