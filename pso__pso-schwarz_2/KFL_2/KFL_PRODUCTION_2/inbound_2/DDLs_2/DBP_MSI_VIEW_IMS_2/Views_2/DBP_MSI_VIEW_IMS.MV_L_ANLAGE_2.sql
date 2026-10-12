CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_L_ANLAGE_2 AS
-- 13.06.2013 twie: Erstellung Lookup Anlage_2
-- 02.09.2013 twie: Dummyanlage entfernt, ist jetzt in Tabelle

   SELECT
   anlage_id,
   anlage_sub_id,
   mandant_id,
   buchungskreis_id AS anlage_buchungskreis_id,
   anlage_bez

   FROM dbp_view.v_anlage_2
;