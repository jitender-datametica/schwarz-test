CREATE OR REPLACE VIEW DBP_MSI_VIEW_IVS.MV_BRANCHE_VORGABE_ZUORDNUNG
AS
   SELECT
   mvf.mandant_id,
   mvf.immo_objekt_id,
   imr.miet_region_id,
   imr.bl_id,
   mvf.flaeche_id,
   mvf.mietvertrag_id,
   mvf.dat_flaeche_uebergabe,
   mvf.dat_flaeche_rueckgabe,
   mvf.branche_id,
   mv.konzessionaer_id,
   fp.flaeche_groesse,
   wcm.bonanzahl_jahr  kunden_anzahl_jahr,
   bv.branche_mix,
   bv.vorgabe_prozent -- Vorgabe Umsatzmiete%
   ,
   bv.vorgabe_betrag  -- Vorgabe durchs. EK
   ,
   bv.vorgabe_prodvt  -- Vorgabe Produktivit‰t
   ,
   bv.vorgabe_miete   -- Vorgabe Miete pro m2
   ,
   bv.vorgabe_achsen_abschnitt,
   bv.vorgabe_steigung,
   CASE WHEN mvf.mandant_id = 1
   THEN CASE WHEN fp.flaeche_groesse BETWEEN 0     AND 50     THEN  77
   WHEN fp.flaeche_groesse BETWEEN 50.01 AND 249.99 THEN 100
   WHEN fp.flaeche_groesse BETWEEN 250   AND 999999 THEN 120
   END
   ELSE CASE WHEN mvf.branche_id <> '120'
   THEN 65 -- irrelevant, da 120 = Bankomat in KMO
   END
   END::DECIMAL(18,4)  vorgabe_immo_vw -- Vorgabe Immo-Verwaltungskosten
   ,
   (bv.vorgabe_betrag * 0.7)  temp_einkauf,
   (wcm.bonanzahl_jahr * bv.vorgabe_steigung + bv.vorgabe_achsen_abschnitt)::DECIMAL(18,4)  kalk_einkauf,
   CASE WHEN bv.mandant_id = 1
   THEN CASE WHEN COALESCE(kalk_einkauf, 0) < COALESCE(temp_einkauf, 0)
   THEN temp_einkauf
   ELSE kalk_einkauf
   END
   ELSE bv.vorgabe_betrag
   END::DECIMAL(18,4)                     WSA_opt_einkauf,
   (wcm.bonanzahl_jahr * WSA_opt_einkauf)  WSA_zielumsatz,
   (bv.vorgabe_prodvt * 1.2)               WSA_opt_prodvt,
   CASE WHEN wsa_opt_prodvt <> 0 THEN (TRUNC(wsa_zielumsatz / wsa_opt_prodvt)) ELSE 0 END WSA_opt_flaeche,
   (wsa_zielumsatz * bv.vorgabe_prozent)   WSA_umsatzmiete_jahr,
   (TRUNC(WSA_umsatzmiete_jahr / 12))             WSA_umsatzmiete,
   (vorgabe_miete * fp.flaeche_groesse)    WSA_mindestmiete,
   CASE WHEN COALESCE(wsa_mindestmiete, 0) > COALESCE(wsa_umsatzmiete, 0)
   THEN wsa_mindestmiete
   ELSE wsa_umsatzmiete
   END                                     WSA_miete,
   ku.konz_umsatz_monat * (TRUNC(CAST(mvf.miete_umsatz_prozent AS DECIMAL(18,2))/100))  kalk_umsatzmiete,
   CASE WHEN bv.mandant_id = 3
   THEN CASE WHEN kalk_umsatzmiete > mvf.miete_betrag
   THEN kalk_umsatzmiete - mvf.miete_betrag
   END
   END kalk_umsatzmiete_abschlag,
   bv.wrg_id,
   bv.wrg_typ_id
   FROM dbp_msi_v_view.v_ivs_mietvtg_fl_zu_per_msi mvf

   JOIN dbp_view.v_ivs_mietvertrag_per  mv
   ON mv.mietvertrag_id = mvf.mietvertrag_id
   AND mv.mandant_id = mvf.mandant_id
   AND mv.dat_bis= '9999-12-31'

   JOIN dbp_view.v_ivs_flaeche_per  fp
   ON fp.flaeche_id = mvf.flaeche_id
   AND fp.mandant_id = mvf.mandant_id
   AND fp.dat_bis= '9999-12-31'

   JOIN dbp_view.v_ivs_immo_obj_miet_region_zu  imr
   ON imr.immo_objekt_id = mvf.immo_objekt_id
   AND imr.mandant_id = mvf.mandant_id
   LEFT JOIN
   (
   SELECT
   wcm0.mandant_id,
   i.immo_objekt_id,
   AVG(wcm0.bonanzahl) * 12 bonanzahl_jahr
   FROM dbp_view.v_wupcal_mo_sum wcm0
   INNER JOIN dbp_view.v_ivs_immo_objekt_per i
   ON wcm0.mandant_id = i.mandant_id
   AND wcm0.wup_id = i.immo_objekt_bez
   AND i.dat_bis = '9999-12-31'

   JOIN dbp_view.v_monat zeit0
   ON wcm0.kjmo = zeit0.kjmo

   WHERE wcm0.nb_id = 0
   AND zeit0.akt_mo_komplett BETWEEN -11 AND 0

   GROUP BY
   wcm0.mandant_id
   ,i.immo_objekt_id
   ) wcm
   ON wcm.immo_objekt_id = mvf.immo_objekt_id
   AND wcm.mandant_id = mvf.mandant_id
   LEFT JOIN
   (  -- Techn. Platz Kaufland Baecker
   SELECT
   tp0.techn_platz_id,
   tp0.mandant_id,
   immo_objekt_id,
   tp2.frische_baecker,
   tp2.discount_backshop,
   CASE WHEN CONTAINS( tp2.frische_baecker, 'J')   THEN 1
   WHEN CONTAINS( tp2.discount_backshop, 'J') THEN 1
   WHEN CONTAINS( tp2.frische_baecker, 'N')   THEN 2
   WHEN CONTAINS( tp2.discount_backshop, 'N') THEN 2
   ELSE 2
   END::BYTEINT  kaufland_baecker_fg
   FROM dbp_view.v_techn_platz_per tp0
   LEFT JOIN dbp_view.v_techn_platz_ebene_2_per tp2
   ON tp0.techn_platz_id = tp2.techn_platz_id
   INNER JOIN dbp_view.v_ivs_immo_objekt_per i
   ON tp0.mandant_id = i.mandant_id
   AND tp0.wup_id = i.immo_objekt_bez
   AND i.dat_bis = '9999-12-31'

   WHERE tp0.techn_platz_ebene_id = 2
   AND tp0.dat_bis = '9999-12-31'
   AND tp2.dat_bis = '9999-12-31'
   ) tp
   ON tp.immo_objekt_id = mvf.immo_objekt_id
   AND tp.mandant_id = mvf.mandant_id
   LEFT OUTER JOIN dbp_msi_view_ivs.mv_branche_vorgabe  bv
   ON bv.mandant_id = mvf.mandant_id
   AND bv.branche_id = mvf.branche_id
   AND (bv.konzessionaer_id = '0' OR bv.konzessionaer_id = mv.konzessionaer_id)
   AND bv.miet_region_id = imr.miet_region_id
   AND bv.bl_id = imr.bl_id
   AND fp.flaeche_groesse BETWEEN bv.flaeche_groesse_von AND bv.flaeche_groesse_bis
   AND wcm.bonanzahl_jahr BETWEEN bv.kunden_anzahl_von AND bv.kunden_anzahl_bis
   AND bv.kaufland_baecker_fg = (CASE WHEN bv.kaufland_baecker_fg > 0 THEN tp.kaufland_baecker_fg ELSE 0 END)
   LEFT JOIN
   (
   SELECT
   mandant_id,
   mietvertrag_id,
   konzessionaer_id,
   immo_objekt_id,
   AVG(betrag_umsatz) konz_umsatz_monat
   FROM dbp_view.v_ivs_konzessionaer_umsatz ku0

   JOIN dbp_view.v_monat zeit0
   ON zeit0.kjmo=ku0.kjmo

   WHERE akt_kj=-1

   GROUP BY
   mandant_id
   ,mietvertrag_id
   ,konzessionaer_id
   ,immo_objekt_id
   ) ku
   ON ku.mietvertrag_id = mvf.mietvertrag_id
   AND ku.konzessionaer_id = mv.konzessionaer_id
   AND ku.immo_objekt_id = mvf.immo_objekt_id
   AND ku.mandant_id = mvf.mandant_id

   WHERE mvf.dat_flaeche_uebergabe BETWEEN '2011-01-01' AND CURRENT_DATE
   AND mvf.dat_flaeche_rueckgabe BETWEEN CURRENT_DATE AND '9999-12-31';