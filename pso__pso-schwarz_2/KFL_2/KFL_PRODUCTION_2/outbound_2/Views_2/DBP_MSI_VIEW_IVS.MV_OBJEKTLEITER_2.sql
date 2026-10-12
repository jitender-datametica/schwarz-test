CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ivs.mv_objektleiter_2 AS SELECT O.mandant_id,
 O.zustaendig_id AS mitarbeiter_id,
 MAX(kfl_production_dbp_process.transcriptc(Z.vorname)) AS vorname,
 MAX(kfl_production_dbp_process.transcriptc(Z.nachname)) AS nachname,
 MAX(Z.anrede) AS anrede
FROM kfl_production_dbp_view.v_ivs_objekt_zustaendig_zu_per_2 AS O
 INNER JOIN kfl_production_dbp_view.v_ivs_immo_zustaendig_2 AS Z ON O.zustaendig_id = Z.zustaendig_id AND O.mandant_id = Z
   .mandant_id
WHERE O.zustaendig_typ_id = 2
 AND O.dat_bis = DATE '9999-12-31'
GROUP BY O.mandant_id,
 mitarbeiter_id;