CREATE OR REPLACE VIEW DBP_MSI_VIEW_IVS.MV_WUP_KOSTENRECHNUNG as
                                      -- 2009-03-24
                                      -- FAKTVIEW denormalisiert, aggregiert (Ausschnitt aus KER)
                                      -- KL Geschaeftsjahr + Mapping 13.Periode KER auf Februar
                                      -- Mapping  immo_objekt - wup - profit_center
                                      -- 2009KW17 EUR + LW über waehrungstyp
                                      -- 2010KW33 Umlenken aller Joins auf ivs_immo_objekt_per WENN Wup-Nachbildung DANN (immo_objekt_bez = wup_id) SONST (immo_objekt_id = immo_objekt_id)


                                      SELECT
                                      io.mandant_id,
                                      io.immo_objekt_id,
                                      ker.pc_id,
                                      ker.wup_id,
                                      ker.gj,
                                      ker.kjmo,
                                      ker.umsatz_ist,
                                      ker.umsatz_plan,
                                      ker.wrg_id,
                                      ker.wrg_typ_id
       FROM dbp_view.v_ivs_immo_objekt_per io
                                      LEFT JOIN
                                      (
                                      SELECT
                                      kr.mandant_id,
                                      kr.pc_id,
                                      pc.wup_id,
                                      wup_id AS kerwup_id,
                                      zeit.gj,
                                      zeit.kjmo,
                                      mwt.wrg_id,
                                      mwt.wrg_typ_id,
                                      SUM(CASE WHEN kr.plan_fg = 0 AND ka.report_pos='UMS'
       THEN CASE WHEN mwt.wrg_typ_id = 0 THEN kostenrechnung_betrag * umrechnungskurs
       WHEN mwt.wrg_typ_id = 1 THEN kostenrechnung_betrag END
       END) umsatz_ist,
                                      SUM(CASE WHEN kr.plan_fg = 1 AND ka.report_pos='UMS'
       THEN CASE WHEN mwt.wrg_typ_id = 0 THEN kostenrechnung_betrag * umrechnungskurs
       WHEN mwt.wrg_typ_id = 1 THEN kostenrechnung_betrag END
       END) umsatz_plan


       FROM dbp_view.v_kostenrechnung kr

                                      JOIN dbp_view.v_profit_center  pc
                                      ON   kr.pc_id = pc.pc_id AND kr.mandant_id = pc.mandant_id
                                      LEFT JOIN dbp_view.v_monat  zeit
                                      ON   zeit.kjmo = (CASE WHEN MOD( kj_ker_mo_id, 100) = 13 THEN kj_ker_mo_id + 89 ELSE kj_ker_mo_id END)

                                      JOIN (
                                      SELECT ka_lv11 kostenart_id,
                                      'UMS'::CHAR(3)  report_pos
                                      FROM dbp_msi_v_view.v_ka_ka_grp_denorm
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
                                      ) ka
                                      ON   kr.kostenart_id = ka.kostenart_id
                                      INNER JOIN dbp_view.v_mandant_wrg_typ_zu  mwt
                                      ON    mwt.mandant_id = kr.mandant_id
                                      INNER JOIN dbp_view.v_kurs  k
                                      ON    k.von_wrg_id = kr.wrg_id
                                      AND   k.kurstyp_id=3
                                      AND   k.dat_bis = '9999-12-31'

                                      GROUP BY
                                      kr.mandant_id
                                      , kr.pc_id
                                      , pc.wup_id
                                      , zeit.gj
                                      , zeit.kjmo
                                      , mwt.wrg_id
                                      , mwt.wrg_typ_id
                                      ) ker
                                      ON  ker.kerwup_id = io.immo_objekt_bez
                                      AND ker.mandant_id = io.mandant_id

                                      WHERE io.dat_bis='9999-12-31';