CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_AKTION_ART_WUP_ZU as
    -- LOOKUP Verbindung zwischen Aktion, Artikel, Filiale
    -- WME/AME Bericht
    -- 2018.0614 : Initial. 
    -- 2018.0615 : Erweiterung Ranking, Filter, Kolli 

   SELECT
     akt0.mandant_id, akt0.aktion_id, akt0.aktionsart_id, akt0.kjwo_von, akt0.dat_von, akt0.dat_bis, akt_art.wup_id, akt_art.nb_id, akt_art.art_id, akt_art.wrg_id, akt_art.vk_aktion_brutto, art_wup.vk_brutto, art_kolli.menge_einh_id, art_kolli.umrech_faktor, RANK() OVER (PARTITION BY akt_art.mandant_id, akt_art.wup_id, akt_art.art_id ORDER BY akt_art.mandant_id, akt_art.wup_id, akt_art.art_id, akt0.kjwo_von DESC NULLS LAST) rang_kw, art_wup.bezugsweg_id, akt0.werbe_kat_id, werbe_kat.werbe_kat_bez, akt_art.aktion_thema_id, akt_thema.aktion_thema_bez, akt0.preisaktiviert_fg

   FROM dbp_view.v_aktion   akt0
   INNER JOIN dbp_view.v_aktion_art_wup_zu akt_art
   ON  akt_art.aktion_id = akt0.aktion_id AND akt_art.mandant_id = akt0.mandant_id
   INNER JOIN dbp_view.v_art_wup_zu_per art_wup
   ON  art_wup.art_id = akt_art.art_id AND art_wup.mandant_id = akt_art.mandant_id AND art_wup.wup_id = akt_art.wup_id
   AND akt0.dat_von BETWEEN art_wup.dat_von AND art_wup.dat_bis
   INNER JOIN dbp_view.v_aktion_thema_spr_zu akt_thema
   ON  akt_thema.aktion_thema_id = akt_art.aktion_thema_id AND akt_thema.mandant_id = akt_art.mandant_id
   AND akt_thema.spr_id = 22
   INNER JOIN dbp_view.v_werbekat_spr_zu werbe_kat
   ON  werbe_kat.werbe_kat_id = akt0.werbe_kat_id AND werbe_kat.mandant_id = akt0.mandant_id
   AND werbe_kat.spr_id = 22

   JOIN ( -- Ermittlung Kolli/Faktor pro Bezugsweg
     SELECT
       art_bzw.art_id, art_bzw.mandant_id, art_bzw.menge_einh_id, art_bzw.bezugsweg_id, COALESCE(art_um.umrech_faktor, 1) AS umrech_faktor
   FROM (
      SELECT art_id, mandant_id, best_menge_einh_id AS menge_einh_id, 1 AS bezugsweg_id
   FROM dbp_view.v_art WHERE dat_bis = '9999-12-31'
  UNION ALL
  SELECT art_id, mandant_id, ausg_menge_einh_id AS menge_einh_id, 4 AS bezugsweg_id
   FROM dbp_view.v_art_vorschlagswert_per WHERE dat_bis = '9999-12-31'
 ) art_bzw
   LEFT JOIN (
   SELECT art_id, mandant_id, altnv_menge_einh_id AS menge_einh_id, umrech_faktor
   FROM dbp_view.v_art_umrechnung_faktor_per WHERE dat_bis = '9999-12-31'
 ) art_um
   ON art_um.art_id = art_bzw.art_id AND art_um.mandant_id = art_bzw.mandant_id
   AND art_um.menge_einh_id = art_bzw.menge_einh_id
 ) art_kolli
   ON art_kolli.art_id = art_wup.art_id AND art_kolli.mandant_id = art_wup.mandant_id
   AND art_kolli.bezugsweg_id = art_wup.bezugsweg_id

   WHERE akt_art.grund_sperrung IS NULL
   AND akt0.dat_von BETWEEN (CURRENT_DATE - 366) AND (CURRENT_DATE -1);