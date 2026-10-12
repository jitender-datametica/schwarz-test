create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_ZB.V_KURS_1(
	MANDANT_ID,
	WRG_TYP_ID,
	VON_WRG_ID,
	NACH_WRG_ID,
	UMRECHNUNGSKURS,
	KURS_1,
	WRG_ID,
	FAKTOR
) as(
SELECT DISTINCT
   mandant_id,
   wrg_typ_id,
   von_wrg_id,
   nach_wrg_id,
   umrechnungskurs,
   kurs_1              AS kurs_1    -- Kurs_1 fuer Anzeige im Bericht
   , nach_wrg_id       AS wrg_id  -- Waehrung fuer Anzeige im Bericht
   , umrechnungskurs   AS FAKTOR  -- Umrechnungsfaktor fuer Berechnung (ALIAS)
   FROM (
   SELECT
   m.mandant_id,
   w.wrg_typ_id,
   k.von_wrg_id,
   k.nach_wrg_id, 
   k.umrechnungskurs AS umrechnungskurs,
   ROUND( 1 / k.umrechnungskurs,5) AS kurs_1
   --, w.user_id
   FROM
   DBP_DATA.KURS_1 k
   JOIN DBP_MSI_DATA.USER_WRG_TYP_ZU_1  w
   ON w.wrg_typ_id = 0 -- Umrechnung in EUR
   JOIN DBP_DATA.MANDANT_1 m
   ON m.default_wrg = k.von_wrg_id
   WHERE k.kurstyp_id = 3 AND k.dat_bis = '9999-12-31' -- -- Berichtskurs (aktuelle Version)

   UNION ALL
   
   SELECT
   m.mandant_id,
   w.wrg_typ_id,
   k.von_wrg_id,
   k.von_wrg_id AS nach_wrg_id,
   1 AS umrechnungskurs,
   1 AS kurs_1
   FROM
   DBP_DATA.KURS_1 k
   JOIN DBP_MSI_DATA.USER_WRG_TYP_ZU_1  w
   ON w.wrg_typ_id = 1 -- Anzeige Landeswaehrung
   JOIN DBP_DATA.MANDANT_1 m
   ON m.default_wrg = k.von_wrg_id
   WHERE k.kurstyp_id = 3 AND k.dat_bis = '9999-12-31' -- -- Berichtskurs (aktuelle Version)
   ) sub01
   
   );
