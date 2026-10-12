CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_BACKPLAN_DENORM_NEU_2 as
   -- FAKT : Backplanung 2016 denormalisiert : Artikel_2 - Tag_2 - Filiale
   -- 2016-07-19 initial : Neue Version 2016 auf Basis neuer Tabelle mit Logik/Berechnung
   -- 2016-09-07 ssch0611 : Parallelbetrieb mit 'altem' Backplan (Strukturen verdoppelt)
   -- 2016-11-15 ssch0611 : Finetuning, Finalversion
   -- 2017.0817 : Rollout Ausland (temp. LEFT JOIN art_backen_spr_zu_2)
   -- 2017.0928 : Erweiterung Eckartikel + fixe Fruehstartmenge

   SELECT
   bp.mandant_id, bp.nb_id, bp.wup_id, bp.art_id, TO_VARCHAR((CASE WHEN bp.mandant_id=1 THEN (bp.art_id/100) ELSE (bp.art_id/10) END), 'FM00000000')  AS kl_art_nr, absz.art_backen_bez, COALESCE(absz.feierabend_fg, 0) AS feierabend_fg, bp.listung_id_backshop                   -- Listung Backplan: 1=gelistet, 2=neu (3 Wochen), 3=AS (3 Wochen), 0=ausgelistet (nicht enthalten!)
   , bp.listung_id_backshop AS art_aktion_id  -- Alias Listung
   , aktion_id                                                                     -- Referenz aktion_2
   , CASE WHEN length(TRIM(aktion_id)) > 1 THEN 1 ELSE 0 END::BYTEINT AS aktion_fg  -- Flag Aktion_2/Werbung
   , bp.dat, COALESCE(abf.fruehstart_menge, 0) AS fruehstart_menge  -- fixe Fruestartmenge
   , bp.menge_gs                 AS menge01           -- Fruehstart  (kalkulierter Absatz)
   , bp.menge_gff - bp.menge_gs  AS menge02           -- Fruehschicht (kalkulierter Absatz)
   , bp.menge_spaet              AS menge03           -- Spaetschicht (erwarteter Absatz)
   , bp.menge_abend              AS menge04           -- Abendschicht (erwarteter Absatz)
   , bp.menge_tag                AS tagesmenge        -- Tagesmenge Backplan
   , bp.menge_abschrift          AS total_abschriften -- durchschn. Totalabschriften
   , back.blech_belegung                              -- Anzahl Artikel_2 pro Blech
   , back.back_programm_id, back.back_dauer, back.back_hinweis_id, back.back_hinweis_bez, back.back_aufbereitung_id, back.back_aufbereitung_bez, back.ofen_typ_id, back.anz_ofen, back.anz_backblech
   FROM dbp_msi_v_view.v_backshop_prognose_neu_2 bp
   LEFT JOIN dbp_view.v_art_backen_spr_zu_2 absz  -- Bezeichnung Backartikel + Eckartikel(Feierabend) FG

   ON bp.art_id = absz.art_id
   AND bp.mandant_id = absz.mandant_id
   AND ((absz.mandant_id=1 AND absz.spr_id=22) OR (absz.mandant_id<>1 AND absz.spr_id<>22))
   LEFT JOIN dbp_view.v_art_backshop_fruehstart_2 abf -- fixe Fruehstartmenge

   ON bp.art_id = abf.art_id
   AND bp.mandant_id = abf.mandant_id
   AND bp.wup_id = abf.wup_id
   LEFT JOIN
   ( -- Backshop-Ofen-Artikel_2
   SELECT
   wbp.mandant_id, wbp.wup_id, wbp.anz_ofen, aoz.art_id, aoz.ofen_typ_id, lo.anz_backblech, aoz.blech_belegung, abz.back_programm_id, lb.back_dauer, lb.gp_backen_bez -- Lieferant (nur bei manchen Programmen)
   , abhz.back_hinweis_id, bhsz.back_hinweis_bez, abaz.back_aufbereitung_id, basz.back_aufbereitung_bez
   FROM dbp_view.v_wup_backshop_per_2 wbp

   JOIN dbp_view.v_art_ofentyp_zu_2 aoz
   ON wbp.mandant_id = aoz.mandant_id
   AND wbp.ofen_typ_id = aoz.ofen_typ_id

   JOIN dbp_view.v_l_ofentyp_2 lo
   ON wbp.mandant_id = lo.mandant_id
   AND wbp.ofen_typ_id = lo.ofen_typ_id

   JOIN dbp_view.v_art_backprogramm_zu_2 abz
   ON aoz.mandant_id = abz.mandant_id
   AND aoz.art_id = abz.art_id

   JOIN dbp_view.v_l_backzeit_2 lb
   ON wbp.mandant_id = lb.mandant_id
   AND wbp.ofen_typ_id = lb.ofen_typ_id
   AND abz.back_programm_id = lb.back_programm_id
   AND (wbp.gp_backen_bez = lb.gp_backen_bez OR lb.gp_backen_bez = '') -- Lieferantenabhaengig

   JOIN dbp_view.v_art_back_aufbereitung_zu_2 abaz
   ON aoz.mandant_id = abaz.mandant_id
   AND aoz.art_id = abaz.art_id
   JOIN dbp_view.v_back_aufbereitung_spr_zu_2 basz
   ON aoz.mandant_id = basz.mandant_id
   AND abaz.back_aufbereitung_id = basz.back_aufbereitung_id

   JOIN dbp_view.v_art_back_hinweis_zu_2 abhz
   ON aoz.mandant_id = abhz.mandant_id
   AND aoz.art_id = abhz.art_id
   JOIN dbp_view.v_back_hinweis_spr_zu_2 bhsz
   ON aoz.mandant_id = bhsz.mandant_id
   AND abhz.back_hinweis_id = bhsz.back_hinweis_id

   WHERE wbp.nb_id = 0
   AND wbp.dat_bis = '9999-12-31'
   ) back
   ON  bp.art_id = back.art_id
   AND bp.mandant_id = back.mandant_id
   AND bp.wup_id = back.wup_id
   ;