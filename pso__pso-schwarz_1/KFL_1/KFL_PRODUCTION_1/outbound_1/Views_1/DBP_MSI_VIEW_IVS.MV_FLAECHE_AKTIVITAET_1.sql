CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ivs.mv_flaeche_aktivitaet_1 AS SELECT sub01.mandant_id,
 sub01.flaeche_id,
 sub01.aktivitaet_ergebnis,
 COALESCE(SUB02.aktivitaet_status, 0) AS aktivitaet_status,
 COALESCE(SUB02.dat_aktivitaet, DATE '1900-01-01') AS dat_aktivitaet,
 COALESCE(SUB02.aktivitaet_typ_id, 17) AS aktivitaet_typ_id,
 COALESCE(SUB02.aktivitaet_bez, 'Sonstige') AS aktivitaet_bez
FROM (SELECT V01.mandant_id,
   V01.flaeche_id,
   COALESCE(v02.ergebnis, '') AS aktivitaet_ergebnis
  FROM kfl_production_dbp_view.v_ivs_flaeche_per_1 AS V01
   LEFT JOIN (SELECT mandant_id,
     flaeche_id,
     MAX(COALESCE(TRIM(aktivitaet_ergebnis), ' - ')) AS ergebnis
    FROM kfl_production_dbp_view.v_ivs_flaeche_aktivitaet_1
    GROUP BY mandant_id,
     flaeche_id) AS v02 ON V01.mandant_id = v02.mandant_id AND V01.flaeche_id = v02.flaeche_id
  WHERE V01.dat_bis = DATE '9999-12-31') AS sub01
 LEFT JOIN kfl_production_dbp_view.v_ivs_flaeche_aktivitaet_1 AS SUB02 ON sub01.mandant_id = SUB02.mandant_id AND sub01.flaeche_id
     = SUB02.flaeche_id AND SUB02.aktivitaet_typ_id > - 1;