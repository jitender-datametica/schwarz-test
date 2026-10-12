-- 20150219 - kkaiser - 3-Jahresbetrachtung Auftrag # 610301

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ivs.mv_produktivitaet_2j_2 AS -- Kennzeichnung Kaufland

-- max. Wert ueber alle Flaechen!
 -- Bezug auf Berichtsmonat
 -- Bezug auf Berichtsmonat

-- Vorgabe Umsatzmiete in Prozent
 -- Vorgabe durchschnittlicher Einkauf
 -- Vorgabe Produktivitaet

-- Vorgabe Miete pro m2
 -- Vorgabe Immo-Verwaltungskosten
 -- durchschn. Grundmiete (Monat_2)

-- Produktivitaet pro Flaeche (Jahr)
 -- durchschn. Einkauf pro KL-Kunde (Monat_2)
 -- entfaellt > Dummy_2

-- entfaellt > Dummy_2
 -- entfaellt > Dummy_2
 -- entfaellt > Dummy_2
 -- entfaellt > Dummy_2
 -- entfaellt > Dummy_2

-- WSA optimierter Einkauf
 -- WSA Zielumsatz
 -- WSA optimierte Produktivitaet
 -- WSA optimierte Flaeche

-- WSA Umsatzmiete
 -- WSA Mindestmiete
 -- WSA Miete
 /* NICHT MEHR VERWENDET - ENDE */
/* Basisdaten Berichtsmonat (Buchungsschluss) */ -- NEU aus Flaeche
 /* SBW Anzahl Kunden und Umsatz aus VIS Aggregat */
/* IST Werte fuer akt. (und kuenftiges) GJ */
/* Flag : KL Diskountbackshop, Frischebaecker, Backshop in Bedienung vorhanden aus WUP_2 */
/* Konzessionaer Umsatz (ohne Mapping SBW Kunden + Grundmiete) */
/* Konzessionaer Umsatz : Ermittlung/Ranking 12 Monate */ -- kkai HIER
 SELECT ivs.mandant_id,
 ivs.konzessionaer_id,
 ivs.mietvertrag_id,
 ivs.immo_objekt_id,
 ivs.immo_objekt_bez,
 COALESCE(wup_dn.bed_backshop_fg, 0) AS kl_backshop_fg,
 IMR.miet_region_id,
 IMR.bl_id,
 ivs.branche_id,
 ivs.wrg_id,
 ivs.wrg_typ_id,
 ivs.kjmo,
 ivs.kjmo AS kjmo_direkt,
 ivs.grundmiete,
 ivs.nebenkosten,
 ivs.umsmietabschlag,
 TRUNC(CAST(ivs.umsmieteproz / 100.00 AS BIGNUMERIC)) AS umsmieteproz,
 MOD(ivs.umsmieteproz * 10000, 10) AS umsmiete_fg,
 ivs.immovwkosten,
 ivs.vertragart_id,
  CASE
  WHEN ivs.dat_vertrag_beginn BETWEEN PARSE_DATE('%F', '1900-01-31') AND ivs.max_dat
  THEN TRUNC(CAST(DATE_DIFF(ivs.dat_vertrag_beginn, ivs.max_dat, DAY) / 30 AS BIGNUMERIC))
  ELSE CAST(- 1 AS BIGNUMERIC)
  END AS laufzeit_beginn,
  CASE
  WHEN ivs.dat_vertrag_ende BETWEEN ivs.max_dat AND (PARSE_DATE('%F', '9999-01-01'))
  THEN TRUNC(CAST(DATE_DIFF(ivs.dat_vertrag_ende, ivs.max_dat, DAY) / 30 AS BIGNUMERIC))
  ELSE CAST(- 1 AS BIGNUMERIC)
  END AS laufzeit_ende,
 ivs.dat_vertrag_beginn,
 ivs.dat_vertrag_ende,
 ivs.flaechenstatus -- max. Wert ueber alle Flaechen (aus flaeche_per)
,
 ivs.flaechennutzung -- max. Wert ueber alle Flaechen!
,
 ivs.flaechentyp -- max. Wert ueber alle Flaechen!
,
 ivs.objektanzahl -- zaehlt auch mehrere Flaechen
,
 ivs.flaechenanzahl,
 ivs.flaechengroesse,
 BV.flaeche_groesse_von -- Vorgabe Flaechengroesse von
