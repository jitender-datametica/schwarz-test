CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_BESCH_RECH_1
 -- 05.09.2013 twie: Dummywup 0 ausgeben statt NULL
 -- 04.07.2014 twie: Vorzeichenlogik bei betrag_diff_toleranz entfernt, soll angezeigt werden wie in SAP
 -- 08.06.2014 twie: SPEC0010434 bestell_nr_ext neu hinzu
 -- 27.07.2017 twie: SPEC0017957 neues Feld ocr_eingangskanal_id
 -- 05.08.2021 twie: NSR2322930 Fkt to_number geändert in try_to_number um '' (blank) abzufangen

 (
 system_id
 ,mandant_id
 ,rech_beleg_id
 ,gj
 ,dat_erfasst
 ,dat_rpw
 ,dat_buch
 ,dat_beleg
 ,dat_rech_eingang
 ,betrag_brutto
 ,betrag_netto
 ,referenzierung_fg
 ,dat_referenzierung
 ,gp_lief_id
 ,dat_leist_erstellung
 ,gp_id_unbek_fg
 ,forderung_unber_fg
 ,dat_vorerfasst
 ,dat_aenderung_rpw
 ,aenderung_user_name
 ,gp_id
 ,einkaufsorganisation_id
 ,belegart_id
 ,erfassung_id
 ,ersteller_id
 ,wup_id
 ,nb_id
 ,buchungskreis_id
 ,rech_beleg_storno_id
 ,storno_gj
 ,vorgangsart_ag08_id
 ,rech_beleg_status_id
 ,betrag_diff_toleranz
 ,bela_limit_unterschreitung_fg
 ,bela_versandsperre_fg
 ,bela_ref_beleg_id
 ,bela_ref_gj
 ,bela_zahlsperre_id
 ,buch_grund_int_id
 ,buch_grund_ext_id
 ,gs_ref_beleg_id
 ,gs_ref_gj
 ,anz_belege_gr_120
 ,anz_belege_90_120
 ,anz_belege_60_89
 ,anz_belege_30_59
 ,anz_belege_15_29
 ,anz_belege_kl_15
 ,anz_belege_keine_buchung
 ,markant_archiv_nr
 ,korrektur_kz
 ,betrag_gp_fehler_netto
 ,obj_id
 , betrag_beleg
 ,betrag_korrektur_netto
 , manuelle_buchung_fg
 , mengenabw_rpw_pos_anz
 , preisabw_rpw_pos_anz
 , mengenabw_rpw_fg
 , preisabw_rpw_fg
 , lieferschein_id_ext
 ,bestell_nr_ext
 ,ocr_eingangskanal_id

 )
 AS
    SELECT
    system_id,
    mandant_id,
    rech_beleg_id,
    gj,
    dat_erfasst_v,
    to_date(dat_rpw_) AS dat_rpw,
    dat_buch,
    dat_beleg,
    dat_rech_eingang,
    betrag_brutto_ AS betrag_brutto,
    betrag_netto_ AS betrag_netto,
    referenzierung_fg,
    dat_referenzierung,
    gp_lief_id,
    dat_leist_erstellung,
    gp_id_unbek_fg,
    forderung_unber_fg,
    dat_vorerfasst,
    dat_aenderung_rpw,
    aenderung_user_name,
    gp_id,
    einkaufsorganisation_id,
    belegart_id,
    erfassung_id,
    ersteller_id,
    COALESCE(wup_id, 0) AS wup_id,
    CASE
    WHEN wup_id IS NULL THEN -1
    ELSE nb_id
    END AS nb_id,
    buchungskreis_id,
    COALESCE(to_varchar(rech_beleg_storno_id), ' ') AS rech_beleg_storno_id,
    storno_gj,
    vorgangsart_ag08_id,
    rech_beleg_status_id,
    betrag_diff_toleranz,
    bela_limit_unterschreitung_fg,
    bela_versandsperre_fg,
    bela_ref_beleg_id,
    bela_ref_gj,
    bela_zahlsperre_id,
    buch_grund_int_id,
    buch_grund_ext_id,
    gs_ref_beleg_id,
    gs_ref_gj,
    anz_belege_gr_120,
    anz_belege_90_120,
    anz_belege_60_89,
    anz_belege_30_59,
    anz_belege_15_29,
    anz_belege_kl_15,
    anz_belege_keine_buchung,
    markant_archiv_nr,
    korrektur_kz,
    betrag_gp_fehler_netto,
    obj_id,
    betrag_beleg,
    betrag_korrektur_netto,
    manuelle_buchung_fg,
    mengenabw_rpw_pos_anz,
    preisabw_rpw_pos_anz,
    mengenabw_rpw_fg,
    preisabw_rpw_fg,
    lieferschein_id_ext,
    bestell_nr_ext,
    ocr_eingangskanal_id

    FROM
    (
    SELECT
    7 AS system_id,
    rech.mandant_id,
    rech.rech_beleg_id,
    rech.gj,
    rech.dat_vorerfasst AS dat_erfasst_v,
    
     -- CASE WHEN rech.rech_beleg_status_id = '5' THEN CAST(rech.dat_erfasst AS VARCHAR) ELSE NULL END AS dat_rpw_,
    
      CASE WHEN rech.rech_beleg_status_id = '5' THEN rech.dat_erfasst ELSE NULL END AS dat_rpw_,
      
      
    rech.dat_buch,
    rech.dat_beleg,
    rech.dat_rech_eingang,
    COALESCE(try_to_number(rech.buch_grund_ext_id), 0) AS buch_grund_ext_id_,
    CASE WHEN (
    (rech.belegart_id IN ('HS', 'HK') AND (buch_grund_ext_id_ < 200 OR buch_grund_ext_id_ > 299)) OR
    rech.belegart_id IN ('32', 'HB') OR
    (rech.belegart_id = '31' AND (buch_grund_ext_id_ BETWEEN 200 AND 299))
    )
    THEN 1
    ELSE -1
    END AS faktor_vorzeichen_belegart,
    CASE WHEN
    (rech.belegart_id IN ('HS', 'HK','HB','32'))
    THEN 1
    ELSE -1
    END AS faktor_vorz_betr_brutto_netto,
    ABS(rech.betrag_brutto) * faktor_vorz_betr_brutto_netto AS betrag_brutto_,
    ABS(rech.betrag_netto) * faktor_vorz_betr_brutto_netto AS betrag_netto_,
    rech.referenzierung_fg,
    rech.dat_referenzierung,
    rech.gp_lief_id,
    rech.dat_leist_erstellung,
    rech.gp_id_unbek_fg,
    rech.forderung_unber_fg,
    rech.dat_vorerfasst,
    rech.dat_aenderung_rpw,
    rech.aenderung_user_name,
    rech.gp_id,
    rech.einkaufsorganisation_id,
    rech.belegart_id,
    rech.erfassung_id,
    rech.ersteller_id,
    rech.wup_id,
    rech.nb_id,
    rech.buchungskreis_id,
    rech.rech_beleg_storno_id,
    rech.storno_gj,
    rech.vorgangsart_ag08_id,
    rech.rech_beleg_status_id,
    rech.betrag_diff_toleranz,
    rech.bela_limit_unterschreitung_fg,
    rech.bela_versandsperre_fg,
    rech.bela_ref_beleg_id,
    rech.bela_ref_gj,
    rech.bela_zahlsperre_id,
    to_char(COALESCE (rech.buch_grund_int_id, '0')) AS buch_grund_int_id,
    to_char(COALESCE (rech.buch_grund_ext_id, '0')) AS buch_grund_ext_id,
    rech.gs_ref_beleg_id,
    rech.gs_ref_gj,
    to_date(rech.dat_erfasst) AS dat_erfasst_,
    CASE WHEN ( (rech.rech_beleg_status_id = '5') AND (rech.dat_buch - dat_erfasst_ > 120)) THEN 1 ELSE 0 END AS  anz_belege_gr_120,
    CASE WHEN ( (rech.rech_beleg_status_id = '5') AND (rech.dat_buch - dat_erfasst_ > 89) AND (rech.dat_buch - dat_erfasst_ <= 120)) THEN 1 ELSE 0 END AS  anz_belege_90_120,
    CASE WHEN ( (rech.rech_beleg_status_id = '5') AND (rech.dat_buch - dat_erfasst_ > 59) AND (rech.dat_buch - dat_erfasst_ <= 89)) THEN 1 ELSE 0 END AS  anz_belege_60_89,
    CASE WHEN ( (rech.rech_beleg_status_id = '5') AND (rech.dat_buch - dat_erfasst_ > 29) AND (rech.dat_buch - dat_erfasst_ <= 59)) THEN 1 ELSE 0 END AS  anz_belege_30_59,
    CASE WHEN ( (rech.rech_beleg_status_id = '5') AND (rech.dat_buch - dat_erfasst_ > 14) AND (rech.dat_buch - dat_erfasst_ <= 29)) THEN 1 ELSE 0 END AS  anz_belege_15_29,
    CASE WHEN ( (rech.rech_beleg_status_id = '5') AND (rech.dat_buch - dat_erfasst_ <= 14)) THEN 1 ELSE 0 END AS  anz_belege_kl_15,
    CASE WHEN (rech.rech_beleg_status_id <> '5') THEN 1 ELSE 0 END AS  anz_belege_keine_buchung,
    rech.markant_archiv_nr,
    (CASE WHEN (rech.mengenabw_rpw_pos_anz  + rech.preisabw_rpw_pos_anz) <> 0 THEN 'K' ELSE NULL END)  AS korrektur_kz,
    ABS(rech.betrag_gp_fehler_netto) * faktor_vorzeichen_belegart AS betrag_gp_fehler_netto,
    obj_id,
    rech.betrag_beleg AS betrag_beleg,
    rech.betrag_korrektur_netto AS betrag_korrektur_netto,
    rech.manuelle_buchung_fg,
    rech.mengenabw_rpw_pos_anz,
    rech.preisabw_rpw_pos_anz,
    CASE WHEN mengenabw_rpw_pos_anz > 0 THEN 1 ELSE 0 END mengenabw_rpw_fg,
    CASE WHEN preisabw_rpw_pos_anz > 0 THEN 1 ELSE 0 END preisabw_rpw_fg,
    rech.lieferschein_id_ext,
    bestell_nr_ext,
    ocr_eingangskanal_id

    FROM dbp_view.v_besch_rech_1  rech


    WHERE rech.mandant_id = 1
    --and nb_id <> 99
    ) a;