CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_STATUSMELDUNG_RFI_2 as
          SELECT

          ROW_NUMBER() OVER (ORDER BY statusid DESC NULLS LAST) AS nr --fortlaufende Nummerierung
          ,
          statusid,
          wmwst,
          waers,
          status_2,
          statmsgtst,
          srcpos,
          srcdoc,
          srcdgj,
          srcdest,
          rmwwr,
          rfi_date,
          lifnr,
          kreditor_2,
          impnr,
          gjahr,
          freigabe,
          fnpm_seq_id,
          edinum,
          ecmproc,
          dq_issue_issue_code,
          dq_issue_field_name,
          docclass,
          cruser,
          belnr,
          autoflag


          FROM dbp_msi_v_view.v_statusmeldung_rfi_2
 ;