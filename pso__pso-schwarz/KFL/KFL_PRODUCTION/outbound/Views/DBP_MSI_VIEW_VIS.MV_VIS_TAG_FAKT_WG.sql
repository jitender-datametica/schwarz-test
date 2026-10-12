CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_vis_tag_fakt_wg (mandant_id, nb_id, wup_id, wrg_id,
arthiertyp_id, abt_id, wg_id, dat, kjwo, kjmo, gj, ums_netto, ums_netto_kvj, ums_netto_kvvj, ums_netto_wvj,
ums_netto_wvvj, ums_netto_af OPTIONS(description='Umsatz Netto Aktionsfrei'), ums_netto_af_kvj
OPTIONS(description='Umsatz Netto Aktionsfrei zum VJ (Kalendertagsvergleich)'), ums_netto_af_kvvj
OPTIONS(description='Umsatz Netto Aktionsfrei zum VVJ (Kalendertagsvergleich)'), ums_netto_af_wvj
OPTIONS(description='Umsatz Netto Aktionsfrei zum VJ (Wochentagsvergleich)'), ums_netto_af_wvvj
OPTIONS(description='Umsatz Netto Aktionsfrei zum VVJ (Wochentagsvergleich)'), ums_netto_af_kvj_abw
OPTIONS(description='Abweichung Umsatz Netto Aktionsfrei zum VJ (Kalendertagsvergleich)'), ums_netto_af_kvvj_abw
OPTIONS(description='Abweichung Umsatz Netto Aktionsfrei zum VVJ (Kalendertagsvergleich)'), ums_netto_af_wvj_abw
OPTIONS(description='Abweichung Umsatz Netto Aktionsfrei zum VJ (Wochentagsvergleich)'), ums_netto_af_wvvj_abw
OPTIONS(description='Abweichung Umsatz Netto Aktionsfrei zum VVJ (Wochentagsvergleich)'), ums_netto_sa
OPTIONS(description='Umsatz Netto Sonderaktion'), ums_netto_sa_kvj
OPTIONS(description='Umsatz Netto Sonderaktion zum VJ (Kalendertagsvergleich)'), ums_netto_sa_kvvj
OPTIONS(description='Umsatz Netto Sonderaktion zum VVJ (Kalendertagsvergleich)'), ums_netto_sa_wvj
OPTIONS(description='Umsatz Netto Sonderaktion zum VJ (Wochentagsvergleich)'), ums_netto_sa_wvvj
OPTIONS(description='Umsatz Netto Sonderaktion zum VVJ (Wochentagsvergleich)'), ums_netto_sa_kvj_abw
OPTIONS(description='Abweichung Umsatz Netto Sonderaktion zum VJ (Kalendertagsvergleich)'), ums_netto_sa_kvvj_abw
OPTIONS(description='Abweichung Umsatz Netto Sonderaktion zum VVJ (Kalendertagsvergleich)'), ums_netto_sa_wvj_abw
OPTIONS(description='Abweichung Umsatz Netto Sonderaktion zum VJ (Wochentagsvergleich)'), ums_netto_sa_wvvj_abw
OPTIONS(description='Abweichung Umsatz Netto Sonderaktion zum VVJ (Wochentagsvergleich)'), ums_brutto, ums_brutto_kvj,
ums_brutto_kvvj, ums_brutto_wvj, ums_brutto_wvvj, menge, menge_kvj, menge_kvvj, menge_wvj, menge_wvvj, menge_af
OPTIONS(description='Menge abverkaufter Artikel Aktionsfrei'), menge_af_kvj
OPTIONS(description='Menge abverkaufter Artikel Aktionsfrei zum VJ (Kalendertagsvergleich)'), menge_af_kvvj
OPTIONS(description='Menge abverkaufter Artikel Aktionsfrei zum VVJ (Kalendertagsvergleich)'), menge_af_wvj
OPTIONS(description='Menge abverkaufter Artikel Aktionsfrei zum VJ (Wochentagsvergleich)'), menge_af_wvvj
OPTIONS(description='Menge abverkaufter Artikel Aktionsfrei zum VVJ (Wochentagsvergleich)'), menge_af_kvj_abw
OPTIONS(description='Abweichung Menge abverkaufter Artikel Aktionsfrei zum VJ (Kalendertagsvergleich)'),
menge_af_kvvj_abw
OPTIONS(description='Abweichung Menge abverkaufter Artikel Aktionsfrei zum VVJ (Kalendertagsvergleich)'),
menge_af_wvj_abw OPTIONS(description='Abweichung Menge abverkaufter Artikel Aktionsfrei zum VJ (Wochentagsvergleich)'),
menge_af_wvvj_abw OPTIONS(description='Abweichung Menge abverkaufter Artikel Aktionsfrei zum VVJ (Wochentagsvergleich)'),
menge_sa OPTIONS(description='Menge abverkaufter Artikel Sonderaktion'), menge_sa_kvj
OPTIONS(description='Menge abverkaufter Artikel Sonderaktion zum VJ (Kalendertagsvergleich)'), menge_sa_kvvj
OPTIONS(description='Menge abverkaufter Artikel Sonderaktion zum VVJ (Kalendertagsvergleich)'), menge_sa_wvj
OPTIONS(description='Menge abverkaufter Artikel Sonderaktion zum VJ (Wochentagsvergleich)'), menge_sa_wvvj
OPTIONS(description='Menge abverkaufter Artikel Sonderaktion zum VVJ (Wochentagsvergleich)'), menge_sa_kvj_abw
OPTIONS(description='Abweichung Menge abverkaufter Artikel Sonderaktion zum VJ (Kalendertagsvergleich)'),
menge_sa_kvvj_abw
OPTIONS(description='Abweichung Menge abverkaufter Artikel Sonderaktion zum VVJ (Kalendertagsvergleich)'),
menge_sa_wvj_abw OPTIONS(description='Abweichung Menge abverkaufter Artikel Sonderaktion zum VJ (Wochentagsvergleich)'),
menge_sa_wvvj_abw
OPTIONS(description='Abweichung Menge abverkaufter Artikel Sonderaktion zum VVJ (Wochentagsvergleich)'))
OPTIONS(DESCRIPTION = `VIS - AGGREGAT AUF TAGESEBENE: UMSATZ(NETTO) PRO TAG - MARKT/ABTEILUNG/WARENGRUPPE`) AS SELECT
 VIS.mandant_id,
 VIS.nb_id,
 WUP.aktuell_wup_id AS wup_id,
 VIS.wrg_id,
 VIS.arthiertyp_id,
 VIS.abt_id,
 VIS.wg_id,
 VIS.dat,
 VIS.kjwo,
 VIS.kjmo,
 VIS.gj,
 VIS.ums_netto,
 VIS.ums_netto_kvj,
 VIS.ums_netto_kvvj,
 VIS.ums_netto_wvj,
 VIS.ums_netto_wvvj,
 VIS.ums_netto_af,
 VIS.ums_netto_af_kvj,
 VIS.ums_netto_af_kvvj,
 VIS.ums_netto_af_wvj,
 VIS.ums_netto_af_wvvj,
 IFNULL(VIS.ums_netto_af - VIS.ums_netto_af_kvj, 0) AS ums_netto_af_kvj_abw,
 IFNULL(VIS.ums_netto_af - VIS.ums_netto_af_kvvj, 0) AS ums_netto_af_kvvj_abw,
 IFNULL(VIS.ums_netto_af - VIS.ums_netto_af_wvj, 0) AS ums_netto_af_wvj_abw,
 IFNULL(VIS.ums_netto_af - VIS.ums_netto_af_wvvj, 0) AS ums_netto_af_wvvj_abw,
 VIS.ums_netto_sa,
 VIS.ums_netto_sa_kvj,
 VIS.ums_netto_sa_kvvj,
 VIS.ums_netto_sa_wvj,
 VIS.ums_netto_sa_wvvj,
 IFNULL(VIS.ums_netto_sa - VIS.ums_netto_sa_kvj, 0) AS ums_netto_sa_kvj_abw,
 IFNULL(VIS.ums_netto_sa - VIS.ums_netto_sa_kvvj, 0) AS ums_netto_sa_kvvj_abw,
 IFNULL(VIS.ums_netto_sa - VIS.ums_netto_sa_wvj, 0) AS ums_netto_sa_wvj_abw,
 IFNULL(VIS.ums_netto_sa - VIS.ums_netto_sa_wvvj, 0) AS ums_netto_sa_wvvj_abw,
 VIS.ums_brutto,
 VIS.ums_brutto_kvj,
 VIS_KVVJ.ums_brutto AS ums_brutto_kvvj,
 VIS.ums_brutto_wvj,
 VIS_WVVJ.ums_brutto AS ums_brutto_wvvj,
 VIS.menge_absatz AS menge,
 VIS.menge_absatz_kvj AS menge_kvj,
 VIS_KVVJ.menge_absatz AS menge_kvvj,
 VIS.menge_absatz_wvj AS menge_wvj,
 VIS_WVVJ.menge_absatz AS menge_wvvj,
 VIS.menge_absatz_af AS menge_af,
 VIS.menge_absatz_af_kvj AS menge_af_kvj,
 VIS_KVVJ.menge_absatz_af AS menge_af_kvvj,
 VIS.menge_absatz_af_wvj AS menge_af_wvj,
 VIS_WVVJ.menge_absatz_af AS menge_af_wvvj,
 IFNULL(VIS.menge_absatz_af - VIS.menge_absatz_af_kvj, 0) AS menge_af_kvj_abw,
 IFNULL(VIS.menge_absatz_af - VIS_KVVJ.menge_absatz_af, 0) AS menge_af_kvvj_abw,
 IFNULL(VIS.menge_absatz_af - VIS.menge_absatz_af_wvj, 0) AS menge_af_wvj_abw,
 IFNULL(VIS.menge_absatz_af - VIS_WVVJ.menge_absatz_af, 0) AS menge_af_wvvj_abw,
 VIS.menge_absatz_sa AS menge_sa,
 VIS.menge_absatz_sa_kvj AS menge_sa_kvj,
 VIS_KVVJ.menge_absatz_sa AS menge_sa_kvvj,
 VIS.menge_absatz_sa_wvj AS menge_sa_wvj,
 VIS_WVVJ.menge_absatz_sa AS menge_sa_wvvj,
 IFNULL(VIS.menge_absatz_sa - VIS.menge_absatz_sa_kvj, 0) AS menge_sa_kvj_abw,
 IFNULL(VIS.menge_absatz_sa - VIS_KVVJ.menge_absatz_sa, 0) AS menge_sa_kvvj_abw,
 IFNULL(VIS.menge_absatz_sa - VIS.menge_absatz_sa_wvj, 0) AS menge_sa_wvj_abw,
 IFNULL(VIS.menge_absatz_sa - VIS_WVVJ.menge_absatz_sa, 0) AS menge_sa_wvvj_abw
