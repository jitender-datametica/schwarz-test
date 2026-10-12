CREATE OR REPLACE VIEW DBP_MSI_VIEW_IVS.MV_PRODUKTIVITAET_3J_2
AS
   -- 20150219 - kkaiser - 3-Jahresbetrachtung Auftrag # 610301

   SELECT
   ivs.mandant_id,
   ivs.konzessionaer_id,
   ivs.mietvertrag_id,
   ivs.immo_objekt_id,
   ivs.immo_objekt_bez,
   COALESCE(wup_dn.bed_backshop_fg, 0) AS kl_backshop_fg -- Kennzeichnung Kaufland
   ,
   imr.miet_region_id,
   imr.bl_id,
   ivs.branche_id,
   ivs.wrg_id,
   ivs.wrg_typ_id,
   ivs.kjmo AS kjmo,
   ivs.kjmo AS kjmo_direkt,
   ivs.grundmiete,
   ivs.nebenkosten,
   ivs.umsmietabschlag,
   (TRUNC(ivs.umsmieteproz / 100.00)) AS umsmieteproz -- max. Wert ueber alle Flaechen!
   ,
   MOD( (ivs.umsmieteproz * 10000), 10) AS umsmiete_fg,
   ivs.immovwkosten,
   ivs.vertragart_id,
   CASE WHEN ivs.dat_vertrag_beginn BETWEEN to_date('1900-01-31','YYYY-MM_2-DD') AND ivs.max_dat THEN TRUNC( (ivs.dat_vertrag_beginn - ivs.max_dat) / 30) ELSE -1 END::INTEGER AS laufzeit_beginn -- Bezug auf Berichtsmonat
   ,
   CASE WHEN ivs.dat_vertrag_ende BETWEEN ivs.max_dat AND to_date('9999-01-01','YYYY-MM_2-DD') THEN TRUNC( (ivs.dat_vertrag_ende - ivs.max_dat) / 30) ELSE -1 END::INTEGER AS laufzeit_ende  -- Bezug auf Berichtsmonat
   ,
   ivs.dat_vertrag_beginn,
   ivs.dat_vertrag_ende,
   ivs.flaechenstatus  -- max. Wert ueber alle Flaechen (aus flaeche_per)
   ,
   ivs.flaechennutzung -- max. Wert ueber alle Flaechen!
   ,
   ivs.flaechentyp     -- max. Wert ueber alle Flaechen!
   ,
   ivs.objektanzahl    -- zaehlt auch mehrere Flaechen
   ,
   ivs.flaechenanzahl,
   ivs.flaechengroesse,
   bv.flaeche_groesse_von -- Vorgabe Flaechengroesse von
   ,
   bv.flaeche_groesse_bis -- Vorgabe Flaechengroesse bis
   ,
   bv.vorgabe_prozent                            AS umsatzmiete_BV -- Vorgabe Umsatzmiete in Prozent
   ,
   bv.vorgabe_betrag                             AS einkauf_BV -- Vorgabe durchschnittlicher Einkauf
   ,
   bv.vorgabe_prodvt                             AS produktivitaet_BV -- Vorgabe Produktivitaet
   ,
   bv.vorgabe_miete                              AS miete_BV -- Vorgabe Miete pro m2
   ,
   CASE WHEN ivs.mandant_id = 1 THEN CASE
  WHEN flaechengroesse > 250 THEN 120
  WHEN flaechengroesse >  50 THEN 100
  WHEN flaechengroesse >   0 THEN  77
  ELSE 0
  END
  ELSE 65
  END::DECIMAL(18,4)                           AS immovw_BV -- Vorgabe Immo-Verwaltungskosten
   ,
   vis.anz_kunde_avg                             AS sbwkunden_monat,
   vis.anz_kunde_avg * 12                        AS sbwkunden_jahr,
   vis.ums_netto_avg                             AS sbwumsatz_monat,
   vis.ums_netto_avg * 12                        AS sbwumsatz_jahr,
   kums.konz_kjmo_max                            AS konz_kjmo,
   kums.kjmo_anz                                 AS konzumsatz_anz,
   CASE WHEN konzumsatz_anz > 5 THEN 1 ELSE 0 END::BYTEINT AS konz_umsatz_fg,
   kums.konz_umsatz_avg                          AS konzumsatz_monat,
   kums.konz_umsatz_avg * konz_umsatz_fg * 12    AS konzumsatz_jahr,
   TRUNC( ivs.grundmiete / CASE WHEN konzumsatz_monat = 0 THEN null ELSE konzumsatz_monat END) AS konz_miete_umsatz   -- durchschn. Grundmiete (Monat_2)
   ,
   TRUNC( konzumsatz_jahr / CASE WHEN flaechengroesse = 0 THEN null ELSE flaechengroesse END) AS konz_produktivitaet -- Produktivitaet pro Flaeche (Jahr)
   ,
   TRUNC( konzumsatz_jahr / CASE WHEN sbwkunden_jahr = 0 THEN null ELSE sbwkunden_jahr END)  AS konz_umsatz_kunde   -- durchschn. Einkauf pro KL-Kunde (Monat_2)
   ,
   NULL AS konzsbwkunden_monat  -- entfaellt > Dummy_2
   ,
   NULL AS konzsbwkunden_jahr   -- entfaellt > Dummy_2
   ,
   NULL AS konzgrundmiete_monat -- entfaellt > Dummy_2
   ,
   NULL AS konzgrundmiete_jahr  -- entfaellt > Dummy_2
   ,
   -1::SMALLINT AS branchenmix_kz  -- entfaellt > Dummy_2
   ,
   ''  AS branchenmix                 -- entfaellt > Dummy_2
   ,
   bv.vorgabe_achsen_abschnitt -- Vorgabe zur Berechnung kalk. Einkauf
   ,
   bv.vorgabe_steigung         -- Vorgabe zur Berechnung kalk. Einkauf
   ,
   (sbwkunden_jahr * bv.vorgabe_steigung) + bv.vorgabe_achsen_abschnitt::DECIMAL(18,4)  AS einkauf_KALK,
   CASE WHEN ivs.mandant_id = 1 THEN CASE
  WHEN COALESCE(einkauf_KALK, 0) < COALESCE(einkauf_BV * 0.7000, 0) THEN einkauf_BV * 0.7000
  ELSE einkauf_KALK
  END
  ELSE einkauf_BV
  END::DECIMAL(18,4)                                                  AS einkauf_WSA -- WSA optimierter Einkauf
   ,
   sbwkunden_jahr * einkauf_WSA::DECIMAL(18,4)                         AS zielumsatz_WSA  -- WSA Zielumsatz
   ,
   produktivitaet_BV * 1.2::DECIMAL(18,4)                              AS produktivitaet_WSA -- WSA optimierte Produktivitaet
   ,
   ZEROIFNULL(TRUNC(zielumsatz_WSA / CASE WHEN produktivitaet_wsa = 0 THEN null ELSE produktivitaet_wsa END))          AS flaeche_WSA -- WSA optimierte Flaeche
   ,
   TRUNC( (zielumsatz_WSA * umsatzmiete_BV) / 12)                               AS umsatzmiete_WSA -- WSA Umsatzmiete
   ,
   miete_BV * flaechengroesse                                           AS mindestmiete_WSA -- WSA Mindestmiete
   ,
   CASE
  WHEN COALESCE(mindestmiete_WSA, 0) > COALESCE(umsatzmiete_WSA, 0) THEN mindestmiete_WSA
  ELSE umsatzmiete_WSA
  END  AS WSA_miete -- WSA Miete
  /* NICHT MEHR VERWENDET - ENDE*/
  FROM
  (  /* Basisdaten Berichtsmonat (Buchungsschluss) */
  SELECT DISTINCT
  ivs.mandant_id,
   ivs.konzessionaer_id,
   ivs.mietvertrag_id,
   ivs.dat_vertrag_beginn,
   ivs.dat_vertrag_ende,
   ivs.vertragart_id,
   ivs.immo_objekt_id,
   immo.immo_objekt_bez,
   ivs.branche_id,
   ivs.vermieter_id,
   ivs.wrg_id,
   ivs.wrg_typ_id,
   ivs.kjmo AS kjmo,
   mo.max_dat -- letzter Tag_2 des Monats
   ,
   SUM(ivs.mvf_miete_betrag) OVER (PARTITION BY ivs.mandant_id, ivs.konzessionaer_id, ivs.mietvertrag_id, ivs.branche_id, ivs.immo_objekt_id, ivs.wrg_typ_id ORDER BY ivs.mandant_id, ivs.konzessionaer_id, ivs.mietvertrag_id, ivs.branche_id, ivs.immo_objekt_id, ivs.wrg_typ_id, ivs.flaeche_id) AS grundmiete,
   SUM(ivs.mvf_nk_betrag + ivs.mvf_nk_abschlag) OVER (PARTITION BY ivs.mandant_id, ivs.konzessionaer_id, ivs.mietvertrag_id, ivs.branche_id, ivs.immo_objekt_id, ivs.wrg_typ_id ORDER BY ivs.mandant_id, ivs.konzessionaer_id, ivs.mietvertrag_id, ivs.branche_id, ivs.immo_objekt_id, ivs.wrg_typ_id, ivs.flaeche_id) AS nebenkosten,
   SUM(ivs.mvf_ums_abschlag) OVER (PARTITION BY ivs.mandant_id, ivs.konzessionaer_id, ivs.mietvertrag_id, ivs.branche_id, ivs.immo_objekt_id, ivs.wrg_typ_id ORDER BY ivs.mandant_id, ivs.konzessionaer_id, ivs.mietvertrag_id, ivs.branche_id, ivs.immo_objekt_id, ivs.wrg_typ_id, ivs.flaeche_id) AS umsmietabschlag,
   MAX(ivs.miete_umsatz_prozent) OVER (PARTITION BY ivs.mandant_id, ivs.konzessionaer_id, ivs.mietvertrag_id, ivs.branche_id, ivs.immo_objekt_id, ivs.wrg_typ_id ORDER BY ivs.mandant_id, ivs.konzessionaer_id, ivs.mietvertrag_id, ivs.branche_id, ivs.immo_objekt_id, ivs.wrg_typ_id, ivs.flaeche_id) AS umsmieteproz,
   SUM(ivs.mv_immo_verw_b) OVER (PARTITION BY ivs.mandant_id, ivs.konzessionaer_id, ivs.mietvertrag_id, ivs.branche_id, ivs.branche_id, ivs.immo_objekt_id, ivs.wrg_typ_id ORDER BY ivs.mandant_id, ivs.konzessionaer_id, ivs.mietvertrag_id, ivs.branche_id, ivs.immo_objekt_id, ivs.wrg_typ_id, ivs.flaeche_id) AS immovwkosten,
   SUM(ivs.flaeche_groesse) OVER (PARTITION BY ivs.mandant_id, ivs.konzessionaer_id, ivs.mietvertrag_id, ivs.branche_id, ivs.immo_objekt_id, ivs.wrg_typ_id ORDER BY ivs.mandant_id, ivs.konzessionaer_id, ivs.mietvertrag_id, ivs.branche_id, ivs.immo_objekt_id, ivs.wrg_typ_id, ivs.flaeche_id) AS flaechengroesse,
   COUNT(ivs.flaeche_id) OVER (PARTITION BY ivs.mandant_id, ivs.konzessionaer_id, ivs.mietvertrag_id, ivs.branche_id, ivs.immo_objekt_id, ivs.wrg_typ_id ORDER BY ivs.mandant_id, ivs.konzessionaer_id, ivs.mietvertrag_id, ivs.branche_id, ivs.immo_objekt_id, ivs.wrg_typ_id, ivs.flaeche_id) AS flaechenanzahl,
   MAX(flaeche.flaeche_status_id) OVER (PARTITION BY ivs.mandant_id, ivs.konzessionaer_id, ivs.mietvertrag_id, ivs.branche_id, ivs.immo_objekt_id, ivs.wrg_typ_id ORDER BY ivs.mandant_id, ivs.konzessionaer_id, ivs.mietvertrag_id, ivs.branche_id, ivs.immo_objekt_id, ivs.wrg_typ_id, ivs.flaeche_id) AS flaechenstatus -- NEU aus Flaeche
   ,
   MAX(ivs.nutzung_id) OVER (PARTITION BY ivs.mandant_id, ivs.konzessionaer_id, ivs.mietvertrag_id, ivs.branche_id, ivs.immo_objekt_id, ivs.wrg_typ_id ORDER BY ivs.mandant_id, ivs.konzessionaer_id, ivs.mietvertrag_id, ivs.branche_id, ivs.immo_objekt_id, ivs.wrg_typ_id, ivs.flaeche_id) AS flaechennutzung,
   MAX(ivs.flaeche_typ_id) OVER (PARTITION BY ivs.mandant_id, ivs.konzessionaer_id, ivs.mietvertrag_id, ivs.branche_id, ivs.immo_objekt_id, ivs.wrg_typ_id ORDER BY ivs.mandant_id, ivs.konzessionaer_id, ivs.mietvertrag_id, ivs.branche_id, ivs.immo_objekt_id, ivs.wrg_typ_id, ivs.flaeche_id) AS flaechentyp,
   COUNT(ivs.immo_objekt_id) OVER (PARTITION BY ivs.mandant_id, ivs.konzessionaer_id, ivs.mietvertrag_id, ivs.branche_id, ivs.wrg_typ_id ORDER BY ivs.mandant_id, ivs.konzessionaer_id, ivs.mietvertrag_id, ivs.branche_id, ivs.immo_objekt_id, ivs.wrg_typ_id, ivs.flaeche_id) AS objektanzahl
  FROM dbp_view.v_ivs_aggregat_2 ivs

   JOIN dbp_view.v_l_buchungsstatus_ker_2 ker
   ON  ivs.kjmo = ker.kj_ker_mo_id
   AND ker.akt_buchungs_schluss = 0

   JOIN dbp_view.v_monat_2 mo
   ON ivs.kjmo = mo.kjmo

   JOIN dbp_view.v_ivs_flaeche_per_2 flaeche
   ON  ivs.flaeche_id = flaeche.flaeche_id
   AND ivs.mandant_id = flaeche.mandant_id
   AND mo.max_dat BETWEEN flaeche.dat_von AND flaeche.dat_bis

   JOIN dbp_view.v_ivs_immo_objekt_per_2 immo
   ON  ivs.immo_objekt_id = immo.immo_objekt_id
   AND ivs.mandant_id = immo.mandant_id
   AND mo.max_dat BETWEEN immo.dat_von AND immo.dat_bis

   WHERE ivs.mietvertrag_id <> '   0'
   AND flaeche.flaeche_status_id IN (4, 6, 7) -- Vorgabe IMA : definierter Flaechenstatus

   ) ivs

   JOIN dbp_view.v_ivs_immo_obj_miet_region_zu_2  imr
   ON  ivs.immo_objekt_id = imr.immo_objekt_id
   AND ivs.mandant_id = imr.mandant_id
   LEFT JOIN
   (  /* SBW Anzahl Kunden und Umsatz aus VIS Aggregat */
   SELECT DISTINCT
   vis.mandant_id,
   vis.wrg_id,
   vis.wup_id,
   vis.kjmo,
   vis.kjmo_lfd,
   AVG(vis.anz_kunde) OVER (PARTITION BY vis.mandant_id, vis.wrg_id, vis.wup_id ORDER BY vis.mandant_id, vis.wup_id, vis.kjmo DESC NULLS LAST) AS anz_kunde_avg,
   AVG(vis.ums_netto) OVER (PARTITION BY vis.mandant_id, vis.wrg_id, vis.wup_id ORDER BY vis.mandant_id, vis.wup_id, vis.kjmo DESC NULLS LAST) AS ums_netto_avg
  FROM
  (
  SELECT
  vis.mandant_id,
   vis.wrg_id,
   vis.wup_id,
   vis.kjmo,
   anz_kunde,
   ums_netto,
   RANK() OVER (PARTITION BY vis.mandant_id, vis.wrg_id, vis.wup_id ORDER BY vis.mandant_id, vis.wup_id, vis.kjmo DESC NULLS LAST)::INTEGER  kjmo_lfd
   FROM
   ( /* IST Werte fuer akt. (und kuenftiges) GJ */
   SELECT
   vis.mandant_id,
   vis.wrg_id,
   vis.wup_id,
   vis.kjmo,
   anz_kunde_kvvj AS anz_kunde,
   ums_netto_kvvj AS ums_netto
  FROM dbp_msi_v_view.v_vis_monat_ums_kunde_pers_wup_2 vis

   JOIN dbp_msi_view_ivs.mv_monat_3gj_2 m01
   ON (vis.kjmo between m01.kjmo_min and m01.kjmo_max)
   AND m01.gj_vj_kz = -1

   WHERE vis.nb_id = 0
   AND vis.ums_netto_kvvj <> 0 AND vis.anz_kunde_kvvj <> 0 /* Vorgabe IMA */

   ) vis
   QUALIFY kjmo_lfd <= 12
   ) vis
   ) vis
   ON  ivs.immo_objekt_bez = vis.wup_id
   AND ivs.mandant_id = vis.mandant_id
   AND ivs.wrg_id = vis.wrg_id
   AND vis.kjmo_lfd = 1
   LEFT JOIN
   (  /* Flag : KL Diskountbackshop, Frischebaecker, Backshop in Bedienung vorhanden aus WUP_2 */
   SELECT
   mandant_id,
   wup_id,
   bed_backshop_fg,
   bed_backshop_dat,
   backshop_system
  FROM dbp_msi_v_view.v_wup_denorm_2 wd

   WHERE bed_backshop_fg > 0
   AND bed_backshop_dat < CURRENT_DATE
   ) wup_dn
   ON  ivs.immo_objekt_bez = wup_dn.wup_id
   AND ivs.mandant_id = wup_dn.mandant_id
   LEFT JOIN dbp_msi_view_ivs.mv_branche_vorgabe_2  bv
   ON  ivs.mandant_id = bv.mandant_id
   AND ivs.branche_id = bv.branche_id
   AND imr.miet_region_id = bv.miet_region_id
   AND imr.bl_id = bv.bl_id
   AND flaechengroesse BETWEEN bv.flaeche_groesse_von AND bv.flaeche_groesse_bis
   AND vis.anz_kunde_avg * 12 BETWEEN bv.kunden_anzahl_von AND bv.kunden_anzahl_bis
   AND bv.kaufland_baecker_fg = (CASE WHEN bv.kaufland_baecker_fg = 1 THEN COALESCE(wup_dn.bed_backshop_fg, 0) ELSE 0 END)
   AND ivs.wrg_typ_id = bv.wrg_typ_id
   AND ivs.wrg_id = bv.wrg_id
   LEFT JOIN
   (  /* Konzessionaer Umsatz (ohne Mapping SBW Kunden + Grundmiete) */
   SELECT DISTINCT
   kum.mandant_id,
   kum.konzessionaer_id,
   kum.mietvertrag_id,
   kum.immo_objekt_id,
   kurs.wrg_id,
   kurs.wrg_typ_id,
   COUNT(kum.kjmo_lfd) OVER (PARTITION BY kum.mandant_id, kum.konzessionaer_id, kum.mietvertrag_id, kum.immo_objekt_id, kurs.wrg_typ_id ORDER BY kum.mandant_id, kum.konzessionaer_id, kum.mietvertrag_id, kum.immo_objekt_id, kurs.wrg_typ_id, kum.kjmo DESC NULLS LAST) AS kjmo_anz,
   MAX(kum.kjmo) OVER (PARTITION BY kum.mandant_id, kum.konzessionaer_id, kum.mietvertrag_id, kum.immo_objekt_id, kurs.wrg_typ_id ORDER BY kum.mandant_id, kum.konzessionaer_id, kum.mietvertrag_id, kum.immo_objekt_id, kurs.wrg_typ_id, kum.kjmo DESC NULLS LAST) AS konz_kjmo_max,
   AVG(kum.betrag_umsatz * kurs_2) OVER (PARTITION BY kum.mandant_id, kum.konzessionaer_id, kum.mietvertrag_id, kum.immo_objekt_id, kurs.wrg_typ_id ORDER BY kum.mandant_id, kum.konzessionaer_id, kum.mietvertrag_id, kum.immo_objekt_id, kurs.wrg_typ_id, kum.kjmo DESC NULLS LAST) AS konz_umsatz_avg
  FROM
  (  /* Konzessionaer Umsatz : Ermittlung/Ranking 12 Monate */
  SELECT
  kumo.mandant_id,
   kumo.konzessionaer_id,
   kumo.mietvertrag_id,
   kumo.immo_objekt_id,
   kumo.wrg_id,
   kumo.kjmo,
   RANK() OVER (PARTITION BY kumo.mandant_id, kumo.konzessionaer_id, kumo.mietvertrag_id, kumo.immo_objekt_id, kumo.wrg_id ORDER BY kumo.mandant_id, kumo.konzessionaer_id, kumo.mietvertrag_id, kumo.immo_objekt_id, kumo.wrg_id, kumo.kjmo DESC NULLS LAST)::INTEGER  kjmo_lfd,
   kumo.betrag_umsatz
  FROM dbp_view.v_ivs_konzessionaer_umsatz_2 kumo
   JOIN dbp_msi_view_ivs.mv_monat_3gj_2 m01
   ON kumo.kjmo between m01.kjmo_min and m01.kjmo_max
   AND gj_vj_kz = -3

   WHERE kumo.betrag_umsatz <> 0
   QUALIFY RANK() OVER (PARTITION BY kumo.mandant_id, kumo.konzessionaer_id, kumo.mietvertrag_id, kumo.immo_objekt_id, kumo.wrg_id ORDER BY kumo.mandant_id, kumo.konzessionaer_id, kumo.mietvertrag_id, kumo.immo_objekt_id, kumo.wrg_id, kumo.kjmo DESC NULLS LAST) <= 12
   ) kum

   JOIN dbp_msi_view_ivs.mv_mandant_wrg_kurs_zu_per_2  kurs_2
   ON  kum.mandant_id = kurs.mandant_id
   AND kurs.kurs_dat_bis = '9999-12-31'
   ) kums
   ON  ivs.mietvertrag_id = kums.mietvertrag_id
   AND ivs.konzessionaer_id = kums.konzessionaer_id
   AND ivs.immo_objekt_id = kums.immo_objekt_id
   AND ivs.mandant_id = kums.mandant_id
   AND ivs.wrg_typ_id = kums.wrg_typ_id
   AND ivs.wrg_id = kums.wrg_id;