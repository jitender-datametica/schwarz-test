CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_L_RECH_ERFASSUNG
       (
       mandant_id
       ,erfassung_id
       ,system_id
       ,EDI_fg
       )
       AS
          SELECT
          mandant_id,
          erfassung_id,
          7,
          CASE WHEN erfassung_id  IN ('MED','DED') THEN  'EDI' ELSE   'NonEDI' END AS EDI_fg
          FROM dbp_view.v_l_rech_erfassung
          WHERE mandant_id = 1
 ;