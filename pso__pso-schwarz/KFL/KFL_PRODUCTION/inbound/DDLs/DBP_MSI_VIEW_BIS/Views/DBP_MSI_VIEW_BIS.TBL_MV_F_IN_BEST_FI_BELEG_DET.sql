CREATE OR REPLACE VIEW DBP_MSI_VIEW_BIS.TBL_MV_F_IN_BEST_FI_BELEG_DET as
            SELECT
            v01.mandant_id,
            v01.in_fi_beleg_id,
            v01.in_fi_beleg_pos_id,
            v01.best_beleg_id,
            v01.best_beleg_pos_id,
            v01.dat_buch,
            v02.buchung_schl_id AS bsak_bschl_id,
            v01.buchung_schl_id AS bseg_bschl_id,
            CASE WHEN soll_haben_kz ='S' THEN +1 ELSE  -1 END ind_vz,
            v01.menge_fi_beleg * ind_vz AS bestell_menge_fi_beleg,
            v03.in_art_id,
            v03.in_lief_id,
            v03.werk_id,
            v01.werk_id     rech_werk_id,
            v01.in_art_id  rech_in_art_id,
            v03.bestellart_id,
            v03. rech_plan_id,
            v03.endrech_fg,
            v03.einkaufsorganisation_id,
            v03.buchungskreis_id,
            v03.dat_von_rb,
            betrag_fi_beleg,
            umrechnungskurs
           FROM dbp_view.v_in_fi_beleg_det v01
            INNER JOIN dbp_view.v_in_fi_beleg_kred  v02
            ON v01.mandant_id = v02.mandant_id
            AND v01.in_fi_beleg_id = v02.in_fi_beleg_id
            AND v01.gj = v02.gj
            AND v01.buchungskreis_id = v02.buchungskreis_id
            INNER JOIN
            (
            SELECT
            v031.mandant_id,
            v031.best_beleg_id,
            v031.best_beleg_pos_id,
            v031.endrech_fg,
            v031.rech_plan_id,
            v032.bestellart_id,
            v031.betrag_pos_netto_best_wrg,
            v031.menge_best_bme,
            v032.in_lief_id,
            v031.in_art_id,
            v032.einkaufsorganisation_id,
            v031.werk_id,
            v032.buchungskreis_id,
            v032.dat_von_rb

           FROM dbp_view.v_in_besch_best_det  v031
            INNER JOIN dbp_view.v_in_besch_best  v032
            ON v031.best_beleg_id = v032.best_beleg_id
            AND v031.mandant_id = v032.mandant_id

            JOIN dbp_view.v_in_art v033
            ON v031.in_art_id = v033.in_art_id
            AND v031.mandant_id = v033.mandant_id

            WHERE (v032.dat_von_rb IS NOT NULL OR v031.rech_plan_id IS NOT NULL) AND v032.memory_fg = 0

            -- nur Umsätze auf relevanten Artikeln reporten, analog Artikellookup
            AND (v033.artikelart_id IN ('ZSAK','ZSDI','ZSKO', 'ZSWG')
            OR SUBSTR( v033.in_art_nr, 1, 1) = 'W'
            OR v033.in_art_id = -1
            )
            --   OR  v031.endrech_fg = 1
            ) v03
            ON
            v01.best_beleg_id = v03.best_beleg_id
            AND v01.best_beleg_pos_id = v03.best_beleg_pos_id
            AND v01.mandant_id = v03.mandant_id

            JOIN dbp_view.v_kurs v05
            ON v01.wrg_id = v05.von_wrg_id
            AND v01.dat_buch BETWEEN v05.dat_von AND v05.dat_bis
            AND v05.kurstyp_id = 9
            AND v05.nach_wrg_id = 'EUR'


            WHERE
            -- Im nächsten Schritt über koart in ('S', 'M') einzuschränken
            v01.buchung_schl_id IN ('40', '50', '70', '75', '80', '81', '82', '83', '84', '85', '86', '89', '90', '91', '92', '93', '94', '95', '96', '99')
            AND v02.offen_posten_fg = 0
            AND in_fi_beleg_pos_kz <> 'T'

            --definierte Buchungsschlüssel aus BSAK
            AND v02.buchung_schl_id IN ('21', '22', '31', '32')

            --Einschränkung auf relevante Lieferanten
            AND (v01.mandant_id, v02.in_lief_id) IN
            (
            SELECT
            v11.mandant_id,
            v11.in_lief_id
           FROM dbp_view.v_in_lieferant_ekorg_zu v11
            INNER JOIN dbp_view.v_in_l_ekorg v12
            ON v11.mandant_id = v12.mandant_id
            AND v11.einkaufsorganisation_id = v12.einkaufsorganisation_id
            AND v12.sako_fg = 1
            AND v11.einkaeufer_grp_id IS NOT NULL
            )
            --Einschränkung auf relevante Buchungskreise
            AND
            (v01.mandant_id, v01.buchungskreis_id) IN
            (
            SELECT
            mandant_id,
            buchungskreis_id
           FROM dbp_view.v_in_l_buchungskreis
           WHERE sako_fg = 1
           )

           --nur Sachkosten laut Feld BKPF-AWSYS
           AND v01.industrie_fg <> 0

           --keine internen Umsätze
           AND v01.vbund_fg = 0

           --keine Umsätze von Lieferanten in EKG "nicht Beschaffung"
           AND v01.beschaffung_relevant_fg = 1;