CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_umschlagshaeufigkeit_je_le_typ (transportart_id, lagereinheit_id
, mandant_id, wup_id, nb_id, art_id, lager_einheiten_typ, letzter_lagerplatz_id, letzter_lagernummer_id,
letzter_lagertyp_id, dat_quittierung, dat_quittierung_vorgaenger, anz_tage) AS SELECT T02.transportart_id,
 COALESCE(T01.lager_einheit_id_nach, T01.lager_einheit_id_von) AS lagereinheit_id,
 T01.mandant_id,
 T01.wup_id,
 T01.nb_id,
 T01.art_id,
 T01.lager_einheiten_typ,
 t03.lagerplatz_id AS letzter_lagerplatz_id,
 t03.lagernummer_id AS letzter_lagernummer_id,
 t03.lagertyp_id AS letzter_lagertyp_id,
 T01.dat_quittierung,
 COALESCE(MAX(T01.dat_quittierung) OVER (PARTITION BY CAST(T01.mandant_id AS STRING), CAST(T01.wup_id AS STRING),
     COALESCE(T01.lager_einheit_id_nach, T01.lager_einheit_id_von) ORDER BY T01.art_id IS NULL, T01.art_id, T01.dat_quittierung
     IS NULL, T01.dat_quittierung, T01.transport_beleg_id IS NULL, T01.transport_beleg_id, T01.transport_beleg_pos_id
     IS NULL, T01.transport_beleg_pos_id ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING), T01.dat_quittierung) AS
 dat_quittierung_vorgaenger,
 DATE_DIFF(T01.dat_quittierung, COALESCE(MAX(T01.dat_quittierung) OVER (PARTITION BY CAST(T01.mandant_id AS STRING), CAST(T01.wup_id AS STRING)
      , COALESCE(T01.lager_einheit_id_nach, T01.lager_einheit_id_von) ORDER BY T01.art_id IS NULL, T01.art_id, T01.dat_quittierung
      IS NULL, T01.dat_quittierung, T01.transport_beleg_id IS NULL, T01.transport_beleg_id, T01.transport_beleg_pos_id
      IS NULL, T01.transport_beleg_pos_id ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING), T01.dat_quittierung), DAY) AS
 anz_tage
FROM kfl_production_dbp_msi_view3.mv_transportauftrag_det AS T01
 INNER JOIN kfl_production_dbp_view.v_tag AS T ON T01.dat_quittierung = T.dat AND T.akt_kj >= - 2
 INNER JOIN kfl_production_dbp_msi_view3.mv_transportauftrag AS T02 ON T01.dat_quittierung = T02.dat_quittierung AND T01
       .lagernummer_id = T02.lagernummer_id AND T01.mandant_id = T02.mandant_id AND T01.nb_id = T02.nb_id AND T01.transport_beleg_id
     = T02.transport_beleg_id AND T01.wup_id = T02.wup_id
 INNER JOIN (SELECT art_id,
   mandant_id,
   system_id,
   wup_id,
   nb_id,
   lagerplatz_id,
   lagernummer_id,
   lagertyp_id
  FROM kfl_production_dbp_msi_view3.mv_art_lagerplatz_tag AS S01
  WHERE mlgt_fg = 1
  QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(art_id AS STRING), CAST(mandant_id AS STRING), CAST(system_id AS STRING)
        , CAST(wup_id AS STRING), CAST(nb_id AS STRING) ORDER BY dat IS NULL, dat)) = 1) AS t03 ON T01.art_id = t03.art_id
      AND T01.mandant_id = t03.mandant_id AND T01.wup_id = t03.wup_id AND T01.nb_id = t03.nb_id
WHERE T01.von_lagertyp_id IN ('BF1', 'ÜN1', 'K01', 'K02') AND T01.nach_lagertyp_id IN ('R03', 'R13')
 OR T01.von_lagertyp_id IN ('R03', 'R13') AND (T01.nach_lagertyp_id IN ('916', '999') OR SUBSTR(T01.nach_lagertyp_id, 1
       , 1) = 'G' OR SUBSTR(T01.nach_lagertyp_id, 1, 1) = 'B');