CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_ods_bon_kopf_2 (bon_id, bon_dat, wup_id, mandant_id, bon_nr,
kasse_nr, kassierer_nr, kunde_fg, bon_beginn, bon_ende, umsatz_brutto, umsatz_mwst, bon_booking, dat_booking,
turnover_fg, wrg_id, zeitstempel_druck, fiskalisierung_fg, bon_nr_fiscal, online_fg, dienstleister_id,
online_transaktion_id, geraet_id, online_bestellung_nr, bon_typ_id, bon_gedruckt_fg, bondruck_abgelehnt_fg) AS SELECT K
 .bon_id,
 K.bon_dat,
 WUP.aktuell_wup_id AS wup_id,
 K.mandant_id,
 K.bon_nr,
 K.kasse_nr,
 0 AS kassierer_nr,
 K.kunde_fg,
 K.bon_beginn,
 K.bon_ende,
  K.umsatz_brutto * krs.umrechnungskurs AS umsatz_brutto,
  K.umsatz_mwst * krs.umrechnungskurs AS umsatz_mwst,
 K.bon_booking,
 K.dat_booking,
 K.turnover_fg,
 krs.nach_wrg_id AS wrg_id,
 CAST('9999-12-31 23:59:59' AS DATETIME) AS zeitstempel_druck,
 K.fiskalisierung_fg,
 K.bon_nr_fiscal,
 K.online_fg,
 K.dienstleister_id,
 K.online_transaktion_id,
 K.geraet_id,
 K.online_bestellung_nr,
 K.bon_typ_id,
 K.bon_gedruckt_fg,
 K.bondruck_abgelehnt_fg
FROM kfl_production_dbp_v_ods.v_ods_bon_kopf_2 AS K
 INNER JOIN (SELECT von_wrg_id,
    nach_wrg_id,
    umrechnungskurs
   FROM kfl_production_dbp_data.kurs_2 AS KRS1
   WHERE kurstyp_id = 3
    AND dat_bis = DATE '9999-12-31'
    AND von_wrg_id NOT IN ('AUD', 'DEM', 'SIT')
   UNION ALL
   SELECT von_wrg_id,
    von_wrg_id AS von_wrg_id0,
    1.0000
   FROM kfl_production_dbp_data.kurs_2 AS KRS2
   WHERE kurstyp_id = 3
    AND dat_bis = DATE '9999-12-31'
    AND von_wrg_id NOT IN ('AUD', 'DEM', 'SIT', 'EUR')) AS krs ON K.wrg_id = krs.von_wrg_id
 INNER JOIN kfl_production_dbp_view.v_wup_2 AS WUP_2 ON K.mandant_id = WUP.mandant_id AND K.wup_id = WUP.wup_id
WHERE K.turnover_fg = 1;