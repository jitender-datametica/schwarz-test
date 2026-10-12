CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_f_flw_belos_vorgang_2 (mandant_id, in_kunde_id, werk_id,
belos_vorgang_id, rundlauf_transport_fg, tour_id, vol_stauraum, wup_id, belos_adresse_absender_num_id, verrechfall_id,
betrag_kosten) AS SELECT V01.mandant_id,
 V04.in_kunde_id,
 V05.werk_id,
 V01.belos_vorgang_id,
 V01.rundlauf_transport_fg,
 V01.tour_id,
 V01.vol_stauraum,
 V01.wup_id,
 V01.belos_adresse_absender_num_id,
 V03.verrechfall_id,
 V03.betrag_kosten
FROM kfl_production_dbp_view.v_belos_vorgang_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_verrechfall_2 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.belos_vorgang_id =
   V02.belos_vorgang_id
 INNER JOIN kfl_production_dbp_view.v_verrechfall_kosten_2 AS V03 ON V02.mandant_id = V03.mandant_id AND V02.verrechfall_id
    = V03.verrechfall_id
 INNER JOIN kfl_production_dbp_msi_view_flw.mv_l_in_kunde_2 AS V04 ON V01.belos_adresse_empfaenger_id = V04.kunde_nr AND
   V01.mandant_id = V04.mandant_id
 INNER JOIN kfl_production_dbp_msi_view_flw.mv_l_in_werk_2 AS V05 ON CAST(V05.werk_nr AS FLOAT64) = V01.belos_adresse_absender_num_id
    AND V01.mandant_id = V05.mandant_id;