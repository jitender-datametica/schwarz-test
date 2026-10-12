CREATE OR REPLACE VIEW dbp_msi_view_rpw_materialized.mv_problemmeldung_rfi_1 (nr, prmsgid, wrbtr, wmwst,
werks, waers, srcpos, srcdgj, rmwwr, rfi_date, resuser, procarea, prmsgtst, prcode, object1, object2, object3, object4,
object5, matnr, lifnr, lfpos, kreditor_1, impnr, gjahr, freigabe, fnpm_seq_id, fieldval1, fieldval2, exrgnr,
dq_issue_issue_code, dq_issue_field_name, docclass, delflag, cruser, causer, bldat, belnr, autoflag) AS SELECT *
FROM dbp_msi_view_rpw.mv_problemmeldung_rfi_1;