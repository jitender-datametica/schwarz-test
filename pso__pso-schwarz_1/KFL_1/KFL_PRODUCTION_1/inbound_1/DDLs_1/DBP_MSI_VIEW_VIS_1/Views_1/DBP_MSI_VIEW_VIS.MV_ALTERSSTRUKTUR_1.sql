CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_ALTERSSTRUKTUR_1 as
   -- ZUORDNUNG Alterstruktur - Markt
   -- 20100304 Korrektur (where-Bedinung / NULL-Filter entfernt)

   SELECT
   altersstruktur_tag_id, altersstruktur_woche_id, altersstruktur_monat_id, mandant_id, nb_id, wup_id
   FROM dbp_msi_v_view.v_altersstruktur_eis_1;