,
 BV.flaeche_groesse_bis -- Vorgabe Flaechengroesse bis
,
 BV.vorgabe_prozent AS umsatzmiete_bv,
 BV.vorgabe_betrag AS einkauf_bv,
 BV.vorgabe_prodvt AS produktivitaet_bv,
 BV.vorgabe_miete AS miete_bv,
 CAST(CASE
   WHEN ivs.mandant_id = 1
   THEN CASE
    WHEN ivs.flaechengroesse > 250
    THEN 120
    WHEN ivs.flaechengroesse > 50
    THEN 100
    WHEN ivs.flaechengroesse > 0
    THEN 77
    ELSE 0
    END
   ELSE 65
   END AS NUMERIC) AS immovw_bv,
 vis.anz_kunde_avg AS sbwkunden_monat,
  vis.anz_kunde_avg * 12 AS sbwkunden_jahr,
 vis.ums_netto_avg AS sbwumsatz_monat,
  vis.ums_netto_avg * 12 AS sbwumsatz_jahr,
 kums.konz_kjmo_max AS konz_kjmo,
 kums.kjmo_anz AS konzumsatz_anz,
 CAST(CASE
   WHEN kums.kjmo_anz > 5
   THEN 1
   ELSE 0
   END AS BIGNUMERIC) AS konz_umsatz_fg,
 kums.konz_umsatz_avg AS konzumsatz_monat,
   kums.konz_umsatz_avg * CAST(CASE
     WHEN kums.kjmo_anz > 5
     THEN 1
     ELSE 0
     END AS BIGNUMERIC) * 12 AS konzumsatz_jahr,
 TRUNC(ivs.grundmiete / CASE
    WHEN kums.konz_umsatz_avg = 0
    THEN NULL
    ELSE kums.konz_umsatz_avg
    END) AS konz_miete_umsatz,
 TRUNC(kums.konz_umsatz_avg * CAST(CASE
       WHEN kums.kjmo_anz > 5
       THEN 1
       ELSE 0
       END AS BIGNUMERIC) * 12 / CASE
    WHEN ivs.flaechengroesse = 0
    THEN NULL
    ELSE ivs.flaechengroesse
    END) AS konz_produktivitaet,
 TRUNC(kums.konz_umsatz_avg * CAST(CASE
       WHEN kums.kjmo_anz > 5
       THEN 1
       ELSE 0
       END AS BIGNUMERIC) * 12 / CASE
    WHEN vis.anz_kunde_avg * 12 = 0
    THEN NULL
    ELSE vis.anz_kunde_avg * 12
    END) AS konz_umsatz_kunde,
 NULL AS konzsbwkunden_monat,
 NULL AS konzsbwkunden_jahr,
 NULL AS konzgrundmiete_monat,
 NULL AS konzgrundmiete_jahr,
 - 1 AS branchenmix_kz,
 '' AS branchenmix,
 BV.vorgabe_achsen_abschnitt -- Vorgabe zur Berechnung kalk. Einkauf
,
 BV.vorgabe_steigung -- Vorgabe zur Berechnung kalk. Einkauf
