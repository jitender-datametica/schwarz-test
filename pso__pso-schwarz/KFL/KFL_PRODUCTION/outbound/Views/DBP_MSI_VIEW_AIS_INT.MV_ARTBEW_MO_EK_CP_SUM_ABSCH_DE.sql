CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_artbew_mo_ek_cp_sum_absch_de (mandant_id, art_id,
bewart_id, bewart_det_id, wup_id, nb_id, kjmo, wrg_id, posten_id_per, posten_kz_per, preis_abschrift_netto) AS SELECT
 mandant_id,
 art_id,
 bewart_id,
 bewart_det_id,
 wup_id,
 nb_id,
 kjmo,
 wrg_id,
 CAST(CASE
   WHEN bewart_id = 1001 AND posten_id NOT IN ('PN', 'PF', 'SP', '1')
   THEN 'SO'
   ELSE 'PN'
   END AS STRING) AS posten_id_per,
 SUBSTR(CASE
   WHEN posten_id NOT IN ('PN', 'PF', 'SP', '1')
   THEN 'SO'
   ELSE 'PN'
   END, 1, 2) AS posten_kz_per,
 preis_abschrift_netto
FROM kfl_production_dbp_view.v_artbew_mo_ek_cp_sum AS V01
WHERE wup_bereinigt_fg = 0
 AND mandant_id = 1;