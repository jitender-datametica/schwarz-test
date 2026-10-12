CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_LETZTE_PROBLEMMELDUNG
                         (
                         last_fg
                         , system_id
                         , mandant_id
                         , problemmeldung_id
                         , beleg_gj
                         , beleg_id
                         , dat
                         , problemmeldung_ecm_lfd_nr
                         , letzte_problemcode_id
                         )
                         AS
                            SELECT
                            v01.last_fg,
                            7,
                            v01.mandant_id,
                            v01.problemmeldung_id,
                            v01.beleg_gj,
                            v01.beleg_id,
                            v01.dat,
                            v01.problemmeldung_ecm_lfd_nr,
                            v01.problemcode_id AS letzte_problemcode_id

FROM dbp_view.v_problemmeldung v01
                            WHERE v01.last_fg = 1
                            AND v01.mandant_id = 1;