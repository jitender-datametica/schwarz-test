CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_BESCH_RECH_DET
       (
       system_id
       ,mandant_id
       ,rech_beleg_id
       ,rech_beleg_pos_id
       ,gj
       ,best_beleg_id
       ,best_beleg_pos_id
       ,wbnk_fg
       ,konditionsart_id
       ,ean_id
       ,gp_art_id
       ,edi_pos_nr
       --,betrag_netto
       ,betrag_mwst
       ,wg_id
       ,gp_id
       ,einkaufsorganisation_id
       ,wup_id
       ,nb_id
       ,art_id
       ,menge_rech
       ,best_menge_einh_id
       ,best_preis_menge
       ,best_preis_menge_einh_id
       ,buch_grund_int_id
       ,buch_grund_ext_id
       ,arthiertyp_id
       ,lagerbew_beleg_id
       ,lagerbew_beleg_pos_id
       ,kj
       ,mengenabw_rpw_fg
       ,preisabw_rpw_fg
       ,menge_rechsteller
       ,rechsteller_menge_einh_id
       ,betrag_kondition
       ,kondition_einh_id
       ,kondition_menge_einh_id
       ,kondition_preis_einh_id
       ,preis_vk_brutto
       ,betrag_vk_brutto
       ,betrag_beleg
       ,soll_haben_kz
       ,vk_wrg_id
       ,pos_manuell_erstellt_fg
       ,dat_rpw
       ,dat_buch
       ,dat_beleg
       ,dat_erfasst
       ,dat_rech_eingang
       ,sap_mwst_id
       ,betrag_korrektur_netto
       ,mwst

       )
       AS
          SELECT
           7
          ,a.mandant_id
          ,a.rech_beleg_id
          ,a.rech_beleg_pos_id
          ,a.gj
          ,a.best_beleg_id
          ,a.best_beleg_pos_id
          ,a.wbnk_fg
          ,COALESCE(a.konditionsart_id, '0') AS konditionsart_id
          ,COALESCE(a.ean_id,0) ean_id
          ,a.gp_art_id
          ,a.edi_pos_nr
          ,a.betrag_mwst
          ,c.wg_id
          ,b.gp_id
          ,a.einkaufsorganisation_id
          ,b.wup_id
          ,b.nb_id
          ,a.art_id
          --CAST(TRUNC(a.menge_rech/u.umrech_faktor,3) AS DECIMAL(18,3)),
          ,CAST((a.menge_rech/round(u.umrech_faktor,21)) AS DECIMAL(18,3))
          ,a.best_menge_einh_id
          ,a.best_preis_menge
          ,a.best_preis_menge_einh_id
          ,COALESCE (a.buch_grund_int_id, '0') buch_grund_int_id
          ,COALESCE (a.buch_grund_ext_id, '0') buch_grund_ext_id
          ,a.arthiertyp_id
          ,a.lagerbew_beleg_id
          ,a.lagerbew_beleg_pos_id
          ,a.kj
          ,a.mengenabw_rpw_fg
          ,a.preisabw_rpw_fg
          ,a.menge_rechsteller
          ,a.rechsteller_menge_einh_id
          ,a.betrag_kondition
          ,a.kondition_einh_id
          ,a.kondition_menge_einh_id
          ,a.kondition_preis_einh_id
          ,a.preis_vk_brutto
          ,a.betrag_vk_brutto
          ,a.betrag_beleg
          ,a.soll_haben_kz
          ,a.vk_wrg_id
          ,a.pos_manuell_erstellt_fg
          ,CASE WHEN b.rech_beleg_status_id = '5' THEN  CAST(b.dat_erfasst AS VARCHAR) ELSE NULL END AS dat_rpw_
          ,b.dat_buch
          ,b.dat_beleg
          ,b.dat_vorerfasst AS dat_erfasst
          ,b.dat_rech_eingang
          ,sap_mwst_id
          ,a.betrag_korrektur_netto
          ,a.mwst
          FROM dbp_view.v_besch_rech_det a
          JOIN dbp_view.v_besch_rech b
          ON a.mandant_id = b.mandant_id
          AND a.rech_beleg_id = b.rech_beleg_id
          AND a.gj = b.gj
          JOIN dbp_view.v_art_wg_zu_per c
          ON a.mandant_id = c.mandant_id
          AND a.art_id = c.art_id
          AND (CASE WHEN b.rech_beleg_status_id = '5' THEN  CAST(b.dat_erfasst AS DATE) ELSE NULL END) BETWEEN c.dat_von AND c.dat_bis
          AND c.arthiertyp_id = 2
          INNER JOIN dbp_view.v_art_umrechnung_faktor_per u
          ON a.art_id = u.art_id
          AND a.mandant_id = u.mandant_id
          AND a.best_menge_einh_id = u.altnv_menge_einh_id
          AND (CASE WHEN b.rech_beleg_status_id = '5' THEN CAST(b.dat_erfasst AS DATE) ELSE NULL END) BETWEEN u.dat_von AND u.dat_bis
          WHERE a.mandant_id = 1;