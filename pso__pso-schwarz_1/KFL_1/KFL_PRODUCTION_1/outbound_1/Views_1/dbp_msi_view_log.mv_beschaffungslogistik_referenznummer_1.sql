CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_beschaffungslogistik_referenznummer_1 (belos_vorgang_id,
mandant_id, belos_vorgangart_id, referenznummer_id, belos_lieferschein_id) AS SELECT belos_vorgang_id,
 mandant_id,
 belos_vorgangart_id,
 STRING_AGG(DISTINCT CAST(referenznummer_id AS STRING), ';') AS referenznummer_id,
 STRING_AGG(DISTINCT belos_lieferschein_id, ';') AS belos_lieferschein_id
FROM (SELECT B_VOR.belos_vorgang_id,
    B_VOR.mandant_id,
    B_VOR.belos_vorgangart_id,
    ROUND(SAFE_CAST(B_VOR.belos_bestell_beleg_id_extern AS NUMERIC), 0) AS referenznummer_id,
    B_VOR.belos_lieferschein_id,
    BB.gp_id
   FROM kfl_production_dbp_view.v_belos_vorgang_1 AS B_VOR
    LEFT JOIN kfl_production_dbp_view.v_besch_best_1 AS BB ON ROUND(SAFE_CAST(B_VOR.belos_bestell_beleg_id_extern AS
        NUMERIC), 0) = BB.best_beleg_id AND B_VOR.mandant_id = BB.mandant_id
   WHERE B_VOR.belos_vorgangart_id = 'K-NA'
   UNION DISTINCT
   SELECT B_VOR.belos_vorgang_id,
    B_VOR.mandant_id,
    B_VOR.belos_vorgangart_id,
    BBB_VOR.best_beleg_id AS referenznummer_id,
    COALESCE(BES_B.ext_beleg_id, '-1') AS belos_lieferschein_id,
    BB.gp_id
   FROM kfl_production_dbp_view.v_belos_vorgang_1 AS B_VOR
    LEFT JOIN kfl_production_dbp_view.v_besch_best_belos_vorgang_zu_1 AS BBB_VOR ON B_VOR.belos_vorgang_id = BBB_VOR.belos_vorgang_id
       AND B_VOR.mandant_id = BBB_VOR.mandant_id
    LEFT JOIN kfl_production_dbp_view.v_besch_bestaetigung_1 AS BES_B ON BBB_VOR.best_beleg_id = BES_B.best_beleg_id AND
      BBB_VOR.mandant_id = BES_B.mandant_id
    LEFT JOIN kfl_production_dbp_view.v_besch_best_1 AS BB ON BBB_VOR.best_beleg_id = BB.best_beleg_id AND BBB_VOR.mandant_id
       = BB.mandant_id
   WHERE B_VOR.belos_vorgangart_id <> 'K-NA') AS t3
GROUP BY belos_vorgang_id,
 mandant_id,
 belos_vorgangart_id;