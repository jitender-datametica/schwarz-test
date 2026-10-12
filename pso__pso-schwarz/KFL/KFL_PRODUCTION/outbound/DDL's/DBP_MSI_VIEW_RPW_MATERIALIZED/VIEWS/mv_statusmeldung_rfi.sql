CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw_materialized.mv_statusmeldung_rfi (nr, statusid, wmwst, waers,
status, statmsgtst, srcpos, srcdoc, srcdgj, srcdest, rmwwr, rfi_date, lifnr, kreditor, impnr, gjahr, freigabe,
fnpm_seq_id, edinum, ecmproc, dq_issue_issue_code, dq_issue_field_name, docclass, cruser, belnr, autoflag) AS SELECT *
FROM kfl_production_dbp_msi_view_rpw.mv_statusmeldung_rfi;