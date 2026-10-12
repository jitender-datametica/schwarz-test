CREATE OR REPLACE VIEW DBP_MSI_VIEW_IVS.MV_KONZESSIONAER_PRODUKTIV_2 AS
                     -- 2008-04-08
                     -- FAKTTVIEW denormalisiert (Produktivitaetsbericht)
                     -- BASIS konzessionaer_umsatz + flaeche_kjmo + wupcal_monat
                     -- zeitabhaengige Kennzahlen auf Basis von max. 12 Monatswerten/Hochrechnung
                     -- 2009KW17 Review; EUR + LW über waehrungstyp
                     -- 2009KW27 Historisierung Kurs_2, Optimierung
                     -- 2009KW47 Umstellung mv_zeit_2 auf v_monat_2
                     -- 2011KW40 Umlenken aller Joins auf ivs_immo_objekt_per_2 WENN Wup_2-Nachbildung DANN (immo_objekt_bez = wup_id) SONST (immo_objekt_id = immo_objekt_id)
                     -- 2011KW46 Zugriff auf Immoobjekt mit Mandant_2 und Gültigkeit
                     -- 2013KW04 Anpassung Logik ( miete_betrag )

                     SELECT
                     kmvk.mandant_id,
                     kmvk.mietvertrag_id,
                     kmvk.immo_objekt_id,
                     kmvk.konzessionaer_id,
                     MIN(kjmo)       AS kjmo_min,
                     MAX(kjmo)       AS kjmo_max,
                     COUNT(kjmo_lfd) AS kjmo_anzahl,
                     MAX(flaeche_groesse)                                      AS konz_flaeche_groesse -- Flaeche
                     ,
                     ZEROIFNULL(SUM(anzahl_kunden))                            AS konz_anzahl_kunden   -- Kunden (Jahr)
                     ,
                     SUM(miete_betrag * kurs_2)                                  AS konz_grundmiete      -- Grundmiete (Jahr)
                     ,
                     SUM(konz_umsatz * kurs_2)                                   AS konz_umsatz_agg      -- Summe aufgel.
                     ,
                     AVG(konz_umsatz * kurs_2)                                   AS konz_umsatz_monat    -- Durchschnitt (Monat_2)
                     ,
                     AVG(konz_umsatz * kurs_2) * 12                              AS konz_umsatz_jahr     -- Jahreswert hochgerechnet
                     ,
                     TRUNC( konz_grundmiete/NULLIF(konz_umsatz_agg, 0))                AS konz_miete_proz,
                     TRUNC( konz_umsatz_jahr/NULLIF(konz_flaeche_groesse, 0))          AS konz_produktivitaet,
                     ZEROIFNULL(TRUNC(konz_umsatz_agg/NULLIF(konz_anzahl_kunden, 0))) AS konz_umsatz_kunde,
                     kurs.wrg_id,
                     kurs.wrg_typ_id
                    FROM ( -- Mapping Konzessionaer Umsatz - Mietvertrag/Fläche - Kunden
                    SELECT
                    kum.mandant_id,
                     kum.mietvertrag_id,
                     kum.immo_objekt_id,
                     kum.konzessionaer_id,
                     kum.kjmo,
                     kum.kjmo_lfd,
                     zeit.max_dat,
                     SUM(mvf.miete_betrag)                AS miete_betrag,
                     SUM(fl.flaeche_groesse)              AS flaeche_groesse,
                     COUNT(fl.flaeche_id)                 AS flaeche_anzahl,
                     TRUNC( SUM(wc.anzahl_kunden)/flaeche_anzahl) AS anzahl_kunden,
                     TRUNC( SUM(kum.konz_umsatz)/flaeche_anzahl)  AS konz_umsatz
                     FROM dbp_view.v_monat_2  zeit_2
                     INNER JOIN ( -- Konzessionaer Umsatz pro Mietvertrag mit Ranking
                     SELECT
                     kum0.mandant_id,
                     kum0.mietvertrag_id,
                     kum0.immo_objekt_id,
                     kum0.konzessionaer_id,
                     kum0.kjmo,
                     kum0.kjmo_lfd,
                     kum0.konz_umsatz
                    FROM ( -- Ermittlung der letzten 12 Konz-Umsaetze
                    SELECT
                    kum00.mandant_id,
                     kum00.mietvertrag_id,
                     kum00.immo_objekt_id,
                     kum00.konzessionaer_id,
                     kum00.kjmo,
                     RANK() OVER (PARTITION BY kum00.mandant_id, kum00.konzessionaer_id, kum00.mietvertrag_id, kum00.immo_objekt_id ORDER BY kum00.kjmo DESC NULLS LAST)::INTEGER kjmo_lfd,
                     kum00.betrag_umsatz AS konz_umsatz
                   FROM dbp_view.v_ivs_konzessionaer_umsatz_2 kum00
                     INNER JOIN dbp_view.v_l_buchungsstatus_ker_2 ker
                     ON ker.kj_ker_mo_id = kum00.kjmo
                     AND kum00.kjmo <= ker.buchungs_schluss_akt

                     WHERE kum00.betrag_umsatz BETWEEN 0.01 AND 999999999 -- nur vorhandene Betraege
                     ) kum0
                     WHERE kum0.kjmo_lfd BETWEEN 1 AND 12
                     ) kum
                     ON kum.kjmo = zeit.kjmo
                     LEFT JOIN ( -- Mietvertrags-Daten
                     SELECT
                     mv00.mandant_id,
                     mv00.mietvertrag_id,
                     mv00.konzessionaer_id,
                     mv00.dat_vertrag_beginn,
                     mv00.dat_vertrag_ende,
                     mv00.dat_bis,
                     mv00.dat_von
                    FROM dbp_view.v_ivs_mietvertrag_per_2 mv00
                     ) mv
                     ON mv.mandant_id = kum.mandant_id AND mv.mietvertrag_id = kum.mietvertrag_id
                     AND mv.konzessionaer_id = kum.konzessionaer_id
                     AND max_dat BETWEEN mv.dat_von AND mv.dat_bis
                     AND max_dat BETWEEN mv.dat_vertrag_beginn AND dat_vertrag_ende
                     INNER JOIN ( -- Mietvertrags-Flaechen-Daten
                     SELECT
                     mandant_id,
                     mietvertrag_id,
                     flaeche_id,
                     immo_objekt_id,
                     NULLIF(dat_flaeche_uebergabe, '1900-01-01') AS dat_flaeche_uebergabe,
                     dat_flaeche_rueckgabe,
                     miete_betrag,
                     dat_von,
                     dat_bis
                    FROM dbp_view.v_ivs_mietvertrag_fl_zu_per_2
                    WHERE miete_betrag BETWEEN 0.01 AND 999999999 -- nur vorhandene Betraege
                    ) mvf
                     ON  mvf.mandant_id = mv.mandant_id
                     AND mvf.mietvertrag_id = mv.mietvertrag_id
                     AND mvf.immo_objekt_id = kum.immo_objekt_id
                     AND max_dat BETWEEN mvf.dat_von AND mvf.dat_bis
                     AND max_dat BETWEEN mvf.dat_flaeche_uebergabe AND dat_flaeche_rueckgabe
                     INNER JOIN ( -- Immo-Objekt-Daten
                     SELECT
                     mandant_id,
                     immo_objekt_id,
                     immo_objekt_bez -- Mapping auf wup_id
                     ,
                     dat_von,
                     dat_bis
                    FROM dbp_view.v_ivs_immo_objekt_per_2 iop
                     ) iop
                     ON mvf.mandant_id = iop.mandant_id
                     AND mvf.immo_objekt_id = iop.immo_objekt_id
                     AND max_dat BETWEEN iop.dat_von AND iop.dat_bis
                     INNER JOIN ( -- Flaechen-Daten
                     SELECT
                     fl0.mandant_id,
                     fl0.immo_objekt_id,
                     fl0.flaeche_id,
                     fl0.dat_existiert_seit,
                     fl0.dat_existiert_bis,
                     fl0.flaeche_groesse,
                     fl0.dat_von,
                     fl0.dat_bis
                    FROM dbp_view.v_ivs_flaeche_per_2 fl0
                     )  fl
                     ON  fl.mandant_id = mvf.mandant_id
                     AND fl.flaeche_id = mvf.flaeche_id
                     AND fl.immo_objekt_id = kum.immo_objekt_id
                     AND max_dat BETWEEN fl.dat_von AND fl.dat_bis
                     AND max_dat BETWEEN fl.dat_existiert_seit AND fl.dat_existiert_bis
                     LEFT JOIN ( -- Anzahl Kunden pro Immo-Objekt
                     SELECT
                     wc0.mandant_id,
                     wc0.wup_id,
                     wc0.kjmo,
                     wc0.anzahl_oeff_tage,
                     wc0.bonanzahl AS anzahl_kunden
                    FROM dbp_view.v_wupcal_mo_sum_2  wc0

                     WHERE wc0.nb_id = 0
                     ) wc
                     ON wc.mandant_id = kum.mandant_id
                     AND wc.wup_id = iop.immo_objekt_bez
                     AND wc.kjmo = kum.kjmo

                     GROUP BY
                     kum.mandant_id
                     ,kum.mietvertrag_id
                     ,kum.immo_objekt_id
                     ,kum.konzessionaer_id
                     ,kum.kjmo
                     ,kum.kjmo_lfd
                     ,max_dat
                     ) kmvk
                     INNER JOIN dbp_msi_view_ivs.mv_mandant_wrg_kurs_zu_per_2  kurs_2
                     ON kurs.mandant_id = kmvk.mandant_id
                     AND max_dat BETWEEN kurs_dat_von AND kurs_dat_bis

                     GROUP BY
                     kmvk.mandant_id
                     , kmvk.mietvertrag_id
                     , kmvk.immo_objekt_id
                     , kmvk.konzessionaer_id
                     , kurs.wrg_id
                     , kurs.wrg_typ_id
;