CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_ANLAGE_KLASSE_INT_SPR_ZU_EN_1
-- 22.03.2013 twie: Sprachzuordung für Anlageklassen INT
-- 22.04.2013 twie: Jede Anlageklasse nur einmal ausgeben, mit der niedrigsten mandant_id, die vorhanden ist
-- 22.04.2013 twie: nur Anlagenklassen mit 8 Stellen (ohne führende Nullen)

AS
   SELECT
   anlage_klasse_id,
   anlage_klasse_bez_kurz,
   anlage_klasse_bez
   FROM  dbp_view.v_anlage_klasse_spr_zu_1
   WHERE spr_id=24
   AND anlage_klasse_bez_kurz <> 'inaktiv'
   AND LENGTH (TRIM (COLLATE(anlage_klasse_id,''), '0')) = 8 
   AND TRY_TO_NUMERIC(anlage_klasse_id) IS NOT NULL
   QUALIFY ROW_NUMBER() OVER (PARTITION BY anlage_klasse_id ORDER BY mandant_id ASC) =1;