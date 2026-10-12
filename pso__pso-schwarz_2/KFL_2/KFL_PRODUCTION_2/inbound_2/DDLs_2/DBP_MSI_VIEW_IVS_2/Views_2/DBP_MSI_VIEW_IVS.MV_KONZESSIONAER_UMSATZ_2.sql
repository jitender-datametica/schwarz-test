CREATE OR REPLACE VIEW DBP_MSI_VIEW_IVS.MV_KONZESSIONAER_UMSATZ_2 as
         -- 2008-06-15
         -- FAKTTVIEW konzessionaer_umsatz (KJMO)
         -- Fremd-Umsaetze von externen Konzessionaeren (Ranking zur Ermittlung der vorhandenen Monats-Umsaetze)
         -- 2009KW07 abgrenzung ueber KER Buchungsschluss
         -- 2009KW17 EUR + LW über waehrungstyp
         -- 2009KW27 Historisierung Kurs_2, Optimierung
         --  2009KW47 Umstellung mv_zeit_2 auf v_monat_2

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
         kumo.betrag_umsatz * kurs_2  konz_umsatz,
         kurs.wrg_id,
         kurs.wrg_typ_id

        FROM dbp_view.v_ivs_konzessionaer_umsatz_2 kumo
         INNER JOIN dbp_view.v_monat_2  zeit_2
         ON zeit.kjmo = kumo.kjmo
         INNER JOIN dbp_view.v_l_buchungsstatus_ker_2 ker
         ON ker.kj_ker_mo_id = kumo.kjmo
         AND kumo.kjmo <= ker.buchungs_schluss_akt
         INNER JOIN dbp_msi_view_ivs.mv_mandant_wrg_kurs_zu_per_2  kurs_2
         ON kurs.mandant_id = kumo.mandant_id
         AND max_dat BETWEEN kurs_dat_von AND kurs_dat_bis

         WHERE kumo.betrag_umsatz BETWEEN 0.01 AND 999999999;