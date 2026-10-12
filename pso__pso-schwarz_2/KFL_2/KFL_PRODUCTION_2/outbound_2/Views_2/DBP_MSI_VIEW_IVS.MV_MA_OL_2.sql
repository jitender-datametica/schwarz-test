CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ivs.mv_ma_ol_2 AS SELECT DISTINCT ZU.mandant_id,
 OZU.zustaendig_typ_id,
 ZU.zustaendig_id AS ol_ma_id,
 kfl_production_dbp_process.transcriptc(ZU.vorname) AS ol_vorname,
 kfl_production_dbp_process.transcriptc(ZU.nachname) AS ol_nachname,
 COALESCE(kfl_production_dbp_process.transcriptc(ZU.anrede), '') AS ol_anrede,
 TRIM(COALESCE(kfl_production_dbp_process.transcriptc(ZU.anrede), '') || ' ' || kfl_production_dbp_process.transcriptc(ZU.vorname) || ' ' ||
   kfl_production_dbp_process.transcriptc(ZU.nachname)) AS ol_name
FROM kfl_production_dbp_view.v_ivs_immo_zustaendig_2 AS ZU
 INNER JOIN kfl_production_dbp_view.v_ivs_objekt_zustaendig_zu_per_2 AS OZU ON ZU.zustaendig_id = OZU.zustaendig_id AND ZU
     .mandant_id = OZU.mandant_id AND OZU.zustaendig_typ_id = 2 AND OZU.dat_bis = DATE '9999-12-31'
WHERE ZU.zustaendig_id <> 0
UNION ALL
SELECT mandant_id,
 3 AS dm__operand1,
 0 AS dm__operand2,
 'ohne' AS dm__operand3,
 'Zuordnung' AS dm__operand4,
 '' AS dm__operand5,
 'ohne Zuordnung' AS dm__operand6
FROM kfl_production_dbp_view.v_mandant_2 AS MDT;