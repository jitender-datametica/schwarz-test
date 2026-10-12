CREATE OR REPLACE VIEW DBP_MSI_VIEW_IVS.MV_WUP_UMSATZENTWICKLUNG_1 as
               -- 2009-03-13
               -- FAKTVIEW denormalisiert (GJ)
               -- BASIS    wup_1 + kostenrechnung_1 + wup_per_1 + wupcal_1
               -- separate Spalten für EUR und LW
               -- (2008-05) KER-Zeit_1 = SAP Buchungsjahr
               -- (2008-07) KOMPLETT NEU ERSTELLT
               -- (2008-09) separate wup_kostenrechnung entfällt
               -- 2009KW07  Zeit_1 = KL Geschaeftsjahr
               -- 2014KW05 : Umsatz EA (Dummy_1)

               SELECT
               wup.mandant_id,
               mand.mandant_kbez,
               wup.wup_id,
               wup.wup_standort,
               wup.dat_eroeffnung,
               TO_NUMBER(NULL, 38, 10)  AS umsatz_ea_eur,
               TO_NUMBER(NULL, 38, 10)  AS umsatz_ea_land,
               CASE WHEN mand.default_wrg <> 'EUR' THEN mand.default_wrg END  AS wrg_bez,
               zeit.gj,
               kr.umsatz_eur,
               kr.umsatz_land,
               kr.umsatz_plan_eur,
               kr.umsatz_plan_land,
               kr.ergebnis_eur,
               kr.ergebnis_land,
               wc.anzahl_kunden,
               TRUNC( umsatz_eur / CASE WHEN anzahl_kunden = 0 THEN null ELSE anzahl_kunden END)       umsatz_durchschnitt_eur,
               TRUNC( umsatz_land / CASE WHEN anzahl_kunden = 0 THEN null ELSE anzahl_kunden END)      umsatz_durchschnitt_land,
               TRUNC( umsatz_eur / CASE WHEN wp.verkaufsflaeche = 0 THEN null ELSE wp.verkaufsflaeche END)  flaeche_produktivitaet_eur,
               TRUNC( umsatz_land / CASE WHEN wp.verkaufsflaeche = 0 THEN null ELSE wp.verkaufsflaeche END) flaeche_produktivitaet_land,
               TRUNC( (ergebnis_eur::NUMBER(38,5)) / CASE WHEN umsatz_eur::NUMBER(38,5) = 0 THEN null ELSE umsatz_eur::NUMBER(38,5) END) * 100.0 ergebnis_proz,
               wp.preiskategorie_food,
               wp.verkaufsflaeche,
               wp.verkaufs_ebene_bez AS verkaufsebenen,
               wp.parken_bez AS parken,
               wp.standort_typ_bez AS standorttyp,
               wp.lage_bez AS lage,
               wp.auflage_tip

              FROM dbp_view.v_wup_1  wup_1
               FULL OUTER JOIN
               (    -- letzte 5 GJ-Jahre + aktuelles pro Mandant_1
               SELECT DISTINCT mand0.mandant_id,
               zeit0.gj
              FROM dbp_view.v_monat_1  zeit0
               CROSS JOIN dbp_view.v_mandant_1  mand0
               WHERE  zeit0.akt_gj BETWEEN -5 AND 0
               ) zeit_1
               ON   wup.mandant_id = zeit.mandant_id
               LEFT OUTER JOIN dbp_view.v_mandant_1  mand
               ON   wup.mandant_id = mand.mandant_id
               LEFT OUTER JOIN
               ( -- Kostenrechnung_1 (Umsatz + Ergebnis) pro WUP_1 und GJ
               SELECT
               kr.mandant_id,
               pc.wup_id,
               zeit.gj,
               kr.wrg_id,
               SUM(CASE WHEN ka.report_pos = 'UMS' AND kr.plan_fg = 0 THEN kostenrechnung_betrag * umrechnungskurs END)::DECIMAL(18,2) umsatz_eur,
               SUM(CASE WHEN ka.report_pos = 'UMS' AND kr.plan_fg = 0 THEN kostenrechnung_betrag END)::DECIMAL(18,2) umsatz_land,
               SUM(CASE WHEN ka.report_pos = 'UMS' AND kr.plan_fg = 1 THEN kostenrechnung_betrag * umrechnungskurs END)::DECIMAL(18,2) umsatz_plan_eur,
               SUM(CASE WHEN ka.report_pos = 'UMS' AND kr.plan_fg = 1 THEN kostenrechnung_betrag END)::DECIMAL(18,2) umsatz_plan_land,
               SUM(CASE WHEN ka.report_pos = 'ERG' AND kr.plan_fg = 0 THEN kostenrechnung_betrag * umrechnungskurs END)::DECIMAL(18,2) ergebnis_eur,
               SUM(CASE WHEN ka.report_pos = 'ERG' AND kr.plan_fg = 0 THEN kostenrechnung_betrag END)::DECIMAL(18,2) ergebnis_land
               FROM dbp_view.v_kostenrechnung_1 kr

               JOIN dbp_view.v_profit_center_1  pc
               ON   pc.pc_id = kr.pc_id AND pc.mandant_id = kr.mandant_id

               JOIN dbp_view.v_monat_1  zeit_1
               ON    zeit.kjmo = (CASE WHEN MOD( kr.kj_ker_mo_id, 100) = 13 THEN kr.kj_ker_mo_id + 89 ELSE kr.kj_ker_mo_id END)

               JOIN dbp_view.v_kurs_1 k
               ON   kr.wrg_id = k.von_wrg_id
               AND  k.dat_bis = '9999-12-31' AND  k.kurstyp_id = 3

               JOIN
               (
               SELECT ka_lv11 kostenart_id,
               'UMS'::CHAR(3)  report_pos
               FROM dbp_msi_v_view.v_ka_ka_grp_denorm_1
               WHERE
               (TRIM(ka_lv1)  IN ('K0')) OR
               (TRIM(ka_lv2)  IN ('K0')) OR
               (TRIM(ka_lv3)  IN ('K0')) OR
               (TRIM(ka_lv4)  IN ('K0')) OR
               (TRIM(ka_lv5)  IN ('K0')) OR
               (TRIM(ka_lv6)  IN ('K0')) OR
               (TRIM(ka_lv7)  IN ('K0')) OR
               (TRIM(ka_lv8)  IN ('K0')) OR
               (TRIM(ka_lv9)  IN ('K0')) OR
               (TRIM(ka_lv10) IN ('K0')) OR
               (TRIM(ka_lv11) IN ('K0'))

               UNION ALL
               SELECT ka_lv11 kostenart_id,
               'ERG'::CHAR(3)  report_pos
               FROM dbp_msi_v_view.v_ka_ka_grp_denorm_1
               WHERE
               (TRIM(ka_lv1)  IN ('K1','K21','K22','K31','K32','K33','K41','K42','K43')) OR
               (TRIM(ka_lv2)  IN ('K1','K21','K22','K31','K32','K33','K41','K42','K43')) OR
               (TRIM(ka_lv3)  IN ('K1','K21','K22','K31','K32','K33','K41','K42','K43')) OR
               (TRIM(ka_lv4)  IN ('K1','K21','K22','K31','K32','K33','K41','K42','K43')) OR
               (TRIM(ka_lv5)  IN ('K1','K21','K22','K31','K32','K33','K41','K42','K43')) OR
               (TRIM(ka_lv6)  IN ('K1','K21','K22','K31','K32','K33','K41','K42','K43')) OR
               (TRIM(ka_lv7)  IN ('K1','K21','K22','K31','K32','K33','K41','K42','K43')) OR
               (TRIM(ka_lv8)  IN ('K1','K21','K22','K31','K32','K33','K41','K42','K43')) OR
               (TRIM(ka_lv9)  IN ('K1','K21','K22','K31','K32','K33','K41','K42','K43')) OR
               (TRIM(ka_lv10) IN ('K1','K21','K22','K31','K32','K33','K41','K42','K43')) OR
               (TRIM(ka_lv11) IN ('K1','K21','K22','K31','K32','K33','K41','K42','K43'))
               ) ka
               ON ka.kostenart_id = kr.kostenart_id

               WHERE zeit.akt_gj BETWEEN -5 AND 0
               AND   pc.nb_id=0

               GROUP BY
               kr.mandant_id
               , pc.wup_id
               , zeit.gj
               , kr.wrg_id
               ) kr
               ON   wup.mandant_id = kr.mandant_id AND wup.wup_id = kr.wup_id
               AND  zeit.gj = kr.gj
               LEFT OUTER JOIN
               ( -- WUP_PER_1 pro GJ
               SELECT
               wp0.mandant_id,
               wp0.wup_id,
               wp0.kjmo,
               zeit0.gj,
               wp0.preiskategorie_food,
               wp0.verkaufsflaeche,
               wp0.verkaufs_ebene_bez,
               wp0.parken_bez,
               wp0_s.standort_typ_bez,
               wp0_l.lage_bez,
               wp0.auflage_tip

              FROM dbp_view.v_wup_per_1 wp0

               JOIN
               ( -- letzter Jahreseintrag
               SELECT
               wp01.mandant_id,
               wp01.wup_id,
               zeit01.gj,
               MAX(wp01.kjmo) kjmo_max
              FROM dbp_view.v_wup_per_1 wp01

               JOIN dbp_view.v_monat_1  zeit01
               ON   zeit01.kjmo = wp01.kjmo

               WHERE zeit01.akt_gj BETWEEN -5 AND 0

               GROUP BY
               wp01.mandant_id
               , wp01.wup_id
               , zeit01.gj
               ) zeit0
               ON  zeit0.mandant_id = wp0.mandant_id AND zeit0.wup_id = wp0.wup_id
               AND zeit0.kjmo_max = wp0.kjmo
               LEFT OUTER JOIN dbp_view.v_l_standort_typ_1 wp0_s
               ON   wp0.standort_typ_id = wp0_s.standort_typ_id
               LEFT OUTER JOIN dbp_view.v_l_lage_1 wp0_l
               ON   wp0.lage_id = wp0_l.lage_id

               WHERE wp0.nb_id = 0 AND wp0.wrg_id = 'EUR'
               ) wp
               ON  wup.mandant_id = wp.mandant_id AND wup.wup_id = wp.wup_id
               AND zeit.gj = wp.gj
               LEFT OUTER JOIN
               ( -- WUPCAL_1 pro GJ
               SELECT
               wc0.mandant_id,
               wc0.wup_id,
               zeit0.gj,
               SUM(wc0.bonanzahl)  anzahl_kunden
              FROM dbp_view.v_wupcal_mo_sum_1 wc0

               JOIN dbp_view.v_monat_1  zeit0
               ON   zeit0.kjmo = wc0.kjmo

               WHERE wc0.nb_id=0
               AND   zeit0.akt_gj BETWEEN -5 AND 0

               GROUP BY
               wc0.mandant_id
               , wc0.wup_id
               , zeit0.gj
               )  wc
               ON  wup.mandant_id = wc.mandant_id AND wup.wup_id = wc.wup_id
               AND zeit.gj = wc.gj

               WHERE wup.nb_id = 0
               AND   wup.dat_eroeffnung < '2090-12-31';