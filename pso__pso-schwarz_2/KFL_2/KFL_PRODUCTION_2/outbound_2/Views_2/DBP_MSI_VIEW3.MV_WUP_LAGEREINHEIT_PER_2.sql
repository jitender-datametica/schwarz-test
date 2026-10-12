CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_wup_lagereinheit_per_2 AS SELECT T01.lagereinheit_id,
 T01.mandant_id,
 T02.dat_zeit,
 T01.lagernummer_id,
 T01.lagertyp_id,
 T01.wup_id,
 T01.nb_id,
 T01.dat_letzte_bewegung,
 T01.spurnummer,
 T01.lager_einheiten_typ,
 COALESCE(T03.bsf_virtuell_fg, 0) AS bsf_virtuell_id
FROM kfl_production_dbp_view.v_wup_lagereinheit_per_2 AS T01
 INNER JOIN kfl_production_dbp_msi_view3.mv_tag_stunde_2 AS T02 ON T01.datzeit_von <= T02.dat_zeit AND T01.datzeit_bis >
   T02.dat_zeit
 LEFT JOIN kfl_production_dbp_view.v_wup_lagernummer_bsflaeche_virtuell_per_2 AS T03 ON T01.mandant_id = T03.mandant_id
     AND T01.wup_id = T03.wup_id AND T01.lagernummer_id = T03.lagernummer_id AND T01.spurnummer = T03.bsflaeche_id AND
   T02.dat BETWEEN T03.dat_von AND T03.dat_bis
WHERE CAST(T02.dat_zeit AS DATE) <= CURRENT_DATE;