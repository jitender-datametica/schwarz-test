CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_in_lieferant_audit_per (mandant_id, in_lief_id, dat_von,
dat_bis, dat, audit_qzahl) AS SELECT V01.mandant_id,
 V01.flw_lief_id AS in_lief_id,
 V01.dat_von,
 V01.dat_bis,
 V02.dat,
 V01.audit_qzahl
FROM kfl_production_dbp_view.v_flw_lieferant_audit_per AS V01
 INNER JOIN kfl_production_dbp_view.v_tag AS V02 ON V02.dat BETWEEN V01.dat_von AND V01.dat_bis AND V02.dat <= DATE_ADD(CURRENT_DATE
    ,INTERVAL 365 DAY);