CREATE OR REPLACE VIEW dbp_msi_view_rpw_materialized.mv_statusmeldung_rfi_1 (nr, statusid, wmwst, waers,
status_1, statmsgtst, srcpos, srcdoc, srcdgj, srcdest, rmwwr, rfi_date, lifnr, kreditor_1, impnr, gjahr, freigabe,
fnpm_seq_id, edinum, ecmproc, dq_issue_issue_code, dq_issue_field_name, docclass, cruser, belnr, autoflag) AS SELECT *
FROM dbp_msi_view_rpw.mv_statusmeldung_rfi_1;