FROM kfl_production_dbp_msi_v_view.v_vis_tag_umsatz_wg AS VIS
 INNER JOIN kfl_production_dbp_view.v_wup AS WUP ON VIS.mandant_id = WUP.mandant_id AND VIS.wup_id = WUP.wup_id
 LEFT JOIN kfl_production_dbp_msi_v_view.v_vis_tag_umsatz_wg AS VIS_WVVJ ON VIS.mandant_id = VIS_WVVJ.mandant_id AND VIS
      .wup_id = VIS_WVVJ.wup_id AND VIS.wrg_id = VIS_WVVJ.wrg_id AND VIS.wg_id = VIS_WVVJ.wg_id AND VIS_WVVJ.dat =
   DATE_SUB(VIS.dat, INTERVAL 728 DAY)
 LEFT JOIN kfl_production_dbp_msi_v_view.v_vis_tag_umsatz_wg AS VIS_KVVJ ON VIS.mandant_id = VIS_KVVJ.mandant_id AND VIS
      .wup_id = VIS_KVVJ.wup_id AND VIS.wrg_id = VIS_KVVJ.wrg_id AND VIS.wg_id = VIS_KVVJ.wg_id AND VIS_KVVJ.dat = IF(VIS
     .dat = LAST_DAY(VIS.dat), LAST_DAY(DATE_ADD(VIS.dat, INTERVAL - 24 MONTH)), DATE_ADD(VIS.dat, INTERVAL - 24 MONTH)
    );