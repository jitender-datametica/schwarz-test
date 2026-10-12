-- 2022-11-30, AP0150311_SPEC0174516, dknop, , separating from bsf part

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3_materialized.mv_protokoll_aenderung_lagernummer_1 (wup_id, nb_id,
mandant_id, lagernummer_id, referenznummer, dat_tour, erster_date_basis_ln, erster_zeitstempel_basis_ln,
letzter_date_basis_ln, letzter_zeitstempel_basis_ln) AS SELECT V01.wup_id,
 V01.nb_id,
 V01.mandant_id,
 V01.lagernummer_id,
 CAST(ROUND(CAST(CASE
     WHEN V01.referenznummer = ''
     THEN '-1'
     ELSE V01.referenznummer
     END AS FLOAT64)) AS INTEGER) AS referenznummer,
 V02.dat_tour,
 MIN(DATE(V01.dat_aenderung)) AS erster_date_basis_ln,
 MIN(V01.datzeit_aenderung_utc) AS erster_zeitstempel_basis_ln,
 MAX(DATE(V01.dat_aenderung)) AS letzter_date_basis_ln,
 MAX(V01.datzeit_aenderung_utc) AS letzter_zeitstempel_basis_ln
FROM kfl_production_dbp_view.v_protokoll_aenderung_bsf_1 AS V01
 LEFT JOIN kfl_production_dbp_view.v_tour_1 AS V02 ON CAST(ROUND(CAST(CASE
        WHEN V01.referenznummer = ''
        THEN '-1'
        ELSE V01.referenznummer
        END AS FLOAT64)) AS INTEGER) = V02.tour_id AND V01.mandant_id = V02.mandant_id AND V01.wup_id = V02.wup_id
   -- where CAST(CASE WHEN v01.referenznummer='' THEN '-1' ELSE v01.referenznummer END AS INTEGER) ='40955396'

GROUP BY V01.wup_id,
 V01.nb_id,
 V01.mandant_id,
 V01.lagernummer_id,
 V01.referenznummer,
 V02.dat_tour;