CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_f_markt_verbrauch_2 (mandant_id, wup_id, nb_id, art_id, dat
, gp_id, markt_verbrauch_menge, markt_verbrauch_ekn2, markt_verbrauch_ekn4) AS SELECT V01.mandant_id,
 V01.wup_id,
 V01.nb_id,
 V01.art_id,
 V01.dat,
 V01.gp_id,
 V01.menge AS markt_verbrauch_menge,
 ROUND(CAST(CASE
    WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0
    THEN V01.diff_umsatz_netto_konz * V04.kein_zekp_fg * V01.diff_ek_nettonetto_konz + V01.menge * (1 - V04.kein_zekp_fg) * V01.diff_ek_nettonetto_konz
    WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1
    THEN V01.umsatz_netto * V04.kein_zekp_fg * V01.ek_nettonetto + V01.menge * (1 - V04.kein_zekp_fg) * V01.ek_nettonetto * V01.umrechnungskurs_hist
    ELSE V01.umsatz_netto * V04.kein_zekp_fg * V01.ek_nettonetto + V01.menge * (1 - V04.kein_zekp_fg) * V01.ek_nettonetto
    END AS NUMERIC), 4) AS markt_verbrauch_ekn2,
 ROUND(CAST(CASE
    WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0
    THEN V01.diff_umsatz_netto_konz * V04.kein_zekp_fg * V01.diff_einstandspreis_konz + V01.menge * (1 - V04.kein_zekp_fg) * V01.diff_einstandspreis_konz
    WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1
    THEN (V01.umsatz_netto * V04.kein_zekp_fg * V01.einstandspreis + V01.menge * (1 - V04.kein_zekp_fg) * V01.einstandspreis) * V01.umrechnungskurs_hist
    ELSE V01.umsatz_netto * V04.kein_zekp_fg * V01.einstandspreis + V01.menge * (1 - V04.kein_zekp_fg) * V01.einstandspreis
    END AS NUMERIC), 4) AS markt_verbrauch_ekn4
FROM kfl_production_dbp_data.artbew_2 AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_2 AS V02 ON (V01.mandant_id <> 5 OR V01.art_id <> 206731500)
      AND (V01.mandant_id <> 2 OR V01.art_id <> 208124500) AND (V01.mandant_id <> 3 OR V01.art_id <> 208113690) AND (V01
       .mandant_id <> 6 OR V01.art_id <> 208131570) AND (V01.mandant_id NOT IN (4, 7) OR V01.art_id <> 208114740) AND (V01
     .mandant_id <> 8 OR V01.art_id <> 208131640)
 INNER JOIN kfl_production_dbp_data.art_wup_ek_zu_per_2 AS V04 ON V01.mandant_id = V04.mandant_id AND V01.art_id = V04.art_id
      AND V01.dat BETWEEN V04.dat_von AND V04.dat_bis AND V04.wup_id = - 1
WHERE V01.mandant_id <> 1;