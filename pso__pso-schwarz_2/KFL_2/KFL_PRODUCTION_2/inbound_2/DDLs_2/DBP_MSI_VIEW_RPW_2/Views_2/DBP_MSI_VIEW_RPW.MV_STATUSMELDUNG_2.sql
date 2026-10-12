CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_STATUSMELDUNG_2
 (
 -- 06.07.2012 twie: wup_2 aus besch_rech_2 dazugejoint
 -- 28.08.2013 kkai: besch_rech_2 wieder ausgebaut
 -- 01.10.2013 twie: besch_rech_2 wieder eingebaut mit zusätzlichen Feldern

 mandant_id
 , statusmeldung_id
 , ecm_vorgang
 , zeitstempel
 , dat
 , dat_erfasst
 , dat_buch
 , statuscode_id
 , ursprung_beleg_id
 , ursprung_beleg_gj
 , ersteller_id
 , gp_id
 , gp_id_last
 , einkaufsorganisation_id
 , auto_fg
 , betrag_brutto
 , betrag_mwst
 , wrg_id
 , quellsystem_id
 , belegklasse_id
 , system_id
 , fi_beleg_id
 , imprint_nr
 , edi_nr
 , beleg_id
 , beleg_gj
 , rpw_beleg_zu_id
 , manuelle_buchung_fg
 , statusmeldung_ecm_lfd_nr
 , last_fg
 , wup_id
 , nb_id
 , gp_lief_id
 , dat_beleg
 , betrag_brutto_rech
 )
 AS
    SELECT
    v01.mandant_id,
    v01.statusmeldung_id,
    v01.ecm_vorgang,
    v01.zeitstempel,
    v01.dat,
    v01.dat_erfasst,
    v01.dat_buch,
    v01.statuscode_id,
    v01.ursprung_beleg_id,
    v01.ursprung_beleg_gj,
    v01.ersteller_id,
    v01.gp_id,
    v01.last_gp_id AS gp_id_last,
    v01.einkaufsorganisation_id,
    v01.auto_fg,
    v01.betrag_brutto,
    v01.betrag_mwst,
    v01.wrg_id,
    v01.quellsystem_id,
    v01.belegklasse_id,
    7,
    v01.fi_beleg_id,
    v01.imprint_nr,
    v01.edi_nr,
    v01.beleg_id,
    v01.beleg_gj,
    v01.beleg_id_orig AS rpw_beleg_zu_id,
    v01.manuelle_buchung_fg,
    v01.statusmeldung_ecm_lfd_nr,
    v01.last_fg,
    COALESCE(v02.wup_id, 0) AS wup_id,
    CASE
    WHEN v02.wup_id IS NULL THEN -1
    ELSE v02.nb_id
    END AS nb_id,
    v02.gp_lief_id,
    v02.dat_beleg,
    v02.betrag_brutto AS betrag_brutto_rech

FROM dbp_view.v_statusmeldung_2 v01
    LEFT OUTER JOIN dbp_view.v_besch_rech_2 v02
    ON v01.beleg_id = v02.rech_beleg_id
    AND v01.beleg_gj = v02.gj
    AND v01.mandant_id = v02.mandant_id

    WHERE v01.mandant_id = 1;