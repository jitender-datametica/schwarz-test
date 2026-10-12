CREATE OR REPLACE view DBP_MSI_VIEW_WWC.MV_ALTERSSTRUKTUR_2 as
   SELECT
   v01.mandant_id, v01.nb_id, v01.wup_id, COALESCE(v02.altersstruktur_tag_id,7) AS altersstruktur_tag_id, COALESCE(v02.altersstruktur_woche_id,7) AS altersstruktur_woche_id, COALESCE(v02.altersstruktur_monat_id,7) AS altersstruktur_monat_id

   FROM dbp_view.v_wup_2  v01
   LEFT OUTER JOIN dbp_msi_v_view.v_altersstruktur_eis_2  v02
   ON v01.wup_id = v02.wup_id
   AND v01.mandant_id = v02.mandant_id
   AND v01.nb_id = v02.nb_id
   ;