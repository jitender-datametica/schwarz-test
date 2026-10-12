CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_LETZTE_STATUSMELDUNG
 -- 05.09.2013 twie: belegklasse_id ausgeben
 -- 01.10.2013 twie_ belegklasse_id wieder entfernt
 (
 last_fg
 , system_id
 , mandant_id
 , statusmeldung_id
 , beleg_gj
 , beleg_id
 , zeitstempel
 , dat
 , statusmeldung_ecm_lfd_nr
 , letzte_statuscode_id
 , ersteller_id

 )
 AS
    SELECT
    v01.last_fg,
    7,
    v01.mandant_id,
    v01.statusmeldung_id,
    v01.beleg_gj,
    v01.beleg_id,
    v01.zeitstempel,
    v01.dat,
    v01.statusmeldung_ecm_lfd_nr,
    v01.statuscode_id AS letzte_statuscode_id,
    v01.ersteller_id


FROM dbp_view.v_statusmeldung v01
    WHERE v01.last_fg = 1
    AND v01.mandant_id = 1;