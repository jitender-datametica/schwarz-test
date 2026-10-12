CREATE OR REPLACE VIEW DBP_MSI_VIEW_IVS.MV_KONZESSIONAER_UMSATZ as
         -- 2008-06-15
         -- FAKTTVIEW konzessionaer_umsatz (KJMO)
         -- Fremd-Umsaetze von externen Konzessionaeren (Ranking zur Ermittlung der vorhandenen Monats-Umsaetze)
         -- 2009KW07 abgrenzung ueber KER Buchungsschluss
         -- 2009KW17 EUR + LW über waehrungstyp
         -- 2009KW27 Historisierung Kurs, Optimierung
         --  2009KW47 Umstellung mv_zeit auf v_monat

         SELECT
         kumo.mandant_id,
         kumo.mietvertrag_id,
         kumo.immo_objekt_id,
         kumo.konzessionaer_id,
         kumo.kjmo,
         RANK() OVER (
        PARTITION BY kumo.mandant_id, kumo.konzessionaer_id, kumo.mietvertrag_id, kumo.immo_objekt_id, kurs.wrg_typ_id
        ORDER BY kumo.kjmo DESC NULLS LAST
        )::INTEGER  kjmo_lfd,
         kumo.betrag_umsatz * kurs  konz_umsatz,
         kurs.wrg_id,
         kurs.wrg_typ_id

        FROM dbp_view.v_ivs_konzessionaer_umsatz kumo
         INNER JOIN dbp_view.v_monat  zeit
         ON zeit.kjmo = kumo.kjmo
         INNER JOIN dbp_view.v_l_buchungsstatus_ker ker
         ON ker.kj_ker_mo_id = kumo.kjmo
         AND kumo.kjmo <= ker.buchungs_schluss_akt
         INNER JOIN dbp_msi_view_ivs.mv_mandant_wrg_kurs_zu_per  kurs
         ON kurs.mandant_id = kumo.mandant_id
         AND max_dat BETWEEN kurs_dat_von AND kurs_dat_bis

         WHERE kumo.betrag_umsatz BETWEEN 0.01 AND 999999999;