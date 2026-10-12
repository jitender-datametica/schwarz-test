CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_STAT_RECH_2
-- 05.08.2021 twie: NSR2322930 CAST geändert in try_to_number um '' (blank) abzufangen

    (
    wup_id
    ,nb_id
    ,dat_buch
    ,dat_beleg
    ,dat_erfasst
    ,belegart_id
    ,mandant_id
    ,statusmeldung_id
    ,rpw_beleg_zu_id
    ,ecm_vorgang
    ,zeitstempel
    ,dat
    ,statuscode_id
    ,ursprung_beleg_id
    ,ursprung_beleg_gj
    ,ersteller_id
    ,gp_id
    ,einkaufsorganisation_id
    ,auto_fg
    ,betrag_brutto
    ,betrag_mwst
    ,wrg_id
    ,quellsystem_id
    ,belegklasse_id
    ,system_id
    ,fi_beleg_id
    ,imprint_nr
    ,edi_nr
    ,beleg_id
    ,beleg_gj
    )
    AS
       SELECT
       wup_id,
       nb_id,
       dat_buch,
       dat_beleg,
       dat_erfasst,
       belegart_id,
       mandant_id,
       statusmeldung_id,
       rpw_beleg_zu_id,
       ecm_vorgang,
       zeitstempel,
       dat,
       statuscode_id,
       ursprung_beleg_id,
       ursprung_beleg_gj,
       ersteller_id,
       gp_id,
       einkaufsorganisation_id,
       auto_fg,
       betrag_brutto_ AS betrag_brutto,
       betrag_mwst,
       wrg_id,
       quellsystem_id,
       belegklasse_id,
       system_id,
       fi_beleg_id,
       imprint_nr,
       edi_nr,
       beleg_id,
       beleg_gj
       FROM
       (
       SELECT
       br.wup_id,
       br.nb_id,
       br.dat_buch,
       br.dat_beleg,
       CAST(br.dat_erfasst AS DATE) AS dat_erfasst,
       br.belegart_id,
       sm.mandant_id,
       sm.statusmeldung_id,
       sm.beleg_id_orig AS rpw_beleg_zu_id,
       sm.ecm_vorgang,
       sm.zeitstempel,
       CAST (sm.zeitstempel AS DATE) AS dat,
       sm.statuscode_id,
       sm.ursprung_beleg_id,
       sm.ursprung_beleg_gj,
       sm.ersteller_id,
       sm.gp_id,
       sm.einkaufsorganisation_id,
       sm.auto_fg,
       COALESCE(try_to_number(br.buch_grund_ext_id), 0) AS buch_grund_ext_id_,
       CASE WHEN (
       (br.belegart_id IN ('HS', 'HK') AND (buch_grund_ext_id_ < 200 OR buch_grund_ext_id_ > 299)) OR
       br.belegart_id IN ('32', 'HB') OR
       (br.belegart_id = '31' AND (buch_grund_ext_id_ BETWEEN 200 AND 299))
       )
       THEN ABS(br.betrag_brutto)
       ELSE ABS(br.betrag_brutto) * (-1)
       END AS besch_rech_vorzeeichen,
       CASE WHEN sm.betrag_brutto >= br.betrag_brutto
       THEN besch_rech_vorzeeichen
       ELSE sm.betrag_brutto
       END AS betrag_brutto_,
       sm.betrag_mwst,
       sm.wrg_id,
       sm.quellsystem_id,
       sm.belegklasse_id,
       7 AS system_id,
       sm.fi_beleg_id,
       sm.imprint_nr,
       sm.edi_nr,
       sm.beleg_id,
       sm.beleg_gj
       FROM dbp_view.v_statusmeldung_2 sm_2

       JOIN dbp_view.v_besch_rech_2 br
       ON sm.beleg_id = br.rech_beleg_id
       AND sm.beleg_gj = br.gj
       AND sm.mandant_id = br.mandant_id

       WHERE sm.mandant_id = 1
       
       ) vorz;