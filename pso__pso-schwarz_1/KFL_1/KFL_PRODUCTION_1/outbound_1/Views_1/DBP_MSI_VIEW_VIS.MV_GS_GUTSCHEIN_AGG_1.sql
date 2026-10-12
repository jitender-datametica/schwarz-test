CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_gs_gutschein_agg_1 AS SELECT MV01.mandant_id,
 MV01.dat,
 MV01.transaktion_id,
 MV01.ausgeber_id,
 MV01.ausgeber_typ_id,
 MV01.wrg_id,
 CAST(SUM(1) AS BIGNUMERIC) AS gutschein_anzahl_agg,
 SUM(MV01.gutschein_betrag) AS gutschein_betrag_agg,
 MV01.wup_id,
 MV01.nb_id,
 MV01.buchungskreis_id,
 MV01.gs_kostenstelle_id,
 MV01.gs_kostenstelle_bez,
 V02.betrag_von
FROM kfl_production_dbp_msi_view_vis.mv_gs_gutschein_1 AS MV01
 INNER JOIN kfl_production_dbp_view.v_l_gs_betrag_1 AS V02 ON MV01.mandant_id = V02.mandant_id AND MV01.ausgeber_typ_id =
     V02.ausgeber_typ_id AND MV01.gutschein_betrag BETWEEN V02.betrag_von AND V02.betrag_bis AND MV01.wrg_id = V02.wrg_id
   
WHERE MV01.transaktion_id IN (4, 6, 7)
GROUP BY MV01.mandant_id,
 MV01.transaktion_id,
 MV01.ausgeber_id,
 MV01.ausgeber_typ_id,
 MV01.dat,
 MV01.wrg_id,
 MV01.wup_id,
 MV01.nb_id,
 MV01.buchungskreis_id,
 MV01.gs_kostenstelle_id,
 MV01.gs_kostenstelle_bez,
 V02.betrag_von;