,
    vis.anz_kunde_avg * 12 * BV.vorgabe_steigung + ROUND(CAST(BV.vorgabe_achsen_abschnitt AS NUMERIC), 4) AS
 einkauf_kalk,
 ROUND(CAST(CASE
    WHEN ivs.mandant_id = 1
    THEN CASE
     WHEN COALESCE(vis.anz_kunde_avg * 12 * BV.vorgabe_steigung + ROUND(CAST(BV.vorgabe_achsen_abschnitt AS NUMERIC), 4
         ), 0) < COALESCE(BV.vorgabe_betrag * 0.7000, 0)
     THEN CAST(BV.vorgabe_betrag * 0.7000 AS FLOAT64)
     ELSE vis.anz_kunde_avg * 12 * BV.vorgabe_steigung + ROUND(CAST(BV.vorgabe_achsen_abschnitt AS NUMERIC), 4)
     END
    ELSE CAST(BV.vorgabe_betrag AS FLOAT64)
    END AS NUMERIC), 4) AS einkauf_wsa,
   vis.anz_kunde_avg * 12 * ROUND(CAST(CASE
     WHEN ivs.mandant_id = 1
     THEN CASE
      WHEN COALESCE(vis.anz_kunde_avg * 12 * BV.vorgabe_steigung + ROUND(CAST(BV.vorgabe_achsen_abschnitt AS NUMERIC), 4
          ), 0) < COALESCE(BV.vorgabe_betrag * 0.7000, 0)
      THEN CAST(BV.vorgabe_betrag * 0.7000 AS FLOAT64)
      ELSE vis.anz_kunde_avg * 12 * BV.vorgabe_steigung + ROUND(CAST(BV.vorgabe_achsen_abschnitt AS NUMERIC), 4)
      END
     ELSE CAST(BV.vorgabe_betrag AS FLOAT64)
     END AS NUMERIC), 4) AS zielumsatz_wsa,
  BV.vorgabe_prodvt * 1.2 AS produktivitaet_wsa,
 IFNULL(TRUNC(vis.anz_kunde_avg * 12 * ROUND(CAST(CASE
        WHEN ivs.mandant_id = 1
        THEN CASE
         WHEN COALESCE(vis.anz_kunde_avg * 12 * BV.vorgabe_steigung + ROUND(CAST(BV.vorgabe_achsen_abschnitt AS NUMERIC)
             , 4), 0) < COALESCE(BV.vorgabe_betrag * 0.7000, 0)
         THEN CAST(BV.vorgabe_betrag * 0.7000 AS FLOAT64)
         ELSE vis.anz_kunde_avg * 12 * BV.vorgabe_steigung + ROUND(CAST(BV.vorgabe_achsen_abschnitt AS NUMERIC), 4)
         END
        ELSE CAST(BV.vorgabe_betrag AS FLOAT64)
        END AS NUMERIC), 4) / CASE
     WHEN BV.vorgabe_prodvt * 1.2 = 0
     THEN NULL
     ELSE BV.vorgabe_prodvt * 1.2
     END), 0) AS flaeche_wsa,
 TRUNC(vis.anz_kunde_avg * 12 * ROUND(CAST(CASE
        WHEN ivs.mandant_id = 1
        THEN CASE
         WHEN COALESCE(vis.anz_kunde_avg * 12 * BV.vorgabe_steigung + ROUND(CAST(BV.vorgabe_achsen_abschnitt AS NUMERIC)
             , 4), 0) < COALESCE(BV.vorgabe_betrag * 0.7000, 0)
         THEN CAST(BV.vorgabe_betrag * 0.7000 AS FLOAT64)
         ELSE vis.anz_kunde_avg * 12 * BV.vorgabe_steigung + ROUND(CAST(BV.vorgabe_achsen_abschnitt AS NUMERIC), 4)
         END
        ELSE CAST(BV.vorgabe_betrag AS FLOAT64)
        END AS NUMERIC), 4) * BV.vorgabe_prozent / 12) AS umsatzmiete_wsa,
  BV.vorgabe_miete * ivs.flaechengroesse AS mindestmiete_wsa,
  CASE
  WHEN COALESCE(BV.vorgabe_miete * ivs.flaechengroesse, 0) > COALESCE(TRUNC(vis.anz_kunde_avg * 12 * ROUND(CAST(CASE
           WHEN ivs.mandant_id = 1
           THEN CASE
            WHEN COALESCE(vis.anz_kunde_avg * 12 * BV.vorgabe_steigung + ROUND(CAST(BV.vorgabe_achsen_abschnitt AS NUMERIC)
                , 4), 0) < COALESCE(BV.vorgabe_betrag * 0.7000, 0)
            THEN CAST(BV.vorgabe_betrag * 0.7000 AS FLOAT64)
            ELSE vis.anz_kunde_avg * 12 * BV.vorgabe_steigung + ROUND(CAST(BV.vorgabe_achsen_abschnitt AS NUMERIC), 4)
            END
           ELSE CAST(BV.vorgabe_betrag AS FLOAT64)
           END AS NUMERIC), 4) * BV.vorgabe_prozent / 12), 0)
  THEN CAST(BV.vorgabe_miete * ivs.flaechengroesse AS FLOAT64)
  ELSE TRUNC(vis.anz_kunde_avg * 12 * ROUND(CAST(CASE
         WHEN ivs.mandant_id = 1
         THEN CASE
          WHEN COALESCE(vis.anz_kunde_avg * 12 * BV.vorgabe_steigung + ROUND(CAST(BV.vorgabe_achsen_abschnitt AS NUMERIC)
              , 4), 0) < COALESCE(BV.vorgabe_betrag * 0.7000, 0)
          THEN CAST(BV.vorgabe_betrag * 0.7000 AS FLOAT64)
          ELSE vis.anz_kunde_avg * 12 * BV.vorgabe_steigung + ROUND(CAST(BV.vorgabe_achsen_abschnitt AS NUMERIC), 4)
          END
         ELSE CAST(BV.vorgabe_betrag AS FLOAT64)
         END AS NUMERIC), 4) * BV.vorgabe_prozent / 12)
  END AS wsa_miete
FROM (SELECT DISTINCT IVS.mandant_id,
   IVS.konzessionaer_id,
   IVS.mietvertrag_id,
   IVS.dat_vertrag_beginn,
   IVS.dat_vertrag_ende,
   IVS.vertragart_id,
   IVS.immo_objekt_id,
   IMMO.immo_objekt_bez,
   IVS.branche_id,
   IVS.vermieter_id,
   IVS.wrg_id,
   IVS.wrg_typ_id,
   IVS.kjmo,
   MO.max_dat -- letzter Tag_2 des Monats
,
   SUM(IVS.mvf_miete_betrag) OVER (PARTITION BY CAST(IVS.mandant_id AS STRING), IVS.konzessionaer_id, IVS.mietvertrag_id
      , IVS.branche_id, IVS.immo_objekt_id, CAST(IVS.wrg_typ_id AS STRING) ORDER BY IVS.mandant_id IS NULL, IVS.mandant_id
      , IVS.konzessionaer_id IS NULL, IVS.konzessionaer_id, IVS.mietvertrag_id IS NULL, IVS.mietvertrag_id, IVS.branche_id
      IS NULL, IVS.branche_id, IVS.immo_objekt_id IS NULL, IVS.immo_objekt_id, IVS.wrg_typ_id IS NULL, IVS.wrg_typ_id,
      IVS.flaeche_id IS NULL, IVS.flaeche_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS grundmiete,
   SUM(IVS.mvf_nk_betrag + IVS.mvf_nk_abschlag) OVER (PARTITION BY CAST(IVS.mandant_id AS STRING), IVS.konzessionaer_id
      , IVS.branche_id, IVS.mietvertrag_id, IVS.immo_objekt_id, CAST(IVS.wrg_typ_id AS STRING) ORDER BY IVS.mandant_id
      IS NULL, IVS.mandant_id, IVS.konzessionaer_id IS NULL, IVS.konzessionaer_id, IVS.mietvertrag_id IS NULL, IVS.mietvertrag_id
      , IVS.branche_id IS NULL, IVS.branche_id, IVS.immo_objekt_id IS NULL, IVS.immo_objekt_id, IVS.wrg_typ_id IS NULL,
      IVS.wrg_typ_id, IVS.flaeche_id IS NULL, IVS.flaeche_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   nebenkosten,
   SUM(IVS.mvf_ums_abschlag) OVER (PARTITION BY CAST(IVS.mandant_id AS STRING), IVS.konzessionaer_id, IVS.mietvertrag_id
      , IVS.branche_id, IVS.immo_objekt_id, CAST(IVS.wrg_typ_id AS STRING) ORDER BY IVS.mandant_id IS NULL, IVS.mandant_id
      , IVS.konzessionaer_id IS NULL, IVS.konzessionaer_id, IVS.mietvertrag_id IS NULL, IVS.mietvertrag_id, IVS.branche_id
      IS NULL, IVS.branche_id, IVS.immo_objekt_id IS NULL, IVS.immo_objekt_id, IVS.wrg_typ_id IS NULL, IVS.wrg_typ_id,
      IVS.flaeche_id IS NULL, IVS.flaeche_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS umsmietabschlag,
   MAX(IVS.miete_umsatz_prozent) OVER (PARTITION BY CAST(IVS.mandant_id AS STRING), IVS.konzessionaer_id, IVS.mietvertrag_id
      , IVS.branche_id, IVS.immo_objekt_id, CAST(IVS.wrg_typ_id AS STRING) ORDER BY IVS.mandant_id IS NULL, IVS.mandant_id
      , IVS.konzessionaer_id IS NULL, IVS.konzessionaer_id, IVS.mietvertrag_id IS NULL, IVS.mietvertrag_id, IVS.branche_id
      IS NULL, IVS.branche_id, IVS.immo_objekt_id IS NULL, IVS.immo_objekt_id, IVS.wrg_typ_id IS NULL, IVS.wrg_typ_id,
      IVS.flaeche_id IS NULL, IVS.flaeche_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS umsmieteproz,
   SUM(IVS.mv_immo_verw_b) OVER (PARTITION BY CAST(IVS.mandant_id AS STRING), IVS.konzessionaer_id, IVS.mietvertrag_id,
      IVS.branche_id, IVS.immo_objekt_id, CAST(IVS.wrg_typ_id AS STRING) ORDER BY IVS.mandant_id IS NULL, IVS.mandant_id
      , IVS.konzessionaer_id IS NULL, IVS.konzessionaer_id, IVS.mietvertrag_id IS NULL, IVS.mietvertrag_id, IVS.branche_id
      IS NULL, IVS.branche_id, IVS.immo_objekt_id IS NULL, IVS.immo_objekt_id, IVS.wrg_typ_id IS NULL, IVS.wrg_typ_id,
      IVS.flaeche_id IS NULL, IVS.flaeche_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS immovwkosten,
   SUM(IVS.flaeche_groesse) OVER (PARTITION BY CAST(IVS.mandant_id AS STRING), IVS.konzessionaer_id, IVS.mietvertrag_id
      , IVS.branche_id, IVS.immo_objekt_id, CAST(IVS.wrg_typ_id AS STRING) ORDER BY IVS.mandant_id IS NULL, IVS.mandant_id
      , IVS.konzessionaer_id IS NULL, IVS.konzessionaer_id, IVS.mietvertrag_id IS NULL, IVS.mietvertrag_id, IVS.branche_id
      IS NULL, IVS.branche_id, IVS.immo_objekt_id IS NULL, IVS.immo_objekt_id, IVS.wrg_typ_id IS NULL, IVS.wrg_typ_id,
      IVS.flaeche_id IS NULL, IVS.flaeche_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS flaechengroesse,
   COUNT(IVS.flaeche_id) OVER (PARTITION BY CAST(IVS.mandant_id AS STRING), IVS.konzessionaer_id, IVS.mietvertrag_id,
      IVS.branche_id, IVS.immo_objekt_id, CAST(IVS.wrg_typ_id AS STRING) ORDER BY IVS.mandant_id IS NULL, IVS.mandant_id
      , IVS.konzessionaer_id IS NULL, IVS.konzessionaer_id, IVS.mietvertrag_id IS NULL, IVS.mietvertrag_id, IVS.branche_id
      IS NULL, IVS.branche_id, IVS.immo_objekt_id IS NULL, IVS.immo_objekt_id, IVS.wrg_typ_id IS NULL, IVS.wrg_typ_id,
      IVS.flaeche_id IS NULL, IVS.flaeche_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS flaechenanzahl,
   MAX(FLAECHE.flaeche_status_id) OVER (PARTITION BY CAST(IVS.mandant_id AS STRING), IVS.konzessionaer_id, IVS.mietvertrag_id
      , IVS.branche_id, IVS.immo_objekt_id, CAST(IVS.wrg_typ_id AS STRING) ORDER BY IVS.mandant_id IS NULL, IVS.mandant_id
      , IVS.konzessionaer_id IS NULL, IVS.konzessionaer_id, IVS.mietvertrag_id IS NULL, IVS.mietvertrag_id, IVS.branche_id
      IS NULL, IVS.branche_id, IVS.immo_objekt_id IS NULL, IVS.immo_objekt_id, IVS.wrg_typ_id IS NULL, IVS.wrg_typ_id,
      IVS.flaeche_id IS NULL, IVS.flaeche_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS flaechenstatus,
   MAX(IVS.nutzung_id) OVER (PARTITION BY CAST(IVS.mandant_id AS STRING), IVS.konzessionaer_id, IVS.mietvertrag_id, IVS
      .branche_id, IVS.immo_objekt_id, CAST(IVS.wrg_typ_id AS STRING) ORDER BY IVS.mandant_id IS NULL, IVS.mandant_id,
      IVS.konzessionaer_id IS NULL, IVS.konzessionaer_id, IVS.mietvertrag_id IS NULL, IVS.mietvertrag_id, IVS.branche_id
      IS NULL, IVS.branche_id, IVS.immo_objekt_id IS NULL, IVS.immo_objekt_id, IVS.wrg_typ_id IS NULL, IVS.wrg_typ_id,
      IVS.flaeche_id IS NULL, IVS.flaeche_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS flaechennutzung,
   MAX(IVS.flaeche_typ_id) OVER (PARTITION BY CAST(IVS.mandant_id AS STRING), IVS.konzessionaer_id, IVS.mietvertrag_id,
      IVS.branche_id, IVS.immo_objekt_id, CAST(IVS.wrg_typ_id AS STRING) ORDER BY IVS.mandant_id IS NULL, IVS.mandant_id
      , IVS.konzessionaer_id IS NULL, IVS.konzessionaer_id, IVS.mietvertrag_id IS NULL, IVS.mietvertrag_id, IVS.branche_id
      IS NULL, IVS.branche_id, IVS.immo_objekt_id IS NULL, IVS.immo_objekt_id, IVS.wrg_typ_id IS NULL, IVS.wrg_typ_id,
      IVS.flaeche_id IS NULL, IVS.flaeche_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS flaechentyp,
   COUNT(IVS.immo_objekt_id) OVER (PARTITION BY CAST(IVS.mandant_id AS STRING), IVS.konzessionaer_id, IVS.mietvertrag_id
      , IVS.branche_id, CAST(IVS.wrg_typ_id AS STRING) ORDER BY IVS.mandant_id IS NULL, IVS.mandant_id, IVS.konzessionaer_id
      IS NULL, IVS.konzessionaer_id, IVS.mietvertrag_id IS NULL, IVS.mietvertrag_id, IVS.branche_id IS NULL, IVS.branche_id
      , IVS.immo_objekt_id IS NULL, IVS.immo_objekt_id, IVS.wrg_typ_id IS NULL, IVS.wrg_typ_id, IVS.flaeche_id IS NULL,
      IVS.flaeche_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS objektanzahl
  FROM kfl_production_dbp_view.v_ivs_aggregat_2 AS IVS
   INNER JOIN kfl_production_dbp_view.v_l_buchungsstatus_ker_2 AS KER ON IVS.kjmo = KER.kj_ker_mo_id AND KER.akt_buchungs_schluss
      = 0
   INNER JOIN kfl_production_dbp_view.v_monat_2 AS MO ON IVS.kjmo = MO.kjmo
   INNER JOIN kfl_production_dbp_view.v_ivs_flaeche_per_2 AS FLAECHE ON IVS.flaeche_id = FLAECHE.flaeche_id AND IVS.mandant_id
       = FLAECHE.mandant_id AND MO.max_dat BETWEEN FLAECHE.dat_von AND FLAECHE.dat_bis
   INNER JOIN kfl_production_dbp_view.v_ivs_immo_objekt_per_2 AS IMMO ON IVS.immo_objekt_id = IMMO.immo_objekt_id AND IVS
      .mandant_id = IMMO.mandant_id AND MO.max_dat BETWEEN IMMO.dat_von AND IMMO.dat_bis) AS ivs
 INNER JOIN kfl_production_dbp_view.v_ivs_immo_obj_miet_region_zu_2 AS IMR ON ivs.immo_objekt_id = IMR.immo_objekt_id AND
   ivs.mandant_id = IMR.mandant_id
 LEFT JOIN (SELECT DISTINCT mandant_id,
   wrg_id,
   wup_id,
   kjmo,
   kjmo_lfd,
   AVG(anz_kunde) OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(wup_id AS STRING) ORDER BY mandant_id
      IS NULL, mandant_id, wup_id IS NULL, wup_id, kjmo IS NULL, kjmo RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS anz_kunde_avg,
   AVG(ums_netto) OVER (PARTITION BY CAST(mandant_id AS STRING), wrg_id, CAST(wup_id AS STRING) ORDER BY mandant_id
      IS NULL, mandant_id, wup_id IS NULL, wup_id, kjmo IS NULL, kjmo RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS ums_netto_avg
  FROM (SELECT VIS.mandant_id,
     VIS.wrg_id,
     VIS.wup_id,
     VIS.kjmo,
     VIS.anz_kunde_kvvj AS anz_kunde,
     VIS.ums_netto_kvvj AS ums_netto,
     CAST(RANK() OVER (PARTITION BY CAST(VIS.mandant_id AS STRING), VIS.wrg_id, CAST(VIS.wup_id AS STRING) ORDER BY VIS
         .mandant_id IS NULL, VIS.mandant_id, VIS.wup_id IS NULL, VIS.wup_id, VIS.kjmo IS NULL, VIS.kjmo) AS BIGNUMERIC
      ) AS kjmo_lfd
    FROM kfl_production_dbp_msi_v_view.v_vis_monat_ums_kunde_pers_wup_2 AS VIS
     INNER JOIN kfl_production_dbp_msi_view_ivs.mv_monat_3gj_2 AS M01 ON VIS.kjmo BETWEEN M01.kjmo_min AND M01.kjmo_max
      AND M01.gj_vj_kz = 0
    WHERE VIS.nb_id = 0
     AND VIS.ums_netto_kvvj <> 0
     AND VIS.anz_kunde_kvvj <> 0 /* Vorgabe IMA */
    QUALIFY CAST(RANK() OVER (PARTITION BY CAST(VIS.mandant_id AS STRING), VIS.wrg_id, CAST(VIS.wup_id AS STRING)
        ORDER BY VIS.mandant_id IS NULL, VIS.mandant_id, VIS.wup_id IS NULL, VIS.wup_id, VIS.kjmo IS NULL, VIS.kjmo) AS
       BIGNUMERIC) <= 12) AS vis) AS vis ON ivs.immo_objekt_bez = vis.wup_id AND ivs.mandant_id = vis.mandant_id AND ivs
    .wrg_id = vis.wrg_id AND vis.kjmo_lfd = 1
 LEFT JOIN (SELECT mandant_id,
   wup_id,
   bed_backshop_fg,
   bed_backshop_dat,
   backshop_system
  FROM kfl_production_dbp_msi_v_view.v_wup_denorm_2 AS WD
  WHERE bed_backshop_fg > 0
   AND bed_backshop_dat < CURRENT_DATE) AS wup_dn ON ivs.immo_objekt_bez = wup_dn.wup_id AND ivs.mandant_id = wup_dn.mandant_id
   
 LEFT JOIN kfl_production_dbp_msi_view_ivs.mv_branche_vorgabe_2 AS BV ON ivs.mandant_id = BV.mandant_id AND ivs.branche_id
           = BV.branche_id AND IMR.miet_region_id = BV.miet_region_id AND IMR.bl_id = BV.bl_id AND ivs.flaechengroesse
       BETWEEN BV.flaeche_groesse_von AND BV.flaeche_groesse_bis AND (vis.anz_kunde_avg * 12) BETWEEN BV.kunden_anzahl_von
      AND BV.kunden_anzahl_bis AND BV.kaufland_baecker_fg = CASE
      WHEN BV.kaufland_baecker_fg = 1
      THEN COALESCE(wup_dn.bed_backshop_fg, 0)
      ELSE 0
      END AND ivs.wrg_typ_id = BV.wrg_typ_id AND ivs.wrg_id = BV.wrg_id
 LEFT JOIN (SELECT DISTINCT kum.mandant_id,
   kum.konzessionaer_id,
   kum.mietvertrag_id,
   kum.immo_objekt_id,
   KURS.wrg_id,
   KURS.wrg_typ_id,
   COUNT(kum.kjmo_lfd) OVER (PARTITION BY CAST(kum.mandant_id AS STRING), kum.konzessionaer_id, kum.mietvertrag_id, kum
      .immo_objekt_id, CAST(KURS.wrg_typ_id AS STRING) ORDER BY kum.mandant_id IS NULL, kum.mandant_id, kum.konzessionaer_id
      IS NULL, kum.konzessionaer_id, kum.mietvertrag_id IS NULL, kum.mietvertrag_id, kum.immo_objekt_id IS NULL, kum.immo_objekt_id
      , KURS.wrg_typ_id IS NULL, KURS.wrg_typ_id, kum.kjmo IS NULL, kum.kjmo RANGE BETWEEN UNBOUNDED PRECEDING AND
    CURRENT ROW) AS kjmo_anz,
   MAX(kum.kjmo) OVER (PARTITION BY CAST(kum.mandant_id AS STRING), kum.konzessionaer_id, kum.mietvertrag_id, kum.immo_objekt_id
      , CAST(KURS.wrg_typ_id AS STRING) ORDER BY kum.mandant_id IS NULL, kum.mandant_id, kum.konzessionaer_id IS NULL,
      kum.konzessionaer_id, kum.mietvertrag_id IS NULL, kum.mietvertrag_id, kum.immo_objekt_id IS NULL, kum.immo_objekt_id
      , KURS.wrg_typ_id IS NULL, KURS.wrg_typ_id, kum.kjmo IS NULL, kum.kjmo RANGE BETWEEN UNBOUNDED PRECEDING AND
    CURRENT ROW) AS konz_kjmo_max,
   AVG(kum.betrag_umsatz * KURS.kurs_2) OVER (PARTITION BY CAST(kum.mandant_id AS STRING), kum.konzessionaer_id, kum.mietvertrag_id
      , kum.immo_objekt_id, CAST(KURS.wrg_typ_id AS STRING) ORDER BY kum.mandant_id IS NULL, kum.mandant_id, kum.konzessionaer_id
      IS NULL, kum.konzessionaer_id, kum.mietvertrag_id IS NULL, kum.mietvertrag_id, kum.immo_objekt_id IS NULL, kum.immo_objekt_id
      , KURS.wrg_typ_id IS NULL, KURS.wrg_typ_id, kum.kjmo IS NULL, kum.kjmo RANGE BETWEEN UNBOUNDED PRECEDING AND
    CURRENT ROW) AS konz_umsatz_avg
  FROM (SELECT KUMO.mandant_id,
     KUMO.konzessionaer_id,
     KUMO.mietvertrag_id,
     KUMO.immo_objekt_id,
     KUMO.wrg_id,
     KUMO.kjmo,
     CAST(RANK() OVER (PARTITION BY CAST(KUMO.mandant_id AS STRING), KUMO.konzessionaer_id, KUMO.mietvertrag_id, KUMO.immo_objekt_id
         , KUMO.wrg_id ORDER BY KUMO.mandant_id IS NULL, KUMO.mandant_id, KUMO.konzessionaer_id IS NULL, KUMO.konzessionaer_id
         , KUMO.mietvertrag_id IS NULL, KUMO.mietvertrag_id, KUMO.immo_objekt_id IS NULL, KUMO.immo_objekt_id, KUMO.wrg_id
         IS NULL, KUMO.wrg_id, KUMO.kjmo IS NULL, KUMO.kjmo) AS BIGNUMERIC) AS kjmo_lfd,
     KUMO.betrag_umsatz
    FROM kfl_production_dbp_view.v_ivs_konzessionaer_umsatz_2 AS KUMO
     INNER JOIN kfl_production_dbp_msi_view_ivs.mv_monat_3gj_2 AS M010 ON KUMO.kjmo BETWEEN M010.kjmo_min AND M010.kjmo_max
        AND M010.gj_vj_kz = - 2
    WHERE KUMO.betrag_umsatz <> 0
    QUALIFY (RANK() OVER (PARTITION BY CAST(KUMO.mandant_id AS STRING), KUMO.konzessionaer_id, KUMO.mietvertrag_id, KUMO
          .immo_objekt_id, KUMO.wrg_id ORDER BY KUMO.mandant_id IS NULL, KUMO.mandant_id, KUMO.konzessionaer_id IS NULL
          , KUMO.konzessionaer_id, KUMO.mietvertrag_id IS NULL, KUMO.mietvertrag_id, KUMO.immo_objekt_id IS NULL, KUMO.immo_objekt_id
          , KUMO.wrg_id IS NULL, KUMO.wrg_id, KUMO.kjmo IS NULL, KUMO.kjmo)) <= 12) AS kum
   INNER JOIN kfl_production_dbp_msi_view_ivs.mv_mandant_wrg_kurs_zu_per_2 AS KURS_2 ON kum.mandant_id = KURS.mandant_id AND
     KURS.kurs_dat_bis = DATE '9999-12-31') AS kums ON ivs.mietvertrag_id = kums.mietvertrag_id AND ivs.konzessionaer_id
        = kums.konzessionaer_id AND ivs.immo_objekt_id = kums.immo_objekt_id AND ivs.mandant_id = kums.mandant_id AND
    ivs.wrg_typ_id = kums.wrg_typ_id AND ivs.wrg_id = kums.wrg_id;