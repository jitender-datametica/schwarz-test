CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm_materialized.mv_art_wup_aktionslistung_dat (mandant_id, wup_id,
nb_id, art_id, dat, aktionslistung_fg) AS -- ausland
 -- de
 SELECT AWS.mandant_id,
 AWS.wup_id,
 AWS.nb_id,
 AWS.art_id,
 T.dat,
 COALESCE(al.aktionslistung_fg, 0) AS aktionslistung_fg
FROM kfl_production_dbp_view.v_art_list_wup_zu_per AS AWS
 INNER JOIN kfl_production_dbp_view.v_tag AS T ON T.dat BETWEEN AWS.dat_von AND AWS.dat_bis
 LEFT JOIN (SELECT A.mandant_id,
   AAW.wup_id,
   AAW.art_id,
   T0.dat,
   1 AS aktionslistung_fg
  FROM kfl_production_dbp_view.v_aktion_art_wup_zu AS AAW
   INNER JOIN kfl_production_dbp_view.v_aktion AS A ON AAW.aktion_id = A.aktion_id AND AAW.mandant_id = A.mandant_id
   INNER JOIN kfl_production_dbp_view.v_tag AS T0 ON T0.dat BETWEEN A.dat_von AND A.dat_bis
  WHERE A.mandant_id <> 1 AND AAW.dat_preisaktiviert <> DATE '1900-01-01' AND AAW.vk_aktion_brutto > 0
   OR A.mandant_id = 1 AND AAW.dat_sperrung IS NULL
  GROUP BY A.mandant_id,
   AAW.wup_id,
   AAW.art_id,
   T0.dat,
   aktionslistung_fg) AS al ON AWS.mandant_id = al.mandant_id AND AWS.wup_id = al.wup_id AND AWS.art_id = al.art_id AND
   T.dat = al.dat
WHERE AWS.nb_id = 0;