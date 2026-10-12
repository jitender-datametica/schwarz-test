CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_ANLAGE_KLASSE_ZU_PER_2 AS
-- 13.06.2013 twie: Erstellung Zuordnung Anlage_2 - Anlageklasse
-- 02.09.2013 twie: Dummyanlage entfernt, ist jetzt in Tabelle

   SELECT
   anlage_id,
   anlage_sub_id,
   mandant_id,
   buchungskreis_id AS anlage_buchungskreis_id,
   anlage_klasse_id

   FROM dbp_view.v_anlage_klasse_zu_per_2
   -- immer aktueller Stand
   WHERE dat_bis =  '9999-12-31'
;