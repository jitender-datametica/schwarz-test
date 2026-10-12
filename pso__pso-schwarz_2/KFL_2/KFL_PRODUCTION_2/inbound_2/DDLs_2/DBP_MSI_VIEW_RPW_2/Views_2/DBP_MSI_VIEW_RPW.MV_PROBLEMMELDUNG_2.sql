CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_PROBLEMMELDUNG_2
 (
 system_id
 , mandant_id
 , problemmeldung_id
 , ecm_vorgang
 , beleg_pos_id
 , problemcode_id
 , zeitstempel
 , belegklasse_id
 , ursprung_beleg_id
 , ursprung_beleg_pos_id
 , ursprung_beleg_gj
 , gp_rech_id
 , gp_rech_pos_id
 , auto_fg
 , loesch_fg
 , gp_id
 , gp_id_last
 , einkaufsorganisation_id
 , art_id
 , wup_id
 , nb_id
 , betrag_brutto
 , betrag_netto
 , betrag_mwst
 , wrg_id
 , ersteller_id
 , verursacher_id
 , imprint_nr
 , edi_nr
 , beleg_id
 , beleg_gj
 , dat
 , dat_erfasst
 , dat_buch
 , double_fg
 , kopf_kz
 , rpw_beleg_zu_id
 , prozessbereich_id
 , last_fg
 )
 AS
    SELECT
    7,
    v01.mandant_id,
    v01.problemmeldung_id,
    v01.ecm_vorgang,
    v01.beleg_pos_id,
    v01.problemcode_id,
    v01.zeitstempel,
    v01.belegklasse_id,
    v01.ursprung_beleg_id,
    v01.ursprung_beleg_pos_id,
    v01.ursprung_beleg_gj,
    v01.gp_rech_id,
    v01.gp_rech_pos_id,
    CASE WHEN v01.manuelle_buchung_fg = 0 THEN 1 ELSE 0 END AS auto_fg,
    v01.loesch_fg,
    v01.gp_id,
    v01.last_gp_id  AS gp_id_last,
    v01.einkaufsorganisation_id,
    v01.art_id,
    v01.wup_id,
    v01.nb_id,
    v01.betrag_brutto,
    v01.betrag_netto,
    v01.betrag_mwst,
    v01.wrg_id,
    v01.ersteller_id,
    v01.verursacher_id,
    v01.imprint_nr,
    v01.edi_nr,
    v01.beleg_id,
    v01.beleg_gj,
    v01.dat,
    v01.dat_erfasst,
    v01.dat_buch,
    CASE WHEN ((v01.problemcode_id = '0458') AND (v01.loesch_fg = 0))THEN 1 ELSE 0 END AS double_fg,
    CASE WHEN v01.beleg_pos_id = 0 THEN 'Kopf' ELSE 'Position' END AS kopf_kz,
    v01.beleg_id_orig AS rpw_beleg_zu_id,
    v01.prozessbereich_id,
    v01.last_fg

FROM dbp_view.v_problemmeldung_2 v01

    WHERE v01.mandant_id = 1;