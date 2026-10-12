CREATE OR REPLACE VIEW dbp_msi_view_immo_materialized.mv_immo_mietvertrag_intreno_zu_hilf_1 (mandant_id, we_intreno,
mo_intreno, mv_intreno, mietvertrag_nr, partner_id, konzessionaer_id, dat_von, dat_bis, we_intreno_akt, mo_intreno_akt,
mv_intreno_akt, konzessionaer_id_akt) AS SELECT DISTINCT V1.mandant_id,
 V1.we_intreno,
 V1.mo_intreno,
 t6.mv_intreno,
 V3.mietvertrag_nr,
 V3.partner_id,
 V3.partner_id AS konzessionaer_id,
 V2.dat_von,
 V2.dat_bis,
 v6.we_intreno_akt,
 v6.mo_intreno_akt,
 v6.mv_intreno_akt,
 v6.konzessionaer_id AS konzessionaer_id_akt
FROM kfl_production_dbp_view.v_immo_mietobjekt_1 AS V1
 LEFT JOIN kfl_production_dbp_view.v_immo_mietvertrag_mo_zu_per_1 AS V2 ON V1.mandant_id = V2.mandant_id AND V1.mo_intreno
    = V2.mo_intreno
 LEFT JOIN kfl_production_dbp_view.v_immo_mietvertrag_per_1 AS V3 ON V2.mandant_id = V3.mandant_id AND V2.mv_intreno = V3
   .mv_intreno
 INNER JOIN (SELECT V11.mandant_id,
   V13.mietvertrag_nr,
   MAX(V11.we_intreno) AS we_intreno_akt,
   MAX(V11.mo_intreno) AS mo_intreno_akt,
   MAX(V12.mv_intreno) AS mv_intreno_akt,
   MAX(V13.partner_id) AS konzessionaer_id
  FROM kfl_production_dbp_view.v_immo_mietobjekt_1 AS V11
   LEFT JOIN kfl_production_dbp_view.v_immo_mietvertrag_mo_zu_per_1 AS V12 ON V11.mandant_id = V12.mandant_id AND V11.mo_intreno
      = V12.mo_intreno
   LEFT JOIN kfl_production_dbp_view.v_immo_mietvertrag_per_1 AS V13 ON V12.mandant_id = V13.mandant_id AND V12.mv_intreno
      = V13.mv_intreno
  GROUP BY V11.mandant_id,
   V13.mietvertrag_nr) AS v6 ON V3.mandant_id = v6.mandant_id AND V3.mietvertrag_nr = v6.mietvertrag_nr
 INNER JOIN (SELECT mandant_id,
   mv_intreno,
   mietvertrag_nr0 AS mietvertrag_nr
  FROM (SELECT DISTINCT V10.mandant_id,
     V10.mv_intreno,
     v2.mietvertrag_nr AS mietvertrag_nr0
    FROM kfl_production_dbp_view.v_immo_mietvertrag_per_1 AS V10
     INNER JOIN (SELECT DISTINCT mandant_id,
       mv_intreno,
       mietvertrag_nr,
       mietvertrag_nr_alt
      FROM kfl_production_dbp_view.v_immo_mietvertrag_per_1) AS v2 ON V10.mietvertrag_nr = v2.mietvertrag_nr_alt AND V10.mandant_id
        = v2.mandant_id) AS v15) AS t6 ON V3.mietvertrag_nr = t6.mietvertrag_nr AND V3.mandant_id = t6.mandant_id
UNION DISTINCT
SELECT DISTINCT V1.mandant_id,
 V1.we_intreno,
 V1.mo_intreno,
 V2.mv_intreno,
 V3.mietvertrag_nr,
 V3.partner_id,
 V3.partner_id AS konzessionaer_id,
 V2.dat_von,
 V2.dat_bis,
 v6.we_intreno_akt,
 v6.mo_intreno_akt,
 v6.mv_intreno_akt,
 v6.konzessionaer_id AS konzessionaer_id_akt
FROM kfl_production_dbp_view.v_immo_mietobjekt_1 AS V1
 LEFT JOIN kfl_production_dbp_view.v_immo_mietvertrag_mo_zu_per_1 AS V2 ON V1.mandant_id = V2.mandant_id AND V1.mo_intreno
    = V2.mo_intreno
 LEFT JOIN kfl_production_dbp_view.v_immo_mietvertrag_per_1 AS V3 ON V2.mandant_id = V3.mandant_id AND V2.mv_intreno = V3
   .mv_intreno
 INNER JOIN (SELECT V11.mandant_id,
   V13.mietvertrag_nr,
   MAX(V11.we_intreno) AS we_intreno_akt,
   MAX(V11.mo_intreno) AS mo_intreno_akt,
   MAX(V12.mv_intreno) AS mv_intreno_akt,
   MAX(V13.partner_id) AS konzessionaer_id
  FROM kfl_production_dbp_view.v_immo_mietobjekt_1 AS V11
   LEFT JOIN kfl_production_dbp_view.v_immo_mietvertrag_mo_zu_per_1 AS V12 ON V11.mandant_id = V12.mandant_id AND V11.mo_intreno
      = V12.mo_intreno
   LEFT JOIN kfl_production_dbp_view.v_immo_mietvertrag_per_1 AS V13 ON V12.mandant_id = V13.mandant_id AND V12.mv_intreno
      = V13.mv_intreno
  GROUP BY V11.mandant_id,
   V13.mietvertrag_nr) AS v6 ON V3.mandant_id = v6.mandant_id AND V3.mietvertrag_nr = v6.mietvertrag_